From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  2 Apr 2012 12:15:29 -0700
Subject: [PATCH] ARM: EXYNOS: convert irq combiner to generic irq chip
Message-ID: <1333394129-20624-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

The irq combiner is very simple, convert it to a generic irq chip.
Also adds a resume handler to restore the masks after suspend.

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c |   71 +++++++++++++++++-----------------------
 1 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index e6cc50e..ec7680c 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -391,28 +391,6 @@ struct combiner_chip_data {
 
 static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
 
-static inline void __iomem *combiner_base(struct irq_data *data)
-{
-	struct combiner_chip_data *combiner_data =
-		irq_data_get_irq_chip_data(data);
-
-	return combiner_data->base;
-}
-
-static void combiner_mask_irq(struct irq_data *data)
-{
-	u32 mask = 1 << (data->irq % 32);
-
-	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_CLEAR);
-}
-
-static void combiner_unmask_irq(struct irq_data *data)
-{
-	u32 mask = 1 << (data->irq % 32);
-
-	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_SET);
-}
-
 static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 {
 	struct combiner_chip_data *chip_data = irq_get_handler_data(irq);
@@ -442,12 +420,6 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static struct irq_chip combiner_chip = {
-	.name		= "COMBINER",
-	.irq_mask	= combiner_mask_irq,
-	.irq_unmask	= combiner_unmask_irq,
-};
-
 static void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq)
 {
 	unsigned int max_nr;
@@ -464,11 +436,20 @@ static void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int i
 	irq_set_chained_handler(irq, combiner_handle_cascade_irq);
 }
 
+static void combiner_resume(struct irq_data *data)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+
+	__raw_writel(~gc->mask_cache, gc->reg_base + COMBINER_ENABLE_CLEAR);
+	__raw_writel(gc->mask_cache, gc->reg_base + COMBINER_ENABLE_SET);
+}
+
 static void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
 			  unsigned int irq_start)
 {
-	unsigned int i;
 	unsigned int max_nr;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
 
 	if (soc_is_exynos5250())
 		max_nr = EXYNOS5_MAX_COMBINER_NR;
@@ -482,18 +463,26 @@ static void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
 	combiner_data[combiner_nr].irq_offset = irq_start;
 	combiner_data[combiner_nr].irq_mask = 0xff << ((combiner_nr % 4) << 3);
 
-	/* Disable all interrupts */
+	if ((combiner_nr % 4) == 0) {
+		/* Disable all interrupts */
 
-	__raw_writel(combiner_data[combiner_nr].irq_mask,
-		     base + COMBINER_ENABLE_CLEAR);
+		__raw_writel(IRQ_MSK(32), base + COMBINER_ENABLE_CLEAR);
 
-	/* Setup the Linux IRQ subsystem */
+		gc = irq_alloc_generic_chip("combiner", 1, irq_start,
+					    base, handle_level_irq);
+		if (!gc) {
+			pr_err("Failed to allocate combiner irq chip\n");
+			return;
+		}
 
-	for (i = irq_start; i < combiner_data[combiner_nr].irq_offset
-				+ MAX_IRQ_IN_COMBINER; i++) {
-		irq_set_chip_and_handler(i, &combiner_chip, handle_level_irq);
-		irq_set_chip_data(i, &combiner_data[combiner_nr]);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+		ct = gc->chip_types;
+		ct->chip.irq_mask = irq_gc_mask_disable_reg;
+		ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+		ct->chip.irq_resume = combiner_resume;
+		ct->regs.enable = COMBINER_ENABLE_SET;
+		ct->regs.disable = COMBINER_ENABLE_CLEAR;
+		irq_setup_generic_chip(gc, IRQ_MSK(32), 0,
+			IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 	}
 }
 
-- 
1.7.2.3
