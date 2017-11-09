From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Nov 2017 10:40:46 +0100
Subject: [PATCH] ASoC: sun8i-codec: Add a comment on the LRCK inversion
Message-ID: <20171109094046.13483-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code might be a bit intriguing without having experienced the
issue before, and might come up as a mistake.

Make explicit what's going on by adding a comment.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun8i-codec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 7a312168f864..3dd183be08a4 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -198,6 +198,17 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
2.14.3
