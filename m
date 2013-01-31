From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 Jan 2013 12:32:17 +0100
Subject: [PATCH 2/2] USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get
 phy
In-Reply-To: <1359631937-26646-1-git-send-email-s.hauer@pengutronix.de>
References: <1359631937-26646-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1359631937-26646-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/chipidea/ci13xxx_imx.c |   31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index b598bb8f..1df4b41 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -30,7 +30,6 @@
 	((struct usb_phy *)platform_get_drvdata(pdev))
 
 struct ci13xxx_imx_data {
-	struct device_node *phy_np;
 	struct usb_phy *phy;
 	struct platform_device *ci_pdev;
 	struct clk *clk;
@@ -90,12 +89,12 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 {
 	struct ci13xxx_imx_data *data;
 	struct ci13xxx_platform_data *pdata;
-	struct platform_device *plat_ci, *phy_pdev;
-	struct device_node *phy_np;
+	struct platform_device *plat_ci;
 	struct resource *res;
 	struct regulator *reg_vbus;
 	struct pinctrl *pinctrl;
 	int ret;
+	struct usb_phy *phy;
 
 	if (of_find_property(pdev->dev.of_node, "fsl,usbmisc", NULL)
 		&& !usbmisc_ops)
@@ -147,18 +146,12 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	phy_np = of_parse_phandle(pdev->dev.of_node, "fsl,usbphy", 0);
-	if (phy_np) {
-		data->phy_np = phy_np;
-		phy_pdev = of_find_device_by_node(phy_np);
-		if (phy_pdev) {
-			struct usb_phy *phy;
-			phy = pdev_to_phy(phy_pdev);
-			if (phy &&
-			    try_module_get(phy_pdev->dev.driver->owner)) {
-				usb_phy_init(phy);
-				data->phy = phy;
-			}
+	phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
+	if (!IS_ERR(phy)) {
+		ret = usb_phy_init(phy);
+		if (ret) {
+			dev_err(&pdev->dev, "unable to init phy: %d\n", ret);
+			goto err_clk;
 		}
 	}
 
@@ -170,7 +163,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Failed to enable vbus regulator, err=%d\n",
 				ret);
-			goto put_np;
+			goto err_clk;
 		}
 		data->reg_vbus = reg_vbus;
 	} else {
@@ -222,9 +215,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 err:
 	if (reg_vbus)
 		regulator_disable(reg_vbus);
-put_np:
-	if (phy_np)
-		of_node_put(phy_np);
+err_clk:
 	clk_disable_unprepare(data->clk);
 	return ret;
 }
@@ -244,8 +235,6 @@ static int ci13xxx_imx_remove(struct platform_device *pdev)
 		module_put(data->phy->dev->driver->owner);
 	}
 
-	of_node_put(data->phy_np);
-
 	clk_disable_unprepare(data->clk);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.10.4
