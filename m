From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  1 Feb 2011 12:18:39 +0100
Subject: [PATCH 5/5] USB ehci-mxc: make phy clock optional on all i.MX SoCs
In-Reply-To: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
References: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296559119-7723-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy clock is present on only some i.MX SoCs. Request
it on every SoC, but use it only when present.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/host/ehci-mxc.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 2cec923..2bccc23 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -177,15 +177,9 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		clk_enable(priv->ahbclk);
 
 	/* "dr" device has its own clock */
-	if (pdev->id == 0) {
-		priv->phyclk = clk_get(dev, "usb_phy");
-		if (IS_ERR(priv->phyclk)) {
-			ret = PTR_ERR(priv->phyclk);
-			goto err_clk_phy;
-		}
+	priv->phyclk = clk_get(dev, "usb_phy");
+	if (!IS_ERR(priv->phyclk))
 		clk_enable(priv->phyclk);
-	}
-
 
 	/* call platform specific init function */
 	if (pdata->init) {
@@ -257,11 +251,10 @@ err_add:
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 err_init:
-	if (priv->phyclk) {
+	if (!IS_ERR(priv->phyclk)) {
 		clk_disable(priv->phyclk);
 		clk_put(priv->phyclk);
 	}
-err_clk_phy:
 	if (!IS_ERR(priv->ahbclk)) {
 		clk_disable(priv->ahbclk);
 		clk_put(priv->ahbclk);
@@ -304,7 +297,7 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 		clk_disable(priv->ahbclk);
 		clk_put(priv->ahbclk);
 	}
-	if (priv->phyclk) {
+	if (!IS_ERR(priv->phyclk)) {
 		clk_disable(priv->phyclk);
 		clk_put(priv->phyclk);
 	}
-- 
1.7.2.3
