From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Tue,  6 Sep 2016 09:23:55 +0800
Subject: [PATCH v2] ASoC: rockchip: spdif: restore register during
 runtime_suspend/resume cycle
Message-ID: <1473125035-74895-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when step into runtime_suspend, spdif pd will be disabled and loss state.
so need to restore register when runtime_resume.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

---

Changes in v2:
- remove system suspend/resume and restore register
  in runtime_suspend/resume per Doug Anderson's suggestion

 sound/soc/rockchip/rockchip_spdif.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 4ca2657..0eb8d49 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -65,6 +65,7 @@ static int __maybe_unused rk_spdif_runtime_suspend(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 
+	regcache_cache_only(spdif->regmap, true);
 	clk_disable_unprepare(spdif->mclk);
 	clk_disable_unprepare(spdif->hclk);
 
@@ -74,7 +75,7 @@ static int __maybe_unused rk_spdif_runtime_suspend(struct device *dev)
 static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	ret = clk_prepare_enable(spdif->mclk);
 	if (ret) {
@@ -88,7 +89,16 @@ static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	return 0;
+	regcache_cache_only(spdif->regmap, false);
+	regcache_mark_dirty(spdif->regmap);
+
+	ret = regcache_sync(spdif->regmap);
+	if (ret) {
+		clk_disable_unprepare(spdif->mclk);
+		clk_disable_unprepare(spdif->hclk);
+	}
+
+	return ret;
 }
 
 static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
-- 
1.9.1
