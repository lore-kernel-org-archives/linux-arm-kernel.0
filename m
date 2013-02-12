From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Tue, 12 Feb 2013 16:32:00 +0530
Subject: [PATCH] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <1360666920-7116-1-git-send-email-y>
References: <y>
 <1360666920-7116-1-git-send-email-y>
Message-ID: <511a2153.294e420a.5385.ffffd3a0@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the SPEAr host controller driver from ehci-hcd host code
into its own driver module.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: linux-usb at vger.kernel.org
Cc: spear-devel at list.st.com
---
 drivers/usb/host/Kconfig      |    8 +++++
 drivers/usb/host/Makefile     |    2 +-
 drivers/usb/host/ehci-hcd.c   |    6 +---
 drivers/usb/host/ehci-spear.c |   77 +++++++++++++++++++++--------------------
 4 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3a21c5d..15e8032 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -162,6 +162,14 @@ config USB_EHCI_HCD_OMAP
 	  Enables support for the on-chip EHCI controller on
 	  OMAP3 and later chips.
 
+config USB_EHCI_HCD_SPEAR
+        tristate "Support for ST SPEAr on-chip EHCI USB controller"
+        depends on USB_EHCI_HCD && PLAT_SPEAR
+        default y
+        ---help---
+          Enables support for the on-chip EHCI controller on
+          ST SPEAr chips.
+
 config USB_EHCI_MSM
 	bool "Support for MSM on-chip EHCI USB controller"
 	depends on USB_EHCI_HCD && ARCH_MSM
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 001fbff..c8fcde9 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_EHCI_PCI)	+= ehci-pci.o
 obj-$(CONFIG_USB_EHCI_HCD_PLATFORM)	+= ehci-platform.o
 obj-$(CONFIG_USB_EHCI_MXC)	+= ehci-mxc.o
-
+obj-$(CONFIG_USB_EHCI_HCD_SPEAR)+= ehci-spear.o
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
 obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index b416a3f..c4afd86 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1297,11 +1297,6 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		vt8500_ehci_driver
 #endif
 
-#ifdef CONFIG_PLAT_SPEAR
-#include "ehci-spear.c"
-#define PLATFORM_DRIVER		spear_ehci_hcd_driver
-#endif
-
 #ifdef CONFIG_USB_EHCI_MSM
 #include "ehci-msm.c"
 #define PLATFORM_DRIVER		ehci_msm_driver
@@ -1346,6 +1341,7 @@ MODULE_LICENSE ("GPL");
 	!IS_ENABLED(CONFIG_USB_EHCI_HCD_PLATFORM) && \
 	!IS_ENABLED(CONFIG_USB_CHIPIDEA_HOST) && \
 	!IS_ENABLED(CONFIG_USB_EHCI_MXC) && \
+	!IS_ENABLED(CONFIG_PLAT_SPEAR) && \
 	!defined(PLATFORM_DRIVER) && \
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
 	!defined(OF_PLATFORM_DRIVER) && \
diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 466c1bb..87775a6 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -1,5 +1,5 @@
 /*
-* Driver for EHCI HCD on SPEAR SOC
+* Driver for EHCI HCD on SPEAr SOC
 *
 * Copyright (C) 2010 ST Micro Electronics,
 * Deepak Sikri <deepak.sikri@st.com>
@@ -12,10 +12,22 @@
 */
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
 #include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ehci.h"
+
+#define DRIVER_DESC "EHCI SPEAr driver"
+
+static const char hcd_name[] = "ehci-SPEAr";
 
 struct spear_ehci {
 	struct ehci_hcd ehci;
@@ -43,40 +55,7 @@ static int ehci_spear_setup(struct usb_hcd *hcd)
 
 	return ehci_setup(hcd);
 }
-
-static const struct hc_driver ehci_spear_hc_driver = {
-	.description			= hcd_name,
-	.product_desc			= "SPEAr EHCI",
-	.hcd_priv_size			= sizeof(struct spear_ehci),
-
-	/* generic hardware linkage */
-	.irq				= ehci_irq,
-	.flags				= HCD_MEMORY | HCD_USB2,
-
-	/* basic lifecycle operations */
-	.reset				= ehci_spear_setup,
-	.start				= ehci_run,
-	.stop				= ehci_stop,
-	.shutdown			= ehci_shutdown,
-
-	/* managing i/o requests and associated device resources */
-	.urb_enqueue			= ehci_urb_enqueue,
-	.urb_dequeue			= ehci_urb_dequeue,
-	.endpoint_disable		= ehci_endpoint_disable,
-	.endpoint_reset			= ehci_endpoint_reset,
-
-	/* scheduling support */
-	.get_frame_number		= ehci_get_frame,
-
-	/* root hub support */
-	.hub_status_data		= ehci_hub_status_data,
-	.hub_control			= ehci_hub_control,
-	.bus_suspend			= ehci_bus_suspend,
-	.bus_resume			= ehci_bus_resume,
-	.relinquish_port		= ehci_relinquish_port,
-	.port_handed_over		= ehci_port_handed_over,
-	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
-};
+static struct hc_driver __read_mostly ehci_spear_hc_driver;
 
 #ifdef CONFIG_PM
 static int ehci_spear_drv_suspend(struct device *dev)
@@ -209,11 +188,35 @@ static struct platform_driver spear_ehci_hcd_driver = {
 	.remove		= spear_ehci_hcd_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
-		.name = "spear-ehci",
+		.name = hcd_name,
 		.bus = &platform_bus_type,
 		.pm = &ehci_spear_pm_ops,
 		.of_match_table = of_match_ptr(spear_ehci_id_table),
 	}
 };
 
-MODULE_ALIAS("platform:spear-ehci");
+
+static const struct ehci_driver_overrides spear_overrides __initdata = {
+	.reset = ehci_spear_setup,
+};
+
+static int __init ehci_spear_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ehci_init_driver(&ehci_spear_hc_driver, &spear_overrides);
+	return platform_driver_register(&spear_ehci_hcd_driver);
+}
+module_init(ehci_spear_init);
+
+static void __exit ehci_spear_cleanup(void)
+{
+	platform_driver_unregister(&spear_ehci_hcd_driver);
+}
+module_exit(ehci_spear_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
