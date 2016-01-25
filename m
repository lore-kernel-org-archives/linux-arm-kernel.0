From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 13:55:00 +0800
Subject: [PATCH] clk: sunxi: usb: Sort clk providers by chip family and name
Message-ID: <1453701300-28241-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest addition of H3 USB clocks placed them at the bottom. Move it
before A80 (sun9i), so they are sorted by SoC family then name.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-usb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
index 67b8e38f4ee9..5432b1c198a4 100644
--- a/drivers/clk/sunxi/clk-usb.c
+++ b/drivers/clk/sunxi/clk-usb.c
@@ -216,6 +216,18 @@ static void __init sun8i_a23_usb_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(sun8i_a23_usb, "allwinner,sun8i-a23-usb-clk", sun8i_a23_usb_setup);
 
+static const struct usb_clk_data sun8i_h3_usb_clk_data __initconst = {
+	.clk_mask =  BIT(19) | BIT(18) | BIT(17) | BIT(16) |
+		     BIT(11) | BIT(10) | BIT(9) | BIT(8),
+	.reset_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
+};
+
+static void __init sun8i_h3_usb_setup(struct device_node *node)
+{
+	sunxi_usb_clk_setup(node, &sun8i_h3_usb_clk_data, &sun4i_a10_usb_lock);
+}
+CLK_OF_DECLARE(sun8i_h3_usb, "allwinner,sun8i-h3-usb-clk", sun8i_h3_usb_setup);
+
 static const struct usb_clk_data sun9i_a80_usb_mod_data __initconst = {
 	.clk_mask = BIT(6) | BIT(5) | BIT(4) | BIT(3) | BIT(2) | BIT(1),
 	.reset_mask = BIT(19) | BIT(18) | BIT(17),
@@ -243,15 +255,3 @@ static void __init sun9i_a80_usb_phy_setup(struct device_node *node)
 	sunxi_usb_clk_setup(node, &sun9i_a80_usb_phy_data, &a80_usb_phy_lock);
 }
 CLK_OF_DECLARE(sun9i_a80_usb_phy, "allwinner,sun9i-a80-usb-phy-clk", sun9i_a80_usb_phy_setup);
-
-static const struct usb_clk_data sun8i_h3_usb_clk_data __initconst = {
-	.clk_mask =  BIT(19) | BIT(18) | BIT(17) | BIT(16) |
-		     BIT(11) | BIT(10) | BIT(9) | BIT(8),
-	.reset_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
-};
-
-static void __init sun8i_h3_usb_setup(struct device_node *node)
-{
-	sunxi_usb_clk_setup(node, &sun8i_h3_usb_clk_data, &sun4i_a10_usb_lock);
-}
-CLK_OF_DECLARE(sun8i_h3_usb, "allwinner,sun8i-h3-usb-clk", sun8i_h3_usb_setup);
-- 
2.7.0
