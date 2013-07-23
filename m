From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:01:05 -0300
Subject: [PATCH RFC 1/8] clk: sunxi: fix initialization of basic clocks
In-Reply-To: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1374541272-32173-2-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recent move towards CLK_OF_DECLARE(...), the driver stopped
initializing osc32k, which is compatible "fixed-clock". This is because
we never called of_clk_init(NULL). Fix this by moving the only other
simple clock (osc24M) to use CLK_OF_DECLARE(...) and call of_clk_init(NULL)
to initialize both of them.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 412912b..323366b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -411,10 +411,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 }
 
 /* Matches for of_clk_init */
-static const __initconst struct of_device_id clk_match[] = {
-	{.compatible = "allwinner,sun4i-osc-clk", .data = sunxi_osc_clk_setup,},
-	{}
-};
+CLK_OF_DECLARE(sunxi_osc, "allwinner,sun4i-osc-clk", sunxi_osc_clk_setup);
 
 /* Matches for factors clocks */
 static const __initconst struct of_device_id clk_factors_match[] = {
@@ -467,8 +464,8 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
 
 void __init sunxi_init_clocks(void)
 {
-	/* Register all the simple sunxi clocks on DT */
-	of_clk_init(clk_match);
+	/* Register all the simple and basic clocks on DT */
+	of_clk_init(NULL);
 
 	/* Register factor clocks */
 	of_sunxi_table_clock_setup(clk_factors_match, sunxi_factors_clk_setup);
-- 
1.8.3.3
