From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue,  2 Jul 2013 17:20:31 +0530
Subject: [PATCH V2] USB: OHCI: make ohci-nxp a separate driver
In-Reply-To: <1372585818-8441-1-git-send-email-manjunath.goudar@linaro.org>
References: <1372585818-8441-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1372765832-18054-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the OHCI NXP host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM.

Many place function name and struct name started with usb,
current scenario replaced usb with ohci for proper naming.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
  - Directive check NXP_PLATFORM_DRIVER block has been removed.
---
 drivers/usb/host/Kconfig    |    8 +++
 drivers/usb/host/Makefile   |    1 +
 drivers/usb/host/ohci-hcd.c |   18 -------
 drivers/usb/host/ohci-nxp.c |  124 +++++++++++++++++--------------------------
 4 files changed, 58 insertions(+), 93 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index f19524f..002bf73 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -398,6 +398,14 @@ config USB_OHCI_HCD_S3CXXXX
           Enables support for the on-chip OHCI controller on
           S3CXXXX chips.
 
+config USB_OHCI_HCD_LPC32XX
+	tristate "Support for LPC on-chip OHCI USB controller"
+	depends on USB_OHCI_HCD && ARCH_LPC32XX
+	default y
+	---help---
+          Enables support for the on-chip OHCI controller on
+          NXP chips.
+
 config USB_OHCI_HCD_AT91
         tristate  "Support for Atmel on-chip OHCI USB controller"
         depends on USB_OHCI_HCD && ARCH_AT91
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 9dffe81..edc0909 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+= ohci-omap3.o
 obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+= ohci-spear.o
 obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
 obj-$(CONFIG_USB_OHCI_HCD_S3CXXXX)	+= ohci-s3c2410.o
+obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index f3dcaa2..39d14f0 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1194,11 +1194,6 @@ MODULE_LICENSE ("GPL");
 #define EP93XX_PLATFORM_DRIVER	ohci_hcd_ep93xx_driver
 #endif
 
-#ifdef CONFIG_ARCH_LPC32XX
-#include "ohci-nxp.c"
-#define NXP_PLATFORM_DRIVER	usb_hcd_nxp_driver
-#endif
-
 #ifdef CONFIG_ARCH_DAVINCI_DA8XX
 #include "ohci-da8xx.c"
 #define DAVINCI_PLATFORM_DRIVER	ohci_hcd_da8xx_driver
@@ -1301,12 +1296,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_ep93xx;
 #endif
 
-#ifdef NXP_PLATFORM_DRIVER
-	retval = platform_driver_register(&NXP_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_nxp;
-#endif
-
 #ifdef DAVINCI_PLATFORM_DRIVER
 	retval = platform_driver_register(&DAVINCI_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1320,10 +1309,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
  error_davinci:
 #endif
-#ifdef NXP_PLATFORM_DRIVER
-	platform_driver_unregister(&NXP_PLATFORM_DRIVER);
- error_nxp:
-#endif
 #ifdef EP93XX_PLATFORM_DRIVER
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
  error_ep93xx:
@@ -1368,9 +1353,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef DAVINCI_PLATFORM_DRIVER
 	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
 #endif
-#ifdef NXP_PLATFORM_DRIVER
-	platform_driver_unregister(&NXP_PLATFORM_DRIVER);
-#endif
 #ifdef EP93XX_PLATFORM_DRIVER
 	platform_driver_unregister(&EP93XX_PLATFORM_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 7d7d507..8d6eecf 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -19,10 +19,19 @@
  * or implied.
  */
 #include <linux/clk.h>
-#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
 #include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/usb/isp1301.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
+
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -57,6 +66,11 @@
 #define start_int_umask(irq)
 #endif
 
+#define DRIVER_DESC "OHCI NXP driver"
+
+static const char hcd_name[] = "ohci-nxp";
+static struct hc_driver __read_mostly ohci_nxp_hc_driver;
+
 static struct i2c_client *isp1301_i2c_client;
 
 extern int usb_disabled(void);
@@ -132,14 +146,14 @@ static inline void isp1301_vbus_off(void)
 		OTG1_VBUS_DRV);
 }
 
-static void nxp_start_hc(void)
+static void ohci_nxp_start_hc(void)
 {
 	unsigned long tmp = __raw_readl(USB_OTG_STAT_CONTROL) | HOST_EN;
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
 	isp1301_vbus_on();
 }
 
-static void nxp_stop_hc(void)
+static void ohci_nxp_stop_hc(void)
 {
 	unsigned long tmp;
 	isp1301_vbus_off();
@@ -147,68 +161,9 @@ static void nxp_stop_hc(void)
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
 }
 
-static int ohci_nxp_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	if ((ret = ohci_init(ohci)) < 0)
-		return ret;
-
-	if ((ret = ohci_run(ohci)) < 0) {
-		dev_err(hcd->self.controller, "can't start\n");
-		ohci_stop(hcd);
-		return ret;
-	}
-	return 0;
-}
-
-static const struct hc_driver ohci_nxp_hc_driver = {
-	.description = hcd_name,
-	.product_desc =		"nxp OHCI",
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq = ohci_irq,
-	.flags = HCD_USB11 | HCD_MEMORY,
-
-	.hcd_priv_size =	sizeof(struct ohci_hcd),
-	/*
-	 * basic lifecycle operations
-	 */
-	.start = ohci_nxp_start,
-	.stop = ohci_stop,
-	.shutdown = ohci_shutdown,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue = ohci_urb_enqueue,
-	.urb_dequeue = ohci_urb_dequeue,
-	.endpoint_disable = ohci_endpoint_disable,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number = ohci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data = ohci_hub_status_data,
-	.hub_control = ohci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend = ohci_bus_suspend,
-	.bus_resume = ohci_bus_resume,
-#endif
-	.start_port_reset = ohci_start_port_reset,
-};
-
-static int usb_hcd_nxp_probe(struct platform_device *pdev)
+static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = 0;
-	struct ohci_hcd *ohci;
 	const struct hc_driver *driver = &ohci_nxp_hc_driver;
 	struct resource *res;
 	int ret = 0, irq;
@@ -313,17 +268,15 @@ static int usb_hcd_nxp_probe(struct platform_device *pdev)
 		goto fail_resource;
 	}
 
-	nxp_start_hc();
+	ohci_nxp_start_hc();
 	platform_set_drvdata(pdev, hcd);
-	ohci = hcd_to_ohci(hcd);
-	ohci_hcd_init(ohci);
 
 	dev_info(&pdev->dev, "at 0x%p, irq %d\n", hcd->regs, hcd->irq);
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret == 0)
 		return ret;
 
-	nxp_stop_hc();
+	ohci_nxp_stop_hc();
 fail_resource:
 	usb_put_hcd(hcd);
 fail_hcd:
@@ -345,12 +298,12 @@ fail_disable:
 	return ret;
 }
 
-static int usb_hcd_nxp_remove(struct platform_device *pdev)
+static int ohci_hcd_nxp_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_remove_hcd(hcd);
-	nxp_stop_hc();
+	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
 	clk_disable(usb_pll_clk);
 	clk_put(usb_pll_clk);
@@ -366,20 +319,41 @@ static int usb_hcd_nxp_remove(struct platform_device *pdev)
 MODULE_ALIAS("platform:usb-ohci");
 
 #ifdef CONFIG_OF
-static const struct of_device_id usb_hcd_nxp_match[] = {
+static const struct of_device_id ohci_hcd_nxp_match[] = {
 	{ .compatible = "nxp,ohci-nxp" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, usb_hcd_nxp_match);
+MODULE_DEVICE_TABLE(of, ohci_hcd_nxp_match);
 #endif
 
-static struct platform_driver usb_hcd_nxp_driver = {
+static struct platform_driver ohci_hcd_nxp_driver = {
 	.driver = {
 		.name = "usb-ohci",
 		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(usb_hcd_nxp_match),
+		.of_match_table = of_match_ptr(ohci_hcd_nxp_match),
 	},
-	.probe = usb_hcd_nxp_probe,
-	.remove = usb_hcd_nxp_remove,
+	.probe = ohci_hcd_nxp_probe,
+	.remove = ohci_hcd_nxp_remove,
 };
 
+static int __init ohci_nxp_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_nxp_hc_driver, NULL);
+	return platform_driver_register(&ohci_hcd_nxp_driver);
+}
+module_init(ohci_nxp_init);
+
+static void __exit ohci_nxp_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_nxp_driver);
+}
+module_exit(ohci_nxp_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL v2");
+
-- 
1.7.9.5
