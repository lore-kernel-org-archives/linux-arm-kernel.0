From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Sep 2016 20:06:57 +0100
Subject: Applied "ASoC: rockchip: i2s: restore register during
 runtime_suspend/resume cycle" to the asoc tree
In-Reply-To: <1473229653-53789-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <E1bjWZF-0002YT-2V@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: i2s: restore register during runtime_suspend/resume cycle

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

>From f0447f6cbb202e1be8244d15aee390a96d65e490 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Wed, 7 Sep 2016 14:27:33 +0800
Subject: [PATCH] ASoC: rockchip: i2s: restore register during
 runtime_suspend/resume cycle

when step into runtime_suspend, i2s pd will be disabled and loss state.
so need to restore register when runtime_resume.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 652e8c5ea166..974915cb4c4f 100644
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
2.8.1
