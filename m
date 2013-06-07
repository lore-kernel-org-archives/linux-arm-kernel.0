From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Fri,  7 Jun 2013 11:33:33 +0530
Subject: [RFC][PATCH 7/7] USB: OHCI: make ohci-s3c2410 a separate driver
In-Reply-To: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1370585013-12809-8-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the Samsung OHCI S3CXXXX host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig        |    8 +++
 drivers/usb/host/Makefile       |    1 +
 drivers/usb/host/ohci-hcd.c     |   20 +------
 drivers/usb/host/ohci-s3c2410.c |  116 ++++++++++++++++-----------------------
 4 files changed, 58 insertions(+), 87 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0aabd84..a863c60 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -411,6 +411,14 @@ config USB_OHCI_HCD_SPEAR
           Enables support for the on-chip OHCI controller on
           ST SPEAr chips.
 
+config USB_OHCI_HCD_S3CXXXX
+        tristate "Support for S3CXXXX on-chip OHCI USB controller"
+        depends on USB_OHCI_HCD && (ARCH_S3C24XX) || (ARCH_S3C64XX)
+        default y
+        ---help---
+          Enables support for the on-chip OHCI controller on
+          S3CXXXX chips.
+
 config USB_OHCI_HCD_AT91
         tristate  "Support for Atmel on-chip OHCI USB controller"
         depends on USB_OHCI_HCD && ARCH_AT91
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 746ffc7..4290701 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+= ohci-omap3.o
 obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+= ohci-spear.o
 obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
+obj-$(CONFIG_USB_OHCI_HCD_S3CXXXX)	+= ohci-s3c2410.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 00409b9..8e5d979 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1173,11 +1173,6 @@ MODULE_LICENSE ("GPL");
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
@@ -1240,13 +1235,13 @@ MODULE_LICENSE ("GPL");
 	!IS_ENABLED(CONFIG_USB_OHCI_HCD_OMAP3) && \
 	!IS_ENABLED(CONFIG_USB_OHCI_HCD_SPEAR) && \
 	!IS_ENABLED(CONFIG_USB_OHCI_HCD_AT91) && \
+	!IS_ENABLED(CONFIG_USB_OHCI_HCD_S3CXXXX) && \
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OF_PLATFORM_DRIVER) &&	\
 	!defined(SA1111_DRIVER) &&	\
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
 	!defined(SM501_OHCI_DRIVER) && \
 	!defined(TMIO_OHCI_DRIVER) && \
-	!defined(S3C2410_PLATFORM_DRIVER) && \
 	!defined(EP93XX_PLATFORM_DRIVER) && \
 	!defined(NXP_PLATFORM_DRIVER) && \
 	!defined(DAVINCI_PLATFORM_DRIVER)
@@ -1309,12 +1304,6 @@ static int __init ohci_hcd_mod_init(void)
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
@@ -1348,10 +1337,6 @@ static int __init ohci_hcd_mod_init(void)
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
@@ -1398,9 +1383,6 @@ static void __exit ohci_hcd_mod_exit(void)
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
index e125770..14843d2 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -19,14 +19,27 @@
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
+#define DRIVER_DESC "OHCI S3CXXXX driver"
+
+static const char hcd_name[] = "ohci-s3cxxxx";
+
 static struct clk *clk;
 static struct clk *usb_clk;
 
@@ -371,10 +384,9 @@ static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
 		goto err_put;
 	}
 
+	ohci_setup(hcd);
 	s3c2410_start_hc(dev, hcd);
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
-
 	retval = usb_add_hcd(hcd, dev->resource[1].start, 0);
 	if (retval != 0)
 		goto err_ioremap;
@@ -391,71 +403,7 @@ static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
 
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
@@ -532,4 +480,36 @@ static struct platform_driver ohci_hcd_s3c2410_driver = {
 	},
 };
 
+static int __init ohci_s3cxxxx_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+	ohci_init_driver(&ohci_s3c2410_hc_driver, NULL);
+
+	/*
+	* The Samsung HW has some unusual quirks, which require Sumsung-specific
+	* workarounds. We override certain hc_driver functions here to
+	* achieve that. We explicitly do not enhance ohci_driver_overrides to
+	* allow this more easily, since this is an unusual case, and we don't
+	* want to encourage others to override these functions by making it
+	* too easy.
+	*/
+
+	ohci_s3c2410_hc_driver.hub_status_data	= ohci_s3c2410_hub_status_data;
+	ohci_s3c2410_hc_driver.hub_control	= ohci_s3c2410_hub_control;
+
+	return platform_driver_register(&ohci_hcd_s3c2410_driver);
+}
+module_init(ohci_s3cxxxx_init);
+
+static void __exit ohci_s3cxxxx_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_s3c2410_driver);
+}
+module_exit(ohci_s3cxxxx_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:s3c2410-ohci");
-- 
1.7.9.5
