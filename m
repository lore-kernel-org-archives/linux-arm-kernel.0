From: broonie@kernel.org (Mark Brown)
Date: Thu, 09 Nov 2017 17:44:14 +0000
Subject: Applied "ASoC: sun8i-codec: Add a comment on the LRCK inversion" to
 the asoc tree
In-Reply-To: <20171109094046.13483-1-maxime.ripard@free-electrons.com>
Message-ID: <E1eCqsA-0006j3-Fj@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: Add a comment on the LRCK inversion

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

>From e7b8a6d3efa8316dfe786e9cd559c62e9152337c Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 9 Nov 2017 10:40:46 +0100
Subject: [PATCH] ASoC: sun8i-codec: Add a comment on the LRCK inversion

The current code might be a bit intriguing without having experienced the
issue before, and might come up as a mistake.

Make explicit what's going on by adding a comment.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index c2ceca485d6a..b3329692e3dc 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -197,6 +197,17 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV),
 			   value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
+
+	/*
+	 * It appears that the DAI and the codec don't share the same
+	 * polarity for the LRCK signal when they mean 'normal' and
+	 * 'inverted' in the datasheet.
+	 *
+	 * Since the DAI here is our regular i2s driver that have been
+	 * tested with way more codecs than just this one, it means
+	 * that the codec probably gets it backward, and we have to
+	 * invert the value here.
+	 */
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
 			   !value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
-- 
2.15.0
