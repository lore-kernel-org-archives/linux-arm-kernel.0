From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon, 12 Aug 2013 12:16:57 +0530
Subject: [PATCH V5 3/6] USB: OHCI: make ohci-omap3 a separate driver
In-Reply-To: <1376290020-26253-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1376290020-26253-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1376290020-26253-4-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the  TI OHCI OMAP3 host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM;
it would be nice to have in 3.11.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -ohci_setup() removed because it is called in .reset member
  of the ohci_hc_driver structure.
 -The improper multi-line commenting style written in proper way.
  ('*' characters aligned in vertically).

V3:
 -RemoteWakeupConnected setting has been removed.

V4:
 -V3 modification revert back, only ohci->regs setting write()
  function has been removed because ohci->regs doesn't get set until
  usb_add_hcd.

V5:
 - No change.
---
 drivers/usb/host/Kconfig      |    2 +-
 drivers/usb/host/Makefile     |    1 +
 drivers/usb/host/ohci-hcd.c   |   18 -------
 drivers/usb/host/ohci-omap3.c |  118 +++++++++++++----------------------------
 4 files changed, 40 insertions(+), 99 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 99b7e7e..3eab432 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -383,7 +383,7 @@ config USB_OHCI_HCD_OMAP1
 	  Enables support for the OHCI controller on OMAP1/2 chips.
 
 config USB_OHCI_HCD_OMAP3
-	bool "OHCI support for OMAP3 and later chips"
+	tristate "OHCI support for OMAP3 and later chips"
 	depends on (ARCH_OMAP3 || ARCH_OMAP4)
 	default y
 	---help---
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index a0220c1..a0064a6 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_USB_OHCI_HCD_PCI)	+= ohci-pci.o
 obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+= ohci-platform.o
 obj-$(CONFIG_USB_OHCI_EXYNOS)	+= ohci-exynos.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
+obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+= ohci-omap3.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 1abc1e7..cad51d2 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1182,11 +1182,6 @@ MODULE_LICENSE ("GPL");
 #define S3C2410_PLATFORM_DRIVER	ohci_hcd_s3c2410_driver
 #endif
 
-#ifdef CONFIG_USB_OHCI_HCD_OMAP3
-#include "ohci-omap3.c"
-#define OMAP3_PLATFORM_DRIVER	ohci_hcd_omap3_driver
-#endif
-
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 #include "ohci-pxa27x.c"
 #define PLATFORM_DRIVER		ohci_hcd_pxa27x_driver
@@ -1284,12 +1279,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_platform;
 #endif
 
-#ifdef OMAP3_PLATFORM_DRIVER
-	retval = platform_driver_register(&OMAP3_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_omap3_platform;
-#endif
-
 #ifdef OF_PLATFORM_DRIVER
 	retval = platform_driver_register(&OF_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1393,10 +1382,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&OF_PLATFORM_DRIVER);
  error_of_platform:
 #endif
-#ifdef OMAP3_PLATFORM_DRIVER
-	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
- error_omap3_platform:
-#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
  error_platform:
@@ -1448,9 +1433,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef OF_PLATFORM_DRIVER
 	platform_driver_unregister(&OF_PLATFORM_DRIVER);
 #endif
-#ifdef OMAP3_PLATFORM_DRIVER
-	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
-#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index 8f71357..e14f4d9 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -29,90 +29,22 @@
  *	- add kernel-doc
  */
 
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/usb/otg.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/of.h>
-#include <linux/dma-mapping.h>
-
-/*-------------------------------------------------------------------------*/
-
-static int ohci_omap3_init(struct usb_hcd *hcd)
-{
-	dev_dbg(hcd->self.controller, "starting OHCI controller\n");
-
-	return ohci_init(hcd_to_ohci(hcd));
-}
-
-/*-------------------------------------------------------------------------*/
-
-static int ohci_omap3_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	/*
-	 * RemoteWakeupConnected has to be set explicitly before
-	 * calling ohci_run. The reset value of RWC is 0.
-	 */
-	ohci->hc_control = OHCI_CTRL_RWC;
-	writel(OHCI_CTRL_RWC, &ohci->regs->control);
-
-	ret = ohci_run(ohci);
-
-	if (ret < 0) {
-		dev_err(hcd->self.controller, "can't start\n");
-		ohci_stop(hcd);
-	}
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
 
-	return ret;
-}
+#include "ohci.h"
 
-/*-------------------------------------------------------------------------*/
+#define DRIVER_DESC "OHCI OMAP3 driver"
 
-static const struct hc_driver ohci_omap3_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"OMAP3 OHCI Host Controller",
-	.hcd_priv_size =	sizeof(struct ohci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.reset =		ohci_omap3_init,
-	.start =		ohci_omap3_start,
-	.stop =			ohci_stop,
-	.shutdown =		ohci_shutdown,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue =		ohci_urb_enqueue,
-	.urb_dequeue =		ohci_urb_dequeue,
-	.endpoint_disable =	ohci_endpoint_disable,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number =	ohci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data =	ohci_hub_status_data,
-	.hub_control =		ohci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend =		ohci_bus_suspend,
-	.bus_resume =		ohci_bus_resume,
-#endif
-	.start_port_reset =	ohci_start_port_reset,
-};
-
-/*-------------------------------------------------------------------------*/
+static const char hcd_name[] = "ohci-omap3";
+static struct hc_driver __read_mostly ohci_omap3_hc_driver;
 
 /*
  * configure so an HC device and id are always provided
@@ -129,6 +61,7 @@ static const struct hc_driver ohci_omap3_hc_driver = {
 static int ohci_hcd_omap3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
+	struct ohci_hcd		*ohci;
 	struct usb_hcd		*hcd = NULL;
 	void __iomem		*regs = NULL;
 	struct resource		*res;
@@ -185,7 +118,12 @@ static int ohci_hcd_omap3_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
+	ohci = hcd_to_ohci(hcd);
+	/*
+	 * RemoteWakeupConnected has to be set explicitly before
+	 * calling ohci_run. The reset value of RWC is 0.
+	 */
+	ohci->hc_control = OHCI_CTRL_RWC;
 
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret) {
@@ -256,5 +194,25 @@ static struct platform_driver ohci_hcd_omap3_driver = {
 	},
 };
 
+static int __init ohci_omap3_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_omap3_hc_driver, NULL);
+	return platform_driver_register(&ohci_hcd_omap3_driver);
+}
+module_init(ohci_omap3_init);
+
+static void __exit ohci_omap3_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_omap3_driver);
+}
+module_exit(ohci_omap3_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_ALIAS("platform:ohci-omap3");
 MODULE_AUTHOR("Anand Gadiyar <gadiyar@ti.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
