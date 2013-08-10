From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Sat, 10 Aug 2013 13:07:35 +0530
Subject: [PATCH V4 5/6] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <1376120256-9244-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1376120256-9244-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1376120256-9244-6-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the  TI OHCI Atmel host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM;
it would be nice to have in 3.12.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -Set non-standard fields in ohci_at91_hc_driver manually, rather than
  relying on an expanded struct ohci_driver_overrides.
 -Save orig_ohci_hub_control and orig_ohci_hub_status_data rather than
  relying on ohci_hub_control and hub_status_data being exported.
 -ohci_setup() has been removed because it is called in .reset member
  of the ohci_hc_driver structure.

V3:
 -The ohci_restart() function is not required in  current scenario,
  only discarding connection state of integrated transceivers is sufficient,
  for this directly handling ohci->hc_control.

V4:
 - Removed extra space after "tristate".
 - Removed extra space between function name  and '(' characters.
 - MODULE_ALIAS line moved to last statement of ohci-at91 file.
---
 drivers/usb/host/Kconfig     |    8 +++
 drivers/usb/host/Makefile    |    1 +
 drivers/usb/host/ohci-at91.c |  153 +++++++++++++++++++-----------------------
 drivers/usb/host/ohci-hcd.c  |   18 -----
 4 files changed, 77 insertions(+), 103 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index a5a34a3..693560a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -390,6 +390,14 @@ config USB_OHCI_HCD_SPEAR
           Enables support for the on-chip OHCI controller on
           ST SPEAr chips.
 
+config USB_OHCI_HCD_AT91
+        tristate "Support for Atmel on-chip OHCI USB controller"
+        depends on USB_OHCI_HCD && ARCH_AT91
+        default y
+        ---help---
+          Enables support for the on-chip OHCI controller on
+          Atmel chips.
+
 config USB_OHCI_HCD_OMAP3
 	tristate "OHCI support for OMAP3 and later chips"
 	depends on (ARCH_OMAP3 || ARCH_OMAP4)
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 8cc3f63..a0ac663 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_USB_OHCI_EXYNOS)	+= ohci-exynos.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+= ohci-omap3.o
 obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+= ohci-spear.o
+obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 9677f68..08e28eb 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -13,27 +13,41 @@
  */
 
 #include <linux/clk.h>
-#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
+#include <linux/platform_device.h>
 #include <linux/platform_data/atmel.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
 
 #include <mach/hardware.h>
 #include <asm/gpio.h>
 
 #include <mach/cpu.h>
 
-#ifndef CONFIG_ARCH_AT91
-#error "CONFIG_ARCH_AT91 must be defined."
-#endif
+
+#include "ohci.h"
 
 #define valid_port(index)	((index) >= 0 && (index) < AT91_MAX_USBH_PORTS)
 #define at91_for_each_port(index)	\
 		for ((index) = 0; (index) < AT91_MAX_USBH_PORTS; (index)++)
 
 /* interface and function clocks; sometimes also an AHB clock */
+
+#define DRIVER_DESC "OHCI Atmel driver"
+
+static const char hcd_name[] = "ohci-atmel";
+
+static struct hc_driver __read_mostly ohci_at91_hc_driver;
 static struct clk *iclk, *fclk, *hclk;
 static int clocked;
+static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
+			u16 wValue, u16 wIndex, char *buf, u16 wLength);
+static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
 
 extern int usb_disabled(void);
 
@@ -111,6 +125,8 @@ static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
 static int usb_hcd_at91_probe(const struct hc_driver *driver,
 			struct platform_device *pdev)
 {
+	struct at91_usbh_data *board;
+	struct ohci_hcd *ohci;
 	int retval;
 	struct usb_hcd *hcd = NULL;
 
@@ -163,8 +179,10 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		goto err5;
 	}
 
+	board = hcd->self.controller->platform_data;
+	ohci = hcd_to_ohci(hcd);
+	ohci->num_ports = board->ports;
 	at91_start_hc(pdev);
-	ohci_hcd_init(hcd_to_ohci(hcd));
 
 	retval = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_SHARED);
 	if (retval == 0)
@@ -221,36 +239,6 @@ static void usb_hcd_at91_remove(struct usb_hcd *hcd,
 }
 
 /*-------------------------------------------------------------------------*/
-
-static int
-ohci_at91_reset (struct usb_hcd *hcd)
-{
-	struct at91_usbh_data	*board = hcd->self.controller->platform_data;
-	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
-	int			ret;
-
-	if ((ret = ohci_init(ohci)) < 0)
-		return ret;
-
-	ohci->num_ports = board->ports;
-	return 0;
-}
-
-static int
-ohci_at91_start (struct usb_hcd *hcd)
-{
-	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
-	int			ret;
-
-	if ((ret = ohci_run(ohci)) < 0) {
-		dev_err(hcd->self.controller, "can't start %s\n",
-			hcd->self.bus_name);
-		ohci_stop(hcd);
-		return ret;
-	}
-	return 0;
-}
-
 static void ohci_at91_usb_set_power(struct at91_usbh_data *pdata, int port, int enable)
 {
 	if (!valid_port(port))
@@ -281,7 +269,7 @@ static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
 static int ohci_at91_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
 	struct at91_usbh_data *pdata = hcd->self.controller->platform_data;
-	int length = ohci_hub_status_data(hcd, buf);
+	int length = orig_ohci_hub_status_data(hcd, buf);
 	int port;
 
 	at91_for_each_port(port) {
@@ -359,7 +347,8 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		break;
 	}
 
-	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex + 1, buf, wLength);
+	ret = orig_ohci_hub_control(hcd, typeReq, wValue, wIndex + 1,
+				buf, wLength);
 	if (ret)
 		goto out;
 
@@ -413,51 +402,6 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 /*-------------------------------------------------------------------------*/
 
-static const struct hc_driver ohci_at91_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"AT91 OHCI",
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
-	.reset =		ohci_at91_reset,
-	.start =		ohci_at91_start,
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
-	.hub_status_data =	ohci_at91_hub_status_data,
-	.hub_control =		ohci_at91_hub_control,
-#ifdef CONFIG_PM
-	.bus_suspend =		ohci_bus_suspend,
-	.bus_resume =		ohci_bus_resume,
-#endif
-	.start_port_reset =	ohci_start_port_reset,
-};
-
-/*-------------------------------------------------------------------------*/
-
 static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
 {
 	struct platform_device *pdev = data;
@@ -686,7 +630,11 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
 	if (at91_suspend_entering_slow_clock()) {
-		ohci_usb_reset (ohci);
+		ohci->hc_control = ohci_readl(ohci, &ohci->regs->control);
+		ohci->hc_control &= OHCI_CTRL_RWC;
+		ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
+		ohci->rh_state = OHCI_RH_HALTED;
+
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
 		at91_stop_clock();
@@ -713,8 +661,6 @@ static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
 #define ohci_hcd_at91_drv_resume  NULL
 #endif
 
-MODULE_ALIAS("platform:at91_ohci");
-
 static struct platform_driver ohci_hcd_at91_driver = {
 	.probe		= ohci_hcd_at91_drv_probe,
 	.remove		= ohci_hcd_at91_drv_remove,
@@ -727,3 +673,40 @@ static struct platform_driver ohci_hcd_at91_driver = {
 		.of_match_table	= of_match_ptr(at91_ohci_dt_ids),
 	},
 };
+
+static int __init ohci_at91_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+	ohci_init_driver(&ohci_at91_hc_driver, NULL);
+
+	/*
+	 * The Atmel HW has some unusual quirks, which require Atmel-specific
+	 * workarounds. We override certain hc_driver functions here to
+	 * achieve that. We explicitly do not enhance ohci_driver_overrides to
+	 * allow this more easily, since this is an unusual case, and we don't
+	 * want to encourage others to override these functions by making it
+	 * too easy.
+	 */
+
+	orig_ohci_hub_control = ohci_at91_hc_driver.hub_control;
+	orig_ohci_hub_status_data = ohci_at91_hc_driver.hub_status_data;
+
+	ohci_at91_hc_driver.hub_status_data	= ohci_at91_hub_status_data;
+	ohci_at91_hc_driver.hub_control		= ohci_at91_hub_control;
+
+	return platform_driver_register(&ohci_hcd_at91_driver);
+}
+module_init(ohci_at91_init);
+
+static void __exit ohci_at91_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_at91_driver);
+}
+module_exit(ohci_at91_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:at91_ohci");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 34ec156..b48c892 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1192,11 +1192,6 @@ MODULE_LICENSE ("GPL");
 #define EP93XX_PLATFORM_DRIVER	ohci_hcd_ep93xx_driver
 #endif
 
-#ifdef CONFIG_ARCH_AT91
-#include "ohci-at91.c"
-#define AT91_PLATFORM_DRIVER	ohci_hcd_at91_driver
-#endif
-
 #ifdef CONFIG_ARCH_LPC32XX
 #include "ohci-nxp.c"
 #define NXP_PLATFORM_DRIVER	usb_hcd_nxp_driver
@@ -1310,12 +1305,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_ep93xx;
 #endif
 
-#ifdef AT91_PLATFORM_DRIVER
-	retval = platform_driver_register(&AT91_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_at91;
-#endif
-
 #ifdef NXP_PLATFORM_DRIVER
 	retval = platform_driver_register(&NXP_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1339,10 +1328,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&NXP_PLATFORM_DRIVER);
  error_nxp:
 #endif
-#ifdef AT91_PLATFORM_DRIVER
-	platform_driver_unregister(&AT91_PLATFORM_DRIVER);
- error_at91:
-#endif
 #ifdef EP93XX_PLATFORM_DRIVER
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
  error_ep93xx:
@@ -1394,9 +1379,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef NXP_PLATFORM_DRIVER
 	platform_driver_unregister(&NXP_PLATFORM_DRIVER);
 #endif
-#ifdef AT91_PLATFORM_DRIVER
-	platform_driver_unregister(&AT91_PLATFORM_DRIVER);
-#endif
 #ifdef EP93XX_PLATFORM_DRIVER
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
 #endif
-- 
1.7.9.5
