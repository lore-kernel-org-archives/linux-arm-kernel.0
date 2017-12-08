From: amery@hanoverdisplays.com (Alejandro Mery)
Date: Fri, 8 Dec 2017 19:23:54 +0000
Subject: [PATCH 1/2] usb: musb: un-break davinci glue layer
Message-ID: <20171208192355.32735-1-amery@hanoverdisplays.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MUSB's davinci glue was made to depend on BROKEN by Felipe Balbi back in
2013 because of lack of active development. needed changes were actually trivial

Fixes: 787f5627bec8 (usb: musb: make davinci and da8xx glues depend on BROKEN)
Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
---
 drivers/usb/musb/Kconfig   |  1 -
 drivers/usb/musb/davinci.c | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 5506a9c03c1f..e13320eebbbf 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -76,7 +76,6 @@ config USB_MUSB_DAVINCI
 	tristate "DaVinci"
 	depends on ARCH_DAVINCI_DMx
 	depends on NOP_USB_XCEIV
-	depends on BROKEN
 
 config USB_MUSB_DA8XX
 	tristate "DA8xx/OMAP-L1x"
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 2ad39dcd2f4c..6571f9e59f8f 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -39,6 +39,7 @@
 struct davinci_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
+	struct platform_device	*phy;
 	struct clk		*clk;
 };
 
@@ -363,10 +364,8 @@ static int davinci_musb_init(struct musb *musb)
 	int 		ret = -ENODEV;
 
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
-	if (IS_ERR_OR_NULL(musb->xceiv)) {
-		ret = -EPROBE_DEFER;
-		goto unregister;
-	}
+	if (IS_ERR_OR_NULL(musb->xceiv))
+		return -EPROBE_DEFER;
 
 	musb->mregs += DAVINCI_BASE_OFFSET;
 
@@ -418,8 +417,6 @@ static int davinci_musb_init(struct musb *musb)
 
 fail:
 	usb_put_phy(musb->xceiv);
-unregister:
-	usb_phy_generic_unregister();
 	return ret;
 }
 
@@ -527,7 +524,9 @@ static int davinci_probe(struct platform_device *pdev)
 
 	pdata->platform_ops		= &davinci_ops;
 
-	usb_phy_generic_register();
+	glue->phy = usb_phy_generic_register();
+	if (IS_ERR(glue->phy))
+		goto err1;
 	platform_set_drvdata(pdev, glue);
 
 	memset(musb_resources, 0x00, sizeof(*musb_resources) *
@@ -563,14 +562,15 @@ static int davinci_probe(struct platform_device *pdev)
 	if (IS_ERR(musb)) {
 		ret = PTR_ERR(musb);
 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
-		goto err1;
+		goto err2;
 	}
 
 	return 0;
 
+err2:
+	usb_phy_generic_unregister(glue->phy);
 err1:
 	clk_disable(clk);
-
 err0:
 	return ret;
 }
@@ -580,7 +580,7 @@ static int davinci_remove(struct platform_device *pdev)
 	struct davinci_glue		*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	usb_phy_generic_unregister();
+	usb_phy_generic_unregister(glue->phy);
 	clk_disable(glue->clk);
 
 	return 0;
-- 
2.15.0
