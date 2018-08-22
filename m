From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:42:56 +0200
Subject: [PATCH 03/14] USB: EHCI: make ehci-mv a separate driver
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <20180822204307.13251-4-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is done do that it could be enabled alongside other platform EHCI
glue drivers on multiplatform kernels.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/Kconfig    |  2 +-
 drivers/usb/host/Makefile   |  1 +
 drivers/usb/host/ehci-hcd.c |  5 --
 drivers/usb/host/ehci-mv.c  | 98 ++++++++++++++++---------------------
 4 files changed, 44 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 1a4ea98cac2a..16758b12a5e9 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -276,7 +276,7 @@ config USB_EHCI_EXYNOS
 	Enable support for the Samsung Exynos SOC's on-chip EHCI controller.
 
 config USB_EHCI_MV
-	bool "EHCI support for Marvell PXA/MMP USB controller"
+	tristate "EHCI support for Marvell PXA/MMP USB controller"
 	depends on (ARCH_PXA || ARCH_MMP)
 	select USB_EHCI_ROOT_HUB_TT
 	---help---
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index e6235269c151..84514f71ae44 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_USB_IMX21_HCD)	+= imx21-hcd.o
 obj-$(CONFIG_USB_FSL_USB2)	+= fsl-mph-dr-of.o
 obj-$(CONFIG_USB_EHCI_FSL)	+= fsl-mph-dr-of.o
 obj-$(CONFIG_USB_EHCI_FSL)	+= ehci-fsl.o
+obj-$(CONFIG_USB_EHCI_MV)	+= ehci-mv.o
 obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
 obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
 obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 8608ac513fb7..e8d7667828eb 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1286,11 +1286,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_grlib_driver
 #endif
 
-#ifdef CONFIG_USB_EHCI_MV
-#include "ehci-mv.c"
-#define        PLATFORM_DRIVER         ehci_mv_driver
-#endif
-
 static int __init ehci_hcd_init(void)
 {
 	int retval = 0;
diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index de764459e05a..77a4ab1dcd07 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -12,12 +12,17 @@
 #include <linux/err.h>
 #include <linux/usb/otg.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/io.h>
+
+#include <linux/usb/hcd.h>
+
+#include "ehci.h"
 
 #define CAPLENGTH_MASK         (0xff)
 
-struct ehci_hcd_mv {
-	struct usb_hcd *hcd;
+#define hcd_to_ehci_hcd_mv(h) ((struct ehci_hcd_mv *)hcd_to_ehci(h)->priv)
 
+struct ehci_hcd_mv {
 	/* Which mode does this ehci running OTG/Host ? */
 	int mode;
 
@@ -66,7 +71,7 @@ static void mv_ehci_disable(struct ehci_hcd_mv *ehci_mv)
 static int mv_ehci_reset(struct usb_hcd *hcd)
 {
 	struct device *dev = hcd->self.controller;
-	struct ehci_hcd_mv *ehci_mv = dev_get_drvdata(dev);
+	struct ehci_hcd_mv *ehci_mv = hcd_to_ehci_hcd_mv(hcd);
 	int retval;
 
 	if (ehci_mv == NULL) {
@@ -83,46 +88,11 @@ static int mv_ehci_reset(struct usb_hcd *hcd)
 	return retval;
 }
 
-static const struct hc_driver mv_ehci_hc_driver = {
-	.description = hcd_name,
-	.product_desc = "Marvell EHCI",
-	.hcd_priv_size = sizeof(struct ehci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq = ehci_irq,
-	.flags = HCD_MEMORY | HCD_USB2 | HCD_BH,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.reset = mv_ehci_reset,
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
-	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
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
+static struct hc_driver __read_mostly ehci_platform_hc_driver;
+
+static const struct ehci_driver_overrides platform_overrides __initconst = {
+	.reset =		mv_ehci_reset,
+	.extra_priv_size =	sizeof(struct ehci_hcd_mv),
 };
 
 static int mv_ehci_probe(struct platform_device *pdev)
@@ -143,19 +113,13 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	if (usb_disabled())
 		return -ENODEV;
 
-	hcd = usb_create_hcd(&mv_ehci_hc_driver, &pdev->dev, "mv ehci");
+	hcd = usb_create_hcd(&ehci_platform_hc_driver, &pdev->dev, "mv ehci");
 	if (!hcd)
 		return -ENOMEM;
 
-	ehci_mv = devm_kzalloc(&pdev->dev, sizeof(*ehci_mv), GFP_KERNEL);
-	if (ehci_mv == NULL) {
-		retval = -ENOMEM;
-		goto err_put_hcd;
-	}
-
-	platform_set_drvdata(pdev, ehci_mv);
+	platform_set_drvdata(pdev, hcd);
+	ehci_mv = hcd_to_ehci_hcd_mv(hcd);
 	ehci_mv->pdata = pdata;
-	ehci_mv->hcd = hcd;
 
 	ehci_mv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ehci_mv->clk)) {
@@ -262,8 +226,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 
 static int mv_ehci_remove(struct platform_device *pdev)
 {
-	struct ehci_hcd_mv *ehci_mv = platform_get_drvdata(pdev);
-	struct usb_hcd *hcd = ehci_mv->hcd;
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct ehci_hcd_mv *ehci_mv = hcd_to_ehci_hcd_mv(hcd);
 
 	if (hcd->rh_registered)
 		usb_remove_hcd(hcd);
@@ -295,8 +259,8 @@ static const struct platform_device_id ehci_id_table[] = {
 
 static void mv_ehci_shutdown(struct platform_device *pdev)
 {
-	struct ehci_hcd_mv *ehci_mv = platform_get_drvdata(pdev);
-	struct usb_hcd *hcd = ehci_mv->hcd;
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct ehci_hcd_mv *ehci_mv = hcd_to_ehci_hcd_mv(hcd);
 
 	if (!hcd->rh_registered)
 		return;
@@ -315,3 +279,25 @@ static struct platform_driver ehci_mv_driver = {
 		   },
 	.id_table = ehci_id_table,
 };
+
+static int __init ehci_platform_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	ehci_init_driver(&ehci_platform_hc_driver, &platform_overrides);
+	return platform_driver_register(&ehci_mv_driver);
+}
+module_init(ehci_platform_init);
+
+static void __exit ehci_platform_cleanup(void)
+{
+	platform_driver_unregister(&ehci_mv_driver);
+}
+module_exit(ehci_platform_cleanup);
+
+MODULE_DESCRIPTION("Marvell EHCI driver");
+MODULE_AUTHOR("Chao Xie <chao.xie@marvell.com>");
+MODULE_AUTHOR("Neil Zhang <zhangwm@marvell.com>");
+MODULE_ALIAS("mv-ehci");
+MODULE_LICENSE("GPL");
-- 
2.17.1
