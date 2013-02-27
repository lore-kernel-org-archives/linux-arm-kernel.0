From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 13:27:15 +0100
Subject: [PATCH 9/9] USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get
 phy
In-Reply-To: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1361968035-18644-10-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

This patch replaces the hand crafted code to retrieve the phy's phandle from
the DT by the helper function devm_usb_get_phy_by_phandle() which has been
added in commit:

    "5d3c28b usb: otg: add device tree support to otg library"

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/ci13xxx_imx.c |   38 ++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index b598bb8..6e720ce 100644
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
@@ -147,19 +146,20 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
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
+	if (PTR_ERR(phy) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_clk;
+	}
+
+	if (!IS_ERR(phy)) {
+		ret = usb_phy_init(phy);
+		if (ret) {
+			dev_err(&pdev->dev, "unable to init phy: %d\n", ret);
+			goto err_clk;
 		}
+
+		data->phy = phy;
 	}
 
 	/* we only support host now, so enable vbus here */
@@ -170,7 +170,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Failed to enable vbus regulator, err=%d\n",
 				ret);
-			goto put_np;
+			goto err_clk;
 		}
 		data->reg_vbus = reg_vbus;
 	} else {
@@ -222,9 +222,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
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
@@ -244,8 +242,6 @@ static int ci13xxx_imx_remove(struct platform_device *pdev)
 		module_put(data->phy->dev->driver->owner);
 	}
 
-	of_node_put(data->phy_np);
-
 	clk_disable_unprepare(data->clk);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.10.4
