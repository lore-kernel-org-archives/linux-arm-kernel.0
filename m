From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 21 Feb 2012 10:03:25 +0530
Subject: [PATCH v4 1/2] ARM: Exynos: Add irq_domain support for interrupt
 combiner
In-Reply-To: <1329798806-32482-1-git-send-email-thomas.abraham@linaro.org>
References: <1329798806-32482-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1329798806-32482-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq_domain support for hardware interrupts of the interrupt combiner.
The hardware interrupts of all the instances of the combiner are grouped
in a single irq_domain.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c |   65 ++++++++++++++++++++++++++++------------
 1 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index f494db8..0c06fa6 100644
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
@@ -284,6 +286,7 @@ struct combiner_chip_data {
 	void __iomem *base;
 };
 
+static struct irq_domain *combiner_irq_domain;
 static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
 
 static inline void __iomem *combiner_base(struct irq_data *data)
@@ -296,14 +299,14 @@ static inline void __iomem *combiner_base(struct irq_data *data)
 
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
@@ -352,30 +355,58 @@ static void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int i
 	irq_set_chained_handler(irq, combiner_handle_cascade_irq);
 }
 
-static void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
-			  unsigned int irq_start)
+static void __init combiner_init_one(unsigned int combiner_nr,
+						void __iomem *base)
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
+static int combiner_irq_domain_map(struct irq_domain *d, unsigned int irq,
+					irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &combiner_chip, handle_level_irq);
+	irq_set_chip_data(irq, &combiner_data[hw >> 3]);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	return 0;
+}
 
-	/* Setup the Linux IRQ subsystem */
+static struct irq_domain_ops combiner_irq_domain_ops = {
+	.map = combiner_irq_domain_map,
+};
 
-	for (i = irq_start; i < combiner_data[combiner_nr].irq_offset
-				+ MAX_IRQ_IN_COMBINER; i++) {
-		irq_set_chip_and_handler(i, &combiner_chip, handle_level_irq);
-		irq_set_chip_data(i, &combiner_data[combiner_nr]);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+void __init combiner_init(void __iomem *combiner_base, struct device_node *np)
+{
+	int i, irq_base;
+	int nr_irq = MAX_COMBINER_NR * MAX_IRQ_IN_COMBINER;
+
+	irq_base = irq_alloc_descs(COMBINER_IRQ(0, 0), 1, nr_irq, 0);
+	if (IS_ERR_VALUE(irq_base)) {
+		irq_base = COMBINER_IRQ(0, 0);
+		pr_warning("combiner_init_irq_domain: irq desc alloc failed. "
+			"Continuing with %d as linux irq base\n", irq_base);
+	}
+
+	combiner_irq_domain = irq_domain_add_legacy(np, nr_irq, irq_base, 0,
+				&combiner_irq_domain_ops, &combiner_data);
+	if (WARN_ON(!combiner_irq_domain)) {
+		pr_warning("combiner_init_irq_domain: irq domain init failed\n");
+		return;
+	}
+
+	for (i = 0; i < MAX_COMBINER_NR; i++) {
+		combiner_init_one(i, combiner_base + (i >> 2) * 0x10);
+		combiner_cascade_irq(i, IRQ_SPI(i));
 	}
 }
 
@@ -388,7 +419,6 @@ static const struct of_device_id exynos4_dt_irq_match[] = {
 
 void __init exynos4_init_irq(void)
 {
-	int irq;
 	unsigned int gic_bank_offset;
 
 	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
@@ -400,12 +430,7 @@ void __init exynos4_init_irq(void)
 		of_irq_init(exynos4_dt_irq_match);
 #endif
 
-	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
-
-		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
-				COMBINER_IRQ(irq, 0));
-		combiner_cascade_irq(irq, IRQ_SPI(irq));
-	}
+	combiner_init(S5P_VA_COMBINER_BASE, NULL);
 
 	/*
 	 * The parameters of s5p_init_irq() are for VIC init.
-- 
1.6.6.rc2
