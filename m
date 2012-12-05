From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  5 Dec 2012 21:43:23 +0100
Subject: [PATCH V2] arm: mvebu: Improve the SMP support of the interrupt
 controller
Message-ID: <1354740203-26665-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the interrupt controller driver more SMP aware for
the Armada XP SoCs. It adds the support for the per-CPU irq. It also
adds the implementation for the set_affinity hook.

Patch initialy wrote by Yehuda Yitschak and reworked by Gregory
CLEMENT.

Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
 arch/arm/mach-mvebu/irq-armada-370-xp.c |   52 +++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 45a567c..088d280 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -23,7 +23,7 @@
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
 	mpic: interrupt-controller at d0020000 {
-	      reg = <0xd0020a00 0x1d0>,
+	      reg = <0xd0020a00 0x2d0>,
 		    <0xd0021070 0x58>;
 	};
 
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
index 549b684..737abd7 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -33,6 +33,7 @@
 #define ARMADA_370_XP_INT_CONTROL		(0x00)
 #define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
 #define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
+#define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
 
 #define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
 
@@ -40,28 +41,79 @@
 #define ARMADA_370_XP_IN_DRBEL_MSK_OFFS          (0xc)
 #define ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS        (0x8)
 
+#define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
+
 #define ACTIVE_DOORBELLS			(8)
 
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
 
+/*
+ * In SMP mode:
+ * For shared global interrupts, mask/unmask global enable bit
+ * For CPU interrtups, mask/unmask the calling CPU's bit
+ */
 static void armada_370_xp_irq_mask(struct irq_data *d)
 {
+#ifdef CONFIG_SMP
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	if (hwirq > ARMADA_370_XP_MAX_PER_CPU_IRQS)
+		writel(hwirq, main_int_base +
+				ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
+	else
+		writel(hwirq, per_cpu_int_base +
+				ARMADA_370_XP_INT_SET_MASK_OFFS);
+#else
 	writel(irqd_to_hwirq(d),
 	       per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
+#endif
 }
 
 static void armada_370_xp_irq_unmask(struct irq_data *d)
 {
+#ifdef CONFIG_SMP
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	if (hwirq > ARMADA_370_XP_MAX_PER_CPU_IRQS)
+		writel(hwirq, main_int_base +
+				ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+	else
+		writel(hwirq, per_cpu_int_base +
+				ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+#else
 	writel(irqd_to_hwirq(d),
 	       per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+#endif
 }
 
 #ifdef CONFIG_SMP
 static int armada_xp_set_affinity(struct irq_data *d,
 				  const struct cpumask *mask_val, bool force)
 {
+	unsigned long reg;
+	unsigned long new_mask = 0;
+	unsigned long online_mask = 0;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	int cpu;
+
+	for_each_cpu(cpu, cpu_online_mask)
+		online_mask |= 1 << cpu_logical_map(cpu);
+
+	for_each_cpu(cpu, mask_val)
+		new_mask |= 1 << cpu_logical_map(cpu);
+
+	raw_spin_lock(&irq_controller_lock);
+
+	reg = readl(main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq));
+	reg = (reg & (~online_mask)) | new_mask;
+	writel(reg, main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq));
+
+	raw_spin_unlock(&irq_controller_lock);
+
 	return 0;
 }
 #endif
-- 
1.7.9.5
