From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed,  8 Feb 2012 10:10:04 -0800
Subject: [PATCH] ARM: Exynos: Add irq domain and device tree support for
 interrupt combiner
Message-ID: <1328724604-11192-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common irq domain for the interrupts managed by the interrupt combiners is
setup. All the instances of irq combiner reference the common irq domain for
translating hardware interrupts to linux irq number.

In case of device tree based boot, a interrupt specifier translator is setup
that can translate interrupt specifiers for device nodes which use combiner
as their interrupt parent.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
Changes since v2:
- Rebased to Grant's irqdomain/next branch.

Changes since v1:
- Includes all changes suggested by Rob Herring.
- Tested with SPARSE_IRQ enabled.

 arch/arm/mach-exynos/common.c |  100 ++++++++++++++++++++++++++++++++--------
 1 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 6de298c..24693f0 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -19,6 +19,8 @@
 #include <linux/serial_core.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/export.h>
+#include <linux/irqdomain.h>
 
 #include <asm/proc-fns.h>
 #include <asm/exception.h>
@@ -292,6 +294,7 @@ struct combiner_chip_data {
 	void __iomem *base;
 };
 
+static struct irq_domain *combiner_irq_domain;
 static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
 
 static inline void __iomem *combiner_base(struct irq_data *data)
@@ -304,14 +307,14 @@ static inline void __iomem *combiner_base(struct irq_data *data)
 
 static void combiner_mask_irq(struct irq_data *data)
 {
-	u32 mask = 1 << (data->irq % 32);
+	u32 mask = 1 << (data->hwirq % 32);
 
 	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_CLEAR);
 }
 
 static void combiner_unmask_irq(struct irq_data *data)
 {
-	u32 mask = 1 << (data->irq % 32);
+	u32 mask = 1 << (data->hwirq % 32);
 
 	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_SET);
 }
@@ -360,43 +363,104 @@ static void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int i
 	irq_set_chained_handler(irq, combiner_handle_cascade_irq);
 }
 
-static void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
-			  unsigned int irq_start)
+static void __init combiner_init(unsigned int combiner_nr, void __iomem *base)
 {
-	unsigned int i;
-
 	if (combiner_nr >= MAX_COMBINER_NR)
 		BUG();
 
 	combiner_data[combiner_nr].base = base;
-	combiner_data[combiner_nr].irq_offset = irq_start;
+	combiner_data[combiner_nr].irq_offset = irq_find_mapping(
+		combiner_irq_domain, combiner_nr * MAX_IRQ_IN_COMBINER);
 	combiner_data[combiner_nr].irq_mask = 0xff << ((combiner_nr % 4) << 3);
 
 	/* Disable all interrupts */
 
 	__raw_writel(combiner_data[combiner_nr].irq_mask,
 		     base + COMBINER_ENABLE_CLEAR);
+}
+
+#ifdef CONFIG_OF
+static int combiner_irq_domain_xlate(struct irq_domain *d,
+		struct device_node *controller, const u32 *intspec,
+		unsigned int intsize, unsigned long *out_hwirq,
+		unsigned int *out_type)
+{
+	if (d->of_node != controller)
+		return -EINVAL;
+	if (intsize < 2)
+		return -EINVAL;
+	*out_hwirq = intspec[0] * MAX_IRQ_IN_COMBINER + intspec[1];
+	*out_type = 0;
+	return 0;
+}
+#else
+static int combiner_irq_domain_xlate(struct irq_domain *d,
+		struct device_node *controller, const u32 *intspec,
+		unsigned int intsize, unsigned long *out_hwirq,
+		unsigned int *out_type)
+{
+	return 0;
+}
+#endif
+
+static int combiner_irq_domain_map(struct irq_domain *d, unsigned int irq,
+					irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &combiner_chip, handle_level_irq);
+	irq_set_chip_data(irq, &combiner_data[hw >> 3]);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	return 0;
+}
+
+static struct irq_domain_ops combiner_irq_domain_ops = {
+	.xlate = combiner_irq_domain_xlate,
+	.map = combiner_irq_domain_map,
+};
+
+int __init combiner_init_irq_domain(int virq_base, unsigned int nr_irq,
+					struct device_node *np)
+{
+	int irq_base;
+
+	irq_base = irq_alloc_descs(virq_base, 1, nr_irq, 0);
+	if (IS_ERR_VALUE(irq_base)) {
+		pr_warning("combiner_init_irq_domain: irq desc alloc failed\n");
+		irq_base = virq_base;
+	}
+
+	combiner_irq_domain = irq_domain_add_legacy(np, nr_irq, irq_base, 0,
+				&combiner_irq_domain_ops, &combiner_data);
+	if (WARN_ON(!combiner_irq_domain))
+		return -EINVAL;
 
-	/* Setup the Linux IRQ subsystem */
+	return 0;
+}
+
+void __init combiner_of_init(struct device_node *np, struct device_node *parent)
+{
+	int irq;
 
-	for (i = irq_start; i < combiner_data[combiner_nr].irq_offset
-				+ MAX_IRQ_IN_COMBINER; i++) {
-		irq_set_chip_and_handler(i, &combiner_chip, handle_level_irq);
-		irq_set_chip_data(i, &combiner_data[combiner_nr]);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+	if (combiner_init_irq_domain(COMBINER_IRQ(0, 0), MAX_COMBINER_NR *
+					MAX_IRQ_IN_COMBINER, np))
+		BUG();
+	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
+		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq));
+		combiner_cascade_irq(irq, IRQ_SPI(irq));
 	}
 }
 
+
 #ifdef CONFIG_OF
 static const struct of_device_id exynos4_dt_irq_match[] = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ .compatible = "samsung,exynos4120-combiner",
+			.data = combiner_of_init, },
 	{},
 };
 #endif
 
 void __init exynos4_init_irq(void)
 {
-	int irq;
 	unsigned int gic_bank_offset;
 
 	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
@@ -408,12 +472,8 @@ void __init exynos4_init_irq(void)
 		of_irq_init(exynos4_dt_irq_match);
 #endif
 
-	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
-
-		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
-				COMBINER_IRQ(irq, 0));
-		combiner_cascade_irq(irq, IRQ_SPI(irq));
-	}
+	if (!of_have_populated_dt())
+		combiner_of_init(NULL, NULL);
 
 	/*
 	 * The parameters of s5p_init_irq() are for VIC init.
-- 
1.7.5.4
