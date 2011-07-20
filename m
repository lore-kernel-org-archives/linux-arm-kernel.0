From: tony.lin@freescale.com (Tony Lin)
Date: Wed, 20 Jul 2011 19:08:24 +0800
Subject: [PATCH 5/7] ehci mxc: make it more flexible to be used for mx28
In-Reply-To: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1311160106-4898-6-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

old driver uses some hard coding for clks' name which could
not be used for mx28. So workaround these hard codings by
judging the cpu is mx28 or not.
add platform callback funtions in usb irq handler in the case
usb phy need to change its disconnect detector mode after usb
device is connected and disconnected. These callbacks also
could be used for other machines whose usb phy need such kind
of operations

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 drivers/usb/host/Kconfig    |    2 +-
 drivers/usb/host/ehci-mxc.c |   57 +++++++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ab085f1..6a5905b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -139,7 +139,7 @@ config USB_EHCI_FSL
 
 config USB_EHCI_MXC
 	bool "Support for Freescale on-chip EHCI USB controller"
-	depends on USB_EHCI_HCD && ARCH_MXC
+	depends on USB_EHCI_HCD && (ARCH_MXC || ARCH_MXS)
 	select USB_EHCI_ROOT_HUB_TT
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 0c058be..65e78cd 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -23,9 +23,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/slab.h>
-
-#include <mach/mxc_ehci.h>
-
+#include <linux/fsl_devices.h>
 #include <asm/mach-types.h>
 
 #define ULPI_VIEWPORT_OFFSET	0x170
@@ -66,6 +64,30 @@ static int ehci_mxc_setup(struct usb_hcd *hcd)
 	return 0;
 }
 
+static irqreturn_t fsl_ehci_irq(struct usb_hcd *hcd)
+{
+	struct mxc_usbh_platform_data *pdata;
+	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
+	u32			status;
+
+	pdata = hcd->self.controller->platform_data;
+	if (pdata->plt_get_usb_connect_status == NULL || \
+		pdata->plt_usb_disconnect_detect == NULL)
+		goto out;
+
+	spin_lock(&ehci->lock);
+	status = ehci_readl(ehci, &ehci->regs->status);
+	if (status & STS_PCD) {
+		if (pdata->plt_get_usb_connect_status())
+			pdata->plt_usb_disconnect_detect(true);
+		else
+			pdata->plt_usb_disconnect_detect(false);
+	}
+	spin_unlock(&ehci->lock);
+out:
+	return ehci_irq(hcd);
+}
+
 static const struct hc_driver ehci_mxc_hc_driver = {
 	.description = hcd_name,
 	.product_desc = "Freescale On-Chip EHCI Host Controller",
@@ -74,7 +96,7 @@ static const struct hc_driver ehci_mxc_hc_driver = {
 	/*
 	 * generic hardware linkage
 	 */
-	.irq = ehci_irq,
+	.irq = fsl_ehci_irq,
 	.flags = HCD_USB2 | HCD_MEMORY,
 
 	/*
@@ -165,14 +187,15 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	/* enable clocks */
-	priv->usbclk = clk_get(dev, "usb");
-	if (IS_ERR(priv->usbclk)) {
-		ret = PTR_ERR(priv->usbclk);
-		goto err_clk;
+	if (!cpu_is_mx28()) {
+		priv->usbclk = clk_get(dev, "usb");
+		if (IS_ERR(priv->usbclk)) {
+			ret = PTR_ERR(priv->usbclk);
+			goto err_clk;
+		}
+		clk_enable(priv->usbclk);
 	}
-	clk_enable(priv->usbclk);
-
-	if (!cpu_is_mx35() && !cpu_is_mx25()) {
+	if (!cpu_is_mx35() && !cpu_is_mx25() && !cpu_is_mx28()) {
 		priv->ahbclk = clk_get(dev, "usb_ahb");
 		if (IS_ERR(priv->ahbclk)) {
 			ret = PTR_ERR(priv->ahbclk);
@@ -272,8 +295,10 @@ err_clk_phy:
 		clk_put(priv->ahbclk);
 	}
 err_clk_ahb:
-	clk_disable(priv->usbclk);
-	clk_put(priv->usbclk);
+	if (priv->usbclk) {
+		clk_disable(priv->usbclk);
+		clk_put(priv->usbclk);
+	}
 err_clk:
 	iounmap(hcd->regs);
 err_ioremap:
@@ -304,8 +329,10 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 	platform_set_drvdata(pdev, NULL);
 
-	clk_disable(priv->usbclk);
-	clk_put(priv->usbclk);
+	if (priv->usbclk) {
+		clk_disable(priv->usbclk);
+		clk_put(priv->usbclk);
+	}
 	if (priv->ahbclk) {
 		clk_disable(priv->ahbclk);
 		clk_put(priv->ahbclk);
-- 
1.7.0.4
