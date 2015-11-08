From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  8 Nov 2015 17:04:36 +0100
Subject: [PATCH v2 3/8] phy: rockchip-usb: move per-phy init into a separate
 function
In-Reply-To: <1446998681-26436-1-git-send-email-heiko@sntech.de>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
Message-ID: <1446998681-26436-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This unclutters the loop in probe a lot and makes current (and future)
error handling easier to read.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/phy/phy-rockchip-usb.c | 82 +++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index e081053..3b69f61 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -103,14 +103,57 @@ static void rockchip_usb_phy_action(void *data)
 		clk_put(rk_phy->clk);
 }
 
+static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
+				 struct device_node *child)
+{
+	struct rockchip_usb_phy *rk_phy;
+	unsigned int reg_offset;
+	int err;
+
+	rk_phy = devm_kzalloc(base->dev, sizeof(*rk_phy), GFP_KERNEL);
+	if (!rk_phy)
+		return -ENOMEM;
+
+	rk_phy->base = base;
+
+	if (of_property_read_u32(child, "reg", &reg_offset)) {
+		dev_err(base->dev, "missing reg property in node %s\n",
+			child->name);
+		return -EINVAL;
+	}
+
+	rk_phy->reg_offset = reg_offset;
+
+	rk_phy->clk = of_clk_get_by_name(child, "phyclk");
+	if (IS_ERR(rk_phy->clk))
+		rk_phy->clk = NULL;
+
+	err = devm_add_action(base->dev, rockchip_usb_phy_action, rk_phy);
+	if (err)
+		goto err_devm_action;
+
+	rk_phy->phy = devm_phy_create(base->dev, child, &ops);
+	if (IS_ERR(rk_phy->phy)) {
+		dev_err(base->dev, "failed to create PHY\n");
+		return PTR_ERR(rk_phy->phy);
+	}
+	phy_set_drvdata(rk_phy->phy, rk_phy);
+
+	/* only power up usb phy when it use, so disable it when init*/
+	return rockchip_usb_phy_power(rk_phy, 1);
+
+err_devm_action:
+	if (rk_phy->clk)
+		clk_put(rk_phy->clk);
+	return err;
+}
+
 static int rockchip_usb_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_usb_phy_base *phy_base;
-	struct rockchip_usb_phy *rk_phy;
 	struct phy_provider *phy_provider;
 	struct device_node *child;
-	unsigned int reg_offset;
 	int err;
 
 	phy_base = devm_kzalloc(dev, sizeof(*phy_base), GFP_KERNEL);
@@ -126,40 +169,7 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	}
 
 	for_each_available_child_of_node(dev->of_node, child) {
-		rk_phy = devm_kzalloc(dev, sizeof(*rk_phy), GFP_KERNEL);
-		if (!rk_phy)
-			return -ENOMEM;
-
-		rk_phy->base = phy_base;
-
-		if (of_property_read_u32(child, "reg", &reg_offset)) {
-			dev_err(dev, "missing reg property in node %s\n",
-				child->name);
-			return -EINVAL;
-		}
-
-		rk_phy->reg_offset = reg_offset;
-
-		rk_phy->clk = of_clk_get_by_name(child, "phyclk");
-		if (IS_ERR(rk_phy->clk))
-			rk_phy->clk = NULL;
-
-		err = devm_add_action(dev, rockchip_usb_phy_action, rk_phy);
-		if (err) {
-			if (rk_phy->clk)
-				clk_put(rk_phy->clk);
-			return err;
-		}
-
-		rk_phy->phy = devm_phy_create(dev, child, &ops);
-		if (IS_ERR(rk_phy->phy)) {
-			dev_err(dev, "failed to create PHY\n");
-			return PTR_ERR(rk_phy->phy);
-		}
-		phy_set_drvdata(rk_phy->phy, rk_phy);
-
-		/* only power up usb phy when it use, so disable it when init*/
-		err = rockchip_usb_phy_power(rk_phy, 1);
+		err = rockchip_usb_phy_init(phy_base, child);
 		if (err)
 			return err;
 	}
-- 
2.6.2
