From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Mar 2017 10:47:55 +0100
Subject: [PATCH 2/2] [media] vcodec: mediatek: mark pm functions as
 __maybe_unused
In-Reply-To: <20170320094812.1365229-1-arnd@arndb.de>
References: <20170320094812.1365229-1-arnd@arndb.de>
Message-ID: <20170320094812.1365229-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_PM is disabled, we get a couple of unused functions:

drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:927:13: error: 'mtk_jpeg_clk_off' defined but not used [-Werror=unused-function]
 static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
             ^~~~~~~~~~~~~~~~
drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:916:13: error: 'mtk_jpeg_clk_on' defined but not used [-Werror=unused-function]
 static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)

Rather than adding more error-prone #ifdefs around those, this patch
removes the existing #ifdef checks and marks the PM functions as __maybe_unused
to let gcc do the right thing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index f9bd58ce7d32..7103b6da25d2 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -1224,8 +1224,7 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mtk_jpeg_pm_suspend(struct device *dev)
+static __maybe_unused int mtk_jpeg_pm_suspend(struct device *dev)
 {
 	struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);
 
@@ -1235,7 +1234,7 @@ static int mtk_jpeg_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int mtk_jpeg_pm_resume(struct device *dev)
+static __maybe_unused int mtk_jpeg_pm_resume(struct device *dev)
 {
 	struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);
 
@@ -1244,10 +1243,8 @@ static int mtk_jpeg_pm_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
-#ifdef CONFIG_PM_SLEEP
-static int mtk_jpeg_suspend(struct device *dev)
+static __maybe_unused int mtk_jpeg_suspend(struct device *dev)
 {
 	int ret;
 
@@ -1258,7 +1255,7 @@ static int mtk_jpeg_suspend(struct device *dev)
 	return ret;
 }
 
-static int mtk_jpeg_resume(struct device *dev)
+static __maybe_unused int mtk_jpeg_resume(struct device *dev)
 {
 	int ret;
 
@@ -1269,7 +1266,6 @@ static int mtk_jpeg_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops mtk_jpeg_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mtk_jpeg_suspend, mtk_jpeg_resume)
-- 
2.9.0
