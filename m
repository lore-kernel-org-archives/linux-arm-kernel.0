From: csmanjuvijay@gmail.com (csmanjuvijay at gmail.com)
Date: Tue, 22 Nov 2016 13:49:22 +0000
Subject: [PATCH] USB: OHCI: use module_platform_driver macro
Message-ID: <1479822562-18719-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <csmanjuvijay@gmail.com>

Use the module_platform_driver macro to do module init/exit.
This eliminates a lot of boilerplate.This also removes
checkpatch.pl errors.

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-usb at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/usb/host/ohci-nxp.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index b7d4756..9908647 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -56,8 +56,6 @@ static struct hc_driver __read_mostly ohci_nxp_hc_driver;
 
 static struct i2c_client *isp1301_i2c_client;
 
-extern int usb_disabled(void);
-
 static struct clk *usb_host_clk;
 
 static void isp1301_configure_lpc32xx(void)
@@ -127,6 +125,7 @@ static inline void isp1301_vbus_off(void)
 static void ohci_nxp_start_hc(void)
 {
 	unsigned long tmp = __raw_readl(USB_OTG_STAT_CONTROL) | HOST_EN;
+
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
 	isp1301_vbus_on();
 }
@@ -134,6 +133,7 @@ static void ohci_nxp_start_hc(void)
 static void ohci_nxp_stop_hc(void)
 {
 	unsigned long tmp;
+
 	isp1301_vbus_off();
 	tmp = __raw_readl(USB_OTG_STAT_CONTROL) & ~HOST_EN;
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
@@ -142,11 +142,17 @@ static void ohci_nxp_stop_hc(void)
 static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = 0;
-	const struct hc_driver *driver = &ohci_nxp_hc_driver;
 	struct resource *res;
 	int ret = 0, irq;
 	struct device_node *isp1301_node;
 
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_nxp_hc_driver, NULL);
+
 	if (pdev->dev.of_node) {
 		isp1301_node = of_parse_phandle(pdev->dev.of_node,
 						"transceiver", 0);
@@ -155,9 +161,8 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	}
 
 	isp1301_i2c_client = isp1301_get_client(isp1301_node);
-	if (!isp1301_i2c_client) {
+	if (!isp1301_i2c_client)
 		return -EPROBE_DEFER;
-	}
 
 	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
@@ -165,6 +170,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s: " DRIVER_DESC " (nxp)\n", hcd_name);
 	if (usb_disabled()) {
+
 		dev_err(&pdev->dev, "USB is disabled\n");
 		ret = -ENODEV;
 		goto fail_disable;
@@ -186,7 +192,8 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 
 	isp1301_configure();
 
-	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
+	hcd = usb_create_hcd(&ohci_nxp_hc_driver, &pdev->dev,
+			 dev_name(&pdev->dev));
 	if (!hcd) {
 		dev_err(&pdev->dev, "Failed to allocate HC buffer\n");
 		ret = -ENOMEM;
@@ -260,24 +267,7 @@ static struct platform_driver ohci_hcd_nxp_driver = {
 	.probe = ohci_hcd_nxp_probe,
 	.remove = ohci_hcd_nxp_remove,
 };
-
-static int __init ohci_nxp_init(void)
-{
-	if (usb_disabled())
-		return -ENODEV;
-
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
-	ohci_init_driver(&ohci_nxp_hc_driver, NULL);
-	return platform_driver_register(&ohci_hcd_nxp_driver);
-}
-module_init(ohci_nxp_init);
-
-static void __exit ohci_nxp_cleanup(void)
-{
-	platform_driver_unregister(&ohci_hcd_nxp_driver);
-}
-module_exit(ohci_nxp_cleanup);
+module_platform_driver(ohci_hcd_nxp_driver);
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL v2");
-- 
2.7.4
