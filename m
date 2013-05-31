From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Fri, 31 May 2013 17:38:39 +0530
Subject: [PATCH V2 1/2] USB: OHCI: make ohci-platform a separate driver
In-Reply-To: <1370002120-19495-1-git-send-email-y>
References: <1369907454-11003-1-git-send-email-manjunath.goudar@linaro.org>
 <1370002120-19495-1-git-send-email-y>
Message-ID: <51a892db.3077420a.5699.0f88@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

This patch splits the ohci-platform code from ohci-hcd out
into its own separate driver module.This work is part of enabling
multi-platform kernels on ARM.

In V2:
  -Passed "hcd" argment instead of "ohci" in ohci_setup() because it is
   using "struct usb_hcd" argment.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig         |    2 +-
 drivers/usb/host/Makefile        |    1 +
 drivers/usb/host/ohci-hcd.c      |    6 +--
 drivers/usb/host/ohci-platform.c |   88 ++++++++++++++++++--------------------
 4 files changed, 44 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index a0a2f3a..5391a38 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -501,7 +501,7 @@ config USB_CNS3XXX_OHCI
 	  It is needed for low-speed USB 1.0 device support.
 
 config USB_OHCI_HCD_PLATFORM
-	bool "Generic OHCI driver for a platform device"
+	tristate "Generic OHCI driver for a platform device"
 	default n
 	---help---
 	  Adds an OHCI host driver for a generic platform device, which
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 2214ded..8a89c3d 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
 
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD_PCI)	+= ohci-pci.o
+obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+= ohci-platform.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 237be7c..39c7624 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1258,12 +1258,8 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_tilegx_driver
 #endif
 
-#ifdef CONFIG_USB_OHCI_HCD_PLATFORM
-#include "ohci-platform.c"
-#define PLATFORM_DRIVER		ohci_platform_driver
-#endif
-
 #if	!IS_ENABLED(CONFIG_USB_OHCI_HCD_PCI) &&	\
+	!IS_ENABLED(CONFIG_USB_OHCI_HCD_PLATFORM) && \
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OMAP1_PLATFORM_DRIVER) &&	\
 	!defined(OMAP3_PLATFORM_DRIVER) &&	\
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 76a3531..288feed 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -13,16 +13,28 @@
  *
  * Licensed under the GNU/GPL. See COPYING for details.
  */
+
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/usb/ohci_pdriver.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
+
+#define DRIVER_DESC "OHCI generic platform driver"
+
+static const char hcd_name[] = "ohci-platform";
 
 static int ohci_platform_reset(struct usb_hcd *hcd)
 {
 	struct platform_device *pdev = to_platform_device(hcd->self.controller);
 	struct usb_ohci_pdata *pdata = pdev->dev.platform_data;
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int err;
 
 	if (pdata->big_endian_desc)
 		ohci->flags |= OHCI_QUIRK_BE_DESC;
@@ -30,58 +42,17 @@ static int ohci_platform_reset(struct usb_hcd *hcd)
 		ohci->flags |= OHCI_QUIRK_BE_MMIO;
 	if (pdata->no_big_frame_no)
 		ohci->flags |= OHCI_QUIRK_FRAME_NO;
-
-	ohci_hcd_init(ohci);
-
 	if (pdata->num_ports)
 		ohci->num_ports = pdata->num_ports;
 
-	err = ohci_init(ohci);
-
-	return err;
-}
-
-static int ohci_platform_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int err;
-
-	err = ohci_run(ohci);
-	if (err < 0) {
-		ohci_err(ohci, "can't start\n");
-		ohci_stop(hcd);
-	}
-
-	return err;
+	return ohci_setup(ohci_to_hcd(ohci));
 }
 
-static const struct hc_driver ohci_platform_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "Generic Platform OHCI Controller",
-	.hcd_priv_size		= sizeof(struct ohci_hcd),
+static struct hc_driver __read_mostly ohci_platform_hc_driver;
 
-	.irq			= ohci_irq,
-	.flags			= HCD_MEMORY | HCD_USB11,
-
-	.reset			= ohci_platform_reset,
-	.start			= ohci_platform_start,
-	.stop			= ohci_stop,
-	.shutdown		= ohci_shutdown,
-
-	.urb_enqueue		= ohci_urb_enqueue,
-	.urb_dequeue		= ohci_urb_dequeue,
-	.endpoint_disable	= ohci_endpoint_disable,
-
-	.get_frame_number	= ohci_get_frame,
-
-	.hub_status_data	= ohci_hub_status_data,
-	.hub_control		= ohci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend		= ohci_bus_suspend,
-	.bus_resume		= ohci_bus_resume,
-#endif
-
-	.start_port_reset	= ohci_start_port_reset,
+static const struct ohci_driver_overrides platform_overrides __initconst = {
+	.product_desc =	"Generic Platform OHCI controller",
+	.reset =	ohci_platform_reset,
 };
 
 static int ohci_platform_probe(struct platform_device *dev)
@@ -222,3 +193,26 @@ static struct platform_driver ohci_platform_driver = {
 		.pm	= &ohci_platform_pm_ops,
 	}
 };
+
+static int __init ohci_platform_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_platform_hc_driver, &platform_overrides);
+	return platform_driver_register(&ohci_platform_driver);
+}
+module_init(ohci_platform_init);
+
+static void __exit ohci_platform_cleanup(void)
+{
+	platform_driver_unregister(&ohci_platform_driver);
+}
+module_exit(ohci_platform_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Hauke Mehrtens");
+MODULE_AUTHOR("Alan Stern");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
