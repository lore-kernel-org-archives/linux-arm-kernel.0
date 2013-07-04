From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu,  4 Jul 2013 22:46:26 +0530
Subject: [PATCH 1/2] USB: OHCI: make ohci-ep93xx a separate driver
In-Reply-To: <1372958187-4039-1-git-send-email-manjunath.goudar@linaro.org>
References: <1372958187-4039-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1372958187-4039-2-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the OHCI EP93XX host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig       |    8 ++++
 drivers/usb/host/Makefile      |    1 +
 drivers/usb/host/ohci-ep93xx.c |   84 +++++++++++++++++++---------------------
 drivers/usb/host/ohci-hcd.c    |   19 ---------
 4 files changed, 48 insertions(+), 64 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index bf9a162..35c7001 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -414,6 +414,14 @@ config USB_OHCI_HCD_DA8XX
           Enables support for the on-chip OHCI controller on
           DA8xx/OMAP-L1x chips.
 
+config USB_OHCI_HCD_EP93XX
+	tristate "Support for EP93XX on-chip OHCI USB controller"
+	depends on USB_OHCI_HCD && ARCH_EP93XX
+	default y
+	---help---
+	  Enables support for the on-chip OHCI controller on
+	  EP93XX chips.
+
 config USB_OHCI_HCD_AT91
         tristate  "Support for Atmel on-chip OHCI USB controller"
         depends on USB_OHCI_HCD && ARCH_AT91
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index f8d59371..3fee3ea 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
 obj-$(CONFIG_USB_OHCI_HCD_S3CXXXX)	+= ohci-s3c2410.o
 obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
 obj-$(CONFIG_USB_OHCI_HCD_DA8XX)	+= ohci-da8xx.o
+obj-$(CONFIG_USB_OHCI_HCD_EP93XX)	+= ohci-ep93xx.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
index f0aaa48..0c2f6df 100644
--- a/drivers/usb/host/ohci-ep93xx.c
+++ b/drivers/usb/host/ohci-ep93xx.c
@@ -25,8 +25,21 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
-#include <linux/signal.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/signal.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
+
+#define DRIVER_DESC "OHCI EP93xx driver"
+
+static const char hcd_name[] = "ohci-ep93xx";
+
+static struct hc_driver __read_mostly ohci_ep93xx_hc_driver;
 
 static struct clk *usb_host_clock;
 
@@ -45,6 +58,7 @@ static int usb_hcd_ep93xx_probe(const struct hc_driver *driver,
 {
 	int retval;
 	struct usb_hcd *hcd;
+	struct ohci_hcd *ohci;
 
 	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
 		dev_dbg(&pdev->dev, "resource[1] is not IORESOURCE_IRQ\n");
@@ -79,7 +93,10 @@ static int usb_hcd_ep93xx_probe(const struct hc_driver *driver,
 
 	ep93xx_start_hc(&pdev->dev);
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
+	ohci = hcd_to_ohci(hcd);
+	ohci->next_statechange = jiffies;
+	spin_lock_init(&ohci->lock);
+	INIT_LIST_HEAD(&ohci->pending);
 
 	retval = usb_add_hcd(hcd, pdev->resource[1].start, 0);
 	if (retval == 0)
@@ -107,48 +124,6 @@ static void usb_hcd_ep93xx_remove(struct usb_hcd *hcd,
 	usb_put_hcd(hcd);
 }
 
-static int ohci_ep93xx_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	if ((ret = ohci_init(ohci)) < 0)
-		return ret;
-
-	if ((ret = ohci_run(ohci)) < 0) {
-		dev_err(hcd->self.controller, "can't start %s\n",
-			hcd->self.bus_name);
-		ohci_stop(hcd);
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct hc_driver ohci_ep93xx_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "EP93xx OHCI",
-	.hcd_priv_size		= sizeof(struct ohci_hcd),
-	.irq			= ohci_irq,
-	.flags			= HCD_USB11 | HCD_MEMORY,
-	.start			= ohci_ep93xx_start,
-	.stop			= ohci_stop,
-	.shutdown		= ohci_shutdown,
-	.urb_enqueue		= ohci_urb_enqueue,
-	.urb_dequeue		= ohci_urb_dequeue,
-	.endpoint_disable	= ohci_endpoint_disable,
-	.get_frame_number	= ohci_get_frame,
-	.hub_status_data	= ohci_hub_status_data,
-	.hub_control		= ohci_hub_control,
-#ifdef CONFIG_PM
-	.bus_suspend		= ohci_bus_suspend,
-	.bus_resume		= ohci_bus_resume,
-#endif
-	.start_port_reset	= ohci_start_port_reset,
-};
-
-extern int usb_disabled(void);
-
 static int ohci_hcd_ep93xx_drv_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -206,7 +181,6 @@ static int ohci_hcd_ep93xx_drv_resume(struct platform_device *pdev)
 }
 #endif
 
-
 static struct platform_driver ohci_hcd_ep93xx_driver = {
 	.probe		= ohci_hcd_ep93xx_drv_probe,
 	.remove		= ohci_hcd_ep93xx_drv_remove,
@@ -221,4 +195,24 @@ static struct platform_driver ohci_hcd_ep93xx_driver = {
 	},
 };
 
+static int __init ohci_ep93xx_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_ep93xx_hc_driver, NULL);
+	return platform_driver_register(&ohci_hcd_ep93xx_driver);
+}
+module_init(ohci_ep93xx_init);
+
+static void __exit ohci_ep93xx_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_ep93xx_driver);
+}
+module_exit(ohci_ep93xx_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:ep93xx-ohci");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index d514e11..3f46cff 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1189,11 +1189,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_pxa27x_driver
 #endif
 
-#ifdef CONFIG_ARCH_EP93XX
-#include "ohci-ep93xx.c"
-#define EP93XX_PLATFORM_DRIVER	ohci_hcd_ep93xx_driver
-#endif
-
 #ifdef CONFIG_USB_OHCI_HCD_PPC_OF
 #include "ohci-ppc-of.c"
 #define OF_PLATFORM_DRIVER	ohci_hcd_ppc_of_driver
@@ -1284,20 +1279,9 @@ static int __init ohci_hcd_mod_init(void)
 	if (retval < 0)
 		goto error_tmio;
 #endif
-
-#ifdef EP93XX_PLATFORM_DRIVER
-	retval = platform_driver_register(&EP93XX_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_ep93xx;
-#endif
-
 	return retval;
 
 	/* Error path */
-#ifdef EP93XX_PLATFORM_DRIVER
-	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
- error_ep93xx:
-#endif
 #ifdef TMIO_OHCI_DRIVER
 	platform_driver_unregister(&TMIO_OHCI_DRIVER);
  error_tmio:
@@ -1335,9 +1319,6 @@ module_init(ohci_hcd_mod_init);
 
 static void __exit ohci_hcd_mod_exit(void)
 {
-#ifdef EP93XX_PLATFORM_DRIVER
-	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
-#endif
 #ifdef TMIO_OHCI_DRIVER
 	platform_driver_unregister(&TMIO_OHCI_DRIVER);
 #endif
-- 
1.7.9.5
