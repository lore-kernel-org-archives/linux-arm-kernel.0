From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 19 Jul 2012 01:31:07 +0200
Subject: [PATCH] usb: chipidea: ci13xxx-imx: remove global struct
Message-ID: <20120718233107.GA32622@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the limitation of having only one
instance of the ci13xxx-imx. Each instance of the ci13xxx-imx
could have different flags to be configured with, so we also
move this settings to the devicetree properties.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 +++++
 drivers/usb/chipidea/ci13xxx_imx.c                 |   25 +++++++++++---------
 drivers/usb/chipidea/core.c                        |   11 +++++++++
 include/linux/usb/chipidea.h                       |    3 +++
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
index 2c29041..5485eb9 100644
--- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
@@ -8,6 +8,9 @@ Required properties:
 Optional properties:
 - fsl,usbphy: phandler of usb phy that connects to the only one port
 - vbus-supply: regulator for vbus
+- require-transceiver: enable the flag in the driver
+- pullup-on-vbus: enable the flag in the driver
+- disable-streaming: enable the flag in the driver
 
 Examples:
 usb at 02184000 { /* USB OTG */
@@ -15,4 +18,7 @@ usb at 02184000 { /* USB OTG */
 	reg = <0x02184000 0x200>;
 	interrupts = <0 43 0x04>;
 	fsl,usbphy = <&usbphy1>;
+	require-transceiver;
+	pullup-on-vbus;
+	disable-streaming;
 };
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index f741a02..7116b0c 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -58,18 +58,10 @@ static int ci13xxx_imx_vbus(struct ci13xxx *ci, int enable)
 	return ret;
 }
 
-static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
-	.name			= "ci13xxx_imx",
-	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
-				  CI13XXX_PULLUP_ON_VBUS |
-				  CI13XXX_DISABLE_STREAMING,
-	.capoffset		= DEF_CAPOFFSET,
-	.set_vbus_power		= ci13xxx_imx_vbus,
-};
-
 static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 {
 	struct ci13xxx_imx_data *data;
+	struct ci13xxx_platform_data *pdata;
 	struct platform_device *plat_ci;
 	struct resource *res;
 	struct regulator *reg_vbus;
@@ -77,6 +69,17 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 	struct usb_phy *phy;
 	int ret;
 
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(&pdev->dev, "Failed to allocate CI13xxx-IMX pdata!\n");
+		return -ENOMEM;
+	}
+
+	pdata->name = "ci13xxx_imx";
+	pdata->capoffset = DEF_CAPOFFSET;
+	pdata->set_vbus_power = ci13xxx_imx_vbus;
+	ci13xxx_get_dr_flags(pdev->dev.of_node, pdata);
+
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		dev_err(&pdev->dev, "Failed to allocate CI13xxx-IMX data!\n");
@@ -112,7 +115,7 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 	if (!IS_ERR_OR_NULL(phy)) {
 		usb_phy_init(phy);
 		data->phy = phy;
-		ci13xxx_imx_platdata.phy = phy;
+		pdata->phy = phy;
 	}
 
 	/* we only support host now, so enable vbus here */
@@ -140,7 +143,7 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 
 	plat_ci = ci13xxx_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
-				&ci13xxx_imx_platdata);
+				pdata);
 	if (IS_ERR(plat_ci)) {
 		ret = PTR_ERR(plat_ci);
 		dev_err(&pdev->dev,
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 0942b9b..556ac76 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -390,6 +390,17 @@ void ci13xxx_remove_device(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ci13xxx_remove_device);
 
+void ci13xxx_get_dr_flags(struct device_node *of_node, struct ci13xxx_platform_data *pdata)
+{
+	if (of_find_property(of_node, "require-transceiver", NULL))
+		pdata->flags |= CI13XXX_REQUIRE_TRANSCEIVER;
+	if (of_find_property(of_node, "pullup-on-vbus", NULL))
+		pdata->flags |= CI13XXX_PULLUP_ON_VBUS;
+	if (of_find_property(of_node, "disable-streaming", NULL))
+		pdata->flags |= CI13XXX_DISABLE_STREAMING;
+}
+EXPORT_SYMBOL_GPL(ci13xxx_get_dr_flags);
+
 static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 080f479..0f8cdbb 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -37,4 +37,7 @@ struct platform_device *ci13xxx_add_device(struct device *dev,
 /* Remove ci13xxx device */
 void ci13xxx_remove_device(struct platform_device *pdev);
 
+/* Parse of-tree "flags" */
+void ci13xxx_get_dr_flags(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
+
 #endif
-- 
1.7.10.4
