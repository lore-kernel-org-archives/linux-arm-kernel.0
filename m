From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 02:05:07 +0200
Subject: [PATCH 25/30] irqchip: exynos: pass max combiner number to
 combiner_init
In-Reply-To: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
Message-ID: <1365638712-1028578-26-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can find out the number of combined IRQs from the device
tree, but in case of ATAGS boot, the driver currently uses
hardcoded values based on the SoC type. We can't do that
in general for a multiplatform kernel, so let's instead pass
this information from platform code directly in case of
ATAGS boot.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-exynos/common.c     | 15 ++++++++++++-
 arch/arm/mach-exynos/common.h     |  3 ++-
 drivers/irqchip/exynos-combiner.c | 46 ++++++++++++++-------------------------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 8e85d6c..b0e0b41 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -452,6 +452,19 @@ void __init exynos_init_time(void)
 	}
 }
 
+static unsigned int max_combiner_nr(void)
+{
+	if (soc_is_exynos5250())
+		return EXYNOS5_MAX_COMBINER_NR;
+	else if (soc_is_exynos4412())
+		return EXYNOS4412_MAX_COMBINER_NR;
+	else if (soc_is_exynos4212())
+		return EXYNOS4212_MAX_COMBINER_NR;
+	else
+		return EXYNOS4210_MAX_COMBINER_NR;
+}
+
+
 void __init exynos4_init_irq(void)
 {
 	unsigned int gic_bank_offset;
@@ -466,7 +479,7 @@ void __init exynos4_init_irq(void)
 #endif
 
 	if (!of_have_populated_dt())
-		combiner_init(S5P_VA_COMBINER_BASE, NULL);
+		combiner_init(S5P_VA_COMBINER_BASE, NULL, max_combiner_nr());
 
 	/*
 	 * The parameters of s5p_init_irq() are for VIC init.
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index f426a5b..49bebd1 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -71,7 +71,8 @@ void exynos4212_register_clocks(void);
 #endif
 
 struct device_node;
-void combiner_init(void __iomem *combiner_base, struct device_node *np);
+void combiner_init(void __iomem *combiner_base, struct device_node *np,
+			unsigned int max_nr);
 
 extern struct smp_operations exynos_smp_ops;
 
diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 02492ab..e7aef59 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -26,6 +26,8 @@
 #define COMBINER_ENABLE_CLEAR	0x4
 #define COMBINER_INT_STATUS	0xC
 
+#define IRQ_IN_COMBINER		8
+
 static DEFINE_SPINLOCK(irq_controller_lock);
 
 struct combiner_chip_data {
@@ -113,23 +115,9 @@ static struct irq_chip combiner_chip = {
 #endif
 };
 
-static unsigned int max_combiner_nr(void)
-{
-	if (soc_is_exynos5250())
-		return EXYNOS5_MAX_COMBINER_NR;
-	else if (soc_is_exynos4412())
-		return EXYNOS4412_MAX_COMBINER_NR;
-	else if (soc_is_exynos4212())
-		return EXYNOS4212_MAX_COMBINER_NR;
-	else
-		return EXYNOS4210_MAX_COMBINER_NR;
-}
-
 static void __init combiner_cascade_irq(unsigned int combiner_nr,
 					unsigned int irq)
 {
-	if (combiner_nr >= max_combiner_nr())
-		BUG();
 	if (irq_set_handler_data(irq, &combiner_data[combiner_nr]) != 0)
 		BUG();
 	irq_set_chained_handler(irq, combiner_handle_cascade_irq);
@@ -140,7 +128,7 @@ static void __init combiner_init_one(unsigned int combiner_nr,
 {
 	combiner_data[combiner_nr].base = base;
 	combiner_data[combiner_nr].irq_offset = irq_find_mapping(
-		combiner_irq_domain, combiner_nr * MAX_IRQ_IN_COMBINER);
+		combiner_irq_domain, combiner_nr * IRQ_IN_COMBINER);
 	combiner_data[combiner_nr].irq_mask = 0xff << ((combiner_nr % 4) << 3);
 	combiner_data[combiner_nr].parent_irq = irq;
 
@@ -162,7 +150,7 @@ static int combiner_irq_domain_xlate(struct irq_domain *d,
 	if (intsize < 2)
 		return -EINVAL;
 
-	*out_hwirq = intspec[0] * MAX_IRQ_IN_COMBINER + intspec[1];
+	*out_hwirq = intspec[0] * IRQ_IN_COMBINER + intspec[1];
 	*out_type = 0;
 
 	return 0;
@@ -210,22 +198,13 @@ static unsigned int exynos4x12_combiner_extra_irq(int group)
 }
 
 void __init combiner_init(void __iomem *combiner_base,
-			  struct device_node *np)
+			  struct device_node *np,
+			  unsigned int max_nr)
 {
 	int i, irq, irq_base;
-	unsigned int max_nr, nr_irq;
+	unsigned int nr_irq;
 
-	max_nr = max_combiner_nr();
-
-	if (np) {
-		if (of_property_read_u32(np, "samsung,combiner-nr", &max_nr)) {
-			pr_info("%s: number of combiners not specified, "
-				"setting default as %d.\n",
-				__func__, max_nr);
-		}
-	}
-
-	nr_irq = max_nr * MAX_IRQ_IN_COMBINER;
+	nr_irq = max_nr * IRQ_IN_COMBINER;
 
 	irq_base = irq_alloc_descs(COMBINER_IRQ(0, 0), 1, nr_irq, 0);
 	if (IS_ERR_VALUE(irq_base)) {
@@ -259,6 +238,7 @@ static int __init combiner_of_init(struct device_node *np,
 				   struct device_node *parent)
 {
 	void __iomem *combiner_base;
+	unsigned int max_nr;
 
 	combiner_base = of_iomap(np, 0);
 	if (!combiner_base) {
@@ -266,7 +246,13 @@ static int __init combiner_of_init(struct device_node *np,
 		return -ENXIO;
 	}
 
-	combiner_init(combiner_base, np);
+	if (of_property_read_u32(np, "samsung,combiner-nr", &max_nr)) {
+		pr_info("%s: number of combiners not specified, "
+			"setting default as %d.\n",
+			__func__, max_nr);
+	}
+
+	combiner_init(combiner_base, np, max_nr);
 
 	return 0;
 }
-- 
1.8.1.2
