From: broonie@kernel.org (Mark Brown)
Date: Tue,  1 May 2018 22:07:53 +0100 (BST)
Subject: Applied "ASoC: cirrus: i2s: Fix LRCLK configuration" to the asoc tree
In-Reply-To: <20180428205142.31921-2-alexander.sverdlin@gmail.com>
Message-ID: <20180501210753.DB47444007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: cirrus: i2s: Fix LRCLK configuration

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

>From 2d534113be9a2aa532a1ae127a57e83558aed358 Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date: Sat, 28 Apr 2018 22:51:38 +0200
Subject: [PATCH] ASoC: cirrus: i2s: Fix LRCLK configuration

The bit responsible for LRCLK polarity is i2s_tlrs (0), not i2s_trel (2)
(refer to "EP93xx User's Guide").

Previously card drivers which specified SND_SOC_DAIFMT_NB_IF actually got
SND_SOC_DAIFMT_NB_NF, an adaptation is necessary to retain the old
behavior.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable at vger.kernel.org
---
 sound/soc/cirrus/edb93xx.c     | 2 +-
 sound/soc/cirrus/ep93xx-i2s.c  | 8 ++++----
 sound/soc/cirrus/snappercl15.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index c53bd6f2c2d7..3d011abaa266 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -67,7 +67,7 @@ static struct snd_soc_dai_link edb93xx_dai = {
 	.cpu_dai_name	= "ep93xx-i2s",
 	.codec_name	= "spi0.0",
 	.codec_dai_name	= "cs4271-hifi",
-	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &edb93xx_ops,
 };
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 934f8aefdd90..38c240c97041 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -213,24 +213,24 @@ static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		/* Negative bit clock, lrclk low on left word */
-		clk_cfg &= ~(EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL);
+		clk_cfg &= ~(EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_LRS);
 		break;
 
 	case SND_SOC_DAIFMT_NB_IF:
 		/* Negative bit clock, lrclk low on right word */
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_CKP;
-		clk_cfg |= EP93XX_I2S_CLKCFG_REL;
+		clk_cfg |= EP93XX_I2S_CLKCFG_LRS;
 		break;
 
 	case SND_SOC_DAIFMT_IB_NF:
 		/* Positive bit clock, lrclk low on left word */
 		clk_cfg |= EP93XX_I2S_CLKCFG_CKP;
-		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
+		clk_cfg &= ~EP93XX_I2S_CLKCFG_LRS;
 		break;
 
 	case SND_SOC_DAIFMT_IB_IF:
 		/* Positive bit clock, lrclk low on right word */
-		clk_cfg |= EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL;
+		clk_cfg |= EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_LRS;
 		break;
 	}
 
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index 2334ec19e7eb..11ff7b2672b2 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -72,7 +72,7 @@ static struct snd_soc_dai_link snappercl15_dai = {
 	.codec_dai_name	= "tlv320aic23-hifi",
 	.codec_name	= "tlv320aic23-codec.0-001a",
 	.platform_name	= "ep93xx-i2s",
-	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &snappercl15_ops,
 };
-- 
2.17.0
