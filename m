From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue,  2 Jul 2013 17:06:59 +0530
Subject: [PATCH] USB: OHCI: make ohci-da8xx a separate driver
Message-ID: <1372765019-7191-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the Davinci OHCI host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM;
it would be nice to have in 3.11.

One preexisting error:
"da8xx_syscfg0_base" [drivers/usb/host/ohci-da8xx.ko] undefined!

Fixed eventually using below modification:
added EXPORT_SYMBOL_GPL(da8xx_syscfg0_base) in
arch/arm/mach-davinci/devices-da8xx.c.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Kevin Hilman <kjh@hilman.org>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig      |    8 +++
 drivers/usb/host/Makefile     |    1 +
 drivers/usb/host/ohci-da8xx.c |  139 +++++++++++++++++++----------------------
 drivers/usb/host/ohci-hcd.c   |   18 ------
 4 files changed, 75 insertions(+), 91 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 002bf73..bf2689d 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -406,6 +406,14 @@ config USB_OHCI_HCD_LPC32XX
           Enables support for the on-chip OHCI controller on
           NXP chips.
 
+config USB_OHCI_HCD_DA8XX
+	tristate "Support for DAVINCI on-chip OHCI USB controller"
+	depends on USB_OHCI_HCD && ARCH_DAVINCI_DA8XX
+	default y
+	---help---
+          Enables support for the on-chip OHCI controller on
+          Davinci chips.
+
 config USB_OHCI_HCD_AT91
         tristate  "Support for Atmel on-chip OHCI USB controller"
         depends on USB_OHCI_HCD && ARCH_AT91
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index edc0909..f8d59371 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+= ohci-spear.o
 obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
 obj-$(CONFIG_USB_OHCI_HCD_S3CXXXX)	+= ohci-s3c2410.o
 obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
+obj-$(CONFIG_USB_OHCI_HCD_DA8XX)	+= ohci-da8xx.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index c649a35..9b4d1e4 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -11,20 +11,35 @@
  * kind, whether express or implied.
  */
 
+#include <linux/clk.h>
+#include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
+#include <linux/platform_data/usb-davinci.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
 
 #include <mach/da8xx.h>
-#include <linux/platform_data/usb-davinci.h>
+#include <asm/unaligned.h>
 
-#ifndef CONFIG_ARCH_DAVINCI_DA8XX
-#error "This file is DA8xx bus glue.  Define CONFIG_ARCH_DAVINCI_DA8XX."
-#endif
+#include "ohci.h"
 
 #define CFGCHIP2	DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG)
 
+#define DRIVER_DESC "OHCI DA8XX driver"
+
+static const char hcd_name[] = "ohci-da8xx";
+
+static struct hc_driver __read_mostly ohci_da8xx_hc_driver;
+
+static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
+			u16 wValue, u16 wIndex, char *buf, u16 wLength);
+static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
+
 static struct clk *usb11_clk;
 static struct clk *usb20_clk;
 
@@ -82,7 +97,7 @@ static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub,
 		hub->set_power(port, 0);
 }
 
-static int ohci_da8xx_init(struct usb_hcd *hcd)
+static int ohci_da8xx_reset(struct usb_hcd *hcd)
 {
 	struct device *dev		= hcd->self.controller;
 	struct da8xx_ohci_root_hub *hub	= dev->platform_data;
@@ -100,7 +115,7 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 	 */
 	ohci->num_ports = 1;
 
-	result = ohci_init(ohci);
+	result = ohci_setup(hcd);
 	if (result < 0)
 		return result;
 
@@ -126,30 +141,12 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 	return result;
 }
 
-static void ohci_da8xx_stop(struct usb_hcd *hcd)
-{
-	ohci_stop(hcd);
-	ohci_da8xx_clock(0);
-}
-
-static int ohci_da8xx_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd	*ohci		= hcd_to_ohci(hcd);
-	int result;
-
-	result = ohci_run(ohci);
-	if (result < 0)
-		ohci_da8xx_stop(hcd);
-
-	return result;
-}
-
 /*
  * Update the status data from the hub with the over-current indicator change.
  */
 static int ohci_da8xx_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
-	int length		= ohci_hub_status_data(hcd, buf);
+	int length		= orig_ohci_hub_status_data(hcd, buf);
 
 	/* See if we have OCIC bit set on port 1 */
 	if (ocic_mask & (1 << 1)) {
@@ -231,53 +228,10 @@ check_port:
 		}
 	}
 
-	return ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+	return orig_ohci_hub_control(hcd, typeReq, wValue,
+			wIndex, buf, wLength);
 }
 
-static const struct hc_driver ohci_da8xx_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "DA8xx OHCI",
-	.hcd_priv_size		= sizeof(struct ohci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq			= ohci_irq,
-	.flags			= HCD_USB11 | HCD_MEMORY,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.reset			= ohci_da8xx_init,
-	.start			= ohci_da8xx_start,
-	.stop			= ohci_da8xx_stop,
-	.shutdown		= ohci_shutdown,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue		= ohci_urb_enqueue,
-	.urb_dequeue		= ohci_urb_dequeue,
-	.endpoint_disable	= ohci_endpoint_disable,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number	= ohci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data	= ohci_da8xx_hub_status_data,
-	.hub_control		= ohci_da8xx_hub_control,
-
-#ifdef	CONFIG_PM
-	.bus_suspend		= ohci_bus_suspend,
-	.bus_resume		= ohci_bus_resume,
-#endif
-	.start_port_reset	= ohci_start_port_reset,
-};
-
 /*-------------------------------------------------------------------------*/
 
 
@@ -337,8 +291,6 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 		goto err3;
 	}
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		error = -ENODEV;
@@ -383,6 +335,7 @@ usb_hcd_da8xx_remove(struct usb_hcd *hcd, struct platform_device *pdev)
 	struct da8xx_ohci_root_hub *hub	= pdev->dev.platform_data;
 
 	hub->ocic_notify(NULL);
+	ohci_da8xx_clock(0);
 	usb_remove_hcd(hcd);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
@@ -444,6 +397,11 @@ static int ohci_da8xx_resume(struct platform_device *dev)
 }
 #endif
 
+static const struct ohci_driver_overrides da8xx_overrides __initconst = {
+	.reset		= ohci_da8xx_reset
+};
+
+
 /*
  * Driver definition to register with platform structure.
  */
@@ -461,4 +419,39 @@ static struct platform_driver ohci_hcd_da8xx_driver = {
 	},
 };
 
+static int __init ohci_da8xx_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+	ohci_init_driver(&ohci_da8xx_hc_driver, &da8xx_overrides);
+
+	/*
+	 * The Davinci da8xx HW has some unusual quirks, which require
+	 * da8xx-specific workarounds. We override certain hc_driver
+	 * functions here to achieve that. We explicitly do not enhance
+	 * ohci_driver_overrides to allow this more easily, since this
+	 * is an unusual case, and we don't want to encourage others to
+	 * override these functions by making it too easy.
+	 */
+
+	orig_ohci_hub_control = ohci_da8xx_hc_driver.hub_control;
+	orig_ohci_hub_status_data = ohci_da8xx_hc_driver.hub_status_data;
+
+	ohci_da8xx_hc_driver.hub_status_data     = ohci_da8xx_hub_status_data;
+	ohci_da8xx_hc_driver.hub_control         = ohci_da8xx_hub_control;
+
+	return platform_driver_register(&ohci_hcd_da8xx_driver);
+}
+module_init(ohci_da8xx_init);
+
+static void __exit ohci_da8xx_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_da8xx_driver);
+}
+module_exit(ohci_da8xx_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:ohci");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 9a0b023..8ae7a1b 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1194,11 +1194,6 @@ MODULE_LICENSE ("GPL");
 #define EP93XX_PLATFORM_DRIVER	ohci_hcd_ep93xx_driver
 #endif
 
-#ifdef CONFIG_ARCH_DAVINCI_DA8XX
-#include "ohci-da8xx.c"
-#define DAVINCI_PLATFORM_DRIVER	ohci_hcd_da8xx_driver
-#endif
-
 #ifdef CONFIG_USB_OHCI_HCD_PPC_OF
 #include "ohci-ppc-of.c"
 #define OF_PLATFORM_DRIVER	ohci_hcd_ppc_of_driver
@@ -1296,19 +1291,9 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_ep93xx;
 #endif
 
-#ifdef DAVINCI_PLATFORM_DRIVER
-	retval = platform_driver_register(&DAVINCI_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_davinci;
-#endif
-
 	return retval;
 
 	/* Error path */
-#ifdef DAVINCI_PLATFORM_DRIVER
-	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
- error_davinci:
-#endif
 #ifdef EP93XX_PLATFORM_DRIVER
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
  error_ep93xx:
@@ -1350,9 +1335,6 @@ module_init(ohci_hcd_mod_init);
 
 static void __exit ohci_hcd_mod_exit(void)
 {
-#ifdef DAVINCI_PLATFORM_DRIVER
-	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
-#endif
 #ifdef NXP_PLATFORM_DRIVER
 	platform_driver_unregister(&NXP_PLATFORM_DRIVER);
 #endif
-- 
1.7.9.5
