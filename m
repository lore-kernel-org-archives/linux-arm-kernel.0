From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Sat, 10 Aug 2013 13:07:32 +0530
Subject: [PATCH V4 2/6] USB: OHCI: make ohci-omap a separate driver
In-Reply-To: <1376120256-9244-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1376120256-9244-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1376120256-9244-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the  TI OHCI OMAP1/2 host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM;
it would be nice to have in 3.11.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -omap_ohci_clock_power(0) called in usb_hcd_omap_remove().
 -Removed ohci_setup() call from usb_hcd_omap_probe().
 -host_enabled and host_initialized variables aren't used for anything
  thats what removed.

V3:
 -rewritten if (config->otg || config->rwc) block statements into
  two separate 'if blocks' to handle below scenarios
  1. config->otg set scenario.
  2. if any of these (config->otg, config->rwc) are set, this
     scenario should be handled only after ohci_setup()

V4:
 -usb_remove_hcd() function is required a valid clock that is what
  omap_ohci_clock_power(0) is called after hcd shutdown.
---
 drivers/usb/host/Kconfig     |    2 +-
 drivers/usb/host/Makefile    |    1 +
 drivers/usb/host/ohci-hcd.c  |   18 -----
 drivers/usb/host/ohci-omap.c |  156 ++++++++++++++----------------------------
 4 files changed, 55 insertions(+), 122 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 7b8f6bd..99b7e7e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -376,7 +376,7 @@ config USB_OHCI_HCD
 if USB_OHCI_HCD
 
 config USB_OHCI_HCD_OMAP1
-	bool "OHCI support for OMAP1/2 chips"
+	tristate "OHCI support for OMAP1/2 chips"
 	depends on ARCH_OMAP1
 	default y
 	---help---
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 45e2ffb..a0220c1 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD_PCI)	+= ohci-pci.o
 obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+= ohci-platform.o
 obj-$(CONFIG_USB_OHCI_EXYNOS)	+= ohci-exynos.o
+obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 2980bb6..1abc1e7 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1182,11 +1182,6 @@ MODULE_LICENSE ("GPL");
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
@@ -1289,12 +1284,6 @@ static int __init ohci_hcd_mod_init(void)
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
@@ -1408,10 +1397,6 @@ static int __init ohci_hcd_mod_init(void)
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
@@ -1466,9 +1451,6 @@ static void __exit ohci_hcd_mod_exit(void)
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
index 8747fa6..8149ef0 100644
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
@@ -68,8 +74,9 @@ extern int ocpi_enable(void);
 
 static struct clk *usb_host_ck;
 static struct clk *usb_dc_ck;
-static int host_enabled;
-static int host_initialized;
+
+static const char hcd_name[] = "ohci-omap";
+static struct hc_driver __read_mostly ohci_omap_hc_driver;
 
 static void omap_ohci_clock_power(int on)
 {
@@ -188,7 +195,7 @@ static void start_hnp(struct ohci_hcd *ohci)
 
 /*-------------------------------------------------------------------------*/
 
-static int ohci_omap_init(struct usb_hcd *hcd)
+static int ohci_omap_reset(struct usb_hcd *hcd)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
 	struct omap_usb_config	*config = hcd->self.controller->platform_data;
@@ -198,9 +205,9 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 	dev_dbg(hcd->self.controller, "starting USB Controller\n");
 
 	if (config->otg) {
-		ohci_to_hcd(ohci)->self.otg_port = config->otg;
+		hcd->self.otg_port = config->otg;
 		/* default/minimum OTG power budget:  8 mA */
-		ohci_to_hcd(ohci)->power_budget = 8;
+		hcd->power_budget = 8;
 	}
 
 	/* boards can use OTG transceivers in non-OTG modes */
@@ -238,9 +245,15 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 		omap_1510_local_bus_init();
 	}
 
-	if ((ret = ohci_init(ohci)) < 0)
+	ret = ohci_setup(hcd);
+	if (ret < 0)
 		return ret;
 
+	if (config->otg || config->rwc) {
+		ohci->hc_control = OHCI_CTRL_RWC;
+		writel(OHCI_CTRL_RWC, &ohci->regs->control);
+	}
+
 	/* board-specific power switching and overcurrent support */
 	if (machine_is_omap_osk() || machine_is_omap_innovator()) {
 		u32	rh = roothub_a (ohci);
@@ -281,14 +294,6 @@ static int ohci_omap_init(struct usb_hcd *hcd)
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
@@ -304,7 +309,6 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
 {
 	int retval, irq;
 	struct usb_hcd *hcd = 0;
-	struct ohci_hcd *ohci;
 
 	if (pdev->num_resources != 2) {
 		printk(KERN_ERR "hcd probe: invalid num_resources: %i\n",
@@ -354,12 +358,6 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
 		goto err2;
 	}
 
-	ohci = hcd_to_ohci(hcd);
-	ohci_hcd_init(ohci);
-
-	host_initialized = 0;
-	host_enabled = 1;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		retval = -ENXIO;
@@ -369,11 +367,6 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
 	if (retval)
 		goto err3;
 
-	host_initialized = 1;
-
-	if (!host_enabled)
-		omap_ohci_clock_power(0);
-
 	return 0;
 err3:
 	iounmap(hcd->regs);
@@ -402,7 +395,9 @@ err0:
 static inline void
 usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 {
+	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
 	usb_remove_hcd(hcd);
+	omap_ohci_clock_power(0);
 	if (!IS_ERR_OR_NULL(hcd->phy)) {
 		(void) otg_set_host(hcd->phy->otg, 0);
 		usb_put_phy(hcd->phy);
@@ -418,76 +413,6 @@ usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 
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
@@ -553,4 +478,29 @@ static struct platform_driver ohci_hcd_omap_driver = {
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
