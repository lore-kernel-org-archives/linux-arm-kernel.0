From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:37 +0800
Subject: [PATCH 06/16] ARM: imx: move irq_domain_add_legacy call into avic
 driver
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move irq_domain_add_legacy call from imx27-dt.c into avic init function
and have the avic driver adopt irqdomain support for both DT and non-DT
boot.

Now avic init function calls irq_alloc_descs to get irq_base and adds
a lenacy irqdomain with the irq_base, so that the mapping between avic
irq and Linux irq number can be handled by irqdomain.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/imx27-dt.c |   15 ---------------
 arch/arm/plat-mxc/avic.c     |   26 +++++++++++++++++++-------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index c734e56..5142ef0 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/irq.h>
-#include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
@@ -33,22 +32,8 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static int __init imx27_avic_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
-	return 0;
-}
-
-static const struct of_device_id imx27_irq_match[] __initconst = {
-	{ .compatible = "fsl,imx27-avic", .data = imx27_avic_add_irq_domain, },
-	{ /* sentinel */ }
-};
-
 static void __init imx27_dt_init(void)
 {
-	of_irq_init(imx27_irq_match);
-
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     imx27_auxdata_lookup, NULL);
 }
diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 689f81f..4fe1d9b 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -19,7 +19,9 @@
 
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <mach/common.h>
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
@@ -50,6 +52,7 @@
 #define AVIC_NUM_IRQS 64
 
 void __iomem *avic_base;
+static struct irq_domain *domain;
 
 static u32 avic_saved_mask_reg[2];
 
@@ -108,7 +111,7 @@ static void avic_irq_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = gc->chip_types;
-	int idx = gc->irq_base >> 5;
+	int idx = d->hwirq >> 5;
 
 	avic_saved_mask_reg[idx] = __raw_readl(avic_base + ct->regs.mask);
 	__raw_writel(gc->wake_active, avic_base + ct->regs.mask);
@@ -118,7 +121,7 @@ static void avic_irq_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = gc->chip_types;
-	int idx = gc->irq_base >> 5;
+	int idx = d->hwirq >> 5;
 
 	__raw_writel(avic_saved_mask_reg[idx], avic_base + ct->regs.mask);
 }
@@ -128,11 +131,10 @@ static void avic_irq_resume(struct irq_data *d)
 #define avic_irq_resume NULL
 #endif
 
-static __init void avic_init_gc(unsigned int irq_start)
+static __init void avic_init_gc(int idx, unsigned int irq_start)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
-	int idx = irq_start >> 5;
 
 	gc = irq_alloc_generic_chip("mxc-avic", 1, irq_start, avic_base,
 				    handle_level_irq);
@@ -161,7 +163,7 @@ asmlinkage void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
 		if (nivector == 0xffff)
 			break;
 
-		handle_IRQ(nivector, regs);
+		handle_IRQ(irq_find_mapping(domain, nivector), regs);
 	} while (1);
 }
 
@@ -172,6 +174,8 @@ asmlinkage void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
  */
 void __init mxc_init_irq(void __iomem *irqbase)
 {
+	struct device_node *np;
+	int irq_base;
 	int i;
 
 	avic_base = irqbase;
@@ -190,8 +194,16 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	__raw_writel(0, avic_base + AVIC_INTTYPEH);
 	__raw_writel(0, avic_base + AVIC_INTTYPEL);
 
-	for (i = 0; i < AVIC_NUM_IRQS; i += 32)
-		avic_init_gc(i);
+	irq_base = irq_alloc_descs(-1, 0, AVIC_NUM_IRQS, numa_node_id());
+	WARN_ON(irq_base < 0);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,avic");
+	domain = irq_domain_add_legacy(np, AVIC_NUM_IRQS, irq_base, 0,
+				       &irq_domain_simple_ops, NULL);
+	WARN_ON(!domain);
+
+	for (i = 0; i < AVIC_NUM_IRQS / 32; i++, irq_base += 32)
+		avic_init_gc(i, irq_base);
 
 	/* Set default priority value (0) for all IRQ's */
 	for (i = 0; i < 8; i++)
-- 
1.7.5.4
