From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 12 Aug 2017 13:00:53 +0200
Subject: [PATCH v3 05/11] ASoC: sun4i-i2s: Add regfields for word size select
 and sample resolution
In-Reply-To: <20170812110059.5115-1-codekipper@gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
Message-ID: <20170812110059.5115-6-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

On newer SoCs the location of the slot width select and sample
resolution are different and also there is a bigger range of
support.

For the current supported rates then an offset is required.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a65dcb013247..482fe0c65c1f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -98,6 +98,9 @@
  * @sun4i_i2s_regmap: regmap config to use.
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
  * @bclk_offset: Value by which bclkdiv needs to be adjusted.
+ * @fmt_offset: Value by which wss and sr needs to be adjusted.
+ * @field_fmt_wss: regmap field to set word select size.
+ * @field_fmt_sr: regmap field to set sample resolution.
  * @field_txchanmap: location of the tx channel mapping register.
  * @field_rxchanmap: location of the rx channel mapping register.
  * @field_txchansel: location of the tx channel select bit fields.
@@ -109,8 +112,11 @@ struct sun4i_i2s_quirks {
 	const struct regmap_config	*sun4i_i2s_regmap;
 	unsigned int			mclk_offset;
 	unsigned int			bclk_offset;
+	unsigned int			fmt_offset;
 
 	/* Register fields for i2s */
+	struct reg_field		field_fmt_wss;
+	struct reg_field		field_fmt_sr;
 	struct reg_field		field_txchanmap;
 	struct reg_field		field_rxchanmap;
 	struct reg_field		field_txchansel;
@@ -129,6 +135,8 @@ struct sun4i_i2s {
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 
 	/* Register fields for i2s */
+	struct regmap_field	*field_fmt_wss;
+	struct regmap_field	*field_fmt_sr;
 	struct regmap_field	*field_txchanmap;
 	struct regmap_field	*field_rxchanmap;
 	struct regmap_field	*field_txchansel;
@@ -314,9 +322,10 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN4I_I2S_FMT0_WSS_MASK | SUN4I_I2S_FMT0_SR_MASK,
-			   SUN4I_I2S_FMT0_WSS(wss) | SUN4I_I2S_FMT0_SR(sr));
+	regmap_field_write(i2s->field_fmt_wss,
+			   wss + i2s->variant->fmt_offset);
+	regmap_field_write(i2s->field_fmt_sr,
+			   sr + i2s->variant->fmt_offset);
 
 	return sun4i_i2s_set_clk_rate(i2s, params_rate(params),
 				      params_width(params));
@@ -701,6 +710,8 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_reset		= false,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
+	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -711,6 +722,8 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
+	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -748,6 +761,20 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 		ret = PTR_ERR_OR_ZERO(i2s->field_rxchansel);
 	}
 
+	if (!ret) {
+		i2s->field_fmt_wss =
+			devm_regmap_field_alloc(dev, i2s->regmap,
+						i2s->variant->field_fmt_wss);
+		ret = PTR_ERR_OR_ZERO(i2s->field_fmt_wss);
+	}
+
+	if (!ret) {
+		i2s->field_fmt_sr =
+			devm_regmap_field_alloc(dev, i2s->regmap,
+						i2s->variant->field_fmt_sr);
+		ret = PTR_ERR_OR_ZERO(i2s->field_fmt_sr);
+	}
+
 	return ret;
 }
 
-- 
2.14.1
