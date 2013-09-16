From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon, 16 Sep 2013 15:40:13 +0530
Subject: [PATCH V5 8/9] USB: OHCI: make ohci-ep93xx a separate driver
In-Reply-To: <1379326215-23047-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1379326215-23047-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1379326215-23047-9-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the OHCI EP93XX host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2->V3:
 -Unused *ohci variable has been removed.

V1->V2:
 -ohci_hcd_init() statements are removed,
  because by default it is called in ohci_setup().
---
 drivers/usb/host/Kconfig       |    8 +++++
 drivers/usb/host/Makefile      |    1 +
 drivers/usb/host/ohci-ep93xx.c |   72 +++++++++++++++++-----------------------
 drivers/usb/host/ohci-hcd.c    |   18 ----------
 4 files changed, 40 insertions(+), 59 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 06c0cec..8e31c98 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -398,6 +398,14 @@ config USB_OHCI_HCD_LPC32XX
           Enables support for the on-chip OHCI controller on
           NXP chips.
 
+config USB_OHCI_HCD_EP93XX
+	tristate "Support for EP93XX on-chip OHCI USB controller"
+	depends on USB_OHCI_HCD && ARCH_EP93XX
+	default y
+	---help---
+	  Enables support for the on-chip OHCI controller on
+	  EP93XX chips.
+
 config USB_OHCI_HCD_AT91
         tristate "Support for Atmel on-chip OHCI USB controller"
         depends on USB_OHCI_HCD && ARCH_AT91
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 30a632c..02f9cd2 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+= ohci-spear.o
 obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
 obj-$(CONFIG_USB_OHCI_HCD_S3C2410)	+= ohci-s3c2410.o
 obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
+obj-$(CONFIG_USB_OHCI_HCD_EP93XX)	+= ohci-ep93xx.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
index 84a20d5..492f681 100644
--- a/drivers/usb/host/ohci-ep93xx.c
+++ b/drivers/usb/host/ohci-ep93xx.c
@@ -25,50 +25,23 @@
 
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
 
-static struct clk *usb_host_clock;
+#include "ohci.h"
 
-static int ohci_ep93xx_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int ret;
+#define DRIVER_DESC "OHCI EP93xx driver"
 
-	if ((ret = ohci_init(ohci)) < 0)
-		return ret;
+static const char hcd_name[] = "ohci-ep93xx";
 
-	if ((ret = ohci_run(ohci)) < 0) {
-		dev_err(hcd->self.controller, "can't start %s\n",
-			hcd->self.bus_name);
-		ohci_stop(hcd);
-		return ret;
-	}
+static struct hc_driver __read_mostly ohci_ep93xx_hc_driver;
 
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
+static struct clk *usb_host_clock;
 
 static int ohci_hcd_ep93xx_drv_probe(struct platform_device *pdev)
 {
@@ -109,8 +82,6 @@ static int ohci_hcd_ep93xx_drv_probe(struct platform_device *pdev)
 
 	clk_enable(usb_host_clock);
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
-
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret)
 		goto err_clk_disable;
@@ -166,7 +137,6 @@ static int ohci_hcd_ep93xx_drv_resume(struct platform_device *pdev)
 }
 #endif
 
-
 static struct platform_driver ohci_hcd_ep93xx_driver = {
 	.probe		= ohci_hcd_ep93xx_drv_probe,
 	.remove		= ohci_hcd_ep93xx_drv_remove,
@@ -181,4 +151,24 @@ static struct platform_driver ohci_hcd_ep93xx_driver = {
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
index c515192..2ee3171 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1182,11 +1182,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_pxa27x_driver
 #endif
 
-#ifdef CONFIG_ARCH_EP93XX
-#include "ohci-ep93xx.c"
-#define EP93XX_PLATFORM_DRIVER	ohci_hcd_ep93xx_driver
-#endif
-
 #ifdef CONFIG_ARCH_DAVINCI_DA8XX
 #include "ohci-da8xx.c"
 #define DAVINCI_PLATFORM_DRIVER	ohci_hcd_da8xx_driver
@@ -1283,12 +1278,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_tmio;
 #endif
 
-#ifdef EP93XX_PLATFORM_DRIVER
-	retval = platform_driver_register(&EP93XX_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_ep93xx;
-#endif
-
 #ifdef DAVINCI_PLATFORM_DRIVER
 	retval = platform_driver_register(&DAVINCI_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1302,10 +1291,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
  error_davinci:
 #endif
-#ifdef EP93XX_PLATFORM_DRIVER
-	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
- error_ep93xx:
-#endif
 #ifdef TMIO_OHCI_DRIVER
 	platform_driver_unregister(&TMIO_OHCI_DRIVER);
  error_tmio:
@@ -1346,9 +1331,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef DAVINCI_PLATFORM_DRIVER
 	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
 #endif
-#ifdef EP93XX_PLATFORM_DRIVER
-	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
-#endif
 #ifdef TMIO_OHCI_DRIVER
 	platform_driver_unregister(&TMIO_OHCI_DRIVER);
 #endif
-- 
1.7.9.5
