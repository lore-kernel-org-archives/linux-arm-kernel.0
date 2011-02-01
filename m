From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  1 Feb 2011 12:18:37 +0100
Subject: [PATCH 3/5] USB ehci-mxc: make ahb clock optional on all i.MX SoCs
In-Reply-To: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
References: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296559119-7723-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ahb clock is not present on all i.MX SoCs. So instead
of requesting this clock on only some SoCs we can request
them on all SoCs and use it when present.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/host/ehci-mxc.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 25c8c10..f5942ee 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -172,14 +172,9 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 	clk_enable(priv->usbclk);
 
-	if (!cpu_is_mx35() && !cpu_is_mx25()) {
-		priv->ahbclk = clk_get(dev, "usb_ahb");
-		if (IS_ERR(priv->ahbclk)) {
-			ret = PTR_ERR(priv->ahbclk);
-			goto err_clk_ahb;
-		}
+	priv->ahbclk = clk_get(dev, "usb_ahb");
+	if (!IS_ERR(priv->ahbclk))
 		clk_enable(priv->ahbclk);
-	}
 
 	/* "dr" device has its own clock on i.MX51 */
 	if (cpu_is_mx51() && (pdev->id == 0)) {
@@ -267,11 +262,10 @@ err_init:
 		clk_put(priv->phy1clk);
 	}
 err_clk_phy:
-	if (priv->ahbclk) {
+	if (!IS_ERR(priv->ahbclk)) {
 		clk_disable(priv->ahbclk);
 		clk_put(priv->ahbclk);
 	}
-err_clk_ahb:
 	clk_disable(priv->usbclk);
 	clk_put(priv->usbclk);
 err_clk:
@@ -306,7 +300,7 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 
 	clk_disable(priv->usbclk);
 	clk_put(priv->usbclk);
-	if (priv->ahbclk) {
+	if (!IS_ERR(priv->ahbclk)) {
 		clk_disable(priv->ahbclk);
 		clk_put(priv->ahbclk);
 	}
-- 
1.7.2.3
