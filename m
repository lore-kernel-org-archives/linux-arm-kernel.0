From: mario.smarduch@huawei.com (Mario Smarduch)
Date: Thu, 13 Jun 2013 17:16:13 +0200
Subject: [PATCH 1/2] support for IRQ priority drop deactivation
Message-ID: <51B9E23D.5040901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated Priority Drop/Deactivation patch -
- moved bitmap to per gic data
- moved initialization of gic irqchip eoi handler to gic_init_bases
- cleaned up the code per suggestions.
- added documentation

Signed-off-by: Mario Smarduch <mario.smarduch@huawei.com>
---
 arch/arm/kvm/Kconfig            |    8 ++
 drivers/irqchip/irq-gic.c       |  204 ++++++++++++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic.h |    6 ++
 3 files changed, 213 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 370e1a8..ae69e9a 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -59,6 +59,14 @@ config KVM_ARM_VGIC
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.
 
+config KVM_ARM_INT_PRIO_DROP
+        bool "KVM support for Interrupt pass-through"
+        depends on KVM_ARM_VGIC && OF
+        default n
+        ---help---
+	  Seperates interrupt priority drop and deactivation to enable device
+	  pass-through to Guests.
+
 config KVM_ARM_TIMER
 	bool "KVM support for Architected Timers"
 	depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1760ceb..ac345ec 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -41,10 +41,13 @@
 #include <linux/slab.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqflags.h>
+#include <linux/bitops.h>
 
 #include <asm/irq.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
+#include <asm/virt.h>
 
 #include "irqchip.h"
 
@@ -68,6 +71,9 @@ struct gic_chip_data {
 #ifdef CONFIG_GIC_NON_BANKED
 	void __iomem *(*get_base)(union gic_base *);
 #endif
+#ifdef CONFIG_KVM_ARM_INT_PRIO_DROP
+	DECLARE_BITMAP(gic_irq_prio_drop, 1020);
+#endif
 };
 
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
@@ -148,6 +154,189 @@ static inline unsigned int gic_irq(struct irq_data *d)
 	return d->hwirq;
 }
 
+#ifdef CONFIG_KVM_ARM_INT_PRIO_DROP
+static inline unsigned long *get_priodrop_map(int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+	return ((struct gic_chip_data *) (d->chip_data))->gic_irq_prio_drop;
+}
+
+/**
+ * void gic_eoi_irq_priodrop() - process end of interrupt handling for
+ *			         passthrough IRQs
+ * @struct irq_data *d:	irq_data associed irq_desc
+ *
+ * When Priority Drop/Deactivation is set this handler replaces the standard
+ * EOI (irq_eoi) handler. The use of this handler will applyt to IRQa on all
+ * CPU for end of interrupt operation. This mode of operations is for
+ * passing IRQs through to guest, and eliminate guest exit for EOI execution.
+ * IRQs not marked for passthrough will write to CPU EOIR and DIR registers,
+ * IRQs makred for passhtrough will only write to EOIR register and guests
+ * write to EOIR register will reactivate the IRQ being passed through.
+ *
+ * IMPORTANT - when enabling this feature the host GICC interface must map
+ * additional page, the device tree should be updated to map 0x2000 instead
+ * of 0x1000.
+ *
+ * Return: void
+ */
+static void gic_eoi_irq_priodrop(struct irq_data *d)
+{
+	if (gic_arch_extn.irq_eoi) {
+		raw_spin_lock(&irq_controller_lock);
+		gic_arch_extn.irq_eoi(d);
+		raw_spin_unlock(&irq_controller_lock);
+	}
+
+	/* Set from KVM device passthrough to determine which interrupts
+	 * must be deactivated by the Guest.
+	 */
+	if (unlikely(gic_spi_get_priodrop(gic_irq(d)))) {
+		/*
+		 * IRQ marked for priority drop, deactivation is deferred
+		 * in this case the Guest deactivates the interrupt, or regular
+		 * path if GCTLR.EOImodeNS=0 or not suppored.
+		 */
+		writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+	} else {
+		/*
+		 * De-prioritize/de-activate interrupt, disable interrupts
+		 * so lower priority interrupt does not stall this one.
+		 */
+		unsigned long flags;
+		raw_local_irq_save(flags);
+		writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+		writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_DIR);
+		raw_local_irq_restore(flags);
+	}
+}
+/**
+ * gic_enable_gicc() - enable CPU GIC interface
+ * @struct gic_chip_data *gic - gic chip data for GIC interface
+ *
+ * If HYP mode is enabled puts CPU GIC interface int priodrop mode. SGI bits
+ * are set in per-gic prio drop map to proces EOI for SGI correctly.
+ * It may happen that boot CPU will set HYP mode to true but subsequent CPUs
+ * may turn HYP mode off and system may come up in mixed mode. Writes to CPU
+ * DIR register with priodrop disabled results in upredictable access.
+ * In this case the host will panic. The Guest never runs in priodrop
+ * mode.
+ *
+ * Return: void
+ */
+static void gic_enable_gicc(struct gic_chip_data *gic)
+{
+	static bool priodrop_set;
+	if (is_hyp_mode_available()) {
+		/*
+		 * Allow Priority Drop in host, but not in Guest
+		 */
+		gic->gic_irq_prio_drop[0] = (u32) (1 << 16) - 1;
+		writel_relaxed(0x201, gic_data_cpu_base(gic)  + GIC_CPU_CTRL);
+		priodrop_set = true;
+	} else {
+		if (priodrop_set  == true)
+			panic("OS misconfigured running in mixed interrupt modes");
+		writel_relaxed(1, gic_data_cpu_base(gic) + GIC_CPU_CTRL);
+	}
+}
+/**
+ * gic_eoi_sgi() - end of interrupt for SGIs in priodrop mode
+ *
+ * @u32 irqstat - EOI word
+ * @struct gic_chip_data *gic - per GIC interface chip data
+ *
+ * Handles SGI EOI handling, for host writes to EOIR and DIR registers. For
+ * Guest to EOIR only.
+ *
+ * Return: void
+ */
+static void gic_eoi_sgi(u32 irqstat, struct gic_chip_data *gic)
+{
+	unsigned long flags;
+	if (unlikely(gic->gic_irq_prio_drop[0] & (1<<((irqstat & ~0x1c00) % 16)))) {
+		raw_local_irq_save(flags);
+		writel_relaxed(irqstat, gic_data_cpu_base(gic) + GIC_CPU_EOI);
+		writel_relaxed(irqstat, gic_data_cpu_base(gic) + GIC_CPU_DIR);
+		raw_local_irq_restore(flags);
+		return;
+	}
+	writel_relaxed(irqstat, gic_data_cpu_base(gic) + GIC_CPU_EOI);
+}
+
+/**
+ * gic_spi_set_priodrop() - set IRQ to priodrop mode
+ *
+ * @int irq - the IRQ for passthrough
+ *
+ * Hypervisor code sets this bit for interrupt passthrough.
+ *
+ * Return: void
+ */
+void gic_spi_set_priodrop(int irq)
+{
+	if (likely(irq >= 32 && irq <= 1020))
+		set_bit(irq, get_priodrop_map(irq));
+}
+
+/**
+ * gic_spi_clr_priodrop() - clears priodrop for IRQ
+ *
+ * @int irq - the IRQ to clear passthrough
+ *
+ * Hypervisor code sets this to interrupt passthrough for the IRQ
+ *
+ * Return: void
+ */
+void gic_spi_clr_priodrop(int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+	if (likely(irq >= 32 && irq < 1020)) {
+		clear_bit(irq, get_priodrop_map(irq));
+		writel_relaxed(irq, gic_cpu_base(d) + GIC_CPU_DIR);
+	}
+}
+
+/**
+ * gic_spi_get_priodrop() - determine if interrupt is set for passthrough
+ *
+ * @int irq - irq to check passhtrough status
+ *
+ * Used by priodrop eoi code and Hypervisor to check IRQ priority drop status.
+ *
+ * Return: bool - true if irq set for passthrough.
+ */
+bool gic_spi_get_priodrop(int irq)
+{
+	if (likely(irq >= 32 && irq <= 1020))
+		return test_bit(irq, get_priodrop_map(irq));
+	return false;
+}
+#else
+static void gic_eoi_irq_priodrop(struct irq_data *d)
+{
+}
+static void gic_enable_gicc(struct gic_chip_data *gic)
+{
+	writel_relaxed(1, gic_data_cpu_base(gic) + GIC_CPU_CTRL);
+}
+static void gic_eoi_sgi(u32 irqstat, struct gic_chip_data *gic)
+{
+	writel_relaxed(irqstat, gic_data_cpu_base(gic) + GIC_CPU_EOI);
+}
+void gic_spi_set_priodrop(int irq)
+{
+}
+void gic_spi_clr_priodrop(int irq)
+{
+}
+bool gic_spi_get_priodrop(int irq)
+{
+	return false;
+}
+#endif
+
+
 /*
  * Routines to acknowledge, disable and enable interrupts
  */
@@ -180,7 +369,6 @@ static void gic_eoi_irq(struct irq_data *d)
 		gic_arch_extn.irq_eoi(d);
 		raw_spin_unlock(&irq_controller_lock);
 	}
-
 	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
@@ -296,7 +484,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 			continue;
 		}
 		if (irqnr < 16) {
-			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
+			gic_eoi_sgi(irqstat, gic);
 #ifdef CONFIG_SMP
 			handle_IPI(irqnr, regs);
 #endif
@@ -450,7 +638,7 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
 
 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, base + GIC_CPU_CTRL);
+	gic_enable_gicc(gic);
 }
 
 #ifdef CONFIG_CPU_PM
@@ -585,7 +773,7 @@ static void gic_cpu_restore(unsigned int gic_nr)
 		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4);
 
 	writel_relaxed(0xf0, cpu_base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, cpu_base + GIC_CPU_CTRL);
+	gic_enable_gicc(&gic_data[gic_nr]);
 }
 
 static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
@@ -735,6 +923,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 
 	BUG_ON(gic_nr >= MAX_GIC_NR);
 
+	/*
+	 * If HYP mode enabled and PRIO DROP set EOIR function to handle PRIO
+	 * DROP
+	 */
+	if (IS_ENABLED(CONFIG_KVM_ARM_INT_PRIO_DROP) && is_hyp_mode_available())
+		gic_chip.irq_eoi = gic_eoi_irq_priodrop;
+
 	gic = &gic_data[gic_nr];
 #ifdef CONFIG_GIC_NON_BANKED
 	if (percpu_offset) { /* Frankein-GIC without banked registers... */
@@ -856,5 +1051,4 @@ IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
 IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
-
 #endif
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 3e203eb..5a906c9 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -17,6 +17,7 @@
 #define GIC_CPU_EOI			0x10
 #define GIC_CPU_RUNNINGPRI		0x14
 #define GIC_CPU_HIGHPRI			0x18
+#define GIC_CPU_DIR                     0x1000
 
 #define GIC_DIST_CTRL			0x000
 #define GIC_DIST_CTR			0x004
@@ -73,6 +74,11 @@ static inline void gic_init(unsigned int nr, int start,
 	gic_init_bases(nr, start, dist, cpu, 0, NULL);
 }
 
+/* Functions to manage interrupt pass-through via priority drop/deactivation */
+void gic_spi_set_priodrop(int);
+void gic_spi_clr_priodrop(int);
+bool gic_spi_get_priodrop(int);
+
 #endif /* __ASSEMBLY */
 
 #endif
-- 
1.7.9.5
