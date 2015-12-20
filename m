From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sun, 20 Dec 2015 20:52:36 +0000
Subject: [PATCH 4.4-rc5 v22 3/4] irqchip: gic: Introduce plumbing for IPI FIQ
In-Reply-To: <1450644757-18734-1-git-send-email-daniel.thompson@linaro.org>
References: <1450644757-18734-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1450644757-18734-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is not possible to exploit FIQ for systems with a GIC, even
on systems are otherwise capable of it. This patch makes it possible
for IPIs to be delivered using FIQ.

To do so it modifies the register state so that normal interrupts are
placed in group 1 and specific IPIs are placed into group 0. It also
configures the controller to raise group 0 interrupts using the FIQ
signal. Finally it provides a means for architecture code to define
which IPIs shall use FIQ and to acknowledge any IPIs that are raised.

All GIC hardware except GICv1-without-TrustZone support provides a means
to group exceptions into group 0 and group 1 but the hardware
functionality is unavailable to the kernel when a secure monitor is
present because access to the grouping registers are prohibited outside
"secure world". However when grouping is not available (or on early
GICv1 implementations where it is available but tricky to enable) the
code to change groups does not deploy and all IPIs will be raised via
IRQ.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Jon Medhurst <tixy@linaro.org>
---
 drivers/irqchip/irq-gic.c       | 183 +++++++++++++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic.h |   6 ++
 2 files changed, 175 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b6c1e96b52a1..8077edd0d38d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -41,6 +41,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/ratelimit.h>
 
 #include <asm/cputype.h>
 #include <asm/irq.h>
@@ -63,6 +64,10 @@ static void gic_check_cpu_features(void)
 #define gic_check_cpu_features()	do { } while(0)
 #endif
 
+#ifndef SMP_IPI_FIQ_MASK
+#define SMP_IPI_FIQ_MASK 0
+#endif
+
 union gic_base {
 	void __iomem *common_base;
 	void __percpu * __iomem *percpu_base;
@@ -82,6 +87,7 @@ struct gic_chip_data {
 #endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
+	bool sgi_with_nsatt;
 #ifdef CONFIG_GIC_NON_BANKED
 	void __iomem *(*get_base)(union gic_base *);
 #endif
@@ -350,12 +356,52 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
+/*
+ * Fully acknowledge (ack, eoi and deactivate) any outstanding FIQ-based IPI,
+ * otherwise do nothing.
+ */
+static void __maybe_unused gic_handle_fiq(struct pt_regs *regs)
+{
+	struct gic_chip_data *gic = &gic_data[0];
+	void __iomem *cpu_base = gic_data_cpu_base(gic);
+	u32 hppstat, hppnr, irqstat, irqnr;
+
+	do {
+		hppstat = readl_relaxed(cpu_base + GIC_CPU_HIGHPRI);
+		hppnr = hppstat & GICC_IAR_INT_ID_MASK;
+		if (!(hppnr < 16 && BIT(hppnr) & SMP_IPI_FIQ_MASK))
+			break;
+
+		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
+		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
+
+		writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
+		if (static_key_true(&supports_deactivate))
+			writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
+
+		if (WARN_RATELIMIT(irqnr > 16,
+			       "Unexpected irqnr %u (bad prioritization?)\n",
+			       irqnr))
+			continue;
+#ifdef CONFIG_SMP
+		handle_IPI(irqnr, regs);
+#endif
+	} while (1);
+}
+
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
 	struct gic_chip_data *gic = &gic_data[0];
 	void __iomem *cpu_base = gic_data_cpu_base(gic);
 
+#ifdef CONFIG_ARM
+	if (in_nmi()) {
+		gic_handle_fiq(regs);
+		return;
+	}
+#endif
+
 	do {
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
@@ -439,6 +485,55 @@ static struct irq_chip gic_eoimode1_chip = {
 				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
+/*
+ * Shift an interrupt between Group 0 and Group 1.
+ *
+ * In addition to changing the group we also modify the priority to
+ * match what "ARM strongly recommends" for a system where no Group 1
+ * interrupt must ever preempt a Group 0 interrupt.
+ *
+ * It is safe to call this function on systems which do not support
+ * grouping (it will have no effect).
+ */
+static void gic_set_group_irq(struct gic_chip_data *gic, unsigned int hwirq,
+			      int group)
+{
+	void __iomem *base = gic_data_dist_base(gic);
+	unsigned int grp_reg = hwirq / 32 * 4;
+	u32 grp_mask = BIT(hwirq % 32);
+	u32 grp_val;
+
+	unsigned int pri_reg = (hwirq / 4) * 4;
+	u32 pri_mask = BIT(7 + ((hwirq % 4) * 8));
+	u32 pri_val;
+
+	/*
+	 * Systems which do not support grouping will have not have
+	 * the EnableGrp1 bit set.
+	 */
+	if (!(GICD_ENABLE_GRP1 & readl_relaxed(base + GIC_DIST_CTRL)))
+		return;
+
+	raw_spin_lock(&irq_controller_lock);
+
+	grp_val = readl_relaxed(base + GIC_DIST_IGROUP + grp_reg);
+	pri_val = readl_relaxed(base + GIC_DIST_PRI + pri_reg);
+
+	if (group) {
+		grp_val |= grp_mask;
+		pri_val |= pri_mask;
+	} else {
+		grp_val &= ~grp_mask;
+		pri_val &= ~pri_mask;
+	}
+
+	writel_relaxed(grp_val, base + GIC_DIST_IGROUP + grp_reg);
+	writel_relaxed(pri_val, base + GIC_DIST_PRI + pri_reg);
+
+	raw_spin_unlock(&irq_controller_lock);
+}
+
+
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 {
 	if (gic_nr >= MAX_GIC_NR)
@@ -469,19 +564,27 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 static void gic_cpu_if_up(struct gic_chip_data *gic)
 {
 	void __iomem *cpu_base = gic_data_cpu_base(gic);
-	u32 bypass = 0;
-	u32 mode = 0;
+	void __iomem *dist_base = gic_data_dist_base(gic);
+	u32 ctrl = 0;
 
-	if (static_key_true(&supports_deactivate))
-		mode = GIC_CPU_CTRL_EOImodeNS;
+	/*
+	 * Preserve bypass disable bits to be written back later
+	 */
+	ctrl = readl(cpu_base + GIC_CPU_CTRL);
+	ctrl &= GICC_DIS_BYPASS_MASK;
 
 	/*
-	* Preserve bypass disable bits to be written back later
-	*/
-	bypass = readl(cpu_base + GIC_CPU_CTRL);
-	bypass &= GICC_DIS_BYPASS_MASK;
+	 * If EnableGrp1 is set in the distributor then enable group 1
+	 * support for this CPU (and route group 0 interrupts to FIQ).
+	 */
+	if (GICD_ENABLE_GRP1 & readl_relaxed(dist_base + GIC_DIST_CTRL))
+		ctrl |= GICC_COMMON_BPR | GICC_FIQ_EN | GICC_ACK_CTL |
+			GICC_ENABLE_GRP1;
+
+	if (static_key_true(&supports_deactivate))
+		ctrl |= GIC_CPU_CTRL_EOImodeNS;
 
-	writel_relaxed(bypass | mode | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
+	writel_relaxed(ctrl | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
 }
 
 
@@ -505,7 +608,31 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 
 	gic_dist_config(base, gic_irqs, NULL);
 
-	writel_relaxed(GICD_ENABLE, base + GIC_DIST_CTRL);
+	/*
+	 * Set EnableGrp1/EnableGrp0 (bit 1 and 0) or EnableGrp (bit 0 only,
+	 * bit 1 ignored) depending on current security mode.
+	 */
+	writel_relaxed(GICD_ENABLE_GRP1 | GICD_ENABLE, base + GIC_DIST_CTRL);
+
+	/*
+	 * Some GICv1 devices (even those with security extensions) do not
+	 * implement EnableGrp1 meaning some parts of the above write may
+	 * be ignored. We will only enable FIQ support if the bit can be set.
+	 */
+	if (GICD_ENABLE_GRP1 & readl_relaxed(base + GIC_DIST_CTRL)) {
+		/* Place all SPIs in group 1 (signally with IRQ). */
+		for (i = 32; i < gic_irqs; i += 32)
+			writel_relaxed(0xffffffff,
+				       base + GIC_DIST_IGROUP + i * 4 / 32);
+
+		/*
+		 * If the GIC supports the security extension then SGIs
+		 * will be filtered based on the value of NSATT. If the
+		 * GIC has this support then enable NSATT support.
+		 */
+		if (GICD_SECURITY_EXTN & readl_relaxed(base + GIC_DIST_CTR))
+			gic->sgi_with_nsatt = true;
+	}
 }
 
 static void gic_cpu_init(struct gic_chip_data *gic)
@@ -514,6 +641,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 	void __iomem *base = gic_data_cpu_base(gic);
 	unsigned int cpu_mask, cpu = smp_processor_id();
 	int i;
+	unsigned long ipi_fiq_mask, fiq;
 
 	/*
 	 * Setting up the CPU map is only relevant for the primary GIC
@@ -539,6 +667,23 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 
 	gic_cpu_config(dist_base, NULL);
 
+	/*
+	 * If the distributor is configured to support interrupt grouping
+	 * then set all SGI and PPI interrupts that are not set in
+	 * SMP_IPI_FIQ_MASK to group1 and ensure any remaining group 0
+	 * interrupts have the right priority.
+	 *
+	 * Note that IGROUP[0] is banked, meaning that although we are
+	 * writing to a distributor register we are actually performing
+	 * part of the per-cpu initialization.
+	 */
+	if (GICD_ENABLE_GRP1 & readl_relaxed(dist_base + GIC_DIST_CTRL)) {
+		ipi_fiq_mask = SMP_IPI_FIQ_MASK;
+		writel_relaxed(~ipi_fiq_mask, dist_base + GIC_DIST_IGROUP + 0);
+		for_each_set_bit(fiq, &ipi_fiq_mask, 16)
+			gic_set_group_irq(gic, fiq, 0);
+	}
+
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
 	gic_cpu_if_up(gic);
 }
@@ -553,7 +698,8 @@ int gic_cpu_if_down(unsigned int gic_nr)
 
 	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
 	val = readl(cpu_base + GIC_CPU_CTRL);
-	val &= ~GICC_ENABLE;
+	val &= ~(GICC_COMMON_BPR | GICC_FIQ_EN | GICC_ACK_CTL |
+		 GICC_ENABLE_GRP1 | GICC_ENABLE);
 	writel_relaxed(val, cpu_base + GIC_CPU_CTRL);
 
 	return 0;
@@ -648,7 +794,8 @@ static void gic_dist_restore(unsigned int gic_nr)
 			dist_base + GIC_DIST_ACTIVE_SET + i * 4);
 	}
 
-	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
+	writel_relaxed(GICD_ENABLE_GRP1 | GICD_ENABLE,
+		       dist_base + GIC_DIST_CTRL);
 }
 
 static void gic_cpu_save(unsigned int gic_nr)
@@ -794,6 +941,8 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
 	int cpu;
 	unsigned long map = 0;
+	unsigned long softint;
+	void __iomem *dist_base;
 
 	gic_migration_lock();
 
@@ -801,14 +950,20 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	for_each_cpu(cpu, mask)
 		map |= gic_cpu_map[cpu];
 
+	/* This always happens on GIC0 */
+	dist_base = gic_data_dist_base(&gic_data[0]);
+
 	/*
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before they observe us issuing the IPI.
 	 */
 	dmb(ishst);
 
-	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	softint = map << 16 | irq;
+
+	writel_relaxed(softint, dist_base + GIC_DIST_SOFTINT);
+	if (gic_data[0].sgi_with_nsatt)
+		writel_relaxed(softint | 0x8000, dist_base + GIC_DIST_SOFTINT);
 
 	gic_migration_unlock();
 }
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index bae69e5d693c..17b9e20d754e 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -23,6 +23,10 @@
 #define GIC_CPU_DEACTIVATE		0x1000
 
 #define GICC_ENABLE			0x1
+#define GICC_ENABLE_GRP1		0x2
+#define GICC_ACK_CTL			0x4
+#define GICC_FIQ_EN			0x8
+#define GICC_COMMON_BPR			0x10
 #define GICC_INT_PRI_THRESHOLD		0xf0
 
 #define GIC_CPU_CTRL_EOImodeNS		(1 << 9)
@@ -48,7 +52,9 @@
 #define GIC_DIST_SGI_PENDING_SET	0xf20
 
 #define GICD_ENABLE			0x1
+#define GICD_ENABLE_GRP1		0x2
 #define GICD_DISABLE			0x0
+#define GICD_SECURITY_EXTN		0x400
 #define GICD_INT_ACTLOW_LVLTRIG		0x0
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
-- 
2.5.0
