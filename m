From: rcsekar@samsung.com (R. Chandrasekar)
Date: Thu, 24 Jan 2013 18:05:30 +0530
Subject: [PATCH] Asoc: Samsung: Add support for I2S runtime S2R
Message-ID: <1359030931-27354-1-git-send-email-rcsekar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "R. Chandrasekar" <rcsekar@samsung.com>

This patch adds runtime suspend to resume support for I2S.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: R. Chandrasekar <rcsekar@samsung.com>
---
 sound/soc/samsung/i2s.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d2d124f..27a5ab1 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -993,6 +993,26 @@ static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 	return i2s;
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
 	u32 dma_pl_chan, dma_cp_chan, dma_pl_sec_chan;
@@ -1143,12 +1163,18 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops samsung_i2s_pm = {
+	SET_RUNTIME_PM_OPS(i2s_runtime_suspend,
+				i2s_runtime_resume, NULL)
+};
+
 static struct platform_driver samsung_i2s_driver = {
 	.probe  = samsung_i2s_probe,
 	.remove = samsung_i2s_remove,
 	.driver = {
 		.name = "samsung-i2s",
 		.owner = THIS_MODULE,
+		.pm = &samsung_i2s_pm,
 	},
 };
 
-- 
1.7.9.5
