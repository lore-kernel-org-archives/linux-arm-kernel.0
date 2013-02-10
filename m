From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Mon, 11 Feb 2013 00:28:10 +0530
Subject: [PATCH 1/8] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <1360522697-22902-1-git-send-email-y>
References: <y>
 <1360522697-22902-1-git-send-email-y>
Message-ID: <5117ede3.860e440a.097c.3508@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the Spear host controller driver from ehci-hcd host code
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
 drivers/usb/host/Kconfig      |    8 +++
 drivers/usb/host/Makefile     |    2 +-
 drivers/usb/host/ehci-hcd.c   |    8 +--
 drivers/usb/host/ehci-spear.c |  131 +++++++++++++++++++++--------------------
 4 files changed, 78 insertions(+), 71 deletions(-)

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
index b416a3f..be7247b 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1274,7 +1274,7 @@ MODULE_LICENSE ("GPL");
 
 #ifdef CONFIG_PLAT_ORION
 #include "ehci-orion.c"
-#define	PLATFORM_DRIVER		ehci_orion_driver
+#define        PLATFORM_DRIVER         ehci_orion_driver
 #endif
 
 #ifdef CONFIG_USB_W90X900_EHCI
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
@@ -1347,6 +1342,7 @@ MODULE_LICENSE ("GPL");
 	!IS_ENABLED(CONFIG_USB_CHIPIDEA_HOST) && \
 	!IS_ENABLED(CONFIG_USB_EHCI_MXC) && \
 	!defined(PLATFORM_DRIVER) && \
+	!IS_ENABLED(CONFIG_PLAT_SPEAR) && \
 	!defined(PS3_SYSTEM_BUS_DRIVER) && \
 	!defined(OF_PLATFORM_DRIVER) && \
 	!defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 466c1bb..0d9ed11 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -1,5 +1,5 @@
 /*
-* Driver for EHCI HCD on SPEAR SOC
+* Driver for EHCI HCD on SPEAr SOC
 *
 * Copyright (C) 2010 ST Micro Electronics,
 * Deepak Sikri <deepak.sikri@st.com>
@@ -12,29 +12,41 @@
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
 
-struct spear_ehci {
+#include "ehci.h"
+
+#define DRIVER_DESC "EHCI SPEAr driver"
+
+static const char hcd_name[] = "ehci-SPEAr";
+
+struct SPEAr_ehci {
 	struct ehci_hcd ehci;
 	struct clk *clk;
 };
 
-#define to_spear_ehci(hcd)	(struct spear_ehci *)hcd_to_ehci(hcd)
+#define to_SPEAr_ehci(hcd)	(struct SPEAr_ehci *)hcd_to_ehci(hcd)
 
-static void spear_start_ehci(struct spear_ehci *ehci)
+static void SPEAr_start_ehci(struct SPEAr_ehci *ehci)
 {
 	clk_prepare_enable(ehci->clk);
 }
 
-static void spear_stop_ehci(struct spear_ehci *ehci)
+static void SPEAr_stop_ehci(struct SPEAr_ehci *ehci)
 {
 	clk_disable_unprepare(ehci->clk);
 }
 
-static int ehci_spear_setup(struct usb_hcd *hcd)
+static int ehci_SPEAr_setup(struct usb_hcd *hcd)
 {
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 
@@ -43,43 +55,10 @@ static int ehci_spear_setup(struct usb_hcd *hcd)
 
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
+static struct hc_driver __read_mostly ehci_SPEAr_hc_driver;
 
 #ifdef CONFIG_PM
-static int ehci_spear_drv_suspend(struct device *dev)
+static int ehci_SPEAr_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	bool do_wakeup = device_may_wakeup(dev);
@@ -87,7 +66,7 @@ static int ehci_spear_drv_suspend(struct device *dev)
 	return ehci_suspend(hcd, do_wakeup);
 }
 
-static int ehci_spear_drv_resume(struct device *dev)
+static int ehci_SPEAr_drv_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 
@@ -96,18 +75,18 @@ static int ehci_spear_drv_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
-static SIMPLE_DEV_PM_OPS(ehci_spear_pm_ops, ehci_spear_drv_suspend,
-		ehci_spear_drv_resume);
+static SIMPLE_DEV_PM_OPS(ehci_SPEAr_pm_ops, ehci_SPEAr_drv_suspend,
+		ehci_SPEAr_drv_resume);
 
-static u64 spear_ehci_dma_mask = DMA_BIT_MASK(32);
+static u64 SPEAr_ehci_dma_mask = DMA_BIT_MASK(32);
 
-static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
+static int SPEAr_ehci_hcd_drv_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd ;
-	struct spear_ehci *ehci;
+	struct SPEAr_ehci *ehci;
 	struct resource *res;
 	struct clk *usbh_clk;
-	const struct hc_driver *driver = &ehci_spear_hc_driver;
+	const struct hc_driver *driver = &ehci_SPEAr_hc_driver;
 	int irq, retval;
 
 	if (usb_disabled())
@@ -125,7 +104,7 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 	 * Once we have dma capability bindings this can go away.
 	 */
 	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &spear_ehci_dma_mask;
+		pdev->dev.dma_mask = &SPEAr_ehci_dma_mask;
 
 	usbh_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(usbh_clk)) {
@@ -161,10 +140,10 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
-	ehci = (struct spear_ehci *)hcd_to_ehci(hcd);
+	ehci = (struct SPEAr_ehci *)hcd_to_ehci(hcd);
 	ehci->clk = usbh_clk;
 
-	spear_start_ehci(ehci);
+	SPEAr_start_ehci(ehci);
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval)
 		goto err_stop_ehci;
@@ -172,7 +151,7 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 	return retval;
 
 err_stop_ehci:
-	spear_stop_ehci(ehci);
+	SPEAr_stop_ehci(ehci);
 err_put_hcd:
 	usb_put_hcd(hcd);
 fail:
@@ -181,10 +160,10 @@ fail:
 	return retval ;
 }
 
-static int spear_ehci_hcd_drv_remove(struct platform_device *pdev)
+static int SPEAr_ehci_hcd_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-	struct spear_ehci *ehci_p = to_spear_ehci(hcd);
+	struct SPEAr_ehci *ehci_p = to_SPEAr_ehci(hcd);
 
 	if (!hcd)
 		return 0;
@@ -193,27 +172,51 @@ static int spear_ehci_hcd_drv_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 
 	if (ehci_p->clk)
-		spear_stop_ehci(ehci_p);
+		SPEAr_stop_ehci(ehci_p);
 	usb_put_hcd(hcd);
 
 	return 0;
 }
 
-static struct of_device_id spear_ehci_id_table[] = {
-	{ .compatible = "st,spear600-ehci", },
+static struct of_device_id SPEAr_ehci_id_table[] = {
+	{ .compatible = "st,SPEAr600-ehci", },
 	{ },
 };
 
-static struct platform_driver spear_ehci_hcd_driver = {
-	.probe		= spear_ehci_hcd_drv_probe,
-	.remove		= spear_ehci_hcd_drv_remove,
+static struct platform_driver SPEAr_ehci_hcd_driver = {
+	.probe		= SPEAr_ehci_hcd_drv_probe,
+	.remove		= SPEAr_ehci_hcd_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
-		.name = "spear-ehci",
+		.name = hcd_name,
 		.bus = &platform_bus_type,
-		.pm = &ehci_spear_pm_ops,
-		.of_match_table = of_match_ptr(spear_ehci_id_table),
+		.pm = &ehci_SPEAr_pm_ops,
+		.of_match_table = of_match_ptr(SPEAr_ehci_id_table),
 	}
 };
 
-MODULE_ALIAS("platform:spear-ehci");
+
+static const struct ehci_driver_overrides SPEAr_overrides __initdata = {
+	.reset = ehci_SPEAr_setup,
+};
+
+static int __init ehci_SPEAr_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ehci_init_driver(&ehci_SPEAr_hc_driver, &SPEAr_overrides);
+	return platform_driver_register(&SPEAr_ehci_hcd_driver);
+}
+module_init(ehci_SPEAr_init);
+
+static void __exit ehci_SPEAr_cleanup(void)
+{
+	platform_driver_unregister(&SPEAr_ehci_hcd_driver);
+}
+module_exit(ehci_SPEAr_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
