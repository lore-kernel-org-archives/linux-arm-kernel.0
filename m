From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  2 Feb 2016 09:47:13 +0100
Subject: [PATCH 4/5] clk: sunxi: Remove old probe and protection code
In-Reply-To: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1454402834-6385-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we don't have any user left for the old registration code, we can
remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 114 ------------------------------------------
 1 file changed, 114 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index da6c1bc763d1..5f2f3e0408bd 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1067,117 +1067,3 @@ static void __init sun6i_pll6_clk_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(sun6i_pll6, "allwinner,sun6i-a31-pll6-clk",
 	       sun6i_pll6_clk_setup);
-
-
-/* Matches for factors clocks */
-static const struct of_device_id clk_factors_match[] __initconst = {
-	{}
-};
-
-/* Matches for divider clocks */
-static const struct of_device_id clk_div_match[] __initconst = {
-	{}
-};
-
-/* Matches for divided outputs */
-static const struct of_device_id clk_divs_match[] __initconst = {
-	{}
-};
-
-/* Matches for mux clocks */
-static const struct of_device_id clk_mux_match[] __initconst = {
-	{}
-};
-
-
-static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_match,
-					      void *function)
-{
-	struct device_node *np;
-	const struct div_data *data;
-	const struct of_device_id *match;
-	void (*setup_function)(struct device_node *, const void *) = function;
-
-	for_each_matching_node_and_match(np, clk_match, &match) {
-		data = match->data;
-		setup_function(np, data);
-	}
-}
-
-static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
-{
-	unsigned int i;
-
-	/* Register divided output clocks */
-	of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
-
-	/* Register factor clocks */
-	of_sunxi_table_clock_setup(clk_factors_match, sunxi_factors_clk_setup);
-
-	/* Register divider clocks */
-	of_sunxi_table_clock_setup(clk_div_match, sunxi_divider_clk_setup);
-
-	/* Register mux clocks */
-	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
-
-	/* Protect the clocks that needs to stay on */
-	for (i = 0; i < nclocks; i++) {
-		struct clk *clk = clk_get(NULL, clocks[i]);
-
-		if (!IS_ERR(clk))
-			clk_prepare_enable(clk);
-	}
-}
-
-static const char *sun4i_a10_critical_clocks[] __initdata = {
-	"pll5_ddr",
-};
-
-static void __init sun4i_a10_init_clocks(struct device_node *node)
-{
-	sunxi_init_clocks(sun4i_a10_critical_clocks,
-			  ARRAY_SIZE(sun4i_a10_critical_clocks));
-}
-CLK_OF_DECLARE(sun4i_a10_clk_init, "allwinner,sun4i-a10", sun4i_a10_init_clocks);
-
-static const char *sun5i_critical_clocks[] __initdata = {
-	"cpu",
-	"pll5_ddr",
-};
-
-static void __init sun5i_init_clocks(struct device_node *node)
-{
-	sunxi_init_clocks(sun5i_critical_clocks,
-			  ARRAY_SIZE(sun5i_critical_clocks));
-}
-CLK_OF_DECLARE(sun5i_a10s_clk_init, "allwinner,sun5i-a10s", sun5i_init_clocks);
-CLK_OF_DECLARE(sun5i_a13_clk_init, "allwinner,sun5i-a13", sun5i_init_clocks);
-CLK_OF_DECLARE(sun5i_r8_clk_init, "allwinner,sun5i-r8", sun5i_init_clocks);
-CLK_OF_DECLARE(sun7i_a20_clk_init, "allwinner,sun7i-a20", sun5i_init_clocks);
-
-static const char *sun6i_critical_clocks[] __initdata = {
-	"cpu",
-};
-
-static void __init sun6i_init_clocks(struct device_node *node)
-{
-	sunxi_init_clocks(sun6i_critical_clocks,
-			  ARRAY_SIZE(sun6i_critical_clocks));
-}
-CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sun6i_init_clocks);
-CLK_OF_DECLARE(sun6i_a31s_clk_init, "allwinner,sun6i-a31s", sun6i_init_clocks);
-CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
-CLK_OF_DECLARE(sun8i_a33_clk_init, "allwinner,sun8i-a33", sun6i_init_clocks);
-CLK_OF_DECLARE(sun8i_h3_clk_init, "allwinner,sun8i-h3", sun6i_init_clocks);
-
-static void __init sun8i_a83t_init_clocks(struct device_node *node)
-{
-	sunxi_init_clocks(NULL, 0);
-}
-CLK_OF_DECLARE(sun8i_a83t_clk_init, "allwinner,sun8i-a83t", sun8i_a83t_init_clocks);
-
-static void __init sun9i_init_clocks(struct device_node *node)
-{
-	sunxi_init_clocks(NULL, 0);
-}
-CLK_OF_DECLARE(sun9i_a80_clk_init, "allwinner,sun9i-a80", sun9i_init_clocks);
-- 
2.6.4
