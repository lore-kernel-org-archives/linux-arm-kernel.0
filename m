From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Wed,  7 Sep 2016 14:30:21 +0800
Subject: [PATCH v3] ASoC: rockchip: spdif: restore register during
 runtime_suspend/resume cycle
Message-ID: <1473229821-54139-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when step into runtime_suspend, spdif pd will be disabled and loss state.
so need to restore register when runtime_resume.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

---

Changes in v3:
- remove unneeded initialization

Changes in v2:
- remove system suspend/resume and restore register
  in runtime_suspend/resume per Doug Anderson's suggestion

 sound/soc/rockchip/rockchip_spdif.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 4ca2657..fa8101d 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -65,6 +65,7 @@ static int __maybe_unused rk_spdif_runtime_suspend(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 
+	regcache_cache_only(spdif->regmap, true);
 	clk_disable_unprepare(spdif->mclk);
 	clk_disable_unprepare(spdif->hclk);
 
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
