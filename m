From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Tue,  5 Jul 2016 10:48:06 +0800
Subject: [PATCH] ASoC: rockchip: implement system suspend/resume for spdif
Message-ID: <1467686886-53257-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

restore hw registers after power loss during a suspend/resume cycle.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_spdif.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 100781e..00ae0e5 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -392,9 +392,35 @@ static int rk_spdif_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int rockchip_spdif_suspend(struct device *dev)
+{
+	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
+
+	regcache_mark_dirty(spdif->regmap);
+
+	return 0;
+}
+
+static int rockchip_spdif_resume(struct device *dev)
+{
+	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+	ret = regcache_sync(spdif->regmap);
+	pm_runtime_put(dev);
+
+	return ret;
+}
+#endif
+
 static const struct dev_pm_ops rk_spdif_pm_ops = {
 	SET_RUNTIME_PM_OPS(rk_spdif_runtime_suspend, rk_spdif_runtime_resume,
 			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(rockchip_spdif_suspend, rockchip_spdif_resume)
 };
 
 static struct platform_driver rk_spdif_driver = {
-- 
1.9.1
