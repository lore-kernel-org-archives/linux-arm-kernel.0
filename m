From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue,  7 May 2013 15:18:16 +0530
Subject: [RFC PATCH 2/2] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <1367920096-15137-1-git-send-email-manjunath.goudar@linaro.org>
References: <y> <1367920096-15137-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1367920096-15137-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch splits the PCI portion of ohci-hcd out into its
own separate driver module, called ohci-pci.  Consistently with the
current practice, the decision whether to build this module is not
user-configurable.  If OHCI_PCI are enabled then the module will
be built, always.

V2:
  - few specific content of pci related code in ohci_pci_start function has been moved to ohci_pci_reset
    and rest of the generic code is written in ohci_start of ohci-hcd.c file.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig    |    9 ++-
 drivers/usb/host/Makefile   |    1 +
 drivers/usb/host/ohci-hcd.c |   19 +------
 drivers/usb/host/ohci-pci.c |  129 +++++++++++++------------------------------
 drivers/usb/host/ohci-q.c   |   13 +++++
 5 files changed, 60 insertions(+), 111 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 7a1a248..3620ecce 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -333,8 +333,13 @@ config USB_ISP1362_HCD
 	  To compile this driver as a module, choose M here: the
 	  module will be called isp1362-hcd.
 
+config USB_OHCI_PCI
+	tristate
+	depends on USB_OHCI_HCD && PCI
+	default y
+
 config USB_OHCI_HCD
-	tristate "OHCI HCD support"
+	tristate "OHCI HCD (USB 1.1) support"
 	depends on USB && USB_ARCH_HAS_OHCI
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
 	select USB_OTG_UTILS if ARCH_OMAP
@@ -402,7 +407,7 @@ config USB_OHCI_HCD_PPC_OF
 	default USB_OHCI_HCD_PPC_OF_BE || USB_OHCI_HCD_PPC_OF_LE
 
 config USB_OHCI_HCD_PCI
-	bool "OHCI support for PCI-bus USB controllers"
+	tristate "OHCI support for PCI-bus USB controllers"
 	depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_MPC52xx || USB_OHCI_HCD_PPC_OF)
 	default y
 	select USB_OHCI_LITTLE_ENDIAN
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index a38d76b..a20a8d9 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
 obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
 
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
+obj-$(CONFIG_USB_OHCI_PCI)	+= ohci-pci.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 7922c61..2e62e7d 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -95,7 +95,6 @@ static inline void sb800_prefetch(struct ohci_hcd *ohci, int on)
 #include "ohci-mem.c"
 #include "ohci-q.c"
 
-
 /*
  * On architectures with edge-triggered interrupts we must never return
  * IRQ_NONE.
@@ -585,7 +584,6 @@ int ohci_init(struct ohci_hcd *ohci)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ohci_init);
-
 /*-------------------------------------------------------------------------*/
 
 /* Start an OHCI controller, set the BUS operational
@@ -1181,11 +1179,6 @@ MODULE_AUTHOR (DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE ("GPL");
 
-#ifdef CONFIG_PCI
-#include "ohci-pci.c"
-#define PCI_DRIVER		ohci_pci_driver
-#endif
-
 #if defined(CONFIG_ARCH_SA1100) && defined(CONFIG_SA1111)
 #include "ohci-sa1111.c"
 #define SA1111_DRIVER		ohci_hcd_sa1111_driver
@@ -1281,7 +1274,7 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_platform_driver
 #endif
 
-#if	!defined(PCI_DRIVER) &&		\
+#if	!IS_ENABLED(CONFIG_USB_OHCI_PCI) &&	\
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OMAP1_PLATFORM_DRIVER) &&	\
 	!defined(OMAP3_PLATFORM_DRIVER) &&	\
@@ -1356,12 +1349,6 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_sa1111;
 #endif
 
-#ifdef PCI_DRIVER
-	retval = pci_register_driver(&PCI_DRIVER);
-	if (retval < 0)
-		goto error_pci;
-#endif
-
 #ifdef SM501_OHCI_DRIVER
 	retval = platform_driver_register(&SM501_OHCI_DRIVER);
 	if (retval < 0)
@@ -1455,10 +1442,6 @@ static int __init ohci_hcd_mod_init(void)
 	platform_driver_unregister(&SM501_OHCI_DRIVER);
  error_sm501:
 #endif
-#ifdef PCI_DRIVER
-	pci_unregister_driver(&PCI_DRIVER);
- error_pci:
-#endif
 #ifdef SA1111_DRIVER
 	sa1111_driver_unregister(&SA1111_DRIVER);
  error_sa1111:
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 0b34b59..20f6187 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -14,12 +14,19 @@
  * This file is licenced under the GPL.
  */
 
-#ifndef CONFIG_PCI
-#error "This file is PCI bus glue.  CONFIG_PCI must be defined."
-#endif
-
-#include <linux/pci.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
+#include "pci-quirks.h"
+
+#define DRIVER_DESC "OHCI PCI platform driver"
+
+static const char hcd_name[] = "ohci-pci";
 
 
 /*-------------------------------------------------------------------------*/
@@ -175,19 +182,6 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
 	return 0;
 }
 
-static void sb800_prefetch(struct ohci_hcd *ohci, int on)
-{
-	struct pci_dev *pdev;
-	u16 misc;
-
-	pdev = to_pci_dev(ohci_to_hcd(ohci)->self.controller);
-	pci_read_config_word(pdev, 0x50, &misc);
-	if (on == 0)
-		pci_write_config_word(pdev, 0x50, misc & 0xfcff);
-	else
-		pci_write_config_word(pdev, 0x50, misc | 0x0300);
-}
-
 /* List of quirks for OHCI */
 static const struct pci_device_id ohci_pci_quirks[] = {
 	{
@@ -261,95 +255,27 @@ static int ohci_pci_reset (struct usb_hcd *hcd)
 			quirk = (void *)quirk_id->driver_data;
 			ret = quirk(hcd);
 		}
-	}
-	if (ret == 0) {
-		ohci_hcd_init (ohci);
-		return ohci_init (ohci);
-	}
-	return ret;
-}
-
-
-static int ohci_pci_start (struct usb_hcd *hcd)
-{
-	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
-	int		ret;
-
 #ifdef CONFIG_PM /* avoid warnings about unused pdev */
-	if (hcd->self.controller) {
-		struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
-
 		/* RWC may not be set for add-in PCI cards, since boot
 		 * firmware probably ignored them.  This transfers PCI
 		 * PM wakeup capabilities.
 		 */
 		if (device_can_wakeup(&pdev->dev))
 			ohci->hc_control |= OHCI_CTRL_RWC;
-	}
 #endif /* CONFIG_PM */
-
-	ret = ohci_run(hcd);
-	if (ret < 0) {
-		ohci_err (ohci, "can't start\n");
-		ohci_stop (hcd);
 	}
+	if (ret == 0)
+		return ohci_init(ohci);
 	return ret;
 }
 
+static struct hc_driver __read_mostly ohci_pci_hc_driver;
 
-/*-------------------------------------------------------------------------*/
-
-static const struct hc_driver ohci_pci_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"OHCI Host Controller",
-	.hcd_priv_size =	sizeof(struct ohci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq =			ohci_irq,
-	.flags =		HCD_MEMORY | HCD_USB11,
-
-	/*
-	 * basic lifecycle operations
-	 */
+static const struct ohci_driver_overrides overrides = {
+	.product_desc =		"OHCI PCI host controller",
 	.reset =		ohci_pci_reset,
-	.start =		ohci_pci_start,
-	.stop =			ohci_stop,
-	.shutdown =		ohci_shutdown,
-
-#ifdef	CONFIG_PM
-	.pci_suspend =		ohci_suspend,
-	.pci_resume =		ohci_resume,
-#endif
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
 };
 
-/*-------------------------------------------------------------------------*/
-
-
 static const struct pci_device_id pci_ids [] = { {
 	/* handle any USB OHCI controller */
 	PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_OHCI, ~0),
@@ -377,3 +303,24 @@ static struct pci_driver ohci_pci_driver = {
 	},
 #endif
 };
+
+static int __init ohci_pci_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_pci_hc_driver, &overrides);
+	return pci_register_driver(&ohci_pci_driver);
+}
+module_init(ohci_pci_init);
+
+static void __exit ohci_pci_cleanup(void)
+{
+	pci_unregister_driver(&ohci_pci_driver);
+}
+module_exit(ohci_pci_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
index 88731b7..a7e8139 100644
--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -29,6 +29,19 @@ static void urb_free_priv (struct ohci_hcd *hc, urb_priv_t *urb_priv)
 	kfree (urb_priv);
 }
 
+static void sb800_prefetch(struct ohci_hcd *ohci, int on)
+{
+	struct pci_dev *pdev;
+	u16 misc;
+
+	pdev = to_pci_dev(ohci_to_hcd(ohci)->self.controller);
+	pci_read_config_word(pdev, 0x50, &misc);
+	if (on == 0)
+		pci_write_config_word(pdev, 0x50, misc & 0xfcff);
+	else
+		pci_write_config_word(pdev, 0x50, misc | 0x0300);
+}
+
 /*-------------------------------------------------------------------------*/
 
 /*
-- 
1.7.9.5
