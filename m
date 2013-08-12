From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon, 12 Aug 2013 12:17:00 +0530
Subject: [PATCH V5 6/6] USB: OHCI: make ohci-s3c2410 a separate driver
In-Reply-To: <1376290020-26253-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1376290020-26253-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1376290020-26253-7-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the Samsung OHCI S3C24xx/S3C64xx host controller driver
from ohci-hcd host code so that it can be built as a separate
driver module.This work is part of enabling multi-platform
kernels on ARM;it would be nice to have in 3.12.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -Set non-standard fields in ohci_s3c2410_hc_driver manually, rather than
  relying on an expanded struct ohci_driver_overrides.
 -Save orig_ohci_hub_control and orig_ohci_hub_status_data rather than
  relying on ohci_hub_control and hub_status_data being exported.

V3:
 -Kconfig wrong parentheses discription fixed.
 -ohci_setup() has been removed because it is called in .reset member
  of the ohci_hc_driver structure.

V4:
 - Removed extra space before the '='.
 - Moved  /* forward definitions */ line before the declarations of functions.

V5:
 - String "s3cxxxx" is replaced by "s3c2410".
---
 drivers/usb/host/Kconfig        |    8 +++
 drivers/usb/host/Makefile       |    1 +
 drivers/usb/host/ohci-hcd.c     |   18 ------
 drivers/usb/host/ohci-s3c2410.c |  128 +++++++++++++++++----------------------
 4 files changed, 66 insertions(+), 89 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 693560a..ac7df55 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -390,6 +390,14 @@ config USB_OHCI_HCD_SPEAR
           Enables support for the on-chip OHCI controller on
           ST SPEAr chips.
 
+config USB_OHCI_HCD_S3C2410
+        tristate "OHCI support for Samsung S3C24xx/S3C64xx SoC series"
+        depends on USB_OHCI_HCD && (ARCH_S3C24XX || ARCH_S3C64XX)
+        default y
+        ---help---
+          Enables support for the on-chip OHCI controller on
+          S3C24xx/S3C64xx chips.
+
 config USB_OHCI_HCD_AT91
         tristate "Support for Atmel on-chip OHCI USB controller"
         depends on USB_OHCI_HCD && ARCH_AT91
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index a0ac663..cc5beaf 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+= ohci-omap3.o
 obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+= ohci-spear.o
 obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
+obj-$(CONFIG_USB_OHCI_HCD_S3C2410)	+= ohci-s3c2410.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index b48c892..b69a49e 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1177,11 +1177,6 @@ MODULE_LICENSE ("GPL");
 #define SA1111_DRIVER		ohci_hcd_sa1111_driver
 #endif
 
-#if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S3C64XX)
-#include "ohci-s3c2410.c"
-#define S3C2410_PLATFORM_DRIVER	ohci_hcd_s3c2410_driver
-#endif
-
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 #include "ohci-pxa27x.c"
 #define PLATFORM_DRIVER		ohci_hcd_pxa27x_driver
@@ -1293,12 +1288,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_tmio;
 #endif
 
-#ifdef S3C2410_PLATFORM_DRIVER
-	retval = platform_driver_register(&S3C2410_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_s3c2410;
-#endif
-
 #ifdef EP93XX_PLATFORM_DRIVER
 	retval = platform_driver_register(&EP93XX_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1332,10 +1321,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
  error_ep93xx:
 #endif
-#ifdef S3C2410_PLATFORM_DRIVER
-	platform_driver_unregister(&S3C2410_PLATFORM_DRIVER);
- error_s3c2410:
-#endif
 #ifdef TMIO_OHCI_DRIVER
 	platform_driver_unregister(&TMIO_OHCI_DRIVER);
  error_tmio:
@@ -1382,9 +1367,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef EP93XX_PLATFORM_DRIVER
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
 #endif
-#ifdef S3C2410_PLATFORM_DRIVER
-	platform_driver_unregister(&S3C2410_PLATFORM_DRIVER);
-#endif
 #ifdef TMIO_OHCI_DRIVER
 	platform_driver_unregister(&TMIO_OHCI_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index e125770..61f9aea 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -19,19 +19,36 @@
  * This file is licenced under the GPL.
 */
 
-#include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/platform_data/usb-ohci-s3c2410.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
+
 
 #define valid_port(idx) ((idx) == 1 || (idx) == 2)
 
 /* clock device associated with the hcd */
 
+
+#define DRIVER_DESC "OHCI S3C2410 driver"
+
+static const char hcd_name[] = "ohci-s3c2410";
+
 static struct clk *clk;
 static struct clk *usb_clk;
 
 /* forward definitions */
 
+static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
+			u16 wValue, u16 wIndex, char *buf, u16 wLength);
+static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
+
 static void s3c2410_hcd_oc(struct s3c2410_hcd_info *info, int port_oc);
 
 /* conversion functions */
@@ -93,7 +110,7 @@ ohci_s3c2410_hub_status_data(struct usb_hcd *hcd, char *buf)
 	int orig;
 	int portno;
 
-	orig  = ohci_hub_status_data(hcd, buf);
+	orig = orig_ohci_hub_status_data(hcd, buf);
 
 	if (info == NULL)
 		return orig;
@@ -164,7 +181,7 @@ static int ohci_s3c2410_hub_control(
 	 * process the request straight away and exit */
 
 	if (info == NULL) {
-		ret = ohci_hub_control(hcd, typeReq, wValue,
+		ret = orig_ohci_hub_control(hcd, typeReq, wValue,
 				       wIndex, buf, wLength);
 		goto out;
 	}
@@ -214,7 +231,7 @@ static int ohci_s3c2410_hub_control(
 		break;
 	}
 
-	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+	ret = orig_ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
 	if (ret)
 		goto out;
 
@@ -373,8 +390,6 @@ static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
 
 	s3c2410_start_hc(dev, hcd);
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
-
 	retval = usb_add_hcd(hcd, dev->resource[1].start, 0);
 	if (retval != 0)
 		goto err_ioremap;
@@ -391,71 +406,7 @@ static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
 
 /*-------------------------------------------------------------------------*/
 
-static int
-ohci_s3c2410_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	ret = ohci_init(ohci);
-	if (ret < 0)
-		return ret;
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
-
-static const struct hc_driver ohci_s3c2410_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"S3C24XX OHCI",
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
-	.start =		ohci_s3c2410_start,
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
-	.hub_status_data =	ohci_s3c2410_hub_status_data,
-	.hub_control =		ohci_s3c2410_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend =		ohci_bus_suspend,
-	.bus_resume =		ohci_bus_resume,
-#endif
-	.start_port_reset =	ohci_start_port_reset,
-};
-
-/* device driver */
+static struct hc_driver __read_mostly ohci_s3c2410_hc_driver;
 
 static int ohci_hcd_s3c2410_drv_probe(struct platform_device *pdev)
 {
@@ -532,4 +483,39 @@ static struct platform_driver ohci_hcd_s3c2410_driver = {
 	},
 };
 
+static int __init ohci_s3c2410_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+	ohci_init_driver(&ohci_s3c2410_hc_driver, NULL);
+
+	/*
+	 * The Samsung HW has some unusual quirks, which require
+	 * Sumsung-specific workarounds. We override certain hc_driver
+	 * functions here to achieve that. We explicitly do not enhance
+	 * ohci_driver_overrides to allow this more easily, since this
+	 * is an unusual case, and we don't want to encourage others to
+	 * override these functions by making it too easy.
+	 */
+
+	orig_ohci_hub_control = ohci_s3c2410_hc_driver.hub_control;
+	orig_ohci_hub_status_data = ohci_s3c2410_hc_driver.hub_status_data;
+
+	ohci_s3c2410_hc_driver.hub_status_data	= ohci_s3c2410_hub_status_data;
+	ohci_s3c2410_hc_driver.hub_control	= ohci_s3c2410_hub_control;
+
+	return platform_driver_register(&ohci_hcd_s3c2410_driver);
+}
+module_init(ohci_s3c2410_init);
+
+static void __exit ohci_s3c2410_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_s3c2410_driver);
+}
+module_exit(ohci_s3c2410_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:s3c2410-ohci");
-- 
1.7.9.5
