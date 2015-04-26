From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:07 +0800
Subject: [PATCH 06/11] ARM: imx6: let pm code map CCM block on its own
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are about to move imx6 clock driver into drivers/clk, so let's get
imx6 pm code map CCM block on its own rather than relying on clock
driver to do the mapping.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c  |  2 --
 arch/arm/mach-imx/clk-imx6sl.c |  3 ---
 arch/arm/mach-imx/clk-imx6sx.c |  2 --
 arch/arm/mach-imx/common.h     |  1 -
 arch/arm/mach-imx/pm-imx6.c    | 16 +++++++++-------
 5 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 54ce0b30b9ad..5e88038ad51c 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -262,8 +262,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
-	imx6q_pm_set_ccm_base(base);
-
 	/*                                              name                reg       shift width parent_names     num_parents */
 	clk[IMX6QDL_CLK_STEP]             = imx_clk_mux("step",	            base + 0xc,  8,  1, step_sels,	   ARRAY_SIZE(step_sels));
 	clk[IMX6QDL_CLK_PLL1_SW]          = imx_clk_mux("pll1_sw",	    base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index d990f51ded71..3aef26464110 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -288,9 +288,6 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	WARN_ON(!base);
 	ccm_base = base;
 
-	/* Reuse imx6q pm code */
-	imx6q_pm_set_ccm_base(base);
-
 	/*                                              name                reg       shift width parent_names     num_parents */
 	clks[IMX6SL_CLK_STEP]             = imx_clk_mux("step",             base + 0xc,  8,  1, step_sels,         ARRAY_SIZE(step_sels));
 	clks[IMX6SL_CLK_PLL1_SW]          = imx_clk_mux("pll1_sw",          base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
index 2b0a1fd5d7eb..151460a95130 100644
--- a/arch/arm/mach-imx/clk-imx6sx.c
+++ b/arch/arm/mach-imx/clk-imx6sx.c
@@ -268,8 +268,6 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
-	imx6q_pm_set_ccm_base(base);
-
 	/*                                                name                reg           shift   width   parent_names       num_parents */
 	clks[IMX6SX_CLK_STEP]               = imx_clk_mux("step",             base + 0xc,   8,      1,      step_sels,         ARRAY_SIZE(step_sels));
 	clks[IMX6SX_CLK_PLL1_SW]            = imx_clk_mux("pll1_sw",          base + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index d7f3b7b1d911..d1e2873f807e 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -127,7 +127,6 @@ void imx6q_pm_init(void);
 void imx6dl_pm_init(void);
 void imx6sl_pm_init(void);
 void imx6sx_pm_init(void);
-void imx6q_pm_set_ccm_base(void __iomem *base);
 
 #ifdef CONFIG_PM
 void imx51_pm_init(void);
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 5858bde5a4e7..27bc80dab2d8 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -89,6 +89,7 @@ struct imx6_pm_base {
 
 struct imx6_pm_socdata {
 	u32 ddr_type;
+	const char *ccm_compat;
 	const char *mmdc_compat;
 	const char *src_compat;
 	const char *iomuxc_compat;
@@ -138,6 +139,7 @@ static const u32 imx6sx_mmdc_io_offset[] __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
+	.ccm_compat = "fsl,imx6q-ccm",
 	.mmdc_compat = "fsl,imx6q-mmdc",
 	.src_compat = "fsl,imx6q-src",
 	.iomuxc_compat = "fsl,imx6q-iomuxc",
@@ -147,6 +149,7 @@ static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
+	.ccm_compat = "fsl,imx6q-ccm",
 	.mmdc_compat = "fsl,imx6q-mmdc",
 	.src_compat = "fsl,imx6q-src",
 	.iomuxc_compat = "fsl,imx6dl-iomuxc",
@@ -156,6 +159,7 @@ static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
+	.ccm_compat = "fsl,imx6sl-ccm",
 	.mmdc_compat = "fsl,imx6sl-mmdc",
 	.src_compat = "fsl,imx6sl-src",
 	.iomuxc_compat = "fsl,imx6sl-iomuxc",
@@ -165,6 +169,7 @@ static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6sx_pm_data __initconst = {
+	.ccm_compat = "fsl,imx6sx-ccm",
 	.mmdc_compat = "fsl,imx6sx-mmdc",
 	.src_compat = "fsl,imx6sx-src",
 	.iomuxc_compat = "fsl,imx6sx-iomuxc",
@@ -392,11 +397,6 @@ static const struct platform_suspend_ops imx6q_pm_ops = {
 	.valid = imx6q_pm_valid,
 };
 
-void __init imx6q_pm_set_ccm_base(void __iomem *base)
-{
-	ccm_base = base;
-}
-
 static int __init imx6_pm_get_base(struct imx6_pm_base *base,
 				const char *compat)
 {
@@ -482,8 +482,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 
 	/*
 	 * ccm physical address is not used by asm code currently,
-	 * so get ccm virtual address directly, as we already have
-	 * it from ccm driver.
+	 * so get ccm virtual address directly.
 	 */
 	pm_info->ccm_base.vbase = ccm_base;
 
@@ -554,9 +553,12 @@ put_node:
 static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 					*socdata)
 {
+	struct device_node *np;
 	struct regmap *gpr;
 	int ret;
 
+	np = of_find_compatible_node(NULL, NULL, socdata->ccm_compat);
+	ccm_base = of_iomap(np, 0);
 	WARN_ON(!ccm_base);
 
 	imx6_set_lpm(WAIT_CLOCKED);
-- 
1.9.1
