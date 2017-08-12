From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 12 Aug 2017 13:00:56 +0200
Subject: [PATCH v3 08/11] ASoC: sun4i-i2s: Add regmap field to set DAI format
In-Reply-To: <20170812110059.5115-1-codekipper@gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
Message-ID: <20170812110059.5115-9-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

On the newer SoCs the bits to configure the operational mode are
located in a different register. Add a regmap field so that this
location can be configured.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 33af99076d62..b61ef87d0049 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -106,6 +106,7 @@
  * @field_fmt_sr: regmap field to set sample resolution.
  * @field_fmt_bclk: regmap field to set clk polarity.
  * @field_fmt_lrclk: regmap field to set frame polarity.
+ * @field_fmt_mode: regmap field to set the operational mode.
  * @field_txchanmap: location of the tx channel mapping register.
  * @field_rxchanmap: location of the rx channel mapping register.
  * @field_txchansel: location of the tx channel select bit fields.
@@ -125,6 +126,7 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_fmt_sr;
 	struct reg_field		field_fmt_bclk;
 	struct reg_field		field_fmt_lrclk;
+	struct reg_field		field_fmt_mode;
 	struct reg_field		field_txchanmap;
 	struct reg_field		field_rxchanmap;
 	struct reg_field		field_txchansel;
@@ -148,6 +150,7 @@ struct sun4i_i2s {
 	struct regmap_field	*field_fmt_sr;
 	struct regmap_field	*field_fmt_bclk;
 	struct regmap_field	*field_fmt_lrclk;
+	struct regmap_field	*field_fmt_mode;
 	struct regmap_field	*field_txchanmap;
 	struct regmap_field	*field_rxchanmap;
 	struct regmap_field	*field_txchansel;
@@ -365,9 +368,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN4I_I2S_FMT0_FMT_MASK,
-			   val);
+	regmap_field_write(i2s->field_fmt_mode, val);
 
 	/* DAI clock polarity */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -722,6 +723,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -737,6 +739,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -781,6 +784,13 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 		ret = PTR_ERR_OR_ZERO(i2s->field_rxchansel);
 	}
 
+	if (!ret) {
+		i2s->field_fmt_mode =
+			devm_regmap_field_alloc(dev, i2s->regmap,
+						i2s->variant->field_fmt_mode);
+		ret = PTR_ERR_OR_ZERO(i2s->field_fmt_mode);
+	}
+
 	if (!ret) {
 		i2s->field_fmt_wss =
 			devm_regmap_field_alloc(dev, i2s->regmap,
-- 
2.14.1
