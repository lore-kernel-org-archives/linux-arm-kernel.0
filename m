From: broonie@kernel.org (Mark Brown)
Date: Tue, 03 Jul 2018 16:33:57 +0100
Subject: Applied "ASoC: atmel-i2s: Remove unnecessary audio PLL clock (aclk)"
 to the asoc tree
In-Reply-To: <20180703145631.15246-2-codrin.ciubotariu@microchip.com>
Message-ID: <E1faNJV-0003et-Ai@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: atmel-i2s: Remove unnecessary audio PLL clock (aclk)

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

>From 73ad0df572901e03fc703b6f114e4442291f45c2 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 3 Jul 2018 17:56:30 +0300
Subject: [PATCH] ASoC: atmel-i2s: Remove unnecessary audio PLL clock (aclk)

The generated clock (gclk) driver is able to set aclk as its parent and
change its rate alone, if needed. This means that our driver no longer
needs to configure aclk and we can let gclk select and configure its
clock source.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-i2s.c | 46 ++++++-------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index 5d3b5af9fd92..d88c1d995036 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -206,7 +206,6 @@ struct atmel_i2s_dev {
 	struct regmap				*regmap;
 	struct clk				*pclk;
 	struct clk				*gclk;
-	struct clk				*aclk;
 	struct snd_dmaengine_dai_dma_data	playback;
 	struct snd_dmaengine_dai_dma_data	capture;
 	unsigned int				fmt;
@@ -303,7 +302,7 @@ static int atmel_i2s_get_gck_param(struct atmel_i2s_dev *dev, int fs)
 {
 	int i, best;
 
-	if (!dev->gclk || !dev->aclk) {
+	if (!dev->gclk) {
 		dev_err(dev->dev, "cannot generate the I2S Master Clock\n");
 		return -EINVAL;
 	}
@@ -421,7 +420,7 @@ static int atmel_i2s_switch_mck_generator(struct atmel_i2s_dev *dev,
 					  bool enabled)
 {
 	unsigned int mr, mr_mask;
-	unsigned long aclk_rate;
+	unsigned long gclk_rate;
 	int ret;
 
 	mr = 0;
@@ -445,35 +444,18 @@ static int atmel_i2s_switch_mck_generator(struct atmel_i2s_dev *dev,
 		/* Disable/unprepare the PMC generated clock. */
 		clk_disable_unprepare(dev->gclk);
 
-		/* Disable/unprepare the PLL audio clock. */
-		clk_disable_unprepare(dev->aclk);
 		return 0;
 	}
 
 	if (!dev->gck_param)
 		return -EINVAL;
 
-	aclk_rate = dev->gck_param->mck * (dev->gck_param->imckdiv + 1);
+	gclk_rate = dev->gck_param->mck * (dev->gck_param->imckdiv + 1);
 
-	/* Fist change the PLL audio clock frequency ... */
-	ret = clk_set_rate(dev->aclk, aclk_rate);
+	ret = clk_set_rate(dev->gclk, gclk_rate);
 	if (ret)
 		return ret;
 
-	/*
-	 * ... then set the PMC generated clock rate to the very same frequency
-	 * to set the gclk parent to aclk.
-	 */
-	ret = clk_set_rate(dev->gclk, aclk_rate);
-	if (ret)
-		return ret;
-
-	/* Prepare and enable the PLL audio clock first ... */
-	ret = clk_prepare_enable(dev->aclk);
-	if (ret)
-		return ret;
-
-	/* ... then prepare and enable the PMC generated clock. */
 	ret = clk_prepare_enable(dev->gclk);
 	if (ret)
 		return ret;
@@ -668,28 +650,14 @@ static int atmel_i2s_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	/* Get audio clocks to generate the I2S Master Clock (I2S_MCK) */
-	dev->aclk = devm_clk_get(&pdev->dev, "aclk");
+	/* Get audio clock to generate the I2S Master Clock (I2S_MCK) */
 	dev->gclk = devm_clk_get(&pdev->dev, "gclk");
-	if (IS_ERR(dev->aclk) && IS_ERR(dev->gclk)) {
-		if (PTR_ERR(dev->aclk) == -EPROBE_DEFER ||
-		    PTR_ERR(dev->gclk) == -EPROBE_DEFER)
+	if (IS_ERR(dev->gclk)) {
+		if (PTR_ERR(dev->gclk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		/* Master Mode not supported */
-		dev->aclk = NULL;
 		dev->gclk = NULL;
-	} else if (IS_ERR(dev->gclk)) {
-		err = PTR_ERR(dev->gclk);
-		dev_err(&pdev->dev,
-			"failed to get the PMC generated clock: %d\n", err);
-		return err;
-	} else if (IS_ERR(dev->aclk)) {
-		err = PTR_ERR(dev->aclk);
-		dev_err(&pdev->dev,
-			"failed to get the PLL audio clock: %d\n", err);
-		return err;
 	}
-
 	dev->dev = &pdev->dev;
 	dev->regmap = regmap;
 	platform_set_drvdata(pdev, dev);
-- 
2.18.0.rc2
