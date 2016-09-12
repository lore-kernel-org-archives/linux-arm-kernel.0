From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Sep 2016 20:06:39 +0100
Subject: Applied "ASoC: rockchip: spdif: restore register during
 runtime_suspend/resume cycle" to the asoc tree
In-Reply-To: <1473229821-54139-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <E1bjWYx-0002XB-Vt@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: spdif: restore register during runtime_suspend/resume cycle

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3628c6987fb45d719cd963805bbba9f15017290e Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Wed, 7 Sep 2016 14:30:21 +0800
Subject: [PATCH] ASoC: rockchip: spdif: restore register during
 runtime_suspend/resume cycle

when step into runtime_suspend, spdif pd will be disabled and loss state.
so need to restore register when runtime_resume.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_spdif.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 4ca265737eda..fa8101d1e16f 100644
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
2.8.1
