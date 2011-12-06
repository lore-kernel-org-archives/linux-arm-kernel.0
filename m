From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 6 Dec 2011 18:43:13 +0800
Subject: [RFC PATCH 2/3] USB: ehci-mxc: Use new phy structure code for mxc
 host use
In-Reply-To: <1323168194-24191-1-git-send-email-peter.chen@freescale.com>
References: <1323168194-24191-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1323168194-24191-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch just shows how mxc hci host uses general phy framework
We can use multi-phy with different phy's pointer.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/host/ehci-mxc.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 55978fc..8daaa7a 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/phy.h>
 #include <linux/usb/ulpi.h>
 #include <linux/slab.h>
 
@@ -34,6 +35,7 @@
 struct ehci_mxc_priv {
 	struct clk *usbclk, *ahbclk, *phy1clk;
 	struct usb_hcd *hcd;
+	struct usb_transceiver *xceiv;
 };
 
 /* called during probe() after chip reset completes */
@@ -120,6 +122,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	int irq, ret;
 	unsigned int flags;
 	struct ehci_mxc_priv *priv;
+	struct usb_transceiver *xceiv = NULL;
 	struct device *dev = &pdev->dev;
 	struct ehci_hcd *ehci;
 
@@ -218,19 +221,26 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	msleep(10);
 
 	/* Initialize the transceiver */
-	if (pdata->otg) {
-		pdata->otg->io_priv = hcd->regs + ULPI_VIEWPORT_OFFSET;
-		ret = otg_init(pdata->otg);
+	xceiv = usb_get_transceiver(dev_name(&pdev->dev));	
+	if (!xceiv) {
+		dev_err(dev, "can't find transceiver\n");
+		ret = -ENODEV;
+		goto err_add;
+	} else {
+		if (xceiv->interface == USB_XCEIV_ULPI)
+			xceiv->io_priv = hcd->regs + ULPI_VIEWPORT_OFFSET;
+		ret = xceiv->init(xceiv);
 		if (ret) {
 			dev_err(dev, "unable to init transceiver, probably missing\n");
 			ret = -ENODEV;
 			goto err_add;
 		}
-		ret = otg_set_vbus(pdata->otg, 1);
+		ret = xceiv->set_vbus(xceiv, 1);
 		if (ret) {
 			dev_err(dev, "unable to enable vbus on transceiver\n");
 			goto err_add;
 		}
+		priv->xceiv = xceiv;
 	}
 
 	priv->hcd = hcd;
@@ -240,16 +250,16 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add;
 
-	if (pdata->otg) {
+	if (xceiv) {
 		/*
 		 * efikamx and efikasb have some hardware bug which is
 		 * preventing usb to work unless CHRGVBUS is set.
 		 * It's in violation of USB specs
 		 */
 		if (machine_is_mx51_efikamx() || machine_is_mx51_efikasb()) {
-			flags = otg_io_read(pdata->otg, ULPI_OTG_CTRL);
+			flags = xceiv_io_read(xceiv, ULPI_OTG_CTRL);
 			flags |= ULPI_OTG_CTRL_CHRGVBUS;
-			ret = otg_io_write(pdata->otg, flags, ULPI_OTG_CTRL);
+			ret = xceiv_io_write(xceiv, flags, ULPI_OTG_CTRL);
 			if (ret) {
 				dev_err(dev, "unable to set CHRVBUS\n");
 				goto err_add;
@@ -296,8 +306,8 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 
-	if (pdata->otg)
-		otg_shutdown(pdata->otg);
+	if (priv->xceiv)
+		usb_put_transceiver(priv->xceiv);
 
 	usb_remove_hcd(hcd);
 	iounmap(hcd->regs);
-- 
1.6.3.3
