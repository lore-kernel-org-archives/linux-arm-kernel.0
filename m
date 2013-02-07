From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Thu,  7 Feb 2013 23:03:59 +0530
Subject: [PATCH 02/10] USB: EHCI: make ehci-omap a separate driver
In-Reply-To: <1360258447-27247-1-git-send-email-yes>
References: <yes>
 <1360258447-27247-1-git-send-email-yes>
Message-ID: <5113e5db.c84e420a.08c3.ffffbe6b@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the OMAP host controller driver from ehci-hcd host code
into its own driver module.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/host/Kconfig     |    2 +-
 drivers/usb/host/Makefile    |    2 +-
 drivers/usb/host/ehci-hcd.c  |    6 +---
 drivers/usb/host/ehci-omap.c |   69 ++++++++++++++++++------------------------
 4 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3a21c5d..11e102e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -155,7 +155,7 @@ config USB_EHCI_MXC
 	  Variation of ARC USB block used in some Freescale chips.
 
 config USB_EHCI_HCD_OMAP
-	bool "EHCI support for OMAP3 and later chips"
+	tristate "EHCI support for OMAP3 and later chips"
 	depends on USB_EHCI_HCD && ARCH_OMAP
 	default y
 	---help---
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 001fbff..b54a597 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_EHCI_PCI)	+= ehci-pci.o
 obj-$(CONFIG_USB_EHCI_HCD_PLATFORM)	+= ehci-platform.o
 obj-$(CONFIG_USB_EHCI_MXC)	+= ehci-mxc.o
-
+obj-$(CONFIG_USB_EHCI_HCD_OMAP) += ehci-omap.o
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
 obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index b416a3f..aaf93ca 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1252,11 +1252,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_hcd_sh_driver
 #endif
 
-#ifdef CONFIG_USB_EHCI_HCD_OMAP
-#include "ehci-omap.c"
-#define        PLATFORM_DRIVER         ehci_hcd_omap_driver
-#endif
-
 #ifdef CONFIG_PPC_PS3
 #include "ehci-ps3.c"
 #define	PS3_SYSTEM_BUS_DRIVER	ps3_ehci_driver
@@ -1347,6 +1342,7 @@ MODULE_LICENSE ("GPL");
 	!IS_ENABLED(CONFIG_USB_CHIPIDEA_HOST) && \
 	!IS_ENABLED(CONFIG_USB_EHCI_MXC) && \
 	!defined(PLATFORM_DRIVER) && \
+	!IS_ENABLED(CONFIG_USB_EHCI_HCD_OMAP) && \
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
 	!defined(OF_PLATFORM_DRIVER) && \
 	!defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index ac17a7c..9c10fc3 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -43,6 +43,11 @@
 #include <linux/pm_runtime.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/io.h>
 
 #include <linux/platform_data/usb-omap.h>
 
@@ -58,9 +63,12 @@
 #define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT		0
 
 /*-------------------------------------------------------------------------*/
+#include "ehci.h"
 
-static const struct hc_driver ehci_omap_hc_driver;
+#define DRIVER_DESC "EHCI OMAP driver"
 
+static const char hcd_name[] = "ehci-omap";
+static struct hc_driver __read_mostly ehci_omap_hc_driver;
 
 static inline void ehci_write(void __iomem *base, u32 reg, u32 val)
 {
@@ -323,56 +331,37 @@ static struct platform_driver ehci_hcd_omap_driver = {
 	/*.suspend		= ehci_hcd_omap_suspend, */
 	/*.resume		= ehci_hcd_omap_resume, */
 	.driver = {
-		.name		= "ehci-omap",
+		.name		= hcd_name,
 	}
 };
 
-/*-------------------------------------------------------------------------*/
-
-static const struct hc_driver ehci_omap_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "OMAP-EHCI Host Controller",
-	.hcd_priv_size		= sizeof(struct ehci_hcd),
 
-	/*
-	 * generic hardware linkage
-	 */
-	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+static const struct ehci_driver_overrides omap_overrides __initdata = {
+	.reset = omap_ehci_init,
+};
 
-	/*
-	 * basic lifecycle operations
-	 */
-	.reset			= omap_ehci_init,
-	.start			= ehci_run,
-	.stop			= ehci_stop,
-	.shutdown		= ehci_shutdown,
+static int __init ehci_omap_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
 
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue		= ehci_urb_enqueue,
-	.urb_dequeue		= ehci_urb_dequeue,
-	.endpoint_disable	= ehci_endpoint_disable,
-	.endpoint_reset		= ehci_endpoint_reset,
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number	= ehci_get_frame,
+	ehci_init_driver(&ehci_omap_hc_driver, &omap_overrides);
+	return platform_driver_register(&ehci_hcd_omap_driver);
+}
+module_init(ehci_omap_init);
 
-	/*
-	 * root hub support
-	 */
-	.hub_status_data	= ehci_hub_status_data,
-	.hub_control		= ehci_hub_control,
-	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
+static void __exit ehci_omap_cleanup(void)
+{
+	platform_driver_unregister(&ehci_hcd_omap_driver);
+}
+module_exit(ehci_omap_cleanup);
 
-	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
-};
+MODULE_DESCRIPTION(DRIVER_DESC);
 
 MODULE_ALIAS("platform:omap-ehci");
 MODULE_AUTHOR("Texas Instruments, Inc.");
 MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
+MODULE_LICENSE("GPL");
 
-- 
1.7.9.5
