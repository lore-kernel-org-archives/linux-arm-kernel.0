From: broonie@kernel.org (Mark Brown)
Date: Wed, 03 Jan 2018 12:12:44 +0000
Subject: Applied "ASoC: mediatek: fix error handling in
 mt2701_afe_pcm_dev_probe()" to the asoc tree
In-Reply-To: <6081b70610c31f2c92ae1b83decb887a3f690f80.1514881870.git.ryder.lee@mediatek.com>
Message-ID: <E1eWhuW-0001Yu-G4@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: fix error handling in mt2701_afe_pcm_dev_probe()

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

>From dd6bb9b16f23f9b95b77713c45bd6182336c5b2e Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Tue, 2 Jan 2018 19:47:18 +0800
Subject: [PATCH] ASoC: mediatek: fix error handling in
 mt2701_afe_pcm_dev_probe()

Fix unbalanced error handling path which will get incorrect counts
if probe failed. The .remove() should be adjusted accordingly.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Tested-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 31 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 8fda182f849b..a7362d1cda1b 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1590,12 +1590,16 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, afe);
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		goto err_pm_disable;
-	pm_runtime_get_sync(&pdev->dev);
 
-	ret = snd_soc_register_platform(&pdev->dev, &mtk_afe_pcm_platform);
+	pm_runtime_enable(dev);
+	if (!pm_runtime_enabled(dev)) {
+		ret = mt2701_afe_runtime_resume(dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+	pm_runtime_get_sync(dev);
+
+	ret = snd_soc_register_platform(dev, &mtk_afe_pcm_platform);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
 		goto err_platform;
@@ -1610,35 +1614,28 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_dai_component;
 	}
 
-	mt2701_afe_runtime_resume(&pdev->dev);
-
 	return 0;
 
 err_dai_component:
-	snd_soc_unregister_component(&pdev->dev);
-
+	snd_soc_unregister_platform(dev);
 err_platform:
-	snd_soc_unregister_platform(&pdev->dev);
-
+	pm_runtime_put_sync(dev);
 err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 
 	return ret;
 }
 
 static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
-
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt2701_afe_runtime_suspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
 
 	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_unregister_platform(&pdev->dev);
-	/* disable afe clock */
-	mt2701_afe_disable_clock(afe);
+
 	return 0;
 }
 
-- 
2.15.1
