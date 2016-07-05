From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Tue,  5 Jul 2016 10:45:11 +0800
Subject: [PATCH] ASoC: rockchip: implement system suspend/resume for i2s
Message-ID: <1467686711-52347-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

restore hw registers after power loss during a suspend/resume cycle.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_i2s.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 574c6af..53970ac 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -614,9 +614,35 @@ static const struct of_device_id rockchip_i2s_match[] = {
 	{},
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int rockchip_i2s_suspend(struct device *dev)
+{
+	struct rk_i2s_dev *i2s = dev_get_drvdata(dev);
+
+	regcache_mark_dirty(i2s->regmap);
+
+	return 0;
+}
+
+static int rockchip_i2s_resume(struct device *dev)
+{
+	struct rk_i2s_dev *i2s = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+	ret = regcache_sync(i2s->regmap);
+	pm_runtime_put(dev);
+
+	return ret;
+}
+#endif
+
 static const struct dev_pm_ops rockchip_i2s_pm_ops = {
 	SET_RUNTIME_PM_OPS(i2s_runtime_suspend, i2s_runtime_resume,
 			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(rockchip_i2s_suspend, rockchip_i2s_resume)
 };
 
 static struct platform_driver rockchip_i2s_driver = {
-- 
1.9.1
