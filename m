From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 21 May 2013 10:12:04 +0800
Subject: [PATCH 2/2] ARM: imx6: use common of_clk_init() call to initialize
 clocks
In-Reply-To: <1369102324-3084-1-git-send-email-shawn.guo@linaro.org>
References: <1369102324-3084-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1369102324-3084-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of explicitly calling clock initialization functions, we can
declare the functions with CLK_OF_DECLARE() and then call common
of_clk_init() to have them invoked properly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c   |    9 +++------
 arch/arm/mach-imx/clk-imx6sl.c  |    9 +++------
 arch/arm/mach-imx/common.h      |    2 --
 arch/arm/mach-imx/mach-imx6q.c  |    3 ++-
 arch/arm/mach-imx/mach-imx6sl.c |    3 ++-
 5 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 1b883c7..0a4a658 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -270,14 +270,12 @@ static struct clk_div_table video_div_table[] = {
 	{ }
 };
 
-int __init mx6q_clocks_init(void)
+static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
 	int i, irq;
 
-	of_clk_init(NULL);
-
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckil] = imx_obtain_fixed_clock("ckil", 0);
 	clk[ckih] = imx_obtain_fixed_clock("ckih1", 0);
@@ -350,7 +348,7 @@ int __init mx6q_clocks_init(void)
 	clk[pll5_post_div] = clk_register_divider_table(NULL, "pll5_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
 	clk[pll5_video_div] = clk_register_divider_table(NULL, "pll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
+	np = ccm_node;
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 	ccm_base = base;
@@ -581,6 +579,5 @@ int __init mx6q_clocks_init(void)
 	WARN_ON(!base);
 	irq = irq_of_parse_and_map(np, 0);
 	mxc_timer_init(base, irq);
-
-	return 0;
 }
+CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index 76835a7..a307ac2 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -66,15 +66,13 @@ static struct clk_div_table video_div_table[] = {
 static struct clk *clks[IMX6SL_CLK_CLK_END];
 static struct clk_onecell_data clk_data;
 
-int __init imx6sl_clocks_init(void)
+static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
 	int irq;
 	int i;
 
-	of_clk_init(NULL);
-
 	clks[IMX6SL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
 	clks[IMX6SL_CLK_CKIL] = imx_obtain_fixed_clock("ckil", 0);
 	clks[IMX6SL_CLK_OSC] = imx_obtain_fixed_clock("osc", 0);
@@ -125,7 +123,7 @@ int __init imx6sl_clocks_init(void)
 	clks[IMX6SL_CLK_PLL3_80M]  = imx_clk_fixed_factor("pll3_80m",  "pll3_usb_otg",   1, 6);
 	clks[IMX6SL_CLK_PLL3_60M]  = imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 8);
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-ccm");
+	np = ccm_node;
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
@@ -265,6 +263,5 @@ int __init imx6sl_clocks_init(void)
 	WARN_ON(!base);
 	irq = irq_of_parse_and_map(np, 0);
 	mxc_timer_init(base, irq);
-
-	return 0;
 }
+CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 208e76f..ee78847 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -68,8 +68,6 @@ extern int mx27_clocks_init_dt(void);
 extern int mx31_clocks_init_dt(void);
 extern int mx51_clocks_init_dt(void);
 extern int mx53_clocks_init_dt(void);
-extern int mx6q_clocks_init(void);
-extern int imx6sl_clocks_init(void);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 extern void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index ec4b7fc..045e5e3 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
@@ -298,7 +299,7 @@ static void __init imx6q_init_irq(void)
 
 static void __init imx6q_timer_init(void)
 {
-	mx6q_clocks_init();
+	of_clk_init(NULL);
 	clocksource_of_init();
 	imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
 			      imx6q_revision());
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 0130ee6..132db260 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/clk-provider.h>
 #include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -33,7 +34,7 @@ static void __init imx6sl_init_irq(void)
 
 static void __init imx6sl_timer_init(void)
 {
-	imx6sl_clocks_init();
+	of_clk_init(NULL);
 }
 
 static const char *imx6sl_dt_compat[] __initdata = {
-- 
1.7.9.5
