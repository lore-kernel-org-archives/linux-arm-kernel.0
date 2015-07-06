From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  6 Jul 2015 14:13:55 +0100
Subject: [PATCH 4.2-rc1 v21 3/6] irqchip: gic: Introduce plumbing for IPI FIQ
In-Reply-To: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
References: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1436188438-9478-4-git-send-email-daniel.thompson@linaro.org>
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
"secure world". However when grouping is not available (or in the case
of early GICv1 implementations is very hard to configure) the code to
change groups does not deploy and all IPIs will be raised via IRQ.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm/kernel/traps.c         |   9 ++-
 drivers/irqchip/irq-gic.c       | 168 +++++++++++++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic.h |   6 ++
 3 files changed, 171 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index d358226236f2..5634823a39cf 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -479,7 +479,14 @@ asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
 
 	nmi_enter();
 
-	/* nop. FIQ handlers for special arch/arm features can be added here. */
+	/*
+	 * Either the interrupt controller supports FIQ, meaning it will
+	 * do the right thing with this call, or we will end up treating a
+	 * spurious FIQ (which is normally fatal) as though it were an IRQ
+	 * which, although it risks deadlock, still gives us a sporting
+	 * chance of surviving long enough to log errors.
+	 */
+	handle_arch_irq(regs);
 
 	nmi_exit();
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 97b227cf3076..77d14beb0cc8 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -41,6 +41,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-acpi.h>
+#include <linux/ratelimit.h>
 
 #include <asm/cputype.h>
 #include <asm/irq.h>
@@ -50,6 +51,10 @@
 #include "irq-gic-common.h"
 #include "irqchip.h"
 
+#ifndef SMP_IPI_FIQ_MASK
+#define SMP_IPI_FIQ_MASK 0
+#endif
+
 union gic_base {
 	void __iomem *common_base;
 	void __percpu * __iomem *percpu_base;
@@ -67,6 +72,7 @@ struct gic_chip_data {
 #endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
+	bool sgi_with_nsatt;
 #ifdef CONFIG_GIC_NON_BANKED
 	void __iomem *(*get_base)(union gic_base *);
 #endif
@@ -285,12 +291,39 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
+/*
+ * Fully acknowledge (both ack and eoi) any outstanding FIQ-based IPI,
+ * otherwise do nothing.
+ */
+void gic_handle_fiq(struct pt_regs *regs)
+{
+	struct gic_chip_data *gic = &gic_data[0];
+	void __iomem *cpu_base = gic_data_cpu_base(gic);
+	unsigned long irqstat, irqnr;
+
+	while ((1u << readl_relaxed(cpu_base + GIC_CPU_HIGHPRI)) &
+	       SMP_IPI_FIQ_MASK) {
+		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
+		writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
+
+		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
+		WARN_RATELIMIT(irqnr > 16,
+			       "Unexpected irqnr %lu (bad prioritization?)\n",
+			       irqnr);
+	}
+}
+
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
 	struct gic_chip_data *gic = &gic_data[0];
 	void __iomem *cpu_base = gic_data_cpu_base(gic);
 
+	if (in_nmi()) {
+		gic_handle_fiq(regs);
+		return;
+	}
+
 	do {
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
@@ -351,6 +384,55 @@ static struct irq_chip gic_chip = {
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
 };
 
+/*
+ * Shift an interrupt between Group 0 and Group 1.
+ *
+ * In addition to changing the group we also modify the priority to
+ * match what "ARM strongly recommends" for a system where no Group 1
+ * interrupt must ever preempt a Group 0 interrupt.
+ *
+ * If is safe to call this function on systems which do not support
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
@@ -382,15 +464,24 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 static void gic_cpu_if_up(void)
 {
 	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[0]);
-	u32 bypass = 0;
+	void __iomem *dist_base = gic_data_dist_base(&gic_data[0]);
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
+
+	/*
+	 * If EnableGrp1 is set in the distributor then enable group 1
+	 * support for this CPU (and route group 0 interrupts to FIQ).
+	 */
+	if (GICD_ENABLE_GRP1 & readl_relaxed(dist_base + GIC_DIST_CTRL))
+		ctrl |= GICC_COMMON_BPR | GICC_FIQ_EN | GICC_ACK_CTL |
+			GICC_ENABLE_GRP1;
 
-	writel_relaxed(bypass | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
+	writel_relaxed(ctrl | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
 }
 
 
@@ -414,7 +505,34 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 
 	gic_dist_config(base, gic_irqs, NULL);
 
-	writel_relaxed(GICD_ENABLE, base + GIC_DIST_CTRL);
+	/*
+	 * Set EnableGrp1/EnableGrp0 (bit 1 and 0) or EnableGrp (bit 0 only,
+	 * bit 1 ignored) depending on current mode.
+	 */
+	writel_relaxed(GICD_ENABLE_GRP1 | GICD_ENABLE, base + GIC_DIST_CTRL);
+
+	/*
+	 * Some GICv1 devices (even those with security extensions) do not
+	 * implement EnableGrp1 meaning some parts of the above write might
+	 * be ignored. We will only enable FIQ support if the bit can be set.
+	 */
+	if (GICD_ENABLE_GRP1 & readl_relaxed(base + GIC_DIST_CTRL)) {
+		/*
+		 * Set all global interrupts to be group 1 (signalled with
+		 * IRQ).
+		 */
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
@@ -423,6 +541,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 	void __iomem *base = gic_data_cpu_base(gic);
 	unsigned int cpu_mask, cpu = smp_processor_id();
 	int i;
+	unsigned long ipi_fiq_mask, fiq;
 
 	/*
 	 * Get what the GIC says our CPU mask is.
@@ -441,6 +560,23 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 
 	gic_cpu_config(dist_base, NULL);
 
+	/*
+	 * If the distributor is configured to support interrupt grouping
+	 * then set any PPI and SGI interrupts not set in SMP_IPI_FIQ_MASK
+	 * to be group1 and ensure any remaining group 0 interrupts have
+	 * the right priority.
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
 	gic_cpu_if_up();
 }
@@ -451,7 +587,8 @@ void gic_cpu_if_down(void)
 	u32 val = 0;
 
 	val = readl(cpu_base + GIC_CPU_CTRL);
-	val &= ~GICC_ENABLE;
+	val &= ~(GICC_COMMON_BPR | GICC_FIQ_EN | GICC_ACK_CTL |
+		 GICC_ENABLE_GRP1 | GICC_ENABLE);
 	writel_relaxed(val, cpu_base + GIC_CPU_CTRL);
 }
 
@@ -530,7 +667,8 @@ static void gic_dist_restore(unsigned int gic_nr)
 		writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
 			dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
-	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
+	writel_relaxed(GICD_ENABLE_GRP1 | GICD_ENABLE,
+		       dist_base + GIC_DIST_CTRL);
 }
 
 static void gic_cpu_save(unsigned int gic_nr)
@@ -658,6 +796,8 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
 	int cpu;
 	unsigned long map = 0;
+	unsigned long softint;
+	void __iomem *dist_base;
 
 	gic_migration_lock();
 
@@ -665,14 +805,20 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
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
index 9de976b4f9a7..249554388142 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -22,6 +22,10 @@
 #define GIC_CPU_IDENT			0xfc
 
 #define GICC_ENABLE			0x1
+#define GICC_ENABLE_GRP1		0x2
+#define GICC_ACK_CTL			0x4
+#define GICC_FIQ_EN			0x8
+#define GICC_COMMON_BPR			0x10
 #define GICC_INT_PRI_THRESHOLD		0xf0
 #define GICC_IAR_INT_ID_MASK		0x3ff
 #define GICC_INT_SPURIOUS		1023
@@ -44,7 +48,9 @@
 #define GIC_DIST_SGI_PENDING_SET	0xf20
 
 #define GICD_ENABLE			0x1
+#define GICD_ENABLE_GRP1		0x2
 #define GICD_DISABLE			0x0
+#define GICD_SECURITY_EXTN		0x400
 #define GICD_INT_ACTLOW_LVLTRIG		0x0
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
-- 
2.4.3
