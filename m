From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  1 Feb 2011 12:18:38 +0100
Subject: [PATCH 4/5] ARM i.MX51/53: register usb phy clock as usb_phy
In-Reply-To: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
References: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296559119-7723-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usb_phy1 is the wrong name as it is the one and only clock belonging
to the usb phy. So rename it to usb_phy.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    2 +-
 drivers/usb/host/ehci-mxc.c         |   26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 0a19e75..2f2b46e 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1295,7 +1295,7 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usboh3_clk)
 	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_ahb_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy1", usb_phy1_clk)
+	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy", usb_phy1_clk)
 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usboh3_clk)
 	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_ahb_clk)
 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usboh3_clk)
diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index f5942ee..2cec923 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -31,7 +31,7 @@
 #define ULPI_VIEWPORT_OFFSET	0x170
 
 struct ehci_mxc_priv {
-	struct clk *usbclk, *ahbclk, *phy1clk;
+	struct clk *usbclk, *ahbclk, *phyclk;
 	struct usb_hcd *hcd;
 };
 
@@ -176,14 +176,14 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	if (!IS_ERR(priv->ahbclk))
 		clk_enable(priv->ahbclk);
 
-	/* "dr" device has its own clock on i.MX51 */
-	if (cpu_is_mx51() && (pdev->id == 0)) {
-		priv->phy1clk = clk_get(dev, "usb_phy1");
-		if (IS_ERR(priv->phy1clk)) {
-			ret = PTR_ERR(priv->phy1clk);
+	/* "dr" device has its own clock */
+	if (pdev->id == 0) {
+		priv->phyclk = clk_get(dev, "usb_phy");
+		if (IS_ERR(priv->phyclk)) {
+			ret = PTR_ERR(priv->phyclk);
 			goto err_clk_phy;
 		}
-		clk_enable(priv->phy1clk);
+		clk_enable(priv->phyclk);
 	}
 
 
@@ -257,9 +257,9 @@ err_add:
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 err_init:
-	if (priv->phy1clk) {
-		clk_disable(priv->phy1clk);
-		clk_put(priv->phy1clk);
+	if (priv->phyclk) {
+		clk_disable(priv->phyclk);
+		clk_put(priv->phyclk);
 	}
 err_clk_phy:
 	if (!IS_ERR(priv->ahbclk)) {
@@ -304,9 +304,9 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 		clk_disable(priv->ahbclk);
 		clk_put(priv->ahbclk);
 	}
-	if (priv->phy1clk) {
-		clk_disable(priv->phy1clk);
-		clk_put(priv->phy1clk);
+	if (priv->phyclk) {
+		clk_disable(priv->phyclk);
+		clk_put(priv->phyclk);
 	}
 
 	kfree(priv);
-- 
1.7.2.3
