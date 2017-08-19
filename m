From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 19 Aug 2017 14:48:38 +0200
Subject: [PATCH v5 7/8] ASoC: sun4i-i2s: Update global enable with bitmask
In-Reply-To: <20170819124839.4034-1-codekipper@gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com>
Message-ID: <20170819124839.4034-8-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The default value of the config register is different on newer
SoCs and therefore enabling/disabling with a register write
will clear bits used to set the direction of the clock and frame
pins.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 573acca24a2c..19d50ca10d1f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -529,8 +529,8 @@ static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
 	/* Enable the whole hardware block */
-	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
-		     SUN4I_I2S_CTRL_GL_EN);
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
 
 	/* Enable the first output line */
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
@@ -553,7 +553,8 @@ static void sun4i_i2s_shutdown(struct snd_pcm_substream *substream,
 			   SUN4I_I2S_CTRL_SDO_EN_MASK, 0);
 
 	/* Disable the whole hardware block */
-	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG, 0);
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_GL_EN, 0);
 }
 
 static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
-- 
2.14.1
