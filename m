From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 13 Jun 2013 19:50:56 +0800
Subject: [PATCH 1/9] ARM: clk-imx6qdl: Add clko1 configuration for
 imx6qdl-sabresd
In-Reply-To: <cover.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
Message-ID: <e88e60e10925e7e2f544995d1beb7d644aba8d2c.1371123426.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WM8962 needs 24MHz clock for its MCLK, so choose PLL4 as the parent of clko1.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c  |    2 +
 arch/arm/mach-imx/mach-imx6q.c |   42 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 0a4a658..07fdb8c 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -550,6 +550,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk_register_clkdev(clk[ahb], "ahb", NULL);
 	clk_register_clkdev(clk[cko1], "cko1", NULL);
 	clk_register_clkdev(clk[arm], NULL, "cpu0");
+	clk_register_clkdev(clk[pll4_post_div], "pll4_post_div", NULL);
+	clk_register_clkdev(clk[pll4_audio], "pll4_audio", NULL);
 
 	if (imx6q_revision() != IMX_CHIP_REVISION_1_0) {
 		clk_set_parent(clk[ldb_di0_sel], clk[pll5_video_div]);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 045e5e3..f596522 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -146,6 +146,45 @@ static void __init imx6q_sabrelite_init(void)
 	imx6q_sabrelite_cko1_setup();
 }
 
+static void __init imx6q_sabresd_cko1_setup(void)
+{
+	struct clk *cko1_sel, *pll4, *pll4_post, *cko1;
+	unsigned long rate;
+
+	cko1_sel = clk_get_sys(NULL, "cko1_sel");
+	pll4 = clk_get_sys(NULL, "pll4_audio");
+	pll4_post = clk_get_sys(NULL, "pll4_post_div");
+	cko1 = clk_get_sys(NULL, "cko1");
+	if (IS_ERR(cko1_sel) || IS_ERR(pll4)
+			|| IS_ERR(pll4_post) || IS_ERR(cko1)) {
+		pr_err("cko1 setup failed!\n");
+		goto put_clk;
+	}
+	/*
+	 * Setting pll4 at 768MHz (24MHz * 32)
+	 * So its child clock can get 24MHz easily
+	 */
+	clk_set_rate(pll4, 768000000);
+
+	clk_set_parent(cko1_sel, pll4_post);
+	rate = clk_round_rate(cko1, 24000000);
+	clk_set_rate(cko1, rate);
+put_clk:
+	if (!IS_ERR(cko1_sel))
+		clk_put(cko1_sel);
+	if (!IS_ERR(pll4_post))
+		clk_put(pll4_post);
+	if (!IS_ERR(pll4))
+		clk_put(pll4);
+	if (!IS_ERR(cko1))
+		clk_put(cko1);
+}
+
+static void __init imx6q_sabresd_init(void)
+{
+	imx6q_sabresd_cko1_setup();
+}
+
 static void __init imx6q_1588_init(void)
 {
 	struct regmap *gpr;
@@ -166,6 +205,9 @@ static void __init imx6q_init_machine(void)
 {
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
 		imx6q_sabrelite_init();
+	else if (of_machine_is_compatible("fsl,imx6q-sabresd") ||
+			of_machine_is_compatible("fsl,imx6dl-sabresd"))
+		imx6q_sabresd_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.7.1
