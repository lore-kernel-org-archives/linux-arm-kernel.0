From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:27:59 +0200
Subject: [PATCH 09/33] USB ehci mxc: prepare/unprepare clock
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/host/ehci-mxc.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index a797d51..ae16c34 100644
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
@@ -179,7 +179,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 			ret = PTR_ERR(priv->ahbclk);
 			goto err_clk_ahb;
 		}
-		clk_enable(priv->ahbclk);
+		clk_prepare_enable(priv->ahbclk);
 	}
 
 	/* "dr" device has its own clock on i.MX51 */
@@ -189,7 +189,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 			ret = PTR_ERR(priv->phy1clk);
 			goto err_clk_phy;
 		}
-		clk_enable(priv->phy1clk);
+		clk_prepare_enable(priv->phy1clk);
 	}
 
 
@@ -266,16 +266,16 @@ err_add:
 		pdata->exit(pdev);
 err_init:
 	if (priv->phy1clk) {
-		clk_disable(priv->phy1clk);
+		clk_disable_unprepare(priv->phy1clk);
 		clk_put(priv->phy1clk);
 	}
 err_clk_phy:
 	if (priv->ahbclk) {
-		clk_disable(priv->ahbclk);
+		clk_disable_unprepare(priv->ahbclk);
 		clk_put(priv->ahbclk);
 	}
 err_clk_ahb:
-	clk_disable(priv->usbclk);
+	clk_disable_unprepare(priv->usbclk);
 	clk_put(priv->usbclk);
 err_clk:
 	iounmap(hcd->regs);
@@ -307,14 +307,14 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 	platform_set_drvdata(pdev, NULL);
 
-	clk_disable(priv->usbclk);
+	clk_disable_unprepare(priv->usbclk);
 	clk_put(priv->usbclk);
 	if (priv->ahbclk) {
-		clk_disable(priv->ahbclk);
+		clk_disable_unprepare(priv->ahbclk);
 		clk_put(priv->ahbclk);
 	}
 	if (priv->phy1clk) {
-		clk_disable(priv->phy1clk);
+		clk_disable_unprepare(priv->phy1clk);
 		clk_put(priv->phy1clk);
 	}
 
-- 
1.7.10
