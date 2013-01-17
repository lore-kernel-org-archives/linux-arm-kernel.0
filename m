From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 13:30:16 +0200
Subject: [PATCH v7 07/22] mfd: omap-usb-tll: Fix error message
In-Reply-To: <1358422231-24736-1-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
Message-ID: <1358422231-24736-8-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_enable/disable_tll() can fail if TLL device is not
initialized. It could be due to multiple reasons and not only
due to missing platform data.

Also make local variables static and use 'struct device *'
instead of 'struct platform_device *' for global reference.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 0e68c8a..81d2cac 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -109,8 +109,8 @@ struct usbtll_omap {
 
 /*-------------------------------------------------------------------------*/
 
-const char usbtll_driver_name[] = USBTLL_DRIVER_NAME;
-struct platform_device	*tll_pdev;
+static const char usbtll_driver_name[] = USBTLL_DRIVER_NAME;
+static struct device	*tll_dev;
 
 /*-------------------------------------------------------------------------*/
 
@@ -337,7 +337,8 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 
 	spin_unlock_irqrestore(&tll->lock, flags);
 	pm_runtime_put_sync(dev);
-	tll_pdev = pdev;
+	/* only after this can omap_tll_enable/disable work */
+	tll_dev = dev;
 
 	return 0;
 
@@ -359,6 +360,8 @@ static int usbtll_omap_remove(struct platform_device *pdev)
 	struct usbtll_omap *tll = platform_get_drvdata(pdev);
 	int i;
 
+	tll_dev = NULL;
+
 	for (i = 0; i < tll->nch; i++)
 		clk_put(tll->ch_clk[i]);
 
@@ -438,21 +441,21 @@ static struct platform_driver usbtll_omap_driver = {
 
 int omap_tll_enable(void)
 {
-	if (!tll_pdev) {
-		pr_err("missing omap usbhs tll platform_data\n");
+	if (!tll_dev) {
+		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
 		return  -ENODEV;
 	}
-	return pm_runtime_get_sync(&tll_pdev->dev);
+	return pm_runtime_get_sync(tll_dev);
 }
 EXPORT_SYMBOL_GPL(omap_tll_enable);
 
 int omap_tll_disable(void)
 {
-	if (!tll_pdev) {
-		pr_err("missing omap usbhs tll platform_data\n");
+	if (!tll_dev) {
+		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
 		return  -ENODEV;
 	}
-	return pm_runtime_put_sync(&tll_pdev->dev);
+	return pm_runtime_put_sync(tll_dev);
 }
 EXPORT_SYMBOL_GPL(omap_tll_disable);
 
-- 
1.7.4.1
