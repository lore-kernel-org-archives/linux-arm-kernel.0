From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 23 May 2013 16:41:46 +0530
Subject: [RFC V6 PATCH 3/3] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <1369307506-4458-1-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
 <1369307506-4458-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1369307506-4458-4-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch splits the PCI portion of ohci-hcd out into its
own separate driver module, called ohci-pci.

The major point of difficulty lies in ohci-pci's many vendor- and
device-specific workarounds.  Some of them have to be applied before
calling ohci_start() some after, which necessitates a fair amount of
code motion.  The other platform drivers require much smaller changes.

The complete sb800_prefetch() function moved to ohci-q.c,because its
only related to ohci-pci driver.

V2:
  - few specific content of pci related code in ohci_pci_start function has been moved to ohci_pci_reset
    and rest of the generic code is written in ohci_start of ohci-hcd.c file.
V3:
 - ohci_restart() has been called in ohci_pci_reset() function for to reset the ohci pci.

V4:
 -sb800_prefetch() moved to ohci-q.c,because its only related to ohci-pci.
 -no longer _creating_ CONFIG_USB_OHCI_PCI,creating CONFIG_USB_OHCI_HCD_PCI.
 -overrides renamed with pci_override,its giving proper meaning.

V5:
 -sb800_prefetch() moved to pci-quirks.c,because its only related to pci.

V6:
 -sb800_prefetch() function has been moved to pci-quirks.c made as separate patch in 2/3.
 -Most of the generic ohci pci changes moved in 2/3 patch,now this is complete  ohci-pci separation patch.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/Kconfig      |    4 +-
 drivers/usb/host/Makefile     |    3 +
 drivers/usb/host/ohci-hcd.c   |   15 -----
 drivers/usb/host/ohci-pci.c   |  132 ++++++++++++++---------------------------
 drivers/usb/host/ohci-q.c     |    2 +
 drivers/usb/host/ohci.h       |    4 ++
 drivers/usb/host/pci-quirks.c |    2 +
 drivers/usb/host/pci-quirks.h |    1 +
 8 files changed, 59 insertions(+), 104 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 64d7209..7e75387 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -377,7 +377,7 @@ config USB_FUSBH200_HCD
 	module will be called fusbh200-hcd.
 
 config USB_OHCI_HCD
-	tristate "OHCI HCD support"
+	tristate "OHCI HCD (USB 1.1) support"
 	depends on USB_ARCH_HAS_OHCI
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
 	depends on USB_ISP1301 || !ARCH_LPC32XX
@@ -446,7 +446,7 @@ config USB_OHCI_HCD_PPC_OF
 	default USB_OHCI_HCD_PPC_OF_BE || USB_OHCI_HCD_PPC_OF_LE
 
 config USB_OHCI_HCD_PCI
-	bool "OHCI support for PCI-bus USB controllers"
+	tristate "OHCI support for PCI-bus USB controllers"
 	depends on PCI && (STB03xxx || PPC_MPC52xx || USB_OHCI_HCD_PPC_OF)
 	default y
 	select USB_OHCI_LITTLE_ENDIAN
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 661c558..2214ded 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -42,7 +42,10 @@ obj-$(CONFIG_USB_EHCI_TEGRA)    +=ehci-tegra.o
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
 obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
+
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
+obj-$(CONFIG_USB_OHCI_HCD_PCI)	+= ohci-pci.o
+
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
 obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 2490b81..36fc3f7 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1166,11 +1166,6 @@ MODULE_AUTHOR (DRIVER_AUTHOR);
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
@@ -1341,12 +1336,6 @@ static int __init ohci_hcd_mod_init(void)
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
@@ -1440,10 +1429,6 @@ static int __init ohci_hcd_mod_init(void)
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
index c3fa936..ea088c1 100644
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
@@ -229,10 +236,10 @@ static const struct pci_device_id ohci_pci_quirks[] = {
 static int ohci_pci_reset (struct usb_hcd *hcd)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
+	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
 	int ret = 0;
 
 	if (hcd->self.controller) {
-		struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
 		const struct pci_device_id *quirk_id;
 
 		quirk_id = pci_match_id(ohci_pci_quirks, pdev);
@@ -242,94 +249,24 @@ static int ohci_pci_reset (struct usb_hcd *hcd)
 			ret = quirk(hcd);
 		}
 	}
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
-#ifdef CONFIG_PM /* avoid warnings about unused pdev */
-	if (hcd->self.controller) {
-		struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
-
-		/* RWC may not be set for add-in PCI cards, since boot
-		 * firmware probably ignored them.  This transfers PCI
-		 * PM wakeup capabilities.
-		 */
-		if (device_can_wakeup(&pdev->dev))
-			ohci->hc_control |= OHCI_CTRL_RWC;
-	}
-#endif /* CONFIG_PM */
-
-	ret = ohci_run (ohci);
-	if (ret < 0) {
-		ohci_err (ohci, "can't start\n");
-		ohci_stop (hcd);
-	}
+	if (ret == 0)
+		ohci_setup(hcd);
+	/*
+	* After ohci setup RWC may not be set for add-in PCI cards.
+	* This transfers PCI PM wakeup capabilities.
+	*/
+	if (device_can_wakeup(&pdev->dev))
+		ohci->hc_control |= OHCI_CTRL_RWC;
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
+static const struct ohci_driver_overrides pci_overrides __initconst = {
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
@@ -357,3 +294,24 @@ static struct pci_driver ohci_pci_driver = {
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
+	ohci_init_driver(&ohci_pci_hc_driver, &pci_overrides);
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
index 78e0095..0ed8187 100644
--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -9,6 +9,8 @@
 
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include "ohci.h"
+#include "pci-quirks.h"
 
 static void urb_free_priv (struct ohci_hcd *hc, urb_priv_t *urb_priv)
 {
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index 3b58482..ecc471a 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -12,6 +12,9 @@
  * __leXX (normally) or __beXX (given OHCI_BIG_ENDIAN), depending on the
  * host controller implementation.
  */
+#ifndef __USB_HOST_OHCI_H
+#define __USB_HOST_OHCI_H
+
 typedef __u32 __bitwise __hc32;
 typedef __u16 __bitwise __hc16;
 
@@ -735,3 +738,4 @@ extern int	ohci_setup(struct usb_hcd *hcd);
 extern int	ohci_suspend(struct usb_hcd *hcd, bool do_wakeup);
 extern int	ohci_resume(struct usb_hcd *hcd, bool hibernated);
 #endif
+#endif
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 5f01540..112c85f 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -17,6 +17,8 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
 #include "pci-quirks.h"
 #include "xhci-ext-caps.h"
 
diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
index 7c5fbc1..ba4d76b 100644
--- a/drivers/usb/host/pci-quirks.h
+++ b/drivers/usb/host/pci-quirks.h
@@ -1,6 +1,7 @@
 #ifndef __LINUX_USB_PCI_QUIRKS_H
 #define __LINUX_USB_PCI_QUIRKS_H
 
+struct ohci_hcd;
 #ifdef CONFIG_PCI
 void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
 int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
-- 
1.7.9.5
