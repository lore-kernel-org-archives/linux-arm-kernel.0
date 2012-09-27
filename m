From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 27 Sep 2012 19:34:08 +0530
Subject: [PATCH v2 2/2] usb: phy: omap-usb2: enable 960Mhz clock for omap5
In-Reply-To: <1348754648-8315-1-git-send-email-kishon@ti.com>
References: <1348754648-8315-1-git-send-email-kishon@ti.com>
Message-ID: <1348754648-8315-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"usb_otg_ss_refclk960m" is needed for usb2 phy present in omap5. For
omap4, the clk_get of this clock will fail since it does not have this
clock.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/phy/omap-usb2.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index d36c282..5512207 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -190,6 +190,12 @@ static int __devinit omap_usb2_probe(struct platform_device *pdev)
 	}
 	clk_prepare(phy->wkupclk);
 
+	phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
+	if (IS_ERR(phy->optclk))
+		dev_vdbg(&pdev->dev, "unable to get refclk960m\n");
+	else
+		clk_prepare(phy->optclk);
+
 	usb_add_phy(&phy->phy, USB_PHY_TYPE_USB2);
 
 	platform_set_drvdata(pdev, phy);
@@ -204,6 +210,7 @@ static int __devexit omap_usb2_remove(struct platform_device *pdev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	clk_unprepare(phy->wkupclk);
+	clk_unprepare(phy->optclk);
 	usb_remove_phy(&phy->phy);
 
 	return 0;
@@ -217,6 +224,7 @@ static int omap_usb2_runtime_suspend(struct device *dev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	clk_disable(phy->wkupclk);
+	clk_disable(phy->optclk);
 
 	return 0;
 }
@@ -228,10 +236,16 @@ static int omap_usb2_runtime_resume(struct device *dev)
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
 	ret = clk_enable(phy->wkupclk);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	ret = clk_enable(phy->optclk);
+	if (ret < 0)
+		dev_vdbg(phy->dev, "Failed to enable optclk %d\n", ret);
+
+	return 0;
 }
 
 static const struct dev_pm_ops omap_usb2_pm_ops = {
-- 
1.7.9.5
