From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue,  9 Jan 2018 20:28:54 +0100
Subject: [PATCH] usb: dwc2: Fix endless deferral probe
Message-ID: <1515526134-2148-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwc2 USB driver tries to find a generic PHY first and then look
for an old style USB PHY. In case of a valid generic PHY node without
a PHY driver, the PHY layer will return -EPROBE_DEFER forever. So dwc2
will never tries for an USB PHY.

Fix this issue by finding a generic PHY and an old style USB PHY
at once.

Fixes: 6c2dad69163f ("usb: dwc2: Return errors from PHY")
Link: https://marc.info/?l=linux-usb&m=151518314314753&w=2
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/usb/dwc2/platform.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 3e26550..5279567 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -225,10 +225,11 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	hsotg->phyif = GUSBCFG_PHYIF16;
 
 	/*
-	 * Attempt to find a generic PHY, then look for an old style
-	 * USB PHY and then fall back to pdata
+	 * Attempt to find a generic PHY or an old style USB PHY at once
+	 * otherwise fall back to pdata
 	 */
 	hsotg->phy = devm_phy_get(hsotg->dev, "usb2-phy");
+	hsotg->uphy = devm_usb_get_phy(hsotg->dev, USB_PHY_TYPE_USB2);
 	if (IS_ERR(hsotg->phy)) {
 		ret = PTR_ERR(hsotg->phy);
 		switch (ret) {
@@ -237,29 +238,34 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 			hsotg->phy = NULL;
 			break;
 		case -EPROBE_DEFER:
-			return ret;
+			if (IS_ERR(hsotg->uphy))
+				return ret;
+
+			hsotg->phy = NULL;
+			break;
 		default:
 			dev_err(hsotg->dev, "error getting phy %d\n", ret);
 			return ret;
 		}
 	}
 
-	if (!hsotg->phy) {
-		hsotg->uphy = devm_usb_get_phy(hsotg->dev, USB_PHY_TYPE_USB2);
-		if (IS_ERR(hsotg->uphy)) {
-			ret = PTR_ERR(hsotg->uphy);
-			switch (ret) {
-			case -ENODEV:
-			case -ENXIO:
-				hsotg->uphy = NULL;
-				break;
-			case -EPROBE_DEFER:
-				return ret;
-			default:
-				dev_err(hsotg->dev, "error getting usb phy %d\n",
-					ret);
+	if (IS_ERR(hsotg->uphy)) {
+		ret = PTR_ERR(hsotg->uphy);
+		switch (ret) {
+		case -ENODEV:
+		case -ENXIO:
+			hsotg->uphy = NULL;
+			break;
+		case -EPROBE_DEFER:
+			if (!hsotg->phy)
 				return ret;
-			}
+
+			hsotg->uphy = NULL;
+			break;
+		default:
+			dev_err(hsotg->dev, "error getting usb phy %d\n",
+				ret);
+			return ret;
 		}
 	}
 
-- 
2.7.4
