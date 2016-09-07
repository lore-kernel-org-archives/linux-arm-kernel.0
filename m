From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Wed,  7 Sep 2016 14:27:33 +0800
Subject: [PATCH v3] ASoC: rockchip: i2s: restore register during
 runtime_suspend/resume cycle
Message-ID: <1473229653-53789-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when step into runtime_suspend, i2s pd will be disabled and loss state.
so need to restore register when runtime_resume.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

---

Changes in v3:
- remove unneeded initialization

Changes in v2:
- remove system suspend/resume and restore register
  in runtime_suspend/resume per Doug Anderson's suggestion

 sound/soc/rockchip/rockchip_i2s.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 652e8c5..974915c 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -57,6 +57,7 @@ static int i2s_runtime_suspend(struct device *dev)
 {
 	struct rk_i2s_dev *i2s = dev_get_drvdata(dev);
 
+	regcache_cache_only(i2s->regmap, true);
 	clk_disable_unprepare(i2s->mclk);
 
 	return 0;
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
