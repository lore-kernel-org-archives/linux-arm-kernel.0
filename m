From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Jan 2018 12:26:34 +0000
Subject: Applied "ASoC: mediatek: fix double free in
 mt2701_afe_pcm_dev_probe()" to the asoc tree
In-Reply-To: <2fd34b71f3c940186b99f799c3ed14a83ccc4bba.1516620578.git.ryder.lee@mediatek.com>
Message-ID: <E1edbBK-0004dh-Ku@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: fix double free in mt2701_afe_pcm_dev_probe()

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

>From dc2a17f4f074c434757e2cef5026d4747fe22955 Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Mon, 22 Jan 2018 19:33:05 +0800
Subject: [PATCH] ASoC: mediatek: fix double free in mt2701_afe_pcm_dev_probe()

The commit dfa3cbb8(ASoC: mediatek: modify MT2701 AFE driver to adapt mfd device)
leads to the following static checker warning:

	sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:1535 mt2701_afe_pcm_dev_probe()
	error: double free of 'component'

This patch fixes that and adds a helper mt2701_afe_add_component() to setup
component.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 32 +++++++++++++++++-------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 5bc4e00a4a29..d68b53f7cefe 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1405,9 +1405,24 @@ static int mt2701_afe_runtime_resume(struct device *dev)
 	return mt2701_afe_enable_clock(afe);
 }
 
-static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
+static int mt2701_afe_add_component(struct mtk_base_afe *afe)
 {
 	struct snd_soc_component *component;
+
+	component = kzalloc(sizeof(*component), GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+
+	component->regmap = afe->regmap;
+
+	return snd_soc_add_component(afe->dev, component,
+				     &mt2701_afe_pcm_dai_component,
+				     mt2701_afe_pcm_dais,
+				     ARRAY_SIZE(mt2701_afe_pcm_dais));
+}
+
+static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
+{
 	struct mtk_base_afe *afe;
 	struct mt2701_afe_private *afe_priv;
 	struct device *dev;
@@ -1477,12 +1492,6 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 			= &mt2701_i2s_data[i][I2S_IN];
 	}
 
-	component = kzalloc(sizeof(*component), GFP_KERNEL);
-	if (!component)
-		return -ENOMEM;
-
-	component->regmap = afe->regmap;
-
 	afe->mtk_afe_hardware = &mt2701_afe_hardware;
 	afe->memif_fs = mt2701_memif_fs;
 	afe->irq_fs = mt2701_irq_fs;
@@ -1495,7 +1504,7 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	ret = mt2701_init_clock(afe);
 	if (ret) {
 		dev_err(dev, "init clock error\n");
-		goto err_init_clock;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, afe);
@@ -1514,10 +1523,7 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_platform;
 	}
 
-	ret = snd_soc_add_component(dev, component,
-				    &mt2701_afe_pcm_dai_component,
-				    mt2701_afe_pcm_dais,
-				    ARRAY_SIZE(mt2701_afe_pcm_dais));
+	ret = mt2701_afe_add_component(afe);
 	if (ret) {
 		dev_warn(dev, "err_dai_component\n");
 		goto err_dai_component;
@@ -1531,8 +1537,6 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 err_pm_disable:
 	pm_runtime_disable(dev);
-err_init_clock:
-	kfree(component);
 
 	return ret;
 }
-- 
2.15.1
