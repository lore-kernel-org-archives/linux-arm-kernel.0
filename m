From: Dinh.Nguyen@freescale.com (Dinh.Nguyen at freescale.com)
Date: Fri, 16 Apr 2010 14:16:10 -0500
Subject: [PATCHv4 2.6.34-rc4 6/7] mxc-usb: Add call to initialize MXC USB HW
	registers
In-Reply-To: <1271445371-18501-5-git-send-email-Dinh.Nguyen@freescale.com>
References: <1271445371-18501-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-4-git-send-email-Dinh.Nguyen@freescale.com>
	<1271445371-18501-5-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <1271445371-18501-6-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <Dinh.Nguyen@freescale.com>

The placing of the function needs to be before setting the USBMODE
register to host, since a reset and start is done in
mxc_initialize_usb_hw.

This patch applies to 2.6.34-rc4.

Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
---
 drivers/usb/host/ehci-mxc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index ead59f4..7091b20 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -191,6 +191,11 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		clk_enable(priv->ahbclk);
 	}
 
+	/* setup specific usb hw */
+	ret = mxc_intialize_usb_hw(pdev->id, pdata->flags);
+	if (ret < 0)
+		goto err_init;
+
 	/* set USBMODE to host mode */
 	temp = readl(hcd->regs + USBMODE_OFFSET);
 	writel(temp | USBMODE_CM_HOST, hcd->regs + USBMODE_OFFSET);
@@ -199,11 +204,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	writel(pdata->portsc, hcd->regs + PORTSC_OFFSET);
 	mdelay(10);
 
-	/* setup USBCONTROL. */
-	ret = mxc_set_usbcontrol(pdev->id, pdata->flags);
-	if (ret < 0)
-		goto err_init;
-
 	/* Initialize the transceiver */
 	if (pdata->otg) {
 		pdata->otg->io_priv = hcd->regs + ULPI_VIEWPORT_OFFSET;
-- 
1.6.0.4
