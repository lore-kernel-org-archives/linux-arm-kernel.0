From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu,  4 Jul 2013 22:46:27 +0530
Subject: [PATCH 2/2] USB: OHCI: make ohci-pxa27x a separate driver
In-Reply-To: <1372958187-4039-1-git-send-email-manjunath.goudar@linaro.org>
References: <1372958187-4039-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1372958187-4039-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the  OHCI pxa27x/pxa3xx host controller driver from
ohci-hcd host code so that it can be built as a separate driver
module. This work is part of enabling multi-platform kernels on
ARM.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig       |    8 +++
 drivers/usb/host/Makefile      |    1 +
 drivers/usb/host/ohci-hcd.c    |    5 --
 drivers/usb/host/ohci-pxa27x.c |  154 ++++++++++++++++------------------------
 4 files changed, 72 insertions(+), 96 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 35c7001..f6fefa2 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -422,6 +422,14 @@ config USB_OHCI_HCD_EP93XX
 	  Enables support for the on-chip OHCI controller on
 	  EP93XX chips.
 
+config USB_OHCI_HCD_PXA27X
+	tristate "Support for PXA27X/PXA3XX on-chip OHCI USB controller"
+	depends on USB_OHCI_HCD && ARCH_PXA
+	default y
+	---help---
+	  Enables support for the on-chip OHCI controller on
+	  PXA27X/PXA3XX chips.
+
 config USB_OHCI_HCD_AT91
         tristate  "Support for Atmel on-chip OHCI USB controller"
         depends on USB_OHCI_HCD && ARCH_AT91
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 3fee3ea..8b7fa89 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_USB_OHCI_HCD_S3CXXXX)	+= ohci-s3c2410.o
 obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
 obj-$(CONFIG_USB_OHCI_HCD_DA8XX)	+= ohci-da8xx.o
 obj-$(CONFIG_USB_OHCI_HCD_EP93XX)	+= ohci-ep93xx.o
+obj-$(CONFIG_USB_OHCI_HCD_PXA27X)	+= ohci-pxa27x.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 3f46cff..f601dde 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1184,11 +1184,6 @@ MODULE_LICENSE ("GPL");
 #define SA1111_DRIVER		ohci_hcd_sa1111_driver
 #endif
 
-#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-#include "ohci-pxa27x.c"
-#define PLATFORM_DRIVER		ohci_hcd_pxa27x_driver
-#endif
-
 #ifdef CONFIG_USB_OHCI_HCD_PPC_OF
 #include "ohci-ppc-of.c"
 #define OF_PLATFORM_DRIVER	ohci_hcd_ppc_of_driver
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 5fb91f1..791e2b5 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -19,15 +19,26 @@
  * This file is licenced under the GPL.
  */
 
-#include <linux/device.h>
-#include <linux/signal.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
-#include <mach/hardware.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
+#include <linux/platform_device.h>
+#include <linux/signal.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/otg.h>
+
+#include <mach/hardware.h>
+
+#include "ohci.h"
+
+#define DRIVER_DESC "OHCI PXA27X driver"
 
 /*
  * UHC: USB Host Controller (OHCI-like) register definitions
@@ -101,11 +112,11 @@
 
 #define PXA_UHC_MAX_PORTNUM    3
 
-struct pxa27x_ohci {
-	/* must be 1st member here for hcd_to_ohci() to work */
-	struct ohci_hcd ohci;
+static const char hcd_name[] = "ohci-pxa27x";
 
-	struct device	*dev;
+static struct hc_driver __read_mostly ohci_pxa27x_hc_driver;
+
+struct pxa27x_ohci {
 	struct clk	*clk;
 	void __iomem	*mmio_base;
 };
@@ -154,8 +165,6 @@ static int pxa27x_ohci_select_pmm(struct pxa27x_ohci *ohci, int mode)
 	return 0;
 }
 
-extern int usb_disabled(void);
-
 /*-------------------------------------------------------------------------*/
 
 static inline void pxa27x_setup_hc(struct pxa27x_ohci *ohci,
@@ -218,6 +227,7 @@ static int pxa27x_start_hc(struct pxa27x_ohci *ohci, struct device *dev)
 	int retval = 0;
 	struct pxaohci_platform_data *inf;
 	uint32_t uhchr;
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
 
 	inf = dev->platform_data;
 
@@ -240,7 +250,7 @@ static int pxa27x_start_hc(struct pxa27x_ohci *ohci, struct device *dev)
 		return retval;
 
 	if (cpu_is_pxa3xx())
-		pxa3xx_u2d_start_hc(&ohci_to_hcd(&ohci->ohci)->self);
+		pxa3xx_u2d_start_hc(&hcd->self);
 
 	uhchr = __raw_readl(ohci->mmio_base + UHCHR) & ~UHCHR_SSE;
 	__raw_writel(uhchr, ohci->mmio_base + UHCHR);
@@ -254,12 +264,13 @@ static int pxa27x_start_hc(struct pxa27x_ohci *ohci, struct device *dev)
 static void pxa27x_stop_hc(struct pxa27x_ohci *ohci, struct device *dev)
 {
 	struct pxaohci_platform_data *inf;
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	uint32_t uhccoms;
 
 	inf = dev->platform_data;
 
 	if (cpu_is_pxa3xx())
-		pxa3xx_u2d_stop_hc(&ohci_to_hcd(&ohci->ohci)->self);
+		pxa3xx_u2d_stop_hc(&hcd->self);
 
 	if (inf->exit)
 		inf->exit(dev);
@@ -357,6 +368,7 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 	struct usb_hcd *hcd;
 	struct pxaohci_platform_data *inf;
 	struct pxa27x_ohci *ohci;
+	struct ohci_hcd *pxaohci;
 	struct resource *r;
 	struct clk *usb_clk;
 
@@ -410,7 +422,6 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 
 	/* initialize "struct pxa27x_ohci" */
 	ohci = (struct pxa27x_ohci *)hcd_to_ohci(hcd);
-	ohci->dev = &pdev->dev;
 	ohci->clk = usb_clk;
 	ohci->mmio_base = (void __iomem *)hcd->regs;
 
@@ -425,7 +436,13 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 	if (inf->power_budget)
 		hcd->power_budget = inf->power_budget;
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
+	pxaohci = hcd_to_ohci(hcd);
+	pxaohci->next_statechange = jiffies;
+	spin_lock_init(&pxaohci->lock);
+	INIT_LIST_HEAD(&pxaohci->pending);
+
+	 /* The value of NDP in roothub_a is incorrect on this hardware */
+	pxaohci->num_ports = 3;
 
 	retval = usb_add_hcd(hcd, irq, 0);
 	if (retval == 0)
@@ -471,76 +488,6 @@ void usb_hcd_pxa27x_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
-static int
-ohci_pxa27x_start (struct usb_hcd *hcd)
-{
-	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
-	int		ret;
-
-	ohci_dbg (ohci, "ohci_pxa27x_start, ohci:%p", ohci);
-
-	/* The value of NDP in roothub_a is incorrect on this hardware */
-	ohci->num_ports = 3;
-
-	if ((ret = ohci_init(ohci)) < 0)
-		return ret;
-
-	if ((ret = ohci_run (ohci)) < 0) {
-		dev_err(hcd->self.controller, "can't start %s",
-			hcd->self.bus_name);
-		ohci_stop (hcd);
-		return ret;
-	}
-
-	return 0;
-}
-
-/*-------------------------------------------------------------------------*/
-
-static const struct hc_driver ohci_pxa27x_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"PXA27x OHCI",
-	.hcd_priv_size =	sizeof(struct pxa27x_ohci),
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
-	.start =		ohci_pxa27x_start,
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
-#ifdef  CONFIG_PM
-	.bus_suspend =		ohci_bus_suspend,
-	.bus_resume =		ohci_bus_resume,
-#endif
-	.start_port_reset =	ohci_start_port_reset,
-};
-
-/*-------------------------------------------------------------------------*/
-
 static int ohci_hcd_pxa27x_drv_probe(struct platform_device *pdev)
 {
 	pr_debug ("In ohci_hcd_pxa27x_drv_probe");
@@ -565,11 +512,13 @@ static int ohci_hcd_pxa27x_drv_suspend(struct device *dev)
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct pxa27x_ohci *ohci = to_pxa27x_ohci(hcd);
 	bool do_wakeup = device_may_wakeup(dev);
+	struct ohci_hcd *pxaohci = hcd_to_ohci(hcd);
 	int ret;
 
-	if (time_before(jiffies, ohci->ohci.next_statechange))
+	if (time_before(jiffies, pxaohci->next_statechange))
 		msleep(5);
-	ohci->ohci.next_statechange = jiffies;
+
+	pxaohci->next_statechange = jiffies;
 
 	ret = ohci_suspend(hcd, do_wakeup);
 	if (ret)
@@ -584,11 +533,13 @@ static int ohci_hcd_pxa27x_drv_resume(struct device *dev)
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct pxa27x_ohci *ohci = to_pxa27x_ohci(hcd);
 	struct pxaohci_platform_data *inf = dev->platform_data;
+	struct ohci_hcd *pxaohci = hcd_to_ohci(hcd);
 	int status;
 
-	if (time_before(jiffies, ohci->ohci.next_statechange))
+	if (time_before(jiffies, pxaohci->next_statechange))
 		msleep(5);
-	ohci->ohci.next_statechange = jiffies;
+
+	pxaohci->next_statechange = jiffies;
 
 	if ((status = pxa27x_start_hc(ohci, dev)) < 0)
 		return status;
@@ -606,9 +557,6 @@ static const struct dev_pm_ops ohci_hcd_pxa27x_pm_ops = {
 };
 #endif
 
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:pxa27x-ohci");
-
 static struct platform_driver ohci_hcd_pxa27x_driver = {
 	.probe		= ohci_hcd_pxa27x_drv_probe,
 	.remove		= ohci_hcd_pxa27x_drv_remove,
@@ -623,3 +571,27 @@ static struct platform_driver ohci_hcd_pxa27x_driver = {
 	},
 };
 
+static const struct ohci_driver_overrides pxa27x_overrides __initconst = {
+	.extra_priv_size =      sizeof(struct pxa27x_ohci),
+};
+
+static int __init ohci_pxa27x_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+	ohci_init_driver(&ohci_pxa27x_hc_driver, &pxa27x_overrides);
+	return platform_driver_register(&ohci_hcd_pxa27x_driver);
+}
+module_init(ohci_pxa27x_init);
+
+static void __exit ohci_pxa27x_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_pxa27x_driver);
+}
+module_exit(ohci_pxa27x_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pxa27x-ohci");
-- 
1.7.9.5
