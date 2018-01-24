From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 24 Jan 2018 15:11:00 +0100
Subject: [PATCH 2/3] ASoC: sun4i-i2s: Do not divide clocks when slave
In-Reply-To: <20180124141101.12867-1-codekipper@gmail.com>
References: <20180124141101.12867-1-codekipper@gmail.com>
Message-ID: <20180124141101.12867-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

There is no need to set the clock and calculate the division of
the audio pll for the bclk and sync signals when they are not
required.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 116 ++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 52 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d7a9141514cf..626679057d0f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -195,6 +195,8 @@ struct sun4i_i2s {
 
 	const struct sun4i_i2s_quirks	*variant;
 
+	bool bit_clk_master;
+
 	unsigned int	tdm_slots;
 	unsigned int	slot_width;
 };
@@ -282,67 +284,73 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	int bclk_div, mclk_div;
 	int ret;
 
-	switch (rate) {
-	case 176400:
-	case 88200:
-	case 44100:
-	case 22050:
-	case 11025:
-		clk_rate = 22579200;
-		break;
+	if (i2s->bit_clk_master) {
+		switch (rate) {
+		case 176400:
+		case 88200:
+		case 44100:
+		case 22050:
+		case 11025:
+			clk_rate = 22579200;
+			break;
 
-	case 192000:
-	case 128000:
-	case 96000:
-	case 64000:
-	case 48000:
-	case 32000:
-	case 24000:
-	case 16000:
-	case 12000:
-	case 8000:
-		clk_rate = 24576000;
-		break;
+		case 192000:
+		case 128000:
+		case 96000:
+		case 64000:
+		case 48000:
+		case 32000:
+		case 24000:
+		case 16000:
+		case 12000:
+		case 8000:
+			clk_rate = 24576000;
+			break;
 
-	default:
-		dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
-		return -EINVAL;
-	}
+		default:
+			dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
+			return -EINVAL;
+		}
 
-	ret = clk_set_rate(i2s->mod_clk, clk_rate);
-	if (ret)
-		return ret;
+		ret = clk_set_rate(i2s->mod_clk, clk_rate);
+		if (ret) {
+			dev_err(dai->dev, "Unable to set clock\n");
+			return ret;
+		}
 
-	oversample_rate = i2s->mclk_freq / rate;
-	if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
-		dev_err(dai->dev, "Unsupported oversample rate: %d\n",
-			oversample_rate);
-		return -EINVAL;
-	}
+		oversample_rate = i2s->mclk_freq / rate;
+		if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
+			dev_err(dai->dev, "Unsupported oversample rate: %d\n",
+				oversample_rate);
+			return -EINVAL;
+		}
 
-	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-					  word_size);
-	if (bclk_div < 0) {
-		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
-		return -EINVAL;
-	}
+		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
+						  word_size);
+		if (bclk_div < 0) {
+			dev_err(dai->dev, "Unsupported BCLK divider: %d\n",
+				bclk_div);
+			return -EINVAL;
+		}
 
-	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-					  clk_rate, rate);
-	if (mclk_div < 0) {
-		dev_err(dai->dev, "Unsupported MCLK divider: %d\n", mclk_div);
-		return -EINVAL;
-	}
+		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+						  clk_rate, rate);
+		if (mclk_div < 0) {
+			dev_err(dai->dev, "Unsupported MCLK divider: %d\n",
+				mclk_div);
+			return -EINVAL;
+		}
 
-	/* Adjust the clock division values if needed */
-	bclk_div += i2s->variant->bclk_offset;
-	mclk_div += i2s->variant->mclk_offset;
+		/* Adjust the clock division values if needed */
+		bclk_div += i2s->variant->bclk_offset;
+		mclk_div += i2s->variant->mclk_offset;
 
-	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
-		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
+		regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
+			     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
+			     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
 
-	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
+		regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
+	}
 
 	/* Set sync period */
 	if (i2s->variant->has_fmt_set_lrck_period)
@@ -501,10 +509,12 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		case SND_SOC_DAIFMT_CBS_CFS:
 			/* BCLK and LRCLK master */
 			val = SUN4I_I2S_CTRL_MODE_MASTER;
+			i2s->bit_clk_master = true;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* BCLK and LRCLK slave */
 			val = SUN4I_I2S_CTRL_MODE_SLAVE;
+			i2s->bit_clk_master = false;
 			break;
 		default:
 			dev_err(dai->dev, "Unsupported slave setting: %d\n",
@@ -525,10 +535,12 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			/* BCLK and LRCLK master */
 			val = SUN8I_I2S_CTRL_BCLK_OUT |
 				SUN8I_I2S_CTRL_LRCK_OUT;
+			i2s->bit_clk_master = true;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* BCLK and LRCLK slave */
 			val = 0;
+			i2s->bit_clk_master = false;
 			break;
 		default:
 			dev_err(dai->dev, "Unsupported slave setting: %d\n",
-- 
2.16.0
