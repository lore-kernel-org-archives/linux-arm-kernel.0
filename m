From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Fri,  7 Jun 2013 11:33:28 +0530
Subject: [RFC][PATCH 2/7] USB: OHCI: make ohci-omap a separate driver
In-Reply-To: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1370585013-12809-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the  TI OHCI OMAP1/2 host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig     |    2 +-
 drivers/usb/host/Makefile    |    1 +
 drivers/usb/host/ohci-hcd.c  |   20 +-----
 drivers/usb/host/ohci-omap.c |  142 ++++++++++++++++--------------------------
 4 files changed, 55 insertions(+), 110 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index f827386..744673b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -397,7 +397,7 @@ config USB_OHCI_HCD
 if USB_OHCI_HCD
 
 config USB_OHCI_HCD_OMAP1
-	bool "OHCI support for OMAP1/2 chips"
+	tristate "OHCI support for OMAP1/2 chips"
 	depends on ARCH_OMAP1
 	default y
 	---help---
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 2a4f11f..1326df2 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD_PCI)	+= ohci-pci.o
 obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+= ohci-platform.o
 obj-$(CONFIG_USB_OHCI_EXYNOS)	+= ohci-exynos.o
+obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 14962f8..4bfd890 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1178,11 +1178,6 @@ MODULE_LICENSE ("GPL");
 #define S3C2410_PLATFORM_DRIVER	ohci_hcd_s3c2410_driver
 #endif
 
-#ifdef CONFIG_USB_OHCI_HCD_OMAP1
-#include "ohci-omap.c"
-#define OMAP1_PLATFORM_DRIVER	ohci_hcd_omap_driver
-#endif
-
 #ifdef CONFIG_USB_OHCI_HCD_OMAP3
 #include "ohci-omap3.c"
 #define OMAP3_PLATFORM_DRIVER	ohci_hcd_omap3_driver
@@ -1256,8 +1251,8 @@ MODULE_LICENSE ("GPL");
 #if	!IS_ENABLED(CONFIG_USB_OHCI_HCD_PCI) &&	\
 	!IS_ENABLED(CONFIG_USB_OHCI_HCD_PLATFORM) && \
 	!IS_ENABLED(CONFIG_USB_OHCI_EXYNOS) && \
+	!IS_ENABLED(CONFIG_USB_OHCI_HCD_OMAP1) && \
 	!defined(PLATFORM_DRIVER) &&	\
-	!defined(OMAP1_PLATFORM_DRIVER) &&	\
 	!defined(OMAP3_PLATFORM_DRIVER) &&	\
 	!defined(OF_PLATFORM_DRIVER) &&	\
 	!defined(SA1111_DRIVER) &&	\
@@ -1305,12 +1300,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_platform;
 #endif
 
-#ifdef OMAP1_PLATFORM_DRIVER
-	retval = platform_driver_register(&OMAP1_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_omap1_platform;
-#endif
-
 #ifdef OMAP3_PLATFORM_DRIVER
 	retval = platform_driver_register(&OMAP3_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1424,10 +1413,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
  error_omap3_platform:
 #endif
-#ifdef OMAP1_PLATFORM_DRIVER
-	platform_driver_unregister(&OMAP1_PLATFORM_DRIVER);
- error_omap1_platform:
-#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
  error_platform:
@@ -1482,9 +1467,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef OMAP3_PLATFORM_DRIVER
 	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
 #endif
-#ifdef OMAP1_PLATFORM_DRIVER
-	platform_driver_unregister(&OMAP1_PLATFORM_DRIVER);
-#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 8747fa6..eee4b72 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -14,12 +14,21 @@
  * This file is licenced under the GPL.
  */
 
-#include <linux/signal.h>
-#include <linux/jiffies.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb/otg.h>
+#include <linux/platform_device.h>
+#include <linux/signal.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
 
 #include <asm/io.h>
 #include <asm/mach-types.h>
@@ -42,10 +51,7 @@
 #define OMAP1510_LB_MMU_RAM_H	0xfffec234
 #define OMAP1510_LB_MMU_RAM_L	0xfffec238
 
-
-#ifndef CONFIG_ARCH_OMAP
-#error "This file is OMAP bus glue.  CONFIG_OMAP must be defined."
-#endif
+#define DRIVER_DESC "OHCI OMAP driver"
 
 #ifdef CONFIG_TPS65010
 #include <linux/i2c/tps65010.h>
@@ -71,6 +77,10 @@ static struct clk *usb_dc_ck;
 static int host_enabled;
 static int host_initialized;
 
+static const char hcd_name[] = "ohci-omap";
+static struct hc_driver __read_mostly ohci_omap_hc_driver;
+
+
 static void omap_ohci_clock_power(int on)
 {
 	if (on) {
@@ -188,7 +198,7 @@ static void start_hnp(struct ohci_hcd *ohci)
 
 /*-------------------------------------------------------------------------*/
 
-static int ohci_omap_init(struct usb_hcd *hcd)
+static int ohci_omap_reset(struct usb_hcd *hcd)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
 	struct omap_usb_config	*config = hcd->self.controller->platform_data;
@@ -201,8 +211,14 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 		ohci_to_hcd(ohci)->self.otg_port = config->otg;
 		/* default/minimum OTG power budget:  8 mA */
 		ohci_to_hcd(ohci)->power_budget = 8;
+		ohci->hc_control = OHCI_CTRL_RWC;
+		writel(OHCI_CTRL_RWC, &ohci->regs->control);
 	}
 
+	if (config->rwc) {
+		ohci->hc_control = OHCI_CTRL_RWC;
+		writel(OHCI_CTRL_RWC, &ohci->regs->control);
+	}
 	/* boards can use OTG transceivers in non-OTG modes */
 	need_transceiver = need_transceiver
 			|| machine_is_omap_h2() || machine_is_omap_h3();
@@ -238,7 +254,8 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 		omap_1510_local_bus_init();
 	}
 
-	if ((ret = ohci_init(ohci)) < 0)
+	ret = ohci_setup(hcd);
+	if (ret < 0)
 		return ret;
 
 	/* board-specific power switching and overcurrent support */
@@ -281,14 +298,6 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 	return 0;
 }
 
-static void ohci_omap_stop(struct usb_hcd *hcd)
-{
-	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
-	ohci_stop(hcd);
-	omap_ohci_clock_power(0);
-}
-
-
 /*-------------------------------------------------------------------------*/
 
 /**
@@ -304,7 +313,6 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
 {
 	int retval, irq;
 	struct usb_hcd *hcd = 0;
-	struct ohci_hcd *ohci;
 
 	if (pdev->num_resources != 2) {
 		printk(KERN_ERR "hcd probe: invalid num_resources: %i\n",
@@ -354,8 +362,7 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
 		goto err2;
 	}
 
-	ohci = hcd_to_ohci(hcd);
-	ohci_hcd_init(ohci);
+	ohci_setup(hcd);
 
 	host_initialized = 0;
 	host_enabled = 1;
@@ -418,76 +425,6 @@ usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
-static int
-ohci_omap_start (struct usb_hcd *hcd)
-{
-	struct omap_usb_config *config;
-	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
-	int		ret;
-
-	if (!host_enabled)
-		return 0;
-	config = hcd->self.controller->platform_data;
-	if (config->otg || config->rwc) {
-		ohci->hc_control = OHCI_CTRL_RWC;
-		writel(OHCI_CTRL_RWC, &ohci->regs->control);
-	}
-
-	if ((ret = ohci_run (ohci)) < 0) {
-		dev_err(hcd->self.controller, "can't start\n");
-		ohci_stop (hcd);
-		return ret;
-	}
-	return 0;
-}
-
-/*-------------------------------------------------------------------------*/
-
-static const struct hc_driver ohci_omap_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"OMAP OHCI",
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
-	.reset =		ohci_omap_init,
-	.start =		ohci_omap_start,
-	.stop =			ohci_omap_stop,
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
-
 static int ohci_hcd_omap_drv_probe(struct platform_device *dev)
 {
 	return usb_hcd_omap_probe(&ohci_omap_hc_driver, dev);
@@ -553,4 +490,29 @@ static struct platform_driver ohci_hcd_omap_driver = {
 	},
 };
 
+static const struct ohci_driver_overrides omap_overrides __initconst = {
+	.product_desc	= "OMAP OHCI",
+	.reset		= ohci_omap_reset
+};
+
+static int __init ohci_omap_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_omap_hc_driver, &omap_overrides);
+	return platform_driver_register(&ohci_hcd_omap_driver);
+}
+module_init(ohci_omap_init);
+
+static void __exit ohci_omap_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_omap_driver);
+}
+module_exit(ohci_omap_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_ALIAS("platform:ohci");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
