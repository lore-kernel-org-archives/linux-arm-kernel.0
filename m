From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 31 Jul 2013 11:37:59 +0530
Subject: [PATCH V4 1/6] USB: OHCI: make ohci-exynos a separate driver
In-Reply-To: <1375250884-28447-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1375250884-28447-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1375250884-28447-2-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the  Samsung OHCI EXYNOS host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM;
it would be nice to have in 3.11.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Cc: Vivek Gautam <gautam.vivek@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -exynos_ohci_hcd structure assignment error fixed.
 -Removed multiple usb_create_hcd() from prob funtion.
 -platform_set_drvdata() called before exynos_ohci_phy_enable().
 -ohci_setup() removed because it is called in .reset member
  of the ohci_hc_driver structure

V3:
 -No major changes only "exynos" written in capital letters
  in "OHCI exynos driver".
---
 drivers/usb/host/Kconfig       |    2 +-
 drivers/usb/host/Makefile      |    1 +
 drivers/usb/host/ohci-exynos.c |  167 +++++++++++++++++-----------------------
 drivers/usb/host/ohci-hcd.c    |   18 -----
 4 files changed, 71 insertions(+), 117 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 7bc598b..7b8f6bd 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -463,7 +463,7 @@ config USB_OHCI_SH
 	  If you use the PCI OHCI controller, this option is not necessary.
 
 config USB_OHCI_EXYNOS
-	boolean "OHCI support for Samsung EXYNOS SoC Series"
+	tristate "OHCI support for Samsung EXYNOS SoC Series"
 	depends on ARCH_EXYNOS
 	help
 	 Enable support for the Samsung Exynos SOC's on-chip OHCI controller.
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 480e203..26cf69a 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD_PCI)	+= ohci-pci.o
 obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+= ohci-platform.o
+obj-$(CONFIG_USB_OHCI_EXYNOS)	+= ohci-exynos.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index b0b542c..ae6068d 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -12,24 +12,39 @@
  */
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/usb-ohci-exynos.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/samsung_usb_phy.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/otg.h>
+
+#include "ohci.h"
+
+#define DRIVER_DESC "OHCI EXYNOS driver"
+
+static const char hcd_name[] = "ohci-exynos";
+static struct hc_driver __read_mostly exynos_ohci_hc_driver;
+
+#define to_exynos_ohci(hcd) (struct exynos_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
 
 struct exynos_ohci_hcd {
-	struct device *dev;
-	struct usb_hcd *hcd;
 	struct clk *clk;
 	struct usb_phy *phy;
 	struct usb_otg *otg;
 	struct exynos4_ohci_platdata *pdata;
 };
 
-static void exynos_ohci_phy_enable(struct exynos_ohci_hcd *exynos_ohci)
+static void exynos_ohci_phy_enable(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(exynos_ohci->dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 
 	if (exynos_ohci->phy)
 		usb_phy_init(exynos_ohci->phy);
@@ -37,9 +52,10 @@ static void exynos_ohci_phy_enable(struct exynos_ohci_hcd *exynos_ohci)
 		exynos_ohci->pdata->phy_init(pdev, USB_PHY_TYPE_HOST);
 }
 
-static void exynos_ohci_phy_disable(struct exynos_ohci_hcd *exynos_ohci)
+static void exynos_ohci_phy_disable(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(exynos_ohci->dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 
 	if (exynos_ohci->phy)
 		usb_phy_shutdown(exynos_ohci->phy);
@@ -47,63 +63,11 @@ static void exynos_ohci_phy_disable(struct exynos_ohci_hcd *exynos_ohci)
 		exynos_ohci->pdata->phy_exit(pdev, USB_PHY_TYPE_HOST);
 }
 
-static int ohci_exynos_reset(struct usb_hcd *hcd)
-{
-	return ohci_init(hcd_to_ohci(hcd));
-}
-
-static int ohci_exynos_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	ohci_dbg(ohci, "ohci_exynos_start, ohci:%p", ohci);
-
-	ret = ohci_run(ohci);
-	if (ret < 0) {
-		dev_err(hcd->self.controller, "can't start %s\n",
-			hcd->self.bus_name);
-		ohci_stop(hcd);
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct hc_driver exynos_ohci_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "EXYNOS OHCI Host Controller",
-	.hcd_priv_size		= sizeof(struct ohci_hcd),
-
-	.irq			= ohci_irq,
-	.flags			= HCD_MEMORY|HCD_USB11,
-
-	.reset			= ohci_exynos_reset,
-	.start			= ohci_exynos_start,
-	.stop			= ohci_stop,
-	.shutdown		= ohci_shutdown,
-
-	.get_frame_number	= ohci_get_frame,
-
-	.urb_enqueue		= ohci_urb_enqueue,
-	.urb_dequeue		= ohci_urb_dequeue,
-	.endpoint_disable	= ohci_endpoint_disable,
-
-	.hub_status_data	= ohci_hub_status_data,
-	.hub_control		= ohci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend		= ohci_bus_suspend,
-	.bus_resume		= ohci_bus_resume,
-#endif
-	.start_port_reset	= ohci_start_port_reset,
-};
-
 static int exynos_ohci_probe(struct platform_device *pdev)
 {
 	struct exynos4_ohci_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_ohci_hcd *exynos_ohci;
 	struct usb_hcd *hcd;
-	struct ohci_hcd *ohci;
 	struct resource *res;
 	struct usb_phy *phy;
 	int irq;
@@ -119,10 +83,14 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	if (!pdev->dev.coherent_dma_mask)
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
-	exynos_ohci = devm_kzalloc(&pdev->dev, sizeof(struct exynos_ohci_hcd),
-					GFP_KERNEL);
-	if (!exynos_ohci)
+	hcd = usb_create_hcd(&exynos_ohci_hc_driver,
+				&pdev->dev, dev_name(&pdev->dev));
+	if (!hcd) {
+		dev_err(&pdev->dev, "Unable to create HCD\n");
 		return -ENOMEM;
+	}
+
+	exynos_ohci = to_exynos_ohci(hcd);
 
 	if (of_device_is_compatible(pdev->dev.of_node,
 					"samsung,exynos5440-ohci"))
@@ -143,17 +111,6 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	}
 
 skip_phy:
-
-	exynos_ohci->dev = &pdev->dev;
-
-	hcd = usb_create_hcd(&exynos_ohci_hc_driver, &pdev->dev,
-					dev_name(&pdev->dev));
-	if (!hcd) {
-		dev_err(&pdev->dev, "Unable to create HCD\n");
-		return -ENOMEM;
-	}
-
-	exynos_ohci->hcd = hcd;
 	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ohci->clk)) {
@@ -190,26 +147,21 @@ skip_phy:
 	}
 
 	if (exynos_ohci->otg)
-		exynos_ohci->otg->set_host(exynos_ohci->otg,
-					&exynos_ohci->hcd->self);
+		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
 
-	exynos_ohci_phy_enable(exynos_ohci);
+	platform_set_drvdata(pdev, hcd);
 
-	ohci = hcd_to_ohci(hcd);
-	ohci_hcd_init(ohci);
+	exynos_ohci_phy_enable(pdev);
 
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add USB HCD\n");
 		goto fail_add_hcd;
 	}
-
-	platform_set_drvdata(pdev, exynos_ohci);
-
 	return 0;
 
 fail_add_hcd:
-	exynos_ohci_phy_disable(exynos_ohci);
+	exynos_ohci_phy_disable(pdev);
 fail_io:
 	clk_disable_unprepare(exynos_ohci->clk);
 fail_clk:
@@ -219,16 +171,15 @@ fail_clk:
 
 static int exynos_ohci_remove(struct platform_device *pdev)
 {
-	struct exynos_ohci_hcd *exynos_ohci = platform_get_drvdata(pdev);
-	struct usb_hcd *hcd = exynos_ohci->hcd;
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 
 	usb_remove_hcd(hcd);
 
 	if (exynos_ohci->otg)
-		exynos_ohci->otg->set_host(exynos_ohci->otg,
-					&exynos_ohci->hcd->self);
+		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
 
-	exynos_ohci_phy_disable(exynos_ohci);
+	exynos_ohci_phy_disable(pdev);
 
 	clk_disable_unprepare(exynos_ohci->clk);
 
@@ -239,8 +190,7 @@ static int exynos_ohci_remove(struct platform_device *pdev)
 
 static void exynos_ohci_shutdown(struct platform_device *pdev)
 {
-	struct exynos_ohci_hcd *exynos_ohci = platform_get_drvdata(pdev);
-	struct usb_hcd *hcd = exynos_ohci->hcd;
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	if (hcd->driver->shutdown)
 		hcd->driver->shutdown(hcd);
@@ -249,9 +199,10 @@ static void exynos_ohci_shutdown(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int exynos_ohci_suspend(struct device *dev)
 {
-	struct exynos_ohci_hcd *exynos_ohci = dev_get_drvdata(dev);
-	struct usb_hcd *hcd = exynos_ohci->hcd;
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	struct platform_device *pdev = to_platform_device(dev);
 	unsigned long flags;
 	int rc = 0;
 
@@ -271,10 +222,9 @@ static int exynos_ohci_suspend(struct device *dev)
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 
 	if (exynos_ohci->otg)
-		exynos_ohci->otg->set_host(exynos_ohci->otg,
-					&exynos_ohci->hcd->self);
+		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
 
-	exynos_ohci_phy_disable(exynos_ohci);
+	exynos_ohci_phy_disable(pdev);
 
 	clk_disable_unprepare(exynos_ohci->clk);
 
@@ -286,16 +236,16 @@ fail:
 
 static int exynos_ohci_resume(struct device *dev)
 {
-	struct exynos_ohci_hcd *exynos_ohci = dev_get_drvdata(dev);
-	struct usb_hcd *hcd = exynos_ohci->hcd;
+	struct usb_hcd *hcd			= dev_get_drvdata(dev);
+	struct exynos_ohci_hcd *exynos_ohci	= to_exynos_ohci(hcd);
+	struct platform_device *pdev		= to_platform_device(dev);
 
 	clk_prepare_enable(exynos_ohci->clk);
 
 	if (exynos_ohci->otg)
-		exynos_ohci->otg->set_host(exynos_ohci->otg,
-					&exynos_ohci->hcd->self);
+		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
 
-	exynos_ohci_phy_enable(exynos_ohci);
+	exynos_ohci_phy_enable(pdev);
 
 	ohci_resume(hcd, false);
 
@@ -306,6 +256,10 @@ static int exynos_ohci_resume(struct device *dev)
 #define exynos_ohci_resume	NULL
 #endif
 
+static const struct ohci_driver_overrides exynos_overrides __initconst = {
+	.extra_priv_size =	sizeof(struct exynos_ohci_hcd),
+};
+
 static const struct dev_pm_ops exynos_ohci_pm_ops = {
 	.suspend	= exynos_ohci_suspend,
 	.resume		= exynos_ohci_resume,
@@ -331,6 +285,23 @@ static struct platform_driver exynos_ohci_driver = {
 		.of_match_table	= of_match_ptr(exynos_ohci_match),
 	}
 };
+static int __init ohci_exynos_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+	ohci_init_driver(&exynos_ohci_hc_driver, &exynos_overrides);
+	return platform_driver_register(&exynos_ohci_driver);
+}
+module_init(ohci_exynos_init);
+
+static void __exit ohci_exynos_cleanup(void)
+{
+	platform_driver_unregister(&exynos_ohci_driver);
+}
+module_exit(ohci_exynos_cleanup);
 
 MODULE_ALIAS("platform:exynos-ohci");
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index a9d3437..2980bb6 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1182,11 +1182,6 @@ MODULE_LICENSE ("GPL");
 #define S3C2410_PLATFORM_DRIVER	ohci_hcd_s3c2410_driver
 #endif
 
-#ifdef CONFIG_USB_OHCI_EXYNOS
-#include "ohci-exynos.c"
-#define EXYNOS_PLATFORM_DRIVER	exynos_ohci_driver
-#endif
-
 #ifdef CONFIG_USB_OHCI_HCD_OMAP1
 #include "ohci-omap.c"
 #define OMAP1_PLATFORM_DRIVER	ohci_hcd_omap_driver
@@ -1336,12 +1331,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_s3c2410;
 #endif
 
-#ifdef EXYNOS_PLATFORM_DRIVER
-	retval = platform_driver_register(&EXYNOS_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_exynos;
-#endif
-
 #ifdef EP93XX_PLATFORM_DRIVER
 	retval = platform_driver_register(&EP93XX_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1395,10 +1384,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
  error_ep93xx:
 #endif
-#ifdef EXYNOS_PLATFORM_DRIVER
-	platform_driver_unregister(&EXYNOS_PLATFORM_DRIVER);
- error_exynos:
-#endif
 #ifdef S3C2410_PLATFORM_DRIVER
 	platform_driver_unregister(&S3C2410_PLATFORM_DRIVER);
  error_s3c2410:
@@ -1463,9 +1448,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef EP93XX_PLATFORM_DRIVER
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
 #endif
-#ifdef EXYNOS_PLATFORM_DRIVER
-	platform_driver_unregister(&EXYNOS_PLATFORM_DRIVER);
-#endif
 #ifdef S3C2410_PLATFORM_DRIVER
 	platform_driver_unregister(&S3C2410_PLATFORM_DRIVER);
 #endif
-- 
1.7.9.5
