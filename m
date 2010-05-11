From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 11 May 2010 16:14:34 +0200
Subject: [PATCH 1/1 v2] ehci-mxc: Fix mx31 OTG host initialisation
In-Reply-To: <1273587274-8045-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1273587274-8045-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1273587274-8045-2-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mx31 the OTG host initialisation fails if you need to have
an ULPI transfert to initialize the PHY.

In order to be able to communicate with the PHY a complete reset
of the usb host is needed. After the PHY initialization the host
usb configuration registers need to be rewritten to avoid a host
controller lockup.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 drivers/usb/host/ehci-mxc.c |   98 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 544ccfd..488a171 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -29,6 +29,11 @@
 #define PORTSC_OFFSET		0x184
 #define USBMODE_OFFSET		0x1a8
 #define USBMODE_CM_HOST		3
+#define USBCMD_OFFSET		0x140
+#define USBCMD_RS		(1 << 0)
+#define USBCMD_RST		(1 << 1)
+#define USBSTS_OFFSET		0x144
+#define USBSTS_HCH		(1 << 12)
 
 struct ehci_mxc_priv {
 	struct clk *usbclk, *ahbclk;
@@ -112,12 +117,73 @@ static const struct hc_driver ehci_mxc_hc_driver = {
 	.port_handed_over = ehci_port_handed_over,
 };
 
+static int ehci_mxc_poll(void __iomem *ptr, u32 mask, u32 done, int usec)
+{
+	int i;
+
+	for (i = 0; i < usec; i++) {
+		if ((readl(ptr) & mask) == done)
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+#define MXC_POLL_TIMEOUT 10000
+static int ehci_mxc_reset(struct usb_hcd *hcd)
+{
+	int ret;
+	int temp;
+
+	/* Wait for the controller to go idle */
+	ret = ehci_mxc_poll(hcd->regs + USBSTS_OFFSET,
+			    USBSTS_HCH, USBSTS_HCH, MXC_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the usb controller */
+	temp = readl(hcd->regs + USBCMD_OFFSET);
+	writel(temp & (~USBCMD_RS), hcd->regs + USBCMD_OFFSET);
+
+	ret = ehci_mxc_poll(hcd->regs + USBCMD_OFFSET, USBCMD_RS, 0,
+			    MXC_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	/* Reset the usb controller */
+	temp = readl(hcd->regs + USBCMD_OFFSET);
+	writel(temp | USBCMD_RST, hcd->regs + USBCMD_OFFSET);
+
+	ret = ehci_mxc_poll(hcd->regs + USBCMD_OFFSET, USBCMD_RST, 0,
+			    MXC_POLL_TIMEOUT);
+
+	return ret;
+}
+
+static int ehci_mxc_setup_host_mode(struct platform_device *pdev,
+				  struct usb_hcd *hcd)
+{
+	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
+	int temp;
+
+	/* set USBMODE to host mode */
+	temp = readl(hcd->regs + USBMODE_OFFSET);
+	writel(temp | USBMODE_CM_HOST, hcd->regs + USBMODE_OFFSET);
+
+	/* set up the PORTSCx register */
+	writel(pdata->portsc, hcd->regs + PORTSC_OFFSET);
+	mdelay(10);
+
+	/* setup specific usb hw */
+	return mxc_initialize_usb_hw(pdev->id, pdata->flags);
+}
+
 static int ehci_mxc_drv_probe(struct platform_device *pdev)
 {
 	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
 	struct usb_hcd *hcd;
 	struct resource *res;
-	int irq, ret, temp;
+	int irq, ret;
 	struct ehci_mxc_priv *priv;
 	struct device *dev = &pdev->dev;
 
@@ -191,19 +257,20 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		clk_enable(priv->ahbclk);
 	}
 
-	/* set USBMODE to host mode */
-	temp = readl(hcd->regs + USBMODE_OFFSET);
-	writel(temp | USBMODE_CM_HOST, hcd->regs + USBMODE_OFFSET);
-
-	/* set up the PORTSCx register */
-	writel(pdata->portsc, hcd->regs + PORTSC_OFFSET);
-	mdelay(10);
-
-	/* setup specific usb hw */
-	ret = mxc_initialize_usb_hw(pdev->id, pdata->flags);
+	ret =  ehci_mxc_setup_host_mode(pdev, hcd);
 	if (ret < 0)
 		goto err_init;
 
+	/* i.Mx31 OTG host has a bug, if you don't do a reset, then ULPI
+	 * transfers timeout. */
+	if (cpu_is_mx31() && pdev->id == 0) {
+		ret = ehci_mxc_reset(hcd);
+		if (ret < 0) {
+			dev_err(dev, "Unable to reset USB controller");
+			goto err_init;
+		}
+	}
+
 	/* Initialize the transceiver */
 	if (pdata->otg) {
 		pdata->otg->io_priv = hcd->regs + ULPI_VIEWPORT_OFFSET;
@@ -213,6 +280,15 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 			dev_err(dev, "unable to enable vbus on transceiver\n");
 	}
 
+	/* i.Mx31 OTG host has a bug, if you do an ULPI transfer then the host
+	 * controller stays busy. Rewriting the register is enough to make it
+	 * working */
+	if (cpu_is_mx31() && pdev->id == 0) {
+		ret = ehci_mxc_setup_host_mode(pdev, hcd);
+		if (ret < 0)
+			goto err_init;
+	}
+
 	priv->hcd = hcd;
 	platform_set_drvdata(pdev, priv);
 
-- 
1.6.3.3
