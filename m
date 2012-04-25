From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:00 +0200
Subject: [PATCH 10/33] USB ehci mxc: sanitize clock handling
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-11-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every i.MX ehci controller has a ahb and a ipg clock, so request
it on every SoC. Do not make a special case for the usb phy clock
of the i.MX51. Just request it but make it optional.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/host/ehci-mxc.c |   56 +++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index ae16c34..c778ffe 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -32,7 +32,7 @@
 #define ULPI_VIEWPORT_OFFSET	0x170
 
 struct ehci_mxc_priv {
-	struct clk *usbclk, *ahbclk, *phy1clk;
+	struct clk *usbclk, *ahbclk, *phyclk;
 	struct usb_hcd *hcd;
 };
 
@@ -166,31 +166,26 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	/* enable clocks */
-	priv->usbclk = clk_get(dev, "usb");
+	priv->usbclk = clk_get(dev, "ipg");
 	if (IS_ERR(priv->usbclk)) {
 		ret = PTR_ERR(priv->usbclk);
 		goto err_clk;
 	}
 	clk_prepare_enable(priv->usbclk);
 
-	if (!cpu_is_mx35() && !cpu_is_mx25()) {
-		priv->ahbclk = clk_get(dev, "usb_ahb");
-		if (IS_ERR(priv->ahbclk)) {
-			ret = PTR_ERR(priv->ahbclk);
-			goto err_clk_ahb;
-		}
-		clk_prepare_enable(priv->ahbclk);
+	priv->ahbclk = clk_get(dev, "ahb");
+	if (IS_ERR(priv->ahbclk)) {
+		ret = PTR_ERR(priv->ahbclk);
+		goto err_clk_ahb;
 	}
+	clk_prepare_enable(priv->ahbclk);
 
 	/* "dr" device has its own clock on i.MX51 */
-	if (cpu_is_mx51() && (pdev->id == 0)) {
-		priv->phy1clk = clk_get(dev, "usb_phy1");
-		if (IS_ERR(priv->phy1clk)) {
-			ret = PTR_ERR(priv->phy1clk);
-			goto err_clk_phy;
-		}
-		clk_prepare_enable(priv->phy1clk);
-	}
+	priv->phyclk = clk_get(dev, "phy");
+	if (IS_ERR(priv->phyclk))
+		priv->phyclk = NULL;
+	if (priv->phyclk)
+		clk_prepare_enable(priv->phyclk);
 
 
 	/* call platform specific init function */
@@ -265,15 +260,13 @@ err_add:
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 err_init:
-	if (priv->phy1clk) {
-		clk_disable_unprepare(priv->phy1clk);
-		clk_put(priv->phy1clk);
-	}
-err_clk_phy:
-	if (priv->ahbclk) {
-		clk_disable_unprepare(priv->ahbclk);
-		clk_put(priv->ahbclk);
+	if (priv->phyclk) {
+		clk_disable_unprepare(priv->phyclk);
+		clk_put(priv->phyclk);
 	}
+
+	clk_disable_unprepare(priv->ahbclk);
+	clk_put(priv->ahbclk);
 err_clk_ahb:
 	clk_disable_unprepare(priv->usbclk);
 	clk_put(priv->usbclk);
@@ -309,13 +302,12 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->usbclk);
 	clk_put(priv->usbclk);
-	if (priv->ahbclk) {
-		clk_disable_unprepare(priv->ahbclk);
-		clk_put(priv->ahbclk);
-	}
-	if (priv->phy1clk) {
-		clk_disable_unprepare(priv->phy1clk);
-		clk_put(priv->phy1clk);
+	clk_disable_unprepare(priv->ahbclk);
+	clk_put(priv->ahbclk);
+
+	if (priv->phyclk) {
+		clk_disable_unprepare(priv->phyclk);
+		clk_put(priv->phyclk);
 	}
 
 	kfree(priv);
-- 
1.7.10
