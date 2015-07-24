From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 24 Jul 2015 15:28:46 +0800
Subject: [PATCH v3 2/2] watchdog: mtk_wdt: add wdt shutdown callback to
 disable wdt if enabled
In-Reply-To: <1437722926-54509-1-git-send-email-eddie.huang@mediatek.com>
References: <1437722926-54509-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1437722926-54509-3-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greta Zhang <greta.zhang@mediatek.com>

Without .shutdown(), watchdog might reset the system during power off.
For example, if watchdog's timeout is set to 30s, then it is reset to
zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
but watchdog is still running and may trigger reset.

Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mtk_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 056412c..6ad9df9 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -210,6 +210,14 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void mtk_wdt_shutdown(struct platform_device *pdev)
+{
+	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
+
+	if (watchdog_active(&mtk_wdt->wdt_dev))
+		mtk_wdt_stop(&mtk_wdt->wdt_dev);
+}
+
 static int mtk_wdt_remove(struct platform_device *pdev)
 {
 	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
@@ -259,6 +267,7 @@ static const struct dev_pm_ops mtk_wdt_pm_ops = {
 static struct platform_driver mtk_wdt_driver = {
 	.probe		= mtk_wdt_probe,
 	.remove		= mtk_wdt_remove,
+	.shutdown	= mtk_wdt_shutdown,
 	.driver		= {
 		.name		= DRV_NAME,
 		.pm		= &mtk_wdt_pm_ops,
-- 
1.8.1.1.dirty
