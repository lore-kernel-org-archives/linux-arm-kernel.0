From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:36 +0800
Subject: [PATCH 05/16] ARM: imx: move irq_domain_add_legacy call into tzic
 driver
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move irq_domain_add_legacy call from imx5*-dt.c into tzic init function
and have the tzic driver adopt irqdomain support for both DT and non-DT
boot.

Now tzic init function calls irq_alloc_descs to get irq_base and adds
a lenacy irqdomain with the irq_base, so that the mapping between tzic
irq and Linux irq number can be handled by irqdomain.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/imx51-dt.c |   15 ---------------
 arch/arm/mach-imx/imx53-dt.c |   15 ---------------
 arch/arm/plat-mxc/tzic.c     |   28 ++++++++++++++++++++--------
 3 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index 3bdabbc..d4067fe 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/irq.h>
-#include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
@@ -45,18 +44,6 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static int __init imx51_tzic_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	irq_domain_add_legacy(np, 128, 0, 0, &irq_domain_simple_ops, NULL);
-	return 0;
-}
-
-static const struct of_device_id imx51_irq_match[] __initconst = {
-	{ .compatible = "fsl,imx51-tzic", .data = imx51_tzic_add_irq_domain, },
-	{ /* sentinel */ }
-};
-
 static const struct of_device_id imx51_iomuxc_of_match[] __initconst = {
 	{ .compatible = "fsl,imx51-iomuxc-babbage", .data = imx51_babbage_common_init, },
 	{ /* sentinel */ }
@@ -68,8 +55,6 @@ static void __init imx51_dt_init(void)
 	const struct of_device_id *of_id;
 	void (*func)(void);
 
-	of_irq_init(imx51_irq_match);
-
 	pinctrl_provide_dummies();
 
 	node = of_find_matching_node(NULL, imx51_iomuxc_of_match);
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index 17fca3c..fdd9080 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -15,7 +15,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
@@ -52,18 +51,6 @@ static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static int __init imx53_tzic_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	irq_domain_add_legacy(np, 128, 0, 0, &irq_domain_simple_ops, NULL);
-	return 0;
-}
-
-static const struct of_device_id imx53_irq_match[] __initconst = {
-	{ .compatible = "fsl,imx53-tzic", .data = imx53_tzic_add_irq_domain, },
-	{ /* sentinel */ }
-};
-
 static const struct of_device_id imx53_iomuxc_of_match[] __initconst = {
 	{ .compatible = "fsl,imx53-iomuxc-ard", .data = imx53_ard_common_init, },
 	{ .compatible = "fsl,imx53-iomuxc-evk", .data = imx53_evk_common_init, },
@@ -91,8 +78,6 @@ static void __init imx53_dt_init(void)
 	const struct of_device_id *of_id;
 	void (*func)(void);
 
-	of_irq_init(imx53_irq_match);
-
 	pinctrl_provide_dummies();
 
 	node = of_find_matching_node(NULL, imx53_iomuxc_of_match);
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index 98308ec..abc90e4 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -15,6 +15,8 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
 
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
@@ -49,6 +51,7 @@
 #define TZIC_ID0	0x0FD0	/* Indentification Register 0 */
 
 void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
+static struct irq_domain *domain;
 
 #define TZIC_NUM_IRQS 128
 
@@ -77,15 +80,14 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 static void tzic_irq_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	int idx = gc->irq_base >> 5;
+	int idx = d->hwirq >> 5;
 
 	__raw_writel(gc->wake_active, tzic_base + TZIC_WAKEUP0(idx));
 }
 
 static void tzic_irq_resume(struct irq_data *d)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	int idx = gc->irq_base >> 5;
+	int idx = d->hwirq >> 5;
 
 	__raw_writel(__raw_readl(tzic_base + TZIC_ENSET0(idx)),
 		     tzic_base + TZIC_WAKEUP0(idx));
@@ -102,11 +104,10 @@ static struct mxc_extra_irq tzic_extra_irq = {
 #endif
 };
 
-static __init void tzic_init_gc(unsigned int irq_start)
+static __init void tzic_init_gc(int idx, unsigned int irq_start)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
-	int idx = irq_start >> 5;
 
 	gc = irq_alloc_generic_chip("tzic", 1, irq_start, tzic_base,
 				    handle_level_irq);
@@ -140,7 +141,8 @@ asmlinkage void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
 			while (stat) {
 				handled = 1;
 				irqofs = fls(stat) - 1;
-				handle_IRQ(irqofs + i * 32, regs);
+				handle_IRQ(irq_find_mapping(domain,
+						irqofs + i * 32), regs);
 				stat &= ~(1 << irqofs);
 			}
 		}
@@ -154,6 +156,8 @@ asmlinkage void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
  */
 void __init tzic_init_irq(void __iomem *irqbase)
 {
+	struct device_node *np;
+	int irq_base;
 	int i;
 
 	tzic_base = irqbase;
@@ -175,8 +179,16 @@ void __init tzic_init_irq(void __iomem *irqbase)
 
 	/* all IRQ no FIQ Warning :: No selection */
 
-	for (i = 0; i < TZIC_NUM_IRQS; i += 32)
-		tzic_init_gc(i);
+	irq_base = irq_alloc_descs(-1, 0, TZIC_NUM_IRQS, numa_node_id());
+	WARN_ON(irq_base < 0);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,tzic");
+	domain = irq_domain_add_legacy(np, TZIC_NUM_IRQS, irq_base, 0,
+				       &irq_domain_simple_ops, NULL);
+	WARN_ON(!domain);
+
+	for (i = 0; i < 4; i++, irq_base += 32)
+		tzic_init_gc(i, irq_base);
 
 #ifdef CONFIG_FIQ
 	/* Initialize FIQ */
-- 
1.7.5.4
