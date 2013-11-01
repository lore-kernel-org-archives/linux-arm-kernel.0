From: matt.porter@linaro.org (Matt Porter)
Date: Fri,  1 Nov 2013 15:45:54 -0400
Subject: [PATCH v2 5/9] usb: gadget: s3c-hsotg: enable generic phy support
In-Reply-To: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1383335158-19730-6-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for the generic PHY subsystem. Generic PHY
support is probed and then the driver falls back to checking
for an old style USB PHY and pdata if not found.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 drivers/usb/gadget/s3c-hsotg.c | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 3e0c124..f97978b 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -34,6 +34,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/phy.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
 #include "s3c-hsotg.h"
@@ -131,7 +132,8 @@ struct s3c_hsotg_ep {
  * struct s3c_hsotg - driver state.
  * @dev: The parent device supplied to the probe function
  * @driver: USB gadget driver
- * @phy: The otg phy transceiver structure for phy control.
+ * @phy: The otg phy transceiver structure for old USB phy control.
+ * @gphy: The otg phy transceiver structure for generic phy control.
  * @plat: The platform specific configuration data. This can be removed once
  * all SoCs support usb transceiver.
  * @regs: The memory area mapped for accessing registers.
@@ -154,6 +156,7 @@ struct s3c_hsotg {
 	struct device		 *dev;
 	struct usb_gadget_driver *driver;
 	struct usb_phy		*phy;
+	struct phy		*gphy;
 	struct s3c_hsotg_plat	 *plat;
 
 	spinlock_t              lock;
@@ -2820,9 +2823,12 @@ static void s3c_hsotg_phy_enable(struct s3c_hsotg *hsotg)
 
 	dev_dbg(hsotg->dev, "pdev 0x%p\n", pdev);
 
-	if (hsotg->phy)
+	if (hsotg->gphy) {
+		phy_init(hsotg->gphy);
+		phy_power_on(hsotg->gphy);
+	} else if (hsotg->phy) {
 		usb_phy_init(hsotg->phy);
-	else if (hsotg->plat->phy_init)
+	} else if (hsotg->plat->phy_init)
 		hsotg->plat->phy_init(pdev, hsotg->plat->phy_type);
 }
 
@@ -2837,9 +2843,12 @@ static void s3c_hsotg_phy_disable(struct s3c_hsotg *hsotg)
 {
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 
-	if (hsotg->phy)
+	if (hsotg->gphy) {
+		phy_power_off(hsotg->gphy);
+		phy_exit(hsotg->gphy);
+	} else if (hsotg->phy) {
 		usb_phy_shutdown(hsotg->phy);
-	else if (hsotg->plat->phy_exit)
+	} else if (hsotg->plat->phy_exit)
 		hsotg->plat->phy_exit(pdev, hsotg->plat->phy_type);
 }
 
@@ -3446,6 +3455,7 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
 {
 	struct s3c_hsotg_plat *plat = dev_get_platdata(&pdev->dev);
 	struct usb_phy *phy;
+	struct phy *gphy;
 	struct device *dev = &pdev->dev;
 	struct s3c_hsotg_ep *eps;
 	struct s3c_hsotg *hsotg;
@@ -3460,19 +3470,27 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-	if (IS_ERR(phy)) {
-		/* Fallback for pdata */
-		plat = dev_get_platdata(&pdev->dev);
-		if (!plat) {
-			dev_err(&pdev->dev, "no platform data or transceiver defined\n");
-			return -EPROBE_DEFER;
-		} else {
-			hsotg->plat = plat;
-		}
-	} else {
-		hsotg->phy = phy;
-	}
+	/*
+	 * Attempt to find a generic PHY, then look for an old style
+	 *  USB PHY, finally fall back to pdata
+	 */
+	gphy = devm_phy_get(dev, "usb2-phy");
+	if (IS_ERR(gphy)) {
+		phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+		if (IS_ERR(phy)) {
+			/* Fallback for pdata */
+			plat = dev_get_platdata(&pdev->dev);
+			if (!plat) {
+				dev_err(&pdev->dev,
+					"no platform data or transceiver defined\n");
+				return -EPROBE_DEFER;
+			} else {
+				hsotg->plat = plat;
+			}
+		} else
+			hsotg->phy = phy;
+	} else
+		hsotg->gphy = gphy;
 
 	hsotg->dev = dev;
 
-- 
1.8.4
