From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 14 Nov 2013 00:09:46 -0200
Subject: [PATCH 1/2] chipidea: ci_hdrc_imx: Allow handling the clock for an
 USB phy/hub
Message-ID: <1384394987-15134-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When using external USB PHY or USB hub, it is common that they require a clock
input.

Add a 'clk_phy' clock, so that it can be retrieved from the device tree and 
enabled in the driver, so that the clock can properly drive the external 
USB phy/hub.

Tested on a imx6q-udoo board, that connects via USBH1 to a USB2514 hub.

In this board the USB2514 is clocked from a 24MHz clock that comes from the 
imx6q CLKO2 pin.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 .../devicetree/bindings/usb/ci13xxx-imx.txt          |  2 ++
 drivers/usb/chipidea/ci_hdrc_imx.c                   | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
index b4b5b79..07ba38c 100644
--- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
@@ -18,6 +18,8 @@ Optional properties:
 - vbus-supply: regulator for vbus
 - disable-over-current: disable over current detect
 - external-vbus-divider: enables off-chip resistor divider for Vbus
+- clocks: phandle to the clock that drives the USB hub
+- clock-names: must be "phy"
 
 Examples:
 usb at 02184000 { /* USB OTG */
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index bb5d976..a197748 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -27,6 +27,7 @@ struct ci_hdrc_imx_data {
 	struct usb_phy *phy;
 	struct platform_device *ci_pdev;
 	struct clk *clk;
+	struct clk *clk_phy;
 	struct imx_usbmisc_data *usbmisc_data;
 };
 
@@ -107,10 +108,22 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	data->clk_phy = devm_clk_get(&pdev->dev, "phy");
+	if (IS_ERR(data->clk_phy)) {
+		data->clk_phy = NULL;
+	} else {
+		ret = clk_prepare_enable(data->clk_phy);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable clk_phy: %d\n", ret);
+			goto err_clk;
+		}
+	}
+
 	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
 	if (IS_ERR(data->phy)) {
 		ret = PTR_ERR(data->phy);
-		goto err_clk;
+		goto err_clk_phy;
 	}
 
 	pdata.phy = data->phy;
@@ -157,6 +170,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
+err_clk_phy:
+	if (data->clk_phy)
+		clk_disable_unprepare(data->clk_phy);
 err_clk:
 	clk_disable_unprepare(data->clk);
 	return ret;
@@ -168,6 +184,8 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	ci_hdrc_remove_device(data->ci_pdev);
+	if (data->clk_phy)
+		clk_disable_unprepare(data->clk_phy);
 	clk_disable_unprepare(data->clk);
 
 	return 0;
-- 
1.8.1.2
