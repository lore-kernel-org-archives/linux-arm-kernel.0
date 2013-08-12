From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon, 12 Aug 2013 12:16:58 +0530
Subject: [PATCH V5 4/6] USB: OHCI: make ohci-spear a separate driver
In-Reply-To: <1376290020-26253-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1376290020-26253-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1376290020-26253-5-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the ST OHCI SPEAr host controller driver from ohci-hcd
host code so that it can be built as a separate driver module.
This work is part of enabling multi-platform kernels on ARM;
it would be nice to have in 3.11.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -ohci_setup() removed because it is called in .reset member
  of the ohci_hc_driver structure.
 -debugging stuff isn't needed any more that's what removed.

V3:
 No change.

V4:
 No change.

V5:
 No change.
---
 drivers/usb/host/Kconfig      |    8 +++
 drivers/usb/host/Makefile     |    1 +
 drivers/usb/host/ohci-hcd.c   |   18 ------
 drivers/usb/host/ohci-spear.c |  140 +++++++++++++++++------------------------
 4 files changed, 65 insertions(+), 102 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3eab432..a5a34a3 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -382,6 +382,14 @@ config USB_OHCI_HCD_OMAP1
 	---help---
 	  Enables support for the OHCI controller on OMAP1/2 chips.
 
+config USB_OHCI_HCD_SPEAR
+        tristate "Support for ST SPEAr on-chip OHCI USB controller"
+        depends on USB_OHCI_HCD && PLAT_SPEAR
+        default y
+        ---help---
+          Enables support for the on-chip OHCI controller on
+          ST SPEAr chips.
+
 config USB_OHCI_HCD_OMAP3
 	tristate "OHCI support for OMAP3 and later chips"
 	depends on (ARCH_OMAP3 || ARCH_OMAP4)
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index a0064a6..8cc3f63 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+= ohci-platform.o
 obj-$(CONFIG_USB_OHCI_EXYNOS)	+= ohci-exynos.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+= ohci-omap.o
 obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+= ohci-omap3.o
+obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+= ohci-spear.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index cad51d2..34ec156 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1212,11 +1212,6 @@ MODULE_LICENSE ("GPL");
 #define OF_PLATFORM_DRIVER	ohci_hcd_ppc_of_driver
 #endif
 
-#ifdef CONFIG_PLAT_SPEAR
-#include "ohci-spear.c"
-#define SPEAR_PLATFORM_DRIVER	spear_ohci_hcd_driver
-#endif
-
 #ifdef CONFIG_PPC_PS3
 #include "ohci-ps3.c"
 #define PS3_SYSTEM_BUS_DRIVER	ps3_ohci_driver
@@ -1333,19 +1328,9 @@ static int __init ohci_hcd_mod_init(void)
 		goto error_davinci;
 #endif
 
-#ifdef SPEAR_PLATFORM_DRIVER
-	retval = platform_driver_register(&SPEAR_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto error_spear;
-#endif
-
 	return retval;
 
 	/* Error path */
-#ifdef SPEAR_PLATFORM_DRIVER
-	platform_driver_unregister(&SPEAR_PLATFORM_DRIVER);
- error_spear:
-#endif
 #ifdef DAVINCI_PLATFORM_DRIVER
 	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
  error_davinci:
@@ -1403,9 +1388,6 @@ module_init(ohci_hcd_mod_init);
 
 static void __exit ohci_hcd_mod_exit(void)
 {
-#ifdef SPEAR_PLATFORM_DRIVER
-	platform_driver_unregister(&SPEAR_PLATFORM_DRIVER);
-#endif
 #ifdef DAVINCI_PLATFORM_DRIVER
 	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
 #endif
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index cc9dd9e..31ff3fc 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -11,92 +11,37 @@
 * warranty of any kind, whether express or implied.
 */
 
-#include <linux/signal.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/signal.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
 
+#define DRIVER_DESC "OHCI SPEAr driver"
+
+static const char hcd_name[] = "SPEAr-ohci";
 struct spear_ohci {
-	struct ohci_hcd ohci;
 	struct clk *clk;
 };
 
-#define to_spear_ohci(hcd)	(struct spear_ohci *)hcd_to_ohci(hcd)
-
-static void spear_start_ohci(struct spear_ohci *ohci)
-{
-	clk_prepare_enable(ohci->clk);
-}
-
-static void spear_stop_ohci(struct spear_ohci *ohci)
-{
-	clk_disable_unprepare(ohci->clk);
-}
-
-static int ohci_spear_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	ret = ohci_init(ohci);
-	if (ret < 0)
-		return ret;
-	ohci->regs = hcd->regs;
-
-	ret = ohci_run(ohci);
-	if (ret < 0) {
-		dev_err(hcd->self.controller, "can't start\n");
-		ohci_stop(hcd);
-		return ret;
-	}
-
-	create_debug_files(ohci);
-
-#ifdef DEBUG
-	ohci_dump(ohci, 1);
-#endif
-	return 0;
-}
-
-static const struct hc_driver ohci_spear_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "SPEAr OHCI",
-	.hcd_priv_size		= sizeof(struct spear_ohci),
-
-	/* generic hardware linkage */
-	.irq			= ohci_irq,
-	.flags			= HCD_USB11 | HCD_MEMORY,
-
-	/* basic lifecycle operations */
-	.start			= ohci_spear_start,
-	.stop			= ohci_stop,
-	.shutdown		= ohci_shutdown,
-#ifdef	CONFIG_PM
-	.bus_suspend		= ohci_bus_suspend,
-	.bus_resume		= ohci_bus_resume,
-#endif
-
-	/* managing i/o requests and associated device resources */
-	.urb_enqueue		= ohci_urb_enqueue,
-	.urb_dequeue		= ohci_urb_dequeue,
-	.endpoint_disable	= ohci_endpoint_disable,
-
-	/* scheduling support */
-	.get_frame_number	= ohci_get_frame,
+#define to_spear_ohci(hcd)     (struct spear_ohci *)(hcd_to_ohci(hcd)->priv)
 
-	/* root hub support */
-	.hub_status_data	= ohci_hub_status_data,
-	.hub_control		= ohci_hub_control,
-
-	.start_port_reset	= ohci_start_port_reset,
-};
+static struct hc_driver __read_mostly ohci_spear_hc_driver;
 
 static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 {
 	const struct hc_driver *driver = &ohci_spear_hc_driver;
+	struct ohci_hcd *ohci;
 	struct usb_hcd *hcd = NULL;
 	struct clk *usbh_clk;
-	struct spear_ohci *ohci_p;
+	struct spear_ohci *sohci_p;
 	struct resource *res;
 	int retval, irq;
 
@@ -151,16 +96,18 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
-	ohci_p = (struct spear_ohci *)hcd_to_ohci(hcd);
-	ohci_p->clk = usbh_clk;
-	spear_start_ohci(ohci_p);
-	ohci_hcd_init(hcd_to_ohci(hcd));
+	sohci_p = to_spear_ohci(hcd);
+	sohci_p->clk = usbh_clk;
+
+	clk_prepare_enable(sohci_p->clk);
+
+	ohci = hcd_to_ohci(hcd);
 
 	retval = usb_add_hcd(hcd, platform_get_irq(pdev, 0), 0);
 	if (retval == 0)
 		return retval;
 
-	spear_stop_ohci(ohci_p);
+	clk_disable_unprepare(sohci_p->clk);
 err_put_hcd:
 	usb_put_hcd(hcd);
 fail:
@@ -172,11 +119,11 @@ fail:
 static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-	struct spear_ohci *ohci_p = to_spear_ohci(hcd);
+	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
-	if (ohci_p->clk)
-		spear_stop_ohci(ohci_p);
+	if (sohci_p->clk)
+		clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
 	return 0;
@@ -188,13 +135,14 @@ static int spear_ohci_hcd_drv_suspend(struct platform_device *dev,
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
-	struct spear_ohci *ohci_p = to_spear_ohci(hcd);
+	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
-	spear_stop_ohci(ohci_p);
+	clk_disable_unprepare(sohci_p->clk);
+
 	return 0;
 }
 
@@ -202,13 +150,13 @@ static int spear_ohci_hcd_drv_resume(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
-	struct spear_ohci *ohci_p = to_spear_ohci(hcd);
+	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
-	spear_start_ohci(ohci_p);
+	clk_prepare_enable(sohci_p->clk);
 	ohci_resume(hcd, false);
 	return 0;
 }
@@ -234,4 +182,28 @@ static struct platform_driver spear_ohci_hcd_driver = {
 	},
 };
 
+static const struct ohci_driver_overrides spear_overrides __initconst = {
+	.extra_priv_size = sizeof(struct spear_ohci),
+};
+static int __init ohci_spear_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_spear_hc_driver, &spear_overrides);
+	return platform_driver_register(&spear_ohci_hcd_driver);
+}
+module_init(ohci_spear_init);
+
+static void __exit ohci_spear_cleanup(void)
+{
+	platform_driver_unregister(&spear_ohci_hcd_driver);
+}
+module_exit(ohci_spear_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Deepak Sikri");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:spear-ohci");
-- 
1.7.9.5
