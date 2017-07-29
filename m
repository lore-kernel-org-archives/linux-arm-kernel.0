From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 29 Jul 2017 16:17:49 +0200
Subject: [PATCH v3 08/12] ASoC: sun4i-i2s: Add mclk enable regmap field
In-Reply-To: <20170729141753.20174-1-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
Message-ID: <20170729141753.20174-9-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The location of the mclk output enable bit is different on newer
SoCs. Use a regmap field to enable it.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 90daa974bd27..6d8d2c4a675b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -74,7 +74,7 @@
 #define SUN4I_I2S_INT_STA_REG		0x20
 
 #define SUN4I_I2S_CLK_DIV_REG		0x24
-#define SUN4I_I2S_CLK_DIV_MCLK_EN		BIT(7)
+#define SUN4I_I2S_CLK_DIV_MCLK_EN		7
 #define SUN4I_I2S_CLK_DIV_BCLK_MASK		GENMASK(6, 4)
 #define SUN4I_I2S_CLK_DIV_BCLK(bclk)			((bclk) << 4)
 #define SUN4I_I2S_CLK_DIV_MCLK_MASK		GENMASK(3, 0)
@@ -101,6 +101,7 @@
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
  * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  * @fmt_offset: Value by which wss and sr needs to be adjusted.
+ * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_set_wss: regmap field to set word select size.
  * @field_fmt_set_sr: regmap field to set sample resolution.
  * @field_fmt_set_bclk_polarity: regmap field to set clk polarity.
@@ -119,6 +120,7 @@ struct sun4i_i2s_quirks {
 	unsigned int			fmt_offset;
 
 	/* Register fields for i2s */
+	struct reg_field		field_clkdiv_mclk_en;
 	struct reg_field		field_fmt_set_wss;
 	struct reg_field		field_fmt_set_sr;
 	struct reg_field		field_fmt_set_bclk_polarity;
@@ -141,6 +143,7 @@ struct sun4i_i2s {
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 
 	/* Register fields for i2s */
+	struct regmap_field	*field_clkdiv_mclk_en;
 	struct regmap_field	*field_fmt_set_wss;
 	struct regmap_field	*field_fmt_set_sr;
 	struct regmap_field	*field_fmt_set_bclk_polarity;
@@ -279,8 +282,9 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
 		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK_EN);
+		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
+
+	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
 
 	return 0;
 }
@@ -710,6 +714,9 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_reset		= false,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG,
+					    SUN4I_I2S_CLK_DIV_MCLK_EN,
+					    SUN4I_I2S_CLK_DIV_MCLK_EN),
 	.field_fmt_set_wss	= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_set_sr	= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_set_bclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
@@ -724,6 +731,9 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG,
+					    SUN4I_I2S_CLK_DIV_MCLK_EN,
+					    SUN4I_I2S_CLK_DIV_MCLK_EN),
 	.field_fmt_set_wss	= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_set_sr	= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_set_bclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
@@ -760,6 +770,12 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev, struct sun4i_i2s *i2
 	if (IS_ERR(i2s->field_fmt_set_lrclk_polarity))
 		return PTR_ERR(i2s->field_fmt_set_lrclk_polarity);
 
+	i2s->field_clkdiv_mclk_en =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->variant->field_clkdiv_mclk_en);
+	if (IS_ERR(i2s->field_clkdiv_mclk_en))
+		return PTR_ERR(i2s->field_clkdiv_mclk_en);
+
 	i2s->field_txchanmap =
 		devm_regmap_field_alloc(dev, i2s->regmap,
 					i2s->variant->field_txchanmap);
-- 
2.13.3
