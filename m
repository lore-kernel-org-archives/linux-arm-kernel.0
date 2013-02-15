From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 23:12:29 +0100
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <1360966349-1242560-1-git-send-email-arnd@arndb.de>
References: <201302152158.23446.arnd@arndb.de>
 <1360966349-1242560-1-git-send-email-arnd@arndb.de>
Message-ID: <1360966349-1242560-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

With the multiplatform changes in arm-soc tree, it becomes
possible to enable the mvebu platform (which uses
ehci-orion) at the same time as other platforms that require
a conflicting EHCI bus glue. At the moment, this results
in a warning like

drivers/usb/host/ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
drivers/usb/host/ehci-hcd.c:1277:0: note: this is the location of the previous definition
drivers/usb/host/ehci-orion.c:334:31: warning: 'ehci_orion_driver' defined but not used [-Wunused-variable]

and an ehci driver that only works on one of them.

With the infrastructure added by Alan Stern in patch 3e0232039
"USB: EHCI: prepare to make ehci-hcd a library module", we can
avoid this problem by turning a bus glue into a separate
module, as we do here for the orion bus glue.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/usb/host/Kconfig      |  8 ++++
 drivers/usb/host/Makefile     |  1 +
 drivers/usb/host/ehci-hcd.c   |  6 +--
 drivers/usb/host/ehci-orion.c | 90 ++++++++++++++++++++-----------------------
 4 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d77e028..7ac6f48 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -162,6 +162,14 @@ config USB_EHCI_HCD_OMAP
 	  Enables support for the on-chip EHCI controller on
 	  OMAP3 and later chips.
 
+config USB_EHCI_HCD_ORION
+        tristate  "Support for Marvell Orion on-chip EHCI USB controller"
+        depends on USB_EHCI_HCD && PLAT_ORION
+        default y
+        ---help---
+          Enables support for the on-chip EHCI controller on
+          Morvell Orion chips.
+
 config USB_EHCI_HCD_VT8500
         tristate "Support for VT8500 on-chip EHCI USB controller"
         depends on USB_EHCI_HCD && ARCH_VT8500
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index b0da9cf..4db3f01 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_USB_EHCI_MXC)	+= ehci-mxc.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_EHCI_HCD_VT8500)+= ehci-vt8500.o
+obj-$(CONFIG_USB_EHCI_HCD_ORION)+= ehci-orion.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
 obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 487ebb8..26154f0 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1272,11 +1272,6 @@ MODULE_LICENSE ("GPL");
 #define XILINX_OF_PLATFORM_DRIVER	ehci_hcd_xilinx_of_driver
 #endif
 
-#ifdef CONFIG_PLAT_ORION
-#include "ehci-orion.c"
-#define	PLATFORM_DRIVER		ehci_orion_driver
-#endif
-
 #ifdef CONFIG_USB_W90X900_EHCI
 #include "ehci-w90x900.c"
 #define	PLATFORM_DRIVER		ehci_hcd_w90x900_driver
@@ -1343,6 +1338,7 @@ MODULE_LICENSE ("GPL");
 	!IS_ENABLED(CONFIG_USB_EHCI_MXC) && \
 	!defined(PLATFORM_DRIVER) && \
 	!IS_ENABLED(CONFIG_ARCH_VT8500) && \
+	!IS_ENABLED(CONFIG_PLAT_ORION) && \
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
 	!defined(OF_PLATFORM_DRIVER) && \
 	!defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 914a3ec..cfc4803 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -17,6 +17,13 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+
+#include "ehci.h"
+
 
 #define rdl(off)	__raw_readl(hcd->regs + (off))
 #define wrl(off, val)	__raw_writel((val), hcd->regs + (off))
@@ -34,6 +41,17 @@
 #define USB_PHY_IVREF_CTRL	0x440
 #define USB_PHY_TST_GRP_CTRL	0x450
 
+#define DRIVER_DESC "EHCI orion driver"
+
+static const char hcd_name[] = "ehci-orion";
+
+static struct hc_driver __read_mostly ehci_orion_hc_driver;
+
+static const struct ehci_driver_overrides orion_overrides __initdata = {
+	.reset = ehci_setup,
+};
+
+
 /*
  * Implement Orion USB controller specification guidelines
  */
@@ -104,51 +122,6 @@ static void orion_usb_phy_v1_setup(struct usb_hcd *hcd)
 	wrl(USB_MODE, 0x13);
 }
 
-static const struct hc_driver ehci_orion_hc_driver = {
-	.description = hcd_name,
-	.product_desc = "Marvell Orion EHCI",
-	.hcd_priv_size = sizeof(struct ehci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq = ehci_irq,
-	.flags = HCD_MEMORY | HCD_USB2,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.reset = ehci_setup,
-	.start = ehci_run,
-	.stop = ehci_stop,
-	.shutdown = ehci_shutdown,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue = ehci_urb_enqueue,
-	.urb_dequeue = ehci_urb_dequeue,
-	.endpoint_disable = ehci_endpoint_disable,
-	.endpoint_reset = ehci_endpoint_reset,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number = ehci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data = ehci_hub_status_data,
-	.hub_control = ehci_hub_control,
-	.bus_suspend = ehci_bus_suspend,
-	.bus_resume = ehci_bus_resume,
-	.relinquish_port = ehci_relinquish_port,
-	.port_handed_over = ehci_port_handed_over,
-
-	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
-};
-
 static void
 ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 			     const struct mbus_dram_target_info *dram)
@@ -323,8 +296,6 @@ static int __exit ehci_orion_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
-MODULE_ALIAS("platform:orion-ehci");
-
 static const struct of_device_id ehci_orion_dt_ids[] = {
 	{ .compatible = "marvell,orion-ehci", },
 	{},
@@ -336,8 +307,31 @@ static struct platform_driver ehci_orion_driver = {
 	.remove		= __exit_p(ehci_orion_drv_remove),
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver = {
-		.name	= "orion-ehci",
+		.name	= hcd_name,
 		.owner  = THIS_MODULE,
 		.of_match_table = of_match_ptr(ehci_orion_dt_ids),
 	},
 };
+
+static int __init ehci_orion_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ehci_init_driver(&ehci_orion_hc_driver, &orion_overrides);
+	return platform_driver_register(&ehci_orion_driver);
+}
+module_init(ehci_orion_init);
+
+static void __exit ehci_orion_cleanup(void)
+{
+	platform_driver_unregister(&ehci_orion_driver);
+}
+module_exit(ehci_orion_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_ALIAS("platform:ehci-orion");
+MODULE_AUTHOR("Tzachi Perelstein");
+MODULE_LICENSE("GPL");
-- 
1.8.1.2
