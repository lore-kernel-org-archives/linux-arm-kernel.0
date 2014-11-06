From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Nov 2014 11:40:29 +0800
Subject: [PATCH resend 1/4] clk: sunxi: unify APB1 clock
In-Reply-To: <1415245232-20585-1-git-send-email-wens@csie.org>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
Message-ID: <1415245232-20585-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This commit unifies the APB1 mux with the APB1 clock, using the new
factors infrastructure.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
[wens at csie.org: Add mux mask bits]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 -
 drivers/clk/sunxi/clk-sunxi.c                     | 7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 0455cb9..6ddcf6e 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -45,7 +45,6 @@ Required properties:
 	"allwinner,sun9i-a80-apb0-gates-clk" - for the APB0 gates on A80
 	"allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
 	"allwinner,sun9i-a80-apb1-clk" - for the APB1 bus clock on A80
-	"allwinner,sun4i-a10-apb1-mux-clk" - for the APB1 clock muxing
 	"allwinner,sun4i-a10-apb1-gates-clk" - for the APB1 gates on A10
 	"allwinner,sun5i-a13-apb1-gates-clk" - for the APB1 gates on A13
 	"allwinner,sun5i-a10s-apb1-gates-clk" - for the APB1 gates on A10s
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 20f47c6..4133e27 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -507,6 +507,8 @@ static const struct factors_data sun6i_a31_pll6_data __initconst = {
 };
 
 static const struct factors_data sun4i_apb1_data __initconst = {
+	.mux = 24,
+	.muxmask = BIT(1) | BIT(0),
 	.table = &sun4i_apb1_config,
 	.getter = sun4i_get_apb1_factors,
 };
@@ -545,10 +547,6 @@ static const struct mux_data sun6i_a31_ahb1_mux_data __initconst = {
 	.shift = 12,
 };
 
-static const struct mux_data sun4i_apb1_mux_data __initconst = {
-	.shift = 24,
-};
-
 static void __init sunxi_mux_clk_setup(struct device_node *node,
 				       struct mux_data *data)
 {
@@ -1109,7 +1107,6 @@ static const struct of_device_id clk_divs_match[] __initconst = {
 /* Matches for mux clocks */
 static const struct of_device_id clk_mux_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-cpu-clk", .data = &sun4i_cpu_mux_data,},
-	{.compatible = "allwinner,sun4i-a10-apb1-mux-clk", .data = &sun4i_apb1_mux_data,},
 	{.compatible = "allwinner,sun6i-a31-ahb1-mux-clk", .data = &sun6i_a31_ahb1_mux_data,},
 	{}
 };
-- 
2.1.1
