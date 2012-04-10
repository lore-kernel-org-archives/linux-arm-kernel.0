From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:52 +0200
Subject: [PATCH 39/40] USB ehci i.MX: Fix clock handling
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-40-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usbotg core generally has three different clocks:

ipg: Bus register accesses
ahb: DMA clock
per: Clock for generating the 60MHz for the phy

The old i.MX clock support messed this up completely, there
were different clocks for different SoCs, but there meaning
varied from SoC to SoC. This patch cleans up the breakage
introduced by the generic clock support. While at it, also
use the managed version of clk_get to make the error path
easier.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/host/ehci-mxc.c |   52 ++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index ae16c34..a2fb7c5 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -32,7 +32,10 @@
 #define ULPI_VIEWPORT_OFFSET	0x170
 
 struct ehci_mxc_priv {
-	struct clk *usbclk, *ahbclk, *phy1clk;
+	struct clk *clk_ipg;
+	struct clk *clk_ahb;
+	struct clk *clk_per;
+	struct clk *phy1clk;
 	struct usb_hcd *hcd;
 };
 
@@ -166,22 +169,28 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	/* enable clocks */
-	priv->usbclk = clk_get(dev, "usb");
-	if (IS_ERR(priv->usbclk)) {
-		ret = PTR_ERR(priv->usbclk);
+	priv->clk_ipg = devm_clk_get(dev, "ipg");
+	if (IS_ERR(priv->clk_ipg)) {
+		ret = PTR_ERR(priv->clk_ipg);
 		goto err_clk;
 	}
-	clk_prepare_enable(priv->usbclk);
 
-	if (!cpu_is_mx35() && !cpu_is_mx25()) {
-		priv->ahbclk = clk_get(dev, "usb_ahb");
-		if (IS_ERR(priv->ahbclk)) {
-			ret = PTR_ERR(priv->ahbclk);
-			goto err_clk_ahb;
-		}
-		clk_prepare_enable(priv->ahbclk);
+	priv->clk_ahb = devm_clk_get(dev, "ahb");
+	if (IS_ERR(priv->clk_ahb)) {
+		ret = PTR_ERR(priv->clk_ahb);
+		goto err_clk;
+	}
+
+	priv->clk_per = devm_clk_get(dev, "per");
+	if (IS_ERR(priv->clk_per)) {
+		ret = PTR_ERR(priv->clk_per);
+		goto err_clk;
 	}
 
+	clk_prepare_enable(priv->clk_per);
+	clk_prepare_enable(priv->clk_ahb);
+	clk_prepare_enable(priv->clk_ipg);
+
 	/* "dr" device has its own clock on i.MX51 */
 	if (cpu_is_mx51() && (pdev->id == 0)) {
 		priv->phy1clk = clk_get(dev, "usb_phy1");
@@ -270,13 +279,9 @@ err_init:
 		clk_put(priv->phy1clk);
 	}
 err_clk_phy:
-	if (priv->ahbclk) {
-		clk_disable_unprepare(priv->ahbclk);
-		clk_put(priv->ahbclk);
-	}
-err_clk_ahb:
-	clk_disable_unprepare(priv->usbclk);
-	clk_put(priv->usbclk);
+	clk_disable_unprepare(priv->clk_ahb);
+	clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_per);
 err_clk:
 	iounmap(hcd->regs);
 err_ioremap:
@@ -307,12 +312,9 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 	platform_set_drvdata(pdev, NULL);
 
-	clk_disable_unprepare(priv->usbclk);
-	clk_put(priv->usbclk);
-	if (priv->ahbclk) {
-		clk_disable_unprepare(priv->ahbclk);
-		clk_put(priv->ahbclk);
-	}
+	clk_disable_unprepare(priv->clk_ahb);
+	clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_per);
 	if (priv->phy1clk) {
 		clk_disable_unprepare(priv->phy1clk);
 		clk_put(priv->phy1clk);
-- 
1.7.9.5
