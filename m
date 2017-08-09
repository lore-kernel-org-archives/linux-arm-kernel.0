From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 9 Aug 2017 17:17:57 +0800
Subject: [PATCH 1/4] phy: rockchip: use of_device_get_match_data()
Message-ID: <1502270280-13792-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reduce the boilerplate code to get the specific data

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |    9 +++------
 drivers/phy/rockchip/phy-rockchip-pcie.c      |    7 +++----
 drivers/phy/rockchip/phy-rockchip-usb.c       |   10 +++-------
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 626883d..c2379b2 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
@@ -1024,7 +1025,6 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct rockchip_usb2phy *rphy;
 	const struct rockchip_usb2phy_cfg *phy_cfgs;
-	const struct of_device_id *match;
 	unsigned int reg;
 	int index, ret;
 
@@ -1032,11 +1032,9 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	if (!rphy)
 		return -ENOMEM;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
-		dev_err(dev, "phy configs are not assigned!\n");
+	phy_cfgs = of_device_get_match_data(dev);
+	if (!phy_cfgs)
 		return -EINVAL;
-	}
 
 	if (!dev->parent || !dev->parent->of_node)
 		return -EINVAL;
@@ -1052,7 +1050,6 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	rphy->dev = dev;
-	phy_cfgs = match->data;
 	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
 	rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
 	platform_set_drvdata(pdev, rphy);
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 6904633..f7dc0d6 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -286,7 +287,6 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
 	struct regmap *grf;
-	const struct of_device_id *of_id;
 
 	grf = syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(grf)) {
@@ -298,11 +298,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 	if (!rk_phy)
 		return -ENOMEM;
 
-	of_id = of_match_device(rockchip_pcie_phy_dt_ids, &pdev->dev);
-	if (!of_id)
+	rk_phy->phy_data = of_device_get_match_data(dev);
+	if (!rk_phy->phy_data)
 		return -EINVAL;
 
-	rk_phy->phy_data = (struct rockchip_pcie_data *)of_id->data;
 	rk_phy->reg_base = grf;
 
 	rk_phy->phy_rst = devm_reset_control_get(dev, "phy");
diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
index 3378eeb..7db1166 100644
--- a/drivers/phy/rockchip/phy-rockchip-usb.c
+++ b/drivers/phy/rockchip/phy-rockchip-usb.c
@@ -22,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -417,7 +418,6 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rockchip_usb_phy_base *phy_base;
 	struct phy_provider *phy_provider;
-	const struct of_device_id *match;
 	struct device_node *child;
 	int err;
 
@@ -425,13 +425,9 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	if (!phy_base)
 		return -ENOMEM;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
-		dev_err(dev, "missing phy data\n");
+	phy_base->pdata = of_device_get_match_data(dev);
+	if (!phy_base->pdata)
 		return -EINVAL;
-	}
-
-	phy_base->pdata = match->data;
 
 	phy_base->dev = dev;
 	phy_base->reg_base = ERR_PTR(-ENODEV);
-- 
1.7.9.5
