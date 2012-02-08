From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  8 Feb 2012 01:12:55 +0100
Subject: [PATCH] EHCI: Fix clk_enable/clk_disable for ehci-mxc usb clock
Message-ID: <1328659975-3534-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock weren't enabled without the following change.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/host/ehci-mxc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 55978fc..f3faf0e 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -171,7 +171,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		ret = PTR_ERR(priv->usbclk);
 		goto err_clk;
 	}
-	clk_enable(priv->usbclk);
+	clk_prepare_enable(priv->usbclk);
 
 	if (!cpu_is_mx35() && !cpu_is_mx25()) {
 		priv->ahbclk = clk_get(dev, "usb_ahb");
@@ -273,7 +273,7 @@ err_clk_phy:
 		clk_put(priv->ahbclk);
 	}
 err_clk_ahb:
-	clk_disable(priv->usbclk);
+	clk_disable_unprepare(priv->usbclk);
 	clk_put(priv->usbclk);
 err_clk:
 	iounmap(hcd->regs);
@@ -305,7 +305,7 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 	platform_set_drvdata(pdev, NULL);
 
-	clk_disable(priv->usbclk);
+	clk_disable_unprepare(priv->usbclk);
 	clk_put(priv->usbclk);
 	if (priv->ahbclk) {
 		clk_disable(priv->ahbclk);
-- 
1.7.8.3
