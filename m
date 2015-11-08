From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  8 Nov 2015 17:04:35 +0100
Subject: [PATCH v2 2/8] phy: rockchip-usb: introduce a common data-struct for
 the device
In-Reply-To: <1446998681-26436-1-git-send-email-heiko@sntech.de>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
Message-ID: <1446998681-26436-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a common struct that holds data belonging to
the umbrella device that contains all the phys and that we
want to use later.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/phy/phy-rockchip-usb.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index dfc056b..e081053 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -36,9 +36,14 @@
 #define SIDDQ_ON		BIT(13)
 #define SIDDQ_OFF		(0 << 13)
 
+struct rockchip_usb_phy_base {
+	struct device *dev;
+	struct regmap *reg_base;
+};
+
 struct rockchip_usb_phy {
+	struct rockchip_usb_phy_base *base;
 	unsigned int	reg_offset;
-	struct regmap	*reg_base;
 	struct clk	*clk;
 	struct phy	*phy;
 };
@@ -46,7 +51,7 @@ struct rockchip_usb_phy {
 static int rockchip_usb_phy_power(struct rockchip_usb_phy *phy,
 					   bool siddq)
 {
-	return regmap_write(phy->reg_base, phy->reg_offset,
+	return regmap_write(phy->base->reg_base, phy->reg_offset,
 			    SIDDQ_WRITE_ENA | (siddq ? SIDDQ_ON : SIDDQ_OFF));
 }
 
@@ -101,17 +106,23 @@ static void rockchip_usb_phy_action(void *data)
 static int rockchip_usb_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct rockchip_usb_phy_base *phy_base;
 	struct rockchip_usb_phy *rk_phy;
 	struct phy_provider *phy_provider;
 	struct device_node *child;
-	struct regmap *grf;
 	unsigned int reg_offset;
 	int err;
 
-	grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
-	if (IS_ERR(grf)) {
+	phy_base = devm_kzalloc(dev, sizeof(*phy_base), GFP_KERNEL);
+	if (!phy_base)
+		return -ENOMEM;
+
+	phy_base->dev = dev;
+	phy_base->reg_base = syscon_regmap_lookup_by_phandle(dev->of_node,
+							     "rockchip,grf");
+	if (IS_ERR(phy_base->reg_base)) {
 		dev_err(&pdev->dev, "Missing rockchip,grf property\n");
-		return PTR_ERR(grf);
+		return PTR_ERR(phy_base->reg_base);
 	}
 
 	for_each_available_child_of_node(dev->of_node, child) {
@@ -119,6 +130,8 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 		if (!rk_phy)
 			return -ENOMEM;
 
+		rk_phy->base = phy_base;
+
 		if (of_property_read_u32(child, "reg", &reg_offset)) {
 			dev_err(dev, "missing reg property in node %s\n",
 				child->name);
@@ -126,7 +139,6 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 		}
 
 		rk_phy->reg_offset = reg_offset;
-		rk_phy->reg_base = grf;
 
 		rk_phy->clk = of_clk_get_by_name(child, "phyclk");
 		if (IS_ERR(rk_phy->clk))
-- 
2.6.2
