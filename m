From: broonie@kernel.org (Mark Brown)
Date: Wed, 08 Nov 2017 21:33:51 +0000
Subject: Applied "ASoC: sun8i-codec: Fix left and right channels inversion" to
 the asoc tree
In-Reply-To: <20171108154710.16407-4-maxime.ripard@free-electrons.com>
Message-ID: <E1eCXyp-0005cC-G2@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: Fix left and right channels inversion

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

>From 18c1bf35c1c09bca05cf70bc984a4764e0b0372b Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 8 Nov 2017 16:47:10 +0100
Subject: [PATCH] ASoC: sun8i-codec: Fix left and right channels inversion

Since its introduction, the codec had an inversion of the left and right
channels. It turned out to be pretty simple as it appears that the codec
doesn't have the same polarity on the LRCK signal than the I2S block.

Fix this by inverting our bit value for the LRCK inversion.

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Cc: <stable@vger.kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 038107baf414..c2ceca485d6a 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -199,7 +199,7 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			   value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
-			   value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
+			   !value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
 
 	/* DAI format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-- 
2.15.0
