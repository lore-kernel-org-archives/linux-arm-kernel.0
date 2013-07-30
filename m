From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 22:49:31 +0200
Subject: [PATCHv2 02/10] clk: sunxi: fix initialization of basic clocks
In-Reply-To: <1375217379-15126-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375217379-15126-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375217379-15126-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

With the recent move towards CLK_OF_DECLARE(...), the driver stopped
initializing osc32k, which is compatible "fixed-clock". This is because
we never called of_clk_init(NULL). Fix this by moving the only other
simple clock (osc24M) to use CLK_OF_DECLARE(...) and call of_clk_init(NULL)
to initialize both of them.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 412912b..fe1528e 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -409,12 +409,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
-
-/* Matches for of_clk_init */
-static const __initconst struct of_device_id clk_match[] = {
-	{.compatible = "allwinner,sun4i-osc-clk", .data = sunxi_osc_clk_setup,},
-	{}
-};
+CLK_OF_DECLARE(sunxi_osc, "allwinner,sun4i-osc-clk", sunxi_osc_clk_setup);
 
 /* Matches for factors clocks */
 static const __initconst struct of_device_id clk_factors_match[] = {
@@ -467,8 +462,8 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
 
 void __init sunxi_init_clocks(void)
 {
-	/* Register all the simple sunxi clocks on DT */
-	of_clk_init(clk_match);
+	/* Register all the simple and basic clocks on DT */
+	of_clk_init(NULL);
 
 	/* Register factor clocks */
 	of_sunxi_table_clock_setup(clk_factors_match, sunxi_factors_clk_setup);
-- 
1.8.3.4
