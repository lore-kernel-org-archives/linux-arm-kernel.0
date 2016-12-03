From: csmanjuvijay@gmail.com (csmanjuvijay at gmail.com)
Date: Sat,  3 Dec 2016 03:46:55 +0000
Subject: [PATCH v2] USB: OHCI: ohci-s3c2410: remove useless functions
In-Reply-To: <1480542166-7032-1-git-send-email-csmanjuvijay@gmail.com>
References: <1480542166-7032-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1480736815-24335-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <csmanjuvijay@gmail.com>

The ohci_hcd_s3c2410_drv_probe and ohci_hcd_s3c2410_drv_remove
functions are removed as these are useless functions except calling
usb_hcd_s3c2410_probe and usb_hcd_s3c2410_remove functions.

The usb_hcd_s3c2410_probe function renamed to ohci_hcd_s3c2410_drv_probe
and usb_hcd_s3c2410_remove function renamed to ohci_hcd_s3c2410_drv_remove
for proper naming.

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-usb at vger.kernel.org
Cc: linux-kernel at vger.kernel.org

---
Changelog v1 -> v2:
Removed checkpatch.pl warnings and errors cleanup code which is not related
to this patch.
 
 drivers/usb/host/ohci-s3c2410.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index d8e03a8..b006b93 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -43,6 +43,8 @@ static const char hcd_name[] = "ohci-s3c2410";
 static struct clk *clk;
 static struct clk *usb_clk;
 
+static struct hc_driver __read_mostly ohci_s3c2410_hc_driver;
+
 /* forward definitions */
 
 static void s3c2410_hcd_oc(struct s3c2410_hcd_info *info, int port_oc);
@@ -321,26 +323,29 @@ static void s3c2410_hcd_oc(struct s3c2410_hcd_info *info, int port_oc)
 /* may be called with controller, bus, and devices active */
 
 /*
- * usb_hcd_s3c2410_remove - shutdown processing for HCD
+ * ohci_hcd_s3c2410_remove - shutdown processing for HCD
  * @dev: USB Host Controller being removed
  * Context: !in_interrupt()
  *
- * Reverses the effect of usb_hcd_3c2410_probe(), first invoking
+ * Reverses the effect of ohci_hcd_3c2410_probe(), first invoking
  * the HCD's stop() method.  It is always called from a thread
  * context, normally "rmmod", "apmd", or something similar.
  *
 */
 
-static void
-usb_hcd_s3c2410_remove(struct usb_hcd *hcd, struct platform_device *dev)
+static int
+ohci_hcd_s3c2410_remove(struct platform_device *dev)
 {
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+
 	usb_remove_hcd(hcd);
 	s3c2410_stop_hc(dev);
 	usb_put_hcd(hcd);
+	return 0;
 }
 
 /**
- * usb_hcd_s3c2410_probe - initialize S3C2410-based HCDs
+ * ohci_hcd_s3c2410_probe - initialize S3C2410-based HCDs
  * Context: !in_interrupt()
  *
  * Allocates basic resources for this USB host controller, and
@@ -348,8 +353,7 @@ usb_hcd_s3c2410_remove(struct usb_hcd *hcd, struct platform_device *dev)
  * through the hotplug entry's driver_data.
  *
  */
-static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
-				  struct platform_device *dev)
+static int ohci_hcd_s3c2410_probe(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = NULL;
 	struct s3c2410_hcd_info *info = dev_get_platdata(&dev->dev);
@@ -358,7 +362,7 @@ static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
 	s3c2410_usb_set_power(info, 1, 1);
 	s3c2410_usb_set_power(info, 2, 1);
 
-	hcd = usb_create_hcd(driver, &dev->dev, "s3c24xx");
+	hcd = usb_create_hcd(&ohci_s3c2410_hc_driver, &dev->dev, "s3c24xx");
 	if (hcd == NULL)
 		return -ENOMEM;
 
@@ -404,21 +408,6 @@ static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
 
 /*-------------------------------------------------------------------------*/
 
-static struct hc_driver __read_mostly ohci_s3c2410_hc_driver;
-
-static int ohci_hcd_s3c2410_drv_probe(struct platform_device *pdev)
-{
-	return usb_hcd_s3c2410_probe(&ohci_s3c2410_hc_driver, pdev);
-}
-
-static int ohci_hcd_s3c2410_drv_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-
-	usb_hcd_s3c2410_remove(hcd, pdev);
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int ohci_hcd_s3c2410_drv_suspend(struct device *dev)
 {
@@ -465,8 +454,8 @@ static const struct of_device_id ohci_hcd_s3c2410_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ohci_hcd_s3c2410_dt_ids);
 
 static struct platform_driver ohci_hcd_s3c2410_driver = {
-	.probe		= ohci_hcd_s3c2410_drv_probe,
-	.remove		= ohci_hcd_s3c2410_drv_remove,
+	.probe		= ohci_hcd_s3c2410_probe,
+	.remove		= ohci_hcd_s3c2410_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
 		.name	= "s3c2410-ohci",
-- 
2.7.4
