From: rcsekar@samsung.com (R. Chandrasekar)
Date: Wed, 30 Jan 2013 17:41:04 +0530
Subject: [PATCH] Asoc: Samsung: I2S: Add support for runtime S2R
Message-ID: <1359547864-1057-1-git-send-email-rcsekar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "R. Chandrasekar" <rcsekar@samsung.com>

This patch adds runtime suspend to resume support for I2S.
I2S clk is disabled at suspend and enabled at resume.

Signed-off-by: R. Chandrasekar <rcsekar@samsung.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 sound/soc/samsung/i2s.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 2fc42f9..d7231e3 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1071,6 +1071,26 @@ static inline int samsung_i2s_get_driver_data(struct platform_device *pdev)
 		return platform_get_device_id(pdev)->driver_data;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int i2s_runtime_suspend(struct device *dev)
+{
+	struct i2s_dai *i2s = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(i2s->clk);
+
+	return 0;
+}
+
+static int i2s_runtime_resume(struct device *dev)
+{
+	struct i2s_dai *i2s = dev_get_drvdata(dev);
+
+	clk_prepare_enable(i2s->clk);
+
+	return 0;
+}
+#endif /* CONFIG_PM_RUNTIME */
+
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
@@ -1288,6 +1308,11 @@ static const struct of_device_id exynos_i2s_match[] = {
 MODULE_DEVICE_TABLE(of, exynos_i2s_match);
 #endif
 
+static const struct dev_pm_ops samsung_i2s_pm = {
+	SET_RUNTIME_PM_OPS(i2s_runtime_suspend,
+				i2s_runtime_resume, NULL)
+};
+
 static struct platform_driver samsung_i2s_driver = {
 	.probe  = samsung_i2s_probe,
 	.remove = samsung_i2s_remove,
@@ -1296,6 +1321,7 @@ static struct platform_driver samsung_i2s_driver = {
 		.name = "samsung-i2s",
 		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(exynos_i2s_match),
+		.pm = &samsung_i2s_pm,
 	},
 };
 
-- 
1.7.9.5
