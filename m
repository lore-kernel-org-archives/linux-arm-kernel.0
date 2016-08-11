From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 11 Aug 2016 12:55:14 +0100
Subject: [PATCH 4.8-rc1 v23 3/4] irqchip: gic: Introduce plumbing for IPI FIQ
In-Reply-To: <1470916515-28510-1-git-send-email-daniel.thompson@linaro.org>
References: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
 <1470916515-28510-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1470916515-28510-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is not possible to exploit FIQ for systems with a GIC, even
on systems that are capable of it. This patch makes it possible
for IPIs to be delivered using FIQ.

To do so it modifies the register state so that normal interrupts are
placed in group 1 and specific IPIs are placed into group 0. It also
configures the controller to raise group 0 interrupts using the FIQ
signal. Finally it provides a means for architecture code to define
which IPIs shall use FIQ and to acknowledge any IPIs that are raised.

All GIC hardware except GICv1-without-TrustZone provides a means
to group exceptions into group 0 and group 1 but the hardware
functionality is unavailable to the kernel when a secure monitor is
present because access to the grouping registers are prohibited outside
secure world. When grouping is not available (or on early GICv1
implementations where it is present but tricky to enable) the code to
change groups does not deploy and all IPIs will be raised via IRQ.

Previous versions of this patch were tested-by Jon Medhurst
<tixy@linaro.org> (thanks!). However I have removed the Tested-by:
for this release because the changes are to great to carry it
over.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jon Medhurst <tixy@linaro.org>
---
 drivers/irqchip/irq-gic.c       | 200 +++++++++++++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic.h |   6 ++
 2 files changed, 191 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4bd423d7b01a..8827593feae3 100644
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
@@ -86,6 +91,9 @@ struct gic_chip_data {
 #endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
+	bool has_grouping_support;
+	bool needs_sgi_with_nsatt;
+	u16 __percpu *sgi_with_nsatt_mask;
 #ifdef CONFIG_GIC_NON_BANKED
 	void __iomem *(*get_base)(union gic_base *);
 #endif
@@ -352,12 +360,59 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
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
+		if (WARN_RATELIMIT(irqnr > 15,
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
+	/*
+	 * ARMv8 added new architectural features that allow NMI to be
+	 * emulated without resorting to FIQ. For that reason we can
+	 * skip this check on 64-bit systems, it would be harmless on
+	 * these systems but it would also be pointless because in_nmi()
+	 * could never be true here.
+	 */
+	if (in_nmi()) {
+		gic_handle_fiq(regs);
+		return;
+	}
+#endif
+
 	do {
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
@@ -428,6 +483,54 @@ static struct irq_chip gic_chip = {
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
+	u32 grp_val, pri_val;
+
+	if (!gic->has_grouping_support)
+		return;
+
+	raw_spin_lock(&irq_controller_lock);
+
+	grp_val = readl_relaxed(base + GIC_DIST_IGROUP + grp_reg);
+	pri_val = readb_relaxed(base + GIC_DIST_PRI + hwirq);
+
+	if (group) {
+		grp_val |= grp_mask;
+		pri_val |= BIT(7);
+	} else {
+		grp_val &= ~grp_mask;
+		pri_val &= ~BIT(7);
+	}
+
+	writel_relaxed(grp_val, base + GIC_DIST_IGROUP + grp_reg);
+	writeb_relaxed(pri_val, base + GIC_DIST_PRI + hwirq);
+
+	if (hwirq < 16 && gic->needs_sgi_with_nsatt) {
+		if (group)
+			raw_cpu_or(*gic->sgi_with_nsatt_mask, (u16)BIT(hwirq));
+		else
+			raw_cpu_and(*gic->sgi_with_nsatt_mask,
+				    (u16) ~BIT(hwirq));
+	}
+
+	raw_spin_unlock(&irq_controller_lock);
+}
+
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 {
 	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
@@ -457,19 +560,22 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 static void gic_cpu_if_up(struct gic_chip_data *gic)
 {
 	void __iomem *cpu_base = gic_data_cpu_base(gic);
-	u32 bypass = 0;
-	u32 mode = 0;
-
-	if (gic == &gic_data[0] && static_key_true(&supports_deactivate))
-		mode = GIC_CPU_CTRL_EOImodeNS;
+	u32 ctrl = 0;
 
 	/*
-	* Preserve bypass disable bits to be written back later
-	*/
-	bypass = readl(cpu_base + GIC_CPU_CTRL);
-	bypass &= GICC_DIS_BYPASS_MASK;
+	 * Preserve bypass disable bits to be written back later
+	 */
+	ctrl = readl(cpu_base + GIC_CPU_CTRL);
+	ctrl &= GICC_DIS_BYPASS_MASK;
 
-	writel_relaxed(bypass | mode | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
+	if (gic->has_grouping_support)
+		ctrl |= GICC_COMMON_BPR | GICC_FIQ_EN | GICC_ACK_CTL |
+			GICC_ENABLE_GRP1;
+
+	if (gic == &gic_data[0] && static_key_true(&supports_deactivate))
+		ctrl |= GIC_CPU_CTRL_EOImodeNS;
+
+	writel_relaxed(ctrl | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
 }
 
 
@@ -493,7 +599,34 @@ static void gic_dist_init(struct gic_chip_data *gic)
 
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
+	if (readl_relaxed(base + GIC_DIST_CTRL) & GICD_ENABLE_GRP1) {
+		/* Cache whether we support grouping */
+		gic->has_grouping_support = true;
+
+		/* Place all SPIs in group 1 (signal with IRQ). */
+		for (i = 32; i < gic_irqs; i += 32)
+			writel_relaxed(0xffffffff,
+				       base + GIC_DIST_IGROUP + i * 4 / 32);
+
+		/*
+		 * If the GIC supports the security extension then SGIs
+		 * will be filtered based on the value of NSATT. If the
+		 * GIC has this support then enable NSATT support.
+		 */
+		if (readl_relaxed(base + GIC_DIST_CTR) & GICD_SECURITY_EXTN)
+			gic->needs_sgi_with_nsatt = true;
+	}
 }
 
 static int gic_cpu_init(struct gic_chip_data *gic)
@@ -502,6 +635,8 @@ static int gic_cpu_init(struct gic_chip_data *gic)
 	void __iomem *base = gic_data_cpu_base(gic);
 	unsigned int cpu_mask, cpu = smp_processor_id();
 	int i;
+	unsigned long ipi_fiq_mask;
+	unsigned int fiq;
 
 	/*
 	 * Setting up the CPU map is only relevant for the primary GIC
@@ -530,6 +665,26 @@ static int gic_cpu_init(struct gic_chip_data *gic)
 
 	gic_cpu_config(dist_base, NULL);
 
+	/*
+	 * If the distributor is configured to support interrupt grouping
+	 * then set all SGI and PPI interrupts to group 1 and then,
+	 * based on SMP_IPI_FIQ_MASK, return the FIQ based IPIs back to
+	 * group 0 (updating meta-data and prioritization at the same
+	 * time).
+	 *
+	 * Note that IGROUP[0] is banked, meaning that although we are
+	 * writing to a distributor register we are actually performing
+	 * part of the per-cpu initialization.
+	 */
+	if (gic->has_grouping_support) {
+		writel_relaxed(0xffffffff, dist_base + GIC_DIST_IGROUP + 0);
+		__this_cpu_write(*gic->sgi_with_nsatt_mask, 0xffff);
+
+		ipi_fiq_mask = SMP_IPI_FIQ_MASK;
+		for_each_set_bit(fiq, &ipi_fiq_mask, 16)
+			gic_set_group_irq(gic, fiq, 0);
+	}
+
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
 	gic_cpu_if_up(gic);
 
@@ -546,7 +701,8 @@ int gic_cpu_if_down(unsigned int gic_nr)
 
 	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
 	val = readl(cpu_base + GIC_CPU_CTRL);
-	val &= ~GICC_ENABLE;
+	val &= ~(GICC_COMMON_BPR | GICC_FIQ_EN | GICC_ACK_CTL |
+		 GICC_ENABLE_GRP1 | GICC_ENABLE);
 	writel_relaxed(val, cpu_base + GIC_CPU_CTRL);
 
 	return 0;
@@ -641,7 +797,8 @@ void gic_dist_restore(struct gic_chip_data *gic)
 			dist_base + GIC_DIST_ACTIVE_SET + i * 4);
 	}
 
-	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
+	writel_relaxed(GICD_ENABLE_GRP1 | GICD_ENABLE,
+		       dist_base + GIC_DIST_CTRL);
 }
 
 void gic_cpu_save(struct gic_chip_data *gic)
@@ -800,6 +957,8 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
 	int cpu;
 	unsigned long map = 0;
+	unsigned long softint;
+	void __iomem *dist_base;
 
 	gic_migration_lock();
 
@@ -807,14 +966,19 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
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
+	if (this_cpu_read(*gic_data[0].sgi_with_nsatt_mask) & BIT(irq))
+		softint |= 0x8000;
+	writel_relaxed(softint, dist_base + GIC_DIST_SOFTINT);
 
 	gic_migration_unlock();
 }
@@ -1166,6 +1330,12 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 		goto error;
 	}
 
+	gic->sgi_with_nsatt_mask = alloc_percpu(u16);
+	if (WARN_ON(!gic->sgi_with_nsatt_mask)) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
 	gic_dist_init(gic);
 	ret = gic_cpu_init(gic);
 	if (ret)
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index eafc965b3eb8..86dae600aef1 100644
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
@@ -49,7 +53,9 @@
 #define GIC_DIST_SGI_PENDING_SET	0xf20
 
 #define GICD_ENABLE			0x1
+#define GICD_ENABLE_GRP1		0x2
 #define GICD_DISABLE			0x0
+#define GICD_SECURITY_EXTN		0x400
 #define GICD_INT_ACTLOW_LVLTRIG		0x0
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
-- 
2.7.4
