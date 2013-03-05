From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:12 +0100
Subject: [PATCH 02/23] irqchip: exynos: remove dependency on mach/irqs.h
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a preparation for multiplatform, this changes the exynos
"combiner" irqchip to no longer make any assumptions about
using specific IRQ numbers or the number of combiners in the
system.

For this, we have to revert to always initializing the combiner
explicitly from architecture code, rather than using the new
irqchip_init function as we should. The problem is the
dependency on the IRQ base value for the combiner, which is
currently hardcoded in the mach/irqs.h file. Once that file
becomes unused, we can move to irqchip_init again.

Getting rid of the dependency on the number of combiners
actually cleans up the code, because we also remove the
global combiner_data array and pass dynamically allocated
pointers through the irq domain instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/common.c     |   5 +-
 arch/arm/mach-exynos/common.h     |   2 +-
 drivers/irqchip/exynos-combiner.c | 113 ++++++++++++++++++++------------------
 3 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index d63d399..4b4526d 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -443,6 +443,7 @@ static void __init exynos5_init_clocks(int xtal)
 
 void __init exynos4_init_irq(void)
 {
+	struct device_node *dn;
 	unsigned int gic_bank_offset;
 
 	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
@@ -454,8 +455,8 @@ void __init exynos4_init_irq(void)
 		irqchip_init();
 #endif
 
-	if (!of_have_populated_dt())
-		combiner_init(S5P_VA_COMBINER_BASE, NULL);
+	dn = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-combiner");
+	combiner_init(S5P_VA_COMBINER_BASE, COMBINER_IRQ(0, 0), dn);
 
 	/*
 	 * The parameters of s5p_init_irq() are for VIC init.
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9339bb8..ed96450 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -61,7 +61,7 @@ void exynos4212_register_clocks(void);
 #endif
 
 struct device_node;
-void combiner_init(void __iomem *combiner_base, struct device_node *np);
+void combiner_init(void __iomem *combiner_base, int irq_base, struct device_node *np);
 
 extern struct smp_operations exynos_smp_ops;
 
diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 04d86a9..1276d4e 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -15,9 +15,13 @@
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <asm/mach/irq.h>
+#include <linux/slab.h>
 
+#ifdef CONFIG_EXYNOS_ATAGS
 #include <plat/cpu.h>
+#endif
+
+#include <asm/mach/irq.h>
 
 #include "irqchip.h"
 
@@ -25,6 +29,8 @@
 #define COMBINER_ENABLE_CLEAR	0x4
 #define COMBINER_INT_STATUS	0xC
 
+#define IRQ_IN_COMBINER		8
+
 static DEFINE_SPINLOCK(irq_controller_lock);
 
 struct combiner_chip_data {
@@ -33,9 +39,6 @@ struct combiner_chip_data {
 	void __iomem *base;
 };
 
-static struct irq_domain *combiner_irq_domain;
-static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
-
 static inline void __iomem *combiner_base(struct irq_data *data)
 {
 	struct combiner_chip_data *combiner_data =
@@ -93,35 +96,6 @@ static struct irq_chip combiner_chip = {
 	.irq_unmask	= combiner_unmask_irq,
 };
 
-static void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq)
-{
-	unsigned int max_nr;
-
-	if (soc_is_exynos5250())
-		max_nr = EXYNOS5_MAX_COMBINER_NR;
-	else
-		max_nr = EXYNOS4_MAX_COMBINER_NR;
-
-	if (combiner_nr >= max_nr)
-		BUG();
-	if (irq_set_handler_data(irq, &combiner_data[combiner_nr]) != 0)
-		BUG();
-	irq_set_chained_handler(irq, combiner_handle_cascade_irq);
-}
-
-static void __init combiner_init_one(unsigned int combiner_nr,
-				     void __iomem *base)
-{
-	combiner_data[combiner_nr].base = base;
-	combiner_data[combiner_nr].irq_offset = irq_find_mapping(
-		combiner_irq_domain, combiner_nr * MAX_IRQ_IN_COMBINER);
-	combiner_data[combiner_nr].irq_mask = 0xff << ((combiner_nr % 4) << 3);
-
-	/* Disable all interrupts */
-	__raw_writel(combiner_data[combiner_nr].irq_mask,
-		     base + COMBINER_ENABLE_CLEAR);
-}
-
 #ifdef CONFIG_OF
 static int combiner_irq_domain_xlate(struct irq_domain *d,
 				     struct device_node *controller,
@@ -135,7 +109,7 @@ static int combiner_irq_domain_xlate(struct irq_domain *d,
 	if (intsize < 2)
 		return -EINVAL;
 
-	*out_hwirq = intspec[0] * MAX_IRQ_IN_COMBINER + intspec[1];
+	*out_hwirq = intspec[0] * IRQ_IN_COMBINER + intspec[1];
 	*out_type = 0;
 
 	return 0;
@@ -154,6 +128,8 @@ static int combiner_irq_domain_xlate(struct irq_domain *d,
 static int combiner_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				   irq_hw_number_t hw)
 {
+	struct combiner_chip_data *combiner_data = d->host_data;
+
 	irq_set_chip_and_handler(irq, &combiner_chip, handle_level_irq);
 	irq_set_chip_data(irq, &combiner_data[hw >> 3]);
 	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
@@ -167,49 +143,80 @@ static struct irq_domain_ops combiner_irq_domain_ops = {
 };
 
 void __init combiner_init(void __iomem *combiner_base,
+			  int plat_irq_base,
 			  struct device_node *np)
 {
 	int i, irq, irq_base;
 	unsigned int max_nr, nr_irq;
+	struct irq_domain *domain;
+	struct combiner_chip_data *combiner_data;
 
-	if (np) {
-		if (of_property_read_u32(np, "samsung,combiner-nr", &max_nr)) {
-			pr_warning("%s: number of combiners not specified, "
-				"setting default as %d.\n",
-				__func__, EXYNOS4_MAX_COMBINER_NR);
-			max_nr = EXYNOS4_MAX_COMBINER_NR;
-		}
-	} else {
+	max_nr = 0;
+	if (of_property_read_u32(np, "samsung,combiner-nr", &max_nr)) {
+#ifdef CONFIG_EXYNOS_ATAGS
 		max_nr = soc_is_exynos5250() ? EXYNOS5_MAX_COMBINER_NR :
-						EXYNOS4_MAX_COMBINER_NR;
+					       EXYNOS4_MAX_COMBINER_NR;
+		pr_warning("%s: number of combiners not specified, "
+			   "setting default as %d.\n", __func__, max_nr);
+#endif
 	}
-	nr_irq = max_nr * MAX_IRQ_IN_COMBINER;
+	if (!max_nr)
+		return;
+
+	nr_irq = max_nr * IRQ_IN_COMBINER;
 
-	irq_base = irq_alloc_descs(COMBINER_IRQ(0, 0), 1, nr_irq, 0);
+	irq_base = irq_alloc_descs(plat_irq_base, 1, nr_irq, 0);
 	if (IS_ERR_VALUE(irq_base)) {
-		irq_base = COMBINER_IRQ(0, 0);
+		irq_base = plat_irq_base;
 		pr_warning("%s: irq desc alloc failed. Continuing with %d as linux irq base\n", __func__, irq_base);
 	}
 
-	combiner_irq_domain = irq_domain_add_legacy(np, nr_irq, irq_base, 0,
-				&combiner_irq_domain_ops, &combiner_data);
-	if (WARN_ON(!combiner_irq_domain)) {
+	combiner_data = kcalloc(max_nr, sizeof *combiner_data, GFP_KERNEL);
+	if (WARN_ON(!combiner_data)) {
+		pr_warning("%s: combiner data alloc failed\n", __func__);
+		return;
+	}
+
+	domain = irq_domain_add_legacy(np, nr_irq, irq_base, 0,
+				&combiner_irq_domain_ops, combiner_data);
+	if (WARN_ON(!domain)) {
 		pr_warning("%s: irq domain init failed\n", __func__);
 		return;
 	}
 
 	for (i = 0; i < max_nr; i++) {
-		combiner_init_one(i, combiner_base + (i >> 2) * 0x10);
+		struct combiner_chip_data *data = &combiner_data[i];
+
+		data->base = combiner_base + (i >> 2) * 0x10;
+		data->irq_offset = irq_find_mapping(domain,
+				   i * IRQ_IN_COMBINER);
+		data->irq_mask = 0xff << ((i % 4) << 3);
+
+		/* Disable all interrupts */
+		__raw_writel(data->irq_mask,
+			     data->base + COMBINER_ENABLE_CLEAR);
+
+#ifdef CONFIG_EXYNOS_ATAGS
 		irq = IRQ_SPI(i);
+#else
+		irq = 0;
+#endif
 #ifdef CONFIG_OF
 		if (np)
 			irq = irq_of_parse_and_map(np, i);
 #endif
-		combiner_cascade_irq(i, irq);
+		if (irq_set_handler_data(irq, &combiner_data[i]) != 0)
+			BUG();
+		irq_set_chained_handler(irq, combiner_handle_cascade_irq);
 	}
 }
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_EXYNOS_IRQDOMAIN_CONVERSION_COMPLETE
+/*
+ * we can only renable this one after all hardcoded IRQ numbers
+ * are gone from DT booted systems and we can allow picking
+ * an arbitrary irq_base.
+ */ 
 static int __init combiner_of_init(struct device_node *np,
 				   struct device_node *parent)
 {
@@ -221,7 +228,7 @@ static int __init combiner_of_init(struct device_node *np,
 		return -ENXIO;
 	}
 
-	combiner_init(combiner_base, np);
+	combiner_init(combiner_base, -1, np);
 
 	return 0;
 }
-- 
1.8.1.2
