From: mario.smarduch@huawei.com (Mario Smarduch)
Date: Fri, 19 Apr 2013 16:25:12 +0200
Subject: [RFC PATCH] Device/Interrupt Passthrough - 3.9rc5
Message-ID: <517153C8.9000409@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sorry for the lengthy email, it covers both the patch submitted
here and high-level approach for Device Passthrough.

For the overall Device Passthrough approach please scroll down.

The Patch
=========
This patch by itself does not serve much purpose without the additional
QEMU/KVM support, the patch has been tested with those features working
Those patches will be rolled out soon. Given this patch touches critical
GIC code required by Device Passthrough it needs to go in first.

The interrupt pass-through patch supports priority drop/deactivation. This is
a first patch intended to facilitate overall device (interrupt) passthrough to
guest.

ARM GICv2 describes recommended way to handle interrupt pass-through
(5.2.2 - 1., 2.) - this patch sets Host GICC_CTLR.EOImodeNS=1 and for
injecting interrupts GICH_LRn.HW=1. Guest sets its CTLR.EOImodeNS=0
executing without changes.

New config param is defined (arm/kvm/Kconfig' KVM_ARM_INT_PRIO_DROP)
which is enabled only if Virtualization && KVM_ARM_VGIC && OF are enabled.

If the parameter is enabled, an IRQ can be marked for pass-through, in
that case host writes to EOIR to lower IRQ priority and Guest EOIR deactivates
the IRQ. For host interrupts writes to both EOIR/DIR are done. If the config
param is diabled then nothing changes.

The patch is strictly intended for Virtualization & KVM device
passthrough, there may be other uses for IRQ prio drop/deactivation they're
not obvious or considered at this time.

Currently the patch assumes if primary CPU has HYP mode enabled and if
PRIO_DROP is defined EOImodeNS is set. It might turn out that subsequent CPU(s)
may not boot in HYP mode in that case all CPUs will be configured to
execute in PRIO DROP mode which practically has no overhead.

What's been tested -
 - we pass-through sp804 timer and event devices from guest to host,
   this tests QEMU, kernel, ARM-KVM memory and interrupt passthrough.
   We're working on lan 911x passthrough and then Arndale NIC
   passthrough
 - all combinations of host and guest have been tested,
   i.e. Host Virt=on/off, PrioDrop=on/off; Guest virt=on/of, PD=on/off
   Any combination of Guest/Host config is supported.

DEVICE PASSTHROUGH overall Architecture
---------------------------------------

To pass through a device following data is required:
 o Host - Device HPA, Size, Perms (r; r/w), Attr (dev, mem), host irq -
   [optional: CPU IRQ affinity, vCPU affinity -  dynamic affiniy although
    affinity for RT/performance a require option] - these values come from
    Device Tree and command line parameters.
 o Guest - Device GPA, IRQ - at run-time select memory and IRQ from
   range predefined for Device passthrough for the emulated machine model and
   patch guest DT. The ranges should be predefined to prevent future conflicts
   between MMIO and devices passed through.

Overall Device Passthrough Design summary - simple usage -
     "-device kvm-device-assign,host="device name" -
device as known in DT.  Although passing all the parameters is also supported.

- This patch being first to lay the groundwork and given it touches
  generic GIC code we would like early feedback.
- Device I/O or Memory Passthrough - combination of new QEMU
  (kvm-device-assign) device and ARM KVM ioctl hooks to map device in
  2nd stage tables. Dynamic discovery and/or allocation of resources.
  With SMMU availability this should be where you map/pin the Guest.
- Interrupt passthrough - reuse current ioctl QEMU/KVM ioctl
  infrastracture in combination with this patch KVM Guest can
  mark a device for interrupt passthrough. Both host/guest IRQs run-time
  discovered/allocated.
  o eventual run-time IRQ -> CPU -> vCPU framework support, although CPU/vCPU
    affinity for some applications is useful as well.
- Support for 1:1 memory mapping to support DMA with no IOMMU. Eventually with
  SMMU secure DMA will be supported until then - provide contiguous memory to
  guest and map 1:1 2nd stage tables - Guest IPA == HPA. This approach
  has some merits and has been utilized by propriotary solutions
  primarily in Wireless where guests are trusted (some devices like SEC
  engines may not be behind SMMU and DMA to memory look-aside crypto).

	Mario.

Signed-off-by: Mario Smarduch <mario.smarduch@huawei.com>
---
 arch/arm/kvm/Kconfig            |   14 ++++
 drivers/irqchip/irq-gic.c       |  148 ++++++++++++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic.h |    6 ++
 3 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 49dd64e..3fcc18e 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -59,6 +59,20 @@ config KVM_ARM_VGIC
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.

+config KVM_ARM_INT_PRIO_DROP
+	bool "KVM support for Interrupt pass-through"
+	depends on KVM_ARM_VGIC && OF
+	default n
+	---help---
+	  Seperates interrupt priority drop and deactivation to enable device
+	  pass-through to Guests. Enabling this config seperates priority drop
+	  from deactivation of the interrupt (active->inactive or pending).
+	  This requires write to EOIR and DIR registers. For interrupts passed
+	  through to Guest, the host does the EOIR and Guest EOIR deactivates
+	  the interrupt. For interrupts not passed through. The host writes to
+	  EOIR and DIR registers. For host to access the DIR reg additional
+	  page must be mapped for GICC (i.e. 2 pages total)
+
 config KVM_ARM_TIMER
 	bool "KVM support for Architected Timers"
 	depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a32e0d5..71ce01e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -39,11 +39,14 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqflags.h>
+#include <linux/bitops.h>

 #include <asm/irq.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
 #include <asm/mach/irq.h>
+#include <asm/virt.h>

 #include "irqchip.h"

@@ -98,6 +101,20 @@ struct irq_chip gic_arch_extn = {

 static struct gic_chip_data gic_data[MAX_GIC_NR] __read_mostly;

+#ifdef CONFIG_KVM_ARM_INT_PRIO_DROP
+/*
+ * Priority drop/deactivation bit map, 1st 16 bits used for SGIs, this bit map
+ * is shared by several guests. If bit is set only execute EOI which drops
+ * current priority but not deactivation.
+ */
+static u32  gic_irq_prio_drop[DIV_ROUND_UP(1020, 32)] __read_mostly;
+static void gic_eoi_irq_priodrop(struct irq_data *);
+#endif
+
+static void gic_enable_gicc(void __iomem *);
+static void gic_eoi_sgi(u32, void __iomem *);
+static void gic_priodrop_remap_eoi(struct irq_chip *);
+
 #ifdef CONFIG_GIC_NON_BANKED
 static void __iomem *gic_get_percpu_base(union gic_base *base)
 {
@@ -294,7 +311,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 			continue;
 		}
 		if (irqnr < 16) {
-			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
+			gic_eoi_sgi(irqstat, cpu_base);
 #ifdef CONFIG_SMP
 			handle_IPI(irqnr, regs);
 #endif
@@ -448,7 +465,7 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);

 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, base + GIC_CPU_CTRL);
+	gic_enable_gicc(base);
 }

 #ifdef CONFIG_CPU_PM
@@ -583,7 +600,7 @@ static void gic_cpu_restore(unsigned int gic_nr)
 		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4);

 	writel_relaxed(0xf0, cpu_base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, cpu_base + GIC_CPU_CTRL);
+	gic_enable_gicc(cpu_base);
 }

 static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
@@ -664,6 +681,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
+	gic_priodrop_remap_eoi(&gic_chip);
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &gic_chip,
@@ -843,3 +861,127 @@ IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);

 #endif
+
+#ifdef CONFIG_KVM_ARM_INT_PRIO_DROP
+/* If HYP mode enabled and PRIO DROP set EOIR function to handle PRIO DROP */
+static inline void gic_priodrop_remap_eoi(struct irq_chip *chip)
+{
+	if (is_hyp_mode_available())
+		chip->irq_eoi = gic_eoi_irq_priodrop;
+}
+
+/* If HYP mode set enable interrupt priority drop/deactivation, and mark
+ * SGIs to deactive through writes to GCICC_DIR. For Guest only enable normal
+ * mode.
+ */
+static void gic_enable_gicc(void __iomem *gicc_base)
+{
+	if (is_hyp_mode_available()) {
+		/* Allow Priority Drop in host, but not in Guest */
+		gic_irq_prio_drop[0] = (u32) (1 << 16) - 1;
+		writel_relaxed(0x201, gicc_base + GIC_CPU_CTRL);
+	} else {
+		writel_relaxed(1, gicc_base + GIC_CPU_CTRL);
+	}
+}
+
+/* If Host write to EOIR and DIR to drop priority and deactivate, Guest
+ * only write to EOIR.
+ */
+static void gic_eoi_sgi(u32 irqstat, void __iomem *gicc_base)
+{
+	unsigned long flags;
+	if (unlikely(gic_irq_prio_drop[0] & (1<<((irqstat & ~0x1c00) % 16)))) {
+		raw_local_irq_save(flags);
+		writel_relaxed(irqstat, gicc_base + GIC_CPU_EOI);
+		writel_relaxed(irqstat, gicc_base + GIC_CPU_DIR);
+		raw_local_irq_restore(flags);
+		return;
+	}
+	writel_relaxed(irqstat, gicc_base + GIC_CPU_EOI);
+}
+
+/* EOIR handler to manage PRIO DROP, if interrupt passed-through only write to
+ * EOIR the Guest will deactivate it through its write to EOIR. Otherwise for
+ * non pass-through write to EOIR and DIR. GICC_DIR _must_ be mapped.
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
+		/* IRQ marked for priority drop, deactivation is deferred
+		 * in this case the Guest deactivates the interrupt, or regular
+		 * path if GCTLR.EOImodeNS=0 or not suppored.
+		 */
+		 writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+	} else {
+		/* De-prioritize/de-activate interrupt, disable interrupts
+		 * so lower priority interrupt does not stall this one.
+		 */
+		unsigned long flags;
+		raw_local_irq_save(flags);
+		writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+		writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_DIR);
+		raw_local_irq_restore(flags);
+	}
+}
+
+/* Priority Drop access functions, serialization must be handled in KVM
+ * when passing device through. The EOI handler reads the state for the
+ * associate SPI without any locking. This requires orderly installation
+ * and teardown of devices passed through.
+ */
+
+/* Set the IRQ for pass-through to Guest */
+void gic_spi_set_priodrop(int irq)
+{
+	if (likely(irq >= 32 && irq <= 1019))
+		set_bit(irq % 32, (void *) &gic_irq_prio_drop[irq/32]);
+}
+
+/* Clear the IRQ from pass-through to Guest */
+void gic_spi_clr_priodrop(int irq)
+{
+	if (likely(irq >= 32 && irq < 1019))
+		clear_bit(irq % 32, (void *) &gic_irq_prio_drop[irq/32]);
+}
+
+/* Get IRQ pass-through status */
+int gic_spi_get_priodrop(int irq)
+{
+	if (likely(irq >= 32 && irq <= 1019))
+		return gic_irq_prio_drop[irq/32] & (1 << (irq % 32));
+
+	return 0;
+}
+#else
+static inline void gic_priodrop_remap_eoi(struct irq_chip *gic_chip)
+{
+}
+static inline void gic_enable_gicc(void __iomem *gicc_base)
+{
+	writel_relaxed(1, gicc_base + GIC_CPU_CTRL);
+}
+static void gic_eoi_sgi(u32 irqstat, void __iomem *gicc_base)
+{
+	writel_relaxed(irqstat, gicc_base + GIC_CPU_EOI);
+}
+void gic_spi_set_priodrop(int irq)
+{
+}
+void gic_spi_clr_priodrop(int irq)
+{
+}
+int gic_spi_get_priodrop(int irq)
+{
+	return 0;
+}
+#endif
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 3fd8e42..5d387ce 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -17,6 +17,7 @@
 #define GIC_CPU_EOI			0x10
 #define GIC_CPU_RUNNINGPRI		0x14
 #define GIC_CPU_HIGHPRI			0x18
+#define GIC_CPU_DIR                     0x1000

 #define GIC_DIST_CTRL			0x000
 #define GIC_DIST_CTR			0x004
@@ -74,6 +75,11 @@ static inline void gic_init(unsigned int nr, int start,
 	gic_init_bases(nr, start, dist, cpu, 0, NULL);
 }

+/* Functions to manage interrupt pass-through */
+void gic_spi_set_priodrop(int);
+void gic_spi_clr_priodrop(int);
+int gic_spi_get_priodrop(int);
+
 #endif /* __ASSEMBLY */

 #endif
-- 
1.7.9.5
