From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 01 Aug 2012 18:35:48 +0530
Subject: [PATCH 2/5] usb: s3c-hsotg: Adding phy driver support
In-Reply-To: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
References: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1343826351-8756-3-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the transceiver to hsotg driver. Keeping the platform data
for continuing the smooth operation for boards which still uses it

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 drivers/usb/gadget/s3c-hsotg.c |   38 ++++++++++++++++++++++++++++----------
 1 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index b13e0bb..f4ba9a3 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -32,6 +32,7 @@
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
 #include <mach/map.h>
@@ -133,7 +134,9 @@ struct s3c_hsotg_ep {
  * struct s3c_hsotg - driver state.
  * @dev: The parent device supplied to the probe function
  * @driver: USB gadget driver
- * @plat: The platform specific configuration data.
+ * @phy: The otg phy transeiver structure for phy control.
+ * @plat: The platform specific configuration data. This can be removed once
+ * all SoCs support usb transceiver.
  * @regs: The memory area mapped for accessing registers.
  * @irq: The IRQ number we are using
  * @supplies: Definition of USB power supplies
@@ -153,6 +156,7 @@ struct s3c_hsotg_ep {
 struct s3c_hsotg {
 	struct device		 *dev;
 	struct usb_gadget_driver *driver;
+	struct usb_phy		*phy;
 	struct s3c_hsotg_plat	 *plat;
 
 	spinlock_t              lock;
@@ -2854,7 +2858,10 @@ static void s3c_hsotg_phy_enable(struct s3c_hsotg *hsotg)
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 
 	dev_dbg(hsotg->dev, "pdev 0x%p\n", pdev);
-	if (hsotg->plat->phy_init)
+
+	if (hsotg->phy)
+		usb_phy_init(hsotg->phy);
+	else if (hsotg->plat->phy_init)
 		hsotg->plat->phy_init(pdev, hsotg->plat->phy_type);
 }
 
@@ -2869,7 +2876,9 @@ static void s3c_hsotg_phy_disable(struct s3c_hsotg *hsotg)
 {
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 
-	if (hsotg->plat->phy_exit)
+	if (hsotg->phy)
+		usb_phy_shutdown(hsotg->phy);
+	else if (hsotg->plat->phy_exit)
 		hsotg->plat->phy_exit(pdev, hsotg->plat->phy_type);
 }
 
@@ -3493,6 +3502,7 @@ static void s3c_hsotg_release(struct device *dev)
 static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 {
 	struct s3c_hsotg_plat *plat = pdev->dev.platform_data;
+	struct usb_phy *phy;
 	struct device *dev = &pdev->dev;
 	struct s3c_hsotg_ep *eps;
 	struct s3c_hsotg *hsotg;
@@ -3501,20 +3511,25 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	plat = pdev->dev.platform_data;
-	if (!plat) {
-		dev_err(&pdev->dev, "no platform data defined\n");
-		return -EINVAL;
-	}
-
 	hsotg = devm_kzalloc(&pdev->dev, sizeof(struct s3c_hsotg), GFP_KERNEL);
 	if (!hsotg) {
 		dev_err(dev, "cannot get memory\n");
 		return -ENOMEM;
 	}
 
+	phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	if (!phy) {
+		/* Fallback for platform data */
+		plat = pdev->dev.platform_data;
+		if (!plat) {
+			dev_err(&pdev->dev, "no platform data or transceiver defined\n");
+			return -ENODEV;
+		} else
+			hsotg->plat = plat;
+	} else
+		hsotg->phy = phy;
+
 	hsotg->dev = dev;
-	hsotg->plat = plat;
 
 	hsotg->clk = clk_get(&pdev->dev, "otg");
 	if (IS_ERR(hsotg->clk)) {
@@ -3689,6 +3704,9 @@ static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
 	s3c_hsotg_phy_disable(hsotg);
 	regulator_bulk_free(ARRAY_SIZE(hsotg->supplies), hsotg->supplies);
 
+	if (hsotg->phy)
+		devm_usb_put_phy(&pdev->dev, hsotg->phy);
+
 	clk_disable_unprepare(hsotg->clk);
 	clk_put(hsotg->clk);
 
-- 
1.7.1
