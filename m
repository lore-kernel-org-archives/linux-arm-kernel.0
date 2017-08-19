From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 19 Aug 2017 14:48:35 +0200
Subject: [PATCH v5 4/8] ASoC: sun4i-i2s: Add mclk enable regmap field
In-Reply-To: <20170819124839.4034-1-codekipper@gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com>
Message-ID: <20170819124839.4034-5-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The location of the mclk output enable bit is different on newer
SoCs. Use a regmap field to enable it.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8c7ad5bfe821..761b7c0f6a32 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -101,6 +101,7 @@
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
  * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  * @fmt_offset: Value by which wss and sr needs to be adjusted.
+ * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
  * @field_fmt_bclk: regmap field to set clk polarity.
@@ -119,6 +120,7 @@ struct sun4i_i2s_quirks {
 	unsigned int			fmt_offset;
 
 	/* Register fields for i2s */
+	struct reg_field		field_clkdiv_mclk_en;
 	struct reg_field		field_fmt_wss;
 	struct reg_field		field_fmt_sr;
 	struct reg_field		field_fmt_bclk;
@@ -141,6 +143,7 @@ struct sun4i_i2s {
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 
 	/* Register fields for i2s */
+	struct regmap_field	*field_clkdiv_mclk_en;
 	struct regmap_field	*field_fmt_wss;
 	struct regmap_field	*field_fmt_sr;
 	struct regmap_field	*field_fmt_bclk;
@@ -283,8 +286,9 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
 		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK_EN);
+		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
+
+	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
 
 	return 0;
 }
@@ -713,6 +717,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_reset		= false,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
@@ -727,6 +732,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
@@ -740,6 +746,12 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
 					struct sun4i_i2s *i2s)
 {
+	i2s->field_clkdiv_mclk_en =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->variant->field_clkdiv_mclk_en);
+	if (IS_ERR(i2s->field_clkdiv_mclk_en))
+		return PTR_ERR(i2s->field_clkdiv_mclk_en);
+
 	i2s->field_fmt_wss =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_fmt_wss);
-- 
2.14.1
