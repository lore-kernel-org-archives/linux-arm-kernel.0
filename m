From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 23:12:28 +0100
Subject: [PATCH 1/2] USB: EHCI: make ehci-vt8500 a separate driver
In-Reply-To: <201302152158.23446.arnd@arndb.de>
References: <201302152158.23446.arnd@arndb.de>
Message-ID: <1360966349-1242560-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

With the multiplatform changes in arm-soc tree, it becomes
possible to enable the vt8500 platform at the same time
as other platforms that require a conflicting EHCI bus
glue. At the moment, this results in a warning like

drivers/usb/host/ehci-hcd.c:1277:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
drivers/usb/host/ehci-hcd.c:1257:0: note: this is the location of the previous definition
drivers/usb/host/ehci-omap.c:319:31: warning: 'ehci_hcd_omap_driver' defined but not used [-Wunused-variable]

and an ehci driver that only works on one of them.

With the infrastructure added by Alan Stern in patch 3e0232039
"USB: EHCI: prepare to make ehci-hcd a library module", we can
avoid this problem by turning a bus glue into a separate
module, as we do here for the vt8500 bus glue.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Alexey Charkov <alchark@gmail.com>
---
 drivers/usb/host/Kconfig       |  8 +++++
 drivers/usb/host/Makefile      |  1 +
 drivers/usb/host/ehci-hcd.c    |  6 +---
 drivers/usb/host/ehci-vt8500.c | 73 +++++++++++++++++++-----------------------
 4 files changed, 43 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c59a112..d77e028 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -162,6 +162,14 @@ config USB_EHCI_HCD_OMAP
 	  Enables support for the on-chip EHCI controller on
 	  OMAP3 and later chips.
 
+config USB_EHCI_HCD_VT8500
+        tristate "Support for VT8500 on-chip EHCI USB controller"
+        depends on USB_EHCI_HCD && ARCH_VT8500
+        default y
+        ---help---
+          Enables support for the on-chip EHCI controller on
+          VT8500 chips.
+
 config USB_EHCI_MSM
 	bool "Support for MSM on-chip EHCI USB controller"
 	depends on USB_EHCI_HCD && ARCH_MSM
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 001fbff..b0da9cf 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_USB_EHCI_HCD_PLATFORM)	+= ehci-platform.o
 obj-$(CONFIG_USB_EHCI_MXC)	+= ehci-mxc.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
+obj-$(CONFIG_USB_EHCI_HCD_VT8500)+= ehci-vt8500.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
 obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index b416a3f..487ebb8 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1292,11 +1292,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_octeon_driver
 #endif
 
-#ifdef CONFIG_ARCH_VT8500
-#include "ehci-vt8500.c"
-#define	PLATFORM_DRIVER		vt8500_ehci_driver
-#endif
-
 #ifdef CONFIG_PLAT_SPEAR
 #include "ehci-spear.c"
 #define PLATFORM_DRIVER		spear_ehci_hcd_driver
@@ -1347,6 +1342,7 @@ MODULE_LICENSE ("GPL");
 	!IS_ENABLED(CONFIG_USB_CHIPIDEA_HOST) && \
 	!IS_ENABLED(CONFIG_USB_EHCI_MXC) && \
 	!defined(PLATFORM_DRIVER) && \
+	!IS_ENABLED(CONFIG_ARCH_VT8500) && \
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
 	!defined(OF_PLATFORM_DRIVER) && \
 	!defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-vt8500.c b/drivers/usb/host/ehci-vt8500.c
index 11695d5..98d65bd 100644
--- a/drivers/usb/host/ehci-vt8500.c
+++ b/drivers/usb/host/ehci-vt8500.c
@@ -16,52 +16,25 @@
  *
  */
 
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-static const struct hc_driver vt8500_ehci_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "VT8500 EHCI",
-	.hcd_priv_size		= sizeof(struct ehci_hcd),
+#include "ehci.h"
 
-	/*
-	 * generic hardware linkage
-	 */
-	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.reset			= ehci_setup,
-	.start			= ehci_run,
-	.stop			= ehci_stop,
-	.shutdown		= ehci_shutdown,
+#define DRIVER_DESC "vt8500 On-Chip EHCI Host driver"
 
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue		= ehci_urb_enqueue,
-	.urb_dequeue		= ehci_urb_dequeue,
-	.endpoint_disable	= ehci_endpoint_disable,
-	.endpoint_reset		= ehci_endpoint_reset,
+static const char hcd_name[] = "ehci-vt8500";
 
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number	= ehci_get_frame,
+static struct hc_driver __read_mostly vt8500_ehci_hc_driver;
 
-	/*
-	 * root hub support
-	 */
-	.hub_status_data	= ehci_hub_status_data,
-	.hub_control		= ehci_hub_control,
-	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
-	.relinquish_port	= ehci_relinquish_port,
-	.port_handed_over	= ehci_port_handed_over,
-
-	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
+static const struct ehci_driver_overrides ehci_vt8500_overrides __initdata = {
+	.reset = ehci_setup,
 };
 
 static u64 vt8500_ehci_dma_mask = DMA_BIT_MASK(32);
@@ -140,11 +113,31 @@ static struct platform_driver vt8500_ehci_driver = {
 	.remove		= vt8500_ehci_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver = {
-		.name	= "vt8500-ehci",
+		.name	= hcd_name,
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(vt8500_ehci_ids),
 	}
 };
 
+static int __init ehci_vt8500_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+	ehci_init_driver(&vt8500_ehci_hc_driver, &ehci_vt8500_overrides);
+	return platform_driver_register(&vt8500_ehci_driver);
+}
+module_init(ehci_vt8500_init);
+
+static void __exit ehci_vt8500_cleanup(void)
+{
+	platform_driver_unregister(&vt8500_ehci_driver);
+}
+module_exit(ehci_vt8500_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Alexey Charkov");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:vt8500-ehci");
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
-- 
1.8.1.2
