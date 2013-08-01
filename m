From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Aug 2013 16:44:18 +0200
Subject: [PATCHv2 2/4] clk: sunxi: Allow to specify the divider width from the
 dividers data
In-Reply-To: <1375368260-1740-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375368260-1740-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375368260-1740-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The divider width used to be hardcoded. Some A31 dividers are no longer
with the hardcoded width, so we need to make it specific to each divider
and set it in the dividers data.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index ac34424..21997d6 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -277,26 +277,28 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
  * sunxi_divider_clk_setup() - Setup function for simple divider clocks
  */
 
-#define SUNXI_DIVISOR_WIDTH	2
-
 struct div_data {
-	u8 shift;
-	u8 pow;
+	u8	shift;
+	u8	pow;
+	u8	width;
 };
 
 static const __initconst struct div_data sun4i_axi_data = {
-	.shift = 0,
-	.pow = 0,
+	.shift	= 0,
+	.pow	= 0,
+	.width	= 2,
 };
 
 static const __initconst struct div_data sun4i_ahb_data = {
-	.shift = 4,
-	.pow = 1,
+	.shift	= 4,
+	.pow	= 1,
+	.width	= 2,
 };
 
 static const __initconst struct div_data sun4i_apb0_data = {
-	.shift = 8,
-	.pow = 1,
+	.shift	= 8,
+	.pow	= 1,
+	.width	= 2,
 };
 
 static void __init sunxi_divider_clk_setup(struct device_node *node,
@@ -312,7 +314,7 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 	clk_parent = of_clk_get_parent_name(node, 0);
 
 	clk = clk_register_divider(NULL, clk_name, clk_parent, 0,
-				   reg, data->shift, SUNXI_DIVISOR_WIDTH,
+				   reg, data->shift, data->width,
 				   data->pow ? CLK_DIVIDER_POWER_OF_TWO : 0,
 				   &clk_lock);
 	if (clk) {
-- 
1.8.3.4
