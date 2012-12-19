From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Wed, 19 Dec 2012 19:29:37 +0100
Subject: [PATCH 2/2] mxc: enable EHCI PER clock
In-Reply-To: <1355941777-99352-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1355941777-99352-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1355941777-99352-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EHCI PER clock (aka usb_div) must be enabled to have EHCI driver working.

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 drivers/usb/host/ehci-mxc.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index ec7f5d2..8050631 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -31,7 +31,7 @@
 #define ULPI_VIEWPORT_OFFSET	0x170
 
 struct ehci_mxc_priv {
-	struct clk *usbclk, *ahbclk, *phyclk;
+	struct clk *usbclk, *ahbclk, *perclk, *phyclk;
 	struct usb_hcd *hcd;
 };
 
@@ -150,6 +150,13 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(priv->ahbclk);
 
+	priv->perclk = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(priv->perclk)) {
+		ret = PTR_ERR(priv->perclk);
+		goto err_clk_per;
+	}
+	clk_prepare_enable(priv->perclk);
+
 	/* "dr" device has its own clock on i.MX51 */
 	priv->phyclk = devm_clk_get(&pdev->dev, "phy");
 	if (IS_ERR(priv->phyclk))
@@ -233,6 +240,8 @@ err_init:
 	if (priv->phyclk)
 		clk_disable_unprepare(priv->phyclk);
 
+	clk_disable_unprepare(priv->perclk);
+err_clk_per:
 	clk_disable_unprepare(priv->ahbclk);
 err_clk_ahb:
 	clk_disable_unprepare(priv->usbclk);
@@ -259,6 +268,7 @@ static int __exit ehci_mxc_drv_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->usbclk);
 	clk_disable_unprepare(priv->ahbclk);
+	clk_disable_unprepare(priv->perclk);
 
 	if (priv->phyclk)
 		clk_disable_unprepare(priv->phyclk);
-- 
1.7.8.6
