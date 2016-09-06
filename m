From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Tue,  6 Sep 2016 09:19:53 +0800
Subject: [PATCH v2] ASoC: rockchip: i2s: restore register during
 runtime_suspend/resume cycle
Message-ID: <1473124793-74625-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when step into runtime_suspend, i2s pd will be disabled and loss state.
so need to restore register when runtime_resume.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

---

Changes in v2:
- remove system suspend/resume and restore register
  in runtime_suspend/resume per Doug Anderson's suggestion

 sound/soc/rockchip/rockchip_i2s.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 652e8c5..98b6822 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -57,6 +57,7 @@ static int i2s_runtime_suspend(struct device *dev)
 {
 	struct rk_i2s_dev *i2s = dev_get_drvdata(dev);
 
+	regcache_cache_only(i2s->regmap, true);
 	clk_disable_unprepare(i2s->mclk);
 
 	return 0;
@@ -65,7 +66,7 @@ static int i2s_runtime_suspend(struct device *dev)
 static int i2s_runtime_resume(struct device *dev)
 {
 	struct rk_i2s_dev *i2s = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	ret = clk_prepare_enable(i2s->mclk);
 	if (ret) {
@@ -73,7 +74,14 @@ static int i2s_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	return 0;
+	regcache_cache_only(i2s->regmap, false);
+	regcache_mark_dirty(i2s->regmap);
+
+	ret = regcache_sync(i2s->regmap);
+	if (ret)
+		clk_disable_unprepare(i2s->mclk);
+
+	return ret;
 }
 
 static inline struct rk_i2s_dev *to_info(struct snd_soc_dai *dai)
-- 
1.9.1
