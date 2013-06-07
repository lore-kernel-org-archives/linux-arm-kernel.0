From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Fri,  7 Jun 2013 11:33:29 +0530
Subject: [RFC][PATCH 3/7] USB: OHCI: make ohci-omap3 a separate driver
In-Reply-To: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1370585013-12809-4-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the  TI OHCI OMAP3 host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig      |    2 +-
 drivers/usb/host/Makefile     |    1 +
 drivers/usb/host/ohci-hcd.c   |   20 +------
 drivers/usb/host/ohci-omap3.c |  122 ++++++++++++++---------------------------
 4 files changed, 45 insertions(+), 100 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 744673b..f42db93 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -404,7 +404,7 @@ config USB_OHCI_HCD_OMAP1
 	  Enables support for the OHCI controller on OMAP1/2 chips.
 
 config USB_OHCI_HCD_OMAP3
-	bool "OHCI support for OMAP3 and later chips"
+	tristate "OHCI support for OMAP3 and later chips"
 	depends on (ARCH_OMAP3 || ARCH_OMAP4)
 	default y
 	---help---
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 1326df2..ceb4e55 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_USB_OHCI_HCD_PCI)	+= ohci-pci.o
 obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+= ohci-platform.o
 obj-$(CONFIG_USB_OHCI_EXYNOS)	+= ohci-exynos.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
+obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+= ohci-omap3.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 4bfd890..8002bbe 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1178,11 +1178,6 @@ MODULE_LICENSE ("GPL");
 #define S3C2410_PLATFORM_DRIVER	ohci_hcd_s3c2410_driver
 #endif
 
-#ifdef CONFIG_USB_OHCI_HCD_OMAP3
-#include "ohci-omap3.c"
-#define OMAP3_PLATFORM_DRIVER	ohci_hcd_omap3_driver
-#endif
-
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 #include "ohci-pxa27x.c"
 #define PLATFORM_DRIVER		ohci_hcd_pxa27x_driver
@@ -1252,8 +1247,8 @@ MODULE_LICENSE ("GPL");
 	!IS_ENABLED(CONFIG_USB_OHCI_HCD_PLATFORM) && \
 	!IS_ENABLED(CONFIG_USB_OHCI_EXYNOS) && \
 	!IS_ENABLED(CONFIG_USB_OHCI_HCD_OMAP1) && \
+	!IS_ENABLED(CONFIG_USB_OHCI_HCD_OMAP3) && \
 	!defined(PLATFORM_DRIVER) &&	\
-	!defined(OMAP3_PLATFORM_DRIVER) &&	\
 	!defined(OF_PLATFORM_DRIVER) &&	\
 	!defined(SA1111_DRIVER) &&	\
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
@@ -1300,12 +1295,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_platform;
 #endif
 
-#ifdef OMAP3_PLATFORM_DRIVER
-	retval = platform_driver_register(&OMAP3_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_omap3_platform;
-#endif
-
 #ifdef OF_PLATFORM_DRIVER
 	retval = platform_driver_register(&OF_PLATFORM_DRIVER);
 	if (retval < 0)
@@ -1409,10 +1398,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&OF_PLATFORM_DRIVER);
  error_of_platform:
 #endif
-#ifdef OMAP3_PLATFORM_DRIVER
-	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
- error_omap3_platform:
-#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
  error_platform:
@@ -1464,9 +1449,6 @@ static void __exit ohci_hcd_mod_exit(void)
 #ifdef OF_PLATFORM_DRIVER
 	platform_driver_unregister(&OF_PLATFORM_DRIVER);
 #endif
-#ifdef OMAP3_PLATFORM_DRIVER
-	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
-#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index 08e811d..1d30bc8 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -29,90 +29,22 @@
  *	- add kernel-doc
  */
 
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/usb/otg.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/of.h>
-#include <linux/dma-mapping.h>
-
-/*-------------------------------------------------------------------------*/
-
-static int ohci_omap3_init(struct usb_hcd *hcd)
-{
-	dev_dbg(hcd->self.controller, "starting OHCI controller\n");
-
-	return ohci_init(hcd_to_ohci(hcd));
-}
-
-/*-------------------------------------------------------------------------*/
-
-static int ohci_omap3_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	/*
-	 * RemoteWakeupConnected has to be set explicitly before
-	 * calling ohci_run. The reset value of RWC is 0.
-	 */
-	ohci->hc_control = OHCI_CTRL_RWC;
-	writel(OHCI_CTRL_RWC, &ohci->regs->control);
-
-	ret = ohci_run(ohci);
-
-	if (ret < 0) {
-		dev_err(hcd->self.controller, "can't start\n");
-		ohci_stop(hcd);
-	}
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
 
-	return ret;
-}
+#include "ohci.h"
 
-/*-------------------------------------------------------------------------*/
+#define DRIVER_DESC "OHCI OMAP3 driver"
 
-static const struct hc_driver ohci_omap3_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"OMAP3 OHCI Host Controller",
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
-	.reset =		ohci_omap3_init,
-	.start =		ohci_omap3_start,
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
-#ifdef	CONFIG_PM
-	.bus_suspend =		ohci_bus_suspend,
-	.bus_resume =		ohci_bus_resume,
-#endif
-	.start_port_reset =	ohci_start_port_reset,
-};
-
-/*-------------------------------------------------------------------------*/
+static const char hcd_name[] = "ohci-omap3";
+static struct hc_driver __read_mostly ohci_omap3_hc_driver;
 
 static u64 omap_ohci_dma_mask = DMA_BIT_MASK(32);
 
@@ -131,6 +63,7 @@ static u64 omap_ohci_dma_mask = DMA_BIT_MASK(32);
 static int ohci_hcd_omap3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
+	struct ohci_hcd		*ohci;
 	struct usb_hcd		*hcd = NULL;
 	void __iomem		*regs = NULL;
 	struct resource		*res;
@@ -185,7 +118,16 @@ static int ohci_hcd_omap3_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ohci_hcd_init(hcd_to_ohci(hcd));
+	ohci = hcd_to_ohci(hcd);
+	/*
+	* RemoteWakeupConnected has to be set explicitly before
+	* calling ohci_run. The reset value of RWC is 0.
+	*/
+	ohci->hc_control = OHCI_CTRL_RWC;
+	writel(OHCI_CTRL_RWC, &ohci->regs->control);
+	dev_dbg(hcd->self.controller, "starting OHCI controller\n");
+
+	ohci_setup(hcd);
 
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret) {
@@ -256,5 +198,25 @@ static struct platform_driver ohci_hcd_omap3_driver = {
 	},
 };
 
+static int __init ohci_omap3_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_omap3_hc_driver, NULL);
+	return platform_driver_register(&ohci_hcd_omap3_driver);
+}
+module_init(ohci_omap3_init);
+
+static void __exit ohci_omap3_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_omap3_driver);
+}
+module_exit(ohci_omap3_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_ALIAS("platform:ohci-omap3");
 MODULE_AUTHOR("Anand Gadiyar <gadiyar@ti.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
