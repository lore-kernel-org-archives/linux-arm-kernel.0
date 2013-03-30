From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 14:04:21 +0100
Subject: [PATCH v4 4/6] USB: EHCI: make ehci-atmel a separate driver
In-Reply-To: <1364648663-29296-1-git-send-email-arnd@arndb.de>
References: <1364648663-29296-1-git-send-email-arnd@arndb.de>
Message-ID: <1364648663-29296-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the Atmel host controller driver from ehci-hcd host code
so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM;
however, note that other changes are still needed before Atmel can be
booted with a multi-platform kernel. This is currently planned for
Linux-3.11.

With the infrastructure added by Alan Stern in patch 3e0232039
"USB: EHCI: prepare to make ehci-hcd a library module", we can
avoid this problem by turning a bus glue into a separate
module, as we do here for the Atmel bus glue.

In V4 (arnd):
 - reordered #include statements.
 - removed call to ehci_shutdown.

In V3:
 -Detailed commit message added here about why this patch is required.
 -Replaced hcd_name string "ehci-atmel" to "atmel-ehci".
 -In Makefile inserted Blank line that separates the EHCI drivers from the following non-EHCI drivers.
 -Export ehci_shutdown symbol as it is needed by the Atmel driver.
 -Eliminated ehci_atmel_setup routine beacuse hcd registers
  directly setting in ehci_atmel_drv_probe function.

In V2:
Resolved below compiler error.
drivers/usb/host/ehci-atmel.c: In function 'ehci_atmel_drv_remove':
drivers/usb/host/ehci-atmel.c:167: error: implicit declaration of function 'ehci_shutdown'

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-usb at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/Kconfig      |  8 ++++
 drivers/usb/host/Makefile     |  1 +
 drivers/usb/host/ehci-atmel.c | 88 ++++++++++++++++++++-----------------------
 drivers/usb/host/ehci-hcd.c   |  6 +--
 4 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 98abec0f..f6f7872 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -182,6 +182,14 @@ config USB_EHCI_HCD_SPEAR
           Enables support for the on-chip EHCI controller on
           ST SPEAr chips.
 
+config USB_EHCI_HCD_AT91
+        tristate  "Support for Atmel on-chip EHCI USB controller"
+        depends on USB_EHCI_HCD && ARCH_AT91
+        default y
+        ---help---
+          Enables support for the on-chip EHCI controller on
+          Atmel chips.
+
 config USB_EHCI_MSM
 	bool "Support for MSM on-chip EHCI USB controller"
 	depends on USB_EHCI_HCD && ARCH_MSM
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 3d895b5..368d3eb 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_USB_EHCI_HCD_OMAP)	+= ehci-omap.o
 obj-$(CONFIG_USB_EHCI_HCD_ORION)	+= ehci-orion.o
 obj-$(CONFIG_USB_EHCI_HCD_SPEAR)	+= ehci-spear.o
 obj-$(CONFIG_USB_EHCI_S5P)	+= ehci-s5p.o
+obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index f3beac4..6642009 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -12,9 +12,22 @@
  */
 
 #include <linux/clk.h>
-#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ehci.h"
+
+#define DRIVER_DESC "EHCI Atmel driver"
+
+static const char hcd_name[] = "ehci-atmel";
+static struct hc_driver __read_mostly ehci_atmel_hc_driver;
 
 /* interface and function clocks */
 static struct clk *iclk, *fclk;
@@ -50,51 +63,6 @@ static void atmel_stop_ehci(struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
-static int ehci_atmel_setup(struct usb_hcd *hcd)
-{
-	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-
-	/* registers start at offset 0x0 */
-	ehci->caps = hcd->regs;
-
-	return ehci_setup(hcd);
-}
-
-static const struct hc_driver ehci_atmel_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "Atmel EHCI UHP HS",
-	.hcd_priv_size		= sizeof(struct ehci_hcd),
-
-	/* generic hardware linkage */
-	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
-
-	/* basic lifecycle operations */
-	.reset			= ehci_atmel_setup,
-	.start			= ehci_run,
-	.stop			= ehci_stop,
-	.shutdown		= ehci_shutdown,
-
-	/* managing i/o requests and associated device resources */
-	.urb_enqueue		= ehci_urb_enqueue,
-	.urb_dequeue		= ehci_urb_dequeue,
-	.endpoint_disable	= ehci_endpoint_disable,
-	.endpoint_reset		= ehci_endpoint_reset,
-
-	/* scheduling support */
-	.get_frame_number	= ehci_get_frame,
-
-	/* root hub support */
-	.hub_status_data	= ehci_hub_status_data,
-	.hub_control		= ehci_hub_control,
-	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
-	.relinquish_port	= ehci_relinquish_port,
-	.port_handed_over	= ehci_port_handed_over,
-
-	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
-};
-
 static u64 at91_ehci_dma_mask = DMA_BIT_MASK(32);
 
 static int ehci_atmel_drv_probe(struct platform_device *pdev)
@@ -102,6 +70,7 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 	struct usb_hcd *hcd;
 	const struct hc_driver *driver = &ehci_atmel_hc_driver;
 	struct resource *res;
+	struct ehci_hcd *ehci;
 	int irq;
 	int retval;
 
@@ -162,6 +131,10 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 		goto fail_request_resource;
 	}
 
+	ehci = hcd_to_ehci(hcd);
+	/* registers start at offset 0x0 */
+	ehci->caps = hcd->regs;
+
 	atmel_start_ehci(pdev);
 
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
@@ -185,7 +158,6 @@ static int ehci_atmel_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
-	ehci_shutdown(hcd);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
@@ -213,3 +185,25 @@ static struct platform_driver ehci_atmel_driver = {
 		.of_match_table	= of_match_ptr(atmel_ehci_dt_ids),
 	},
 };
+
+static int __init ehci_atmel_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+	ehci_init_driver(&ehci_atmel_hc_driver, NULL);
+	return platform_driver_register(&ehci_atmel_driver);
+}
+module_init(ehci_atmel_init);
+
+static void __exit ehci_atmel_cleanup(void)
+{
+	platform_driver_unregister(&ehci_atmel_driver);
+}
+module_exit(ehci_atmel_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_ALIAS("platform:atmel-ehci");
+MODULE_AUTHOR("Nicolas Ferre");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 8f1f4b4..ccc78ab 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1254,11 +1254,6 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_hcd_w90x900_driver
 #endif
 
-#ifdef CONFIG_ARCH_AT91
-#include "ehci-atmel.c"
-#define	PLATFORM_DRIVER		ehci_atmel_driver
-#endif
-
 #ifdef CONFIG_USB_OCTEON_EHCI
 #include "ehci-octeon.c"
 #define PLATFORM_DRIVER		ehci_octeon_driver
@@ -1307,6 +1302,7 @@ MODULE_LICENSE ("GPL");
 	!IS_ENABLED(CONFIG_USB_EHCI_HCD_ORION) && \
 	!IS_ENABLED(CONFIG_USB_EHCI_HCD_SPEAR) && \
 	!IS_ENABLED(CONFIG_USB_EHCI_S5P) && \
+	!IS_ENABLED(CONFIG_USB_EHCI_HCD_AT91) && \
 	!defined(PLATFORM_DRIVER) && \
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
 	!defined(OF_PLATFORM_DRIVER) && \
-- 
1.8.1.2
