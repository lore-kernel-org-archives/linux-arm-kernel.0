From: broonie@kernel.org (Mark Brown)
Date: Mon, 08 Jan 2018 12:35:35 +0000
Subject: Applied "ASoC: mediatek: mt2701: fix return value check in
 mt2701_afe_pcm_dev_probe()" to the asoc tree
In-Reply-To: <1515377701-37553-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <E1eYWeN-0003J4-DW@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: mt2701: fix return value check in mt2701_afe_pcm_dev_probe()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3e8052d90d24320a1edb556c20523f3b17195985 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 8 Jan 2018 02:15:01 +0000
Subject: [PATCH] ASoC: mediatek: mt2701: fix return value check in
 mt2701_afe_pcm_dev_probe()

In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: dfa3cbb83e09 ("ASoC: mediatek: modify MT2701 AFE driver to adapt mfd device")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index f0cd08fa5c5d..5bc4e00a4a29 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1440,9 +1440,9 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	}
 
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
-	if (!afe->regmap) {
+	if (IS_ERR(afe->regmap)) {
 		dev_err(dev, "could not get regmap from parent\n");
-		return -ENODEV;
+		return PTR_ERR(afe->regmap);
 	}
 
 	mutex_init(&afe->irq_alloc_lock);
-- 
2.15.1
