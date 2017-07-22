From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 22 Jul 2017 08:53:52 +0200
Subject: [PATCH v2 2/2] ASoC: sun4i-i2s: Add support for H3
In-Reply-To: <20170722065352.7635-1-codekipper@gmail.com>
References: <20170722065352.7635-1-codekipper@gmail.com>
Message-ID: <20170722065352.7635-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The sun8i-h3 introduces a lot of changes to the i2s block such
as different register locations, extended clock division and
more operational modes. As we have to consider the earlier
implementation then these changes need to be isolated.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
 sound/soc/sunxi/sun4i-i2s.c                        | 202 +++++++++++++++++++++
 2 files changed, 204 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index ee21da865771..fc5da6080759 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible: should be one of the following:
    - "allwinner,sun4i-a10-i2s"
    - "allwinner,sun6i-a31-i2s"
+   - "allwinner,sun8i-h3-i2s"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
@@ -22,6 +23,7 @@ Required properties:
 
 Required properties for the following compatibles:
 	- "allwinner,sun6i-a31-i2s"
+	- "allwinner,sun8i-h3-i2s"
 - resets: phandle to the reset line for this codec
 
 Example:
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 1854405cbcb1..2b3c2b28059c 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -26,6 +26,8 @@
 #include <sound/soc-dai.h>
 
 #define SUN4I_I2S_CTRL_REG		0x00
+#define SUN8I_I2S_CTRL_BCLK_OUT			BIT(18)
+#define SUN8I_I2S_CTRL_LRCK_OUT			BIT(17)
 #define SUN4I_I2S_CTRL_SDO_EN_MASK		GENMASK(11, 8)
 #define SUN4I_I2S_CTRL_SDO_EN(sdo)			BIT(8 + (sdo))
 #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
@@ -55,6 +57,7 @@
 
 #define SUN4I_I2S_FMT1_REG		0x08
 #define SUN4I_I2S_FIFO_TX_REG		0x0c
+#define SUN8I_I2S_INT_STA_REG		0x0c
 #define SUN4I_I2S_FIFO_RX_REG		0x10
 
 #define SUN4I_I2S_FIFO_CTRL_REG		0x14
@@ -72,8 +75,10 @@
 #define SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN	BIT(3)
 
 #define SUN4I_I2S_INT_STA_REG		0x20
+#define SUN8I_I2S_FIFO_TX_REG		0x20
 
 #define SUN4I_I2S_CLK_DIV_REG		0x24
+#define SUN8I_I2S_CLK_DIV_MCLK_EN		8
 #define SUN4I_I2S_CLK_DIV_MCLK_EN		7
 #define SUN4I_I2S_CLK_DIV_BCLK_MASK		GENMASK(6, 4)
 #define SUN4I_I2S_CLK_DIV_BCLK(bclk)			((bclk) << 4)
@@ -86,16 +91,29 @@
 #define SUN4I_I2S_TX_CHAN_SEL_REG	0x30
 #define SUN4I_I2S_CHAN_SEL(num_chan)		(((num_chan) - 1) << 0)
 
+#define SUN8I_I2S_CHAN_CFG_REG		0x30
+
 #define SUN4I_I2S_TX_CHAN_MAP_REG	0x34
 #define SUN4I_I2S_TX_CHAN_MAP(chan, sample)	((sample) << (chan << 2))
+#define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
+#define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN4I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1))
 
 #define SUN4I_I2S_RX_CHAN_SEL_REG	0x38
 #define SUN4I_I2S_RX_CHAN_MAP_REG	0x3c
 
+#define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
+
+#define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
+#define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
+
 struct sun4i_i2s_quirks {
 	bool				has_reset;
 	bool				has_master_slave_sel;
+	bool				has_fmt_set_lrck_period;
+	bool				has_chcfg;
+	bool				has_chsel_tx_chen;
+	bool				has_chsel_offset;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	unsigned int			reg_offset_txchanmap;
 	unsigned int			reg_offset_rxchanmap;
@@ -113,6 +131,11 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_fmt_set_mode;
 	struct reg_field		field_txchansel;
 	struct reg_field		field_rxchansel;
+	struct reg_field		field_fmt_set_lrck_period;
+	struct reg_field		field_chcfg_tx_slot_num;
+	struct reg_field		field_chcfg_rx_slot_num;
+	struct reg_field		field_chsel_tx_chen;
+	struct reg_field		field_chsel_offset;
 };
 
 struct sun4i_i2s {
@@ -136,6 +159,11 @@ struct sun4i_i2s {
 	struct regmap_field	*field_fmt_set_mode;
 	struct regmap_field	*field_txchansel;
 	struct regmap_field	*field_rxchansel;
+	struct regmap_field	*field_fmt_set_lrck_period;
+	struct regmap_field	*field_chcfg_tx_slot_num;
+	struct regmap_field	*field_chcfg_rx_slot_num;
+	struct regmap_field	*field_chsel_tx_chen;
+	struct regmap_field	*field_chsel_offset;
 
 	const struct sun4i_i2s_quirks	*variant;
 };
@@ -152,6 +180,14 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
 	{ .div = 8, .val = 3 },
 	{ .div = 12, .val = 4 },
 	{ .div = 16, .val = 5 },
+	{ .div = 24, .val = 6 },
+	{ .div = 32, .val = 7 },
+	{ .div = 48, .val = 8 },
+	{ .div = 64, .val = 9 },
+	{ .div = 96, .val = 10 },
+	{ .div = 128, .val = 11 },
+	{ .div = 176, .val = 12 },
+	{ .div = 192, .val = 13 },
 };
 
 static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
@@ -163,6 +199,13 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
 	{ .div = 12, .val = 5 },
 	{ .div = 16, .val = 6 },
 	{ .div = 24, .val = 7 },
+	{ .div = 32, .val = 8 },
+	{ .div = 48, .val = 9 },
+	{ .div = 64, .val = 10 },
+	{ .div = 96, .val = 11 },
+	{ .div = 128, .val = 12 },
+	{ .div = 176, .val = 13 },
+	{ .div = 192, .val = 14 },
 };
 
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
@@ -270,6 +313,10 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 
 	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
 
+	/* Set sync period */
+	if (i2s->variant->has_fmt_set_lrck_period)
+		regmap_field_write(i2s->field_fmt_set_lrck_period, 0x1f);
+
 	return 0;
 }
 
@@ -284,6 +331,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (params_channels(params) != 2)
 		return -EINVAL;
 
+	if (i2s->variant->has_chcfg) {
+		regmap_field_write(i2s->field_chcfg_tx_slot_num,
+				   params_channels(params) - 1);
+		regmap_field_write(i2s->field_chcfg_rx_slot_num,
+				   params_channels(params) - 1);
+	}
+
 	/* Map the channels for playback */
 	regmap_write(i2s->regmap, i2s->variant->reg_offset_txchanmap,
 		     0x76543210);
@@ -299,6 +353,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_rxchansel,
 			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
 
+	if (i2s->variant->has_chsel_tx_chen)
+		regmap_field_write(i2s->field_chsel_tx_chen,
+				   SUN4I_I2S_TX_CHAN_EN(params_channels(params)));
 
 	switch (params_physical_width(params)) {
 	case 16:
@@ -332,6 +389,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	u32 val;
+	u32 offset = 0;
 	u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 	u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 
@@ -339,6 +397,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		val = SUN4I_I2S_FMT0_FMT_I2S;
+		offset = 1;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		val = SUN4I_I2S_FMT0_FMT_LEFT_J;
@@ -350,6 +409,19 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	if (i2s->variant->has_chsel_offset) {
+		/*
+		 * offset being set indicates that we're connected to an i2s
+		 * device, however offset is only used on the sun8i block and
+		 * i2s shares the same setting with the LJ format. Increment
+		 * val so that the bit to value to write is correct.
+		 */
+		if (offset > 0)
+			val++;
+		/* blck offset determines whether i2s or LJ */
+		regmap_field_write(i2s->field_chsel_offset, offset);
+	}
+
 	regmap_field_write(i2s->field_fmt_set_mode, val);
 
 	/* DAI clock polarity */
@@ -393,6 +465,29 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
 				   SUN4I_I2S_CTRL_MODE_MASK,
 				   val);
+	} else {
+		/*
+		 * The newer i2s block does not have a slave select bit,
+		 * instead the clk pins are configured as inputs.
+		 */
+		/* DAI clock master masks */
+		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+		case SND_SOC_DAIFMT_CBS_CFS:
+			/* BCLK and LRCLK master */
+			val = SUN8I_I2S_CTRL_BCLK_OUT |
+				SUN8I_I2S_CTRL_LRCK_OUT;
+			break;
+		case SND_SOC_DAIFMT_CBM_CFM:
+			/* BCLK and LRCLK slave */
+			val = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+				   SUN8I_I2S_CTRL_BCLK_OUT |
+				   SUN8I_I2S_CTRL_LRCK_OUT,
+				   val);
 	}
 
 	/* Set significant bits in our FIFOs */
@@ -642,6 +737,15 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
+{
+
+	if (reg == SUN8I_I2S_INT_STA_REG)
+		return true;
+
+	return sun4i_i2s_volatile_reg(dev, reg);
+}
+
 static const struct reg_default sun4i_i2s_reg_defaults[] = {
 	{ SUN4I_I2S_CTRL_REG, 0x00000000 },
 	{ SUN4I_I2S_FMT0_REG, 0x0000000c },
@@ -655,6 +759,20 @@ static const struct reg_default sun4i_i2s_reg_defaults[] = {
 	{ SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210 },
 };
 
+static const struct reg_default sun8i_i2s_reg_defaults[] = {
+	{ SUN4I_I2S_CTRL_REG, 0x00060000 },
+	{ SUN4I_I2S_FMT0_REG, 0x00000033 },
+	{ SUN4I_I2S_FMT1_REG, 0x00000030 },
+	{ SUN4I_I2S_FIFO_CTRL_REG, 0x000400f0 },
+	{ SUN4I_I2S_DMA_INT_CTRL_REG, 0x00000000 },
+	{ SUN4I_I2S_CLK_DIV_REG, 0x00000000 },
+	{ SUN8I_I2S_CHAN_CFG_REG, 0x00000000 },
+	{ SUN8I_I2S_TX_CHAN_SEL_REG, 0x00000000 },
+	{ SUN8I_I2S_TX_CHAN_MAP_REG, 0x00000000 },
+	{ SUN8I_I2S_RX_CHAN_SEL_REG, 0x00000000 },
+	{ SUN8I_I2S_RX_CHAN_MAP_REG, 0x00000000 },
+};
+
 static const struct regmap_config sun4i_i2s_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -669,6 +787,19 @@ static const struct regmap_config sun4i_i2s_regmap_config = {
 	.volatile_reg	= sun4i_i2s_volatile_reg,
 };
 
+static const struct regmap_config sun8i_i2s_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN8I_I2S_RX_CHAN_MAP_REG,
+	.cache_type	= REGCACHE_FLAT,
+	.reg_defaults	= sun8i_i2s_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(sun8i_i2s_reg_defaults),
+	.writeable_reg	= sun4i_i2s_wr_reg,
+	.readable_reg	= sun4i_i2s_rd_reg,
+	.volatile_reg	= sun8i_i2s_volatile_reg,
+};
+
 static int sun4i_i2s_runtime_resume(struct device *dev)
 {
 	struct sun4i_i2s *i2s = dev_get_drvdata(dev);
@@ -745,6 +876,36 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 };
 
+static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
+	.has_reset		= true,
+	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
+	.reg_offset_txchanmap	= SUN8I_I2S_TX_CHAN_MAP_REG,
+	.reg_offset_rxchanmap	= SUN8I_I2S_RX_CHAN_MAP_REG,
+	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
+	.mclk_adjust		= 1,
+	.bclk_adjust		= 2,
+	.fmt_adjust		= 3,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG,
+					    SUN8I_I2S_CLK_DIV_MCLK_EN,
+					    SUN8I_I2S_CLK_DIV_MCLK_EN),
+	.has_fmt_set_lrck_period = true,
+	.field_fmt_set_lrck_period = REG_FIELD(SUN4I_I2S_FMT0_REG, 8, 17),
+	.has_chcfg		= true,
+	.field_chcfg_tx_slot_num = REG_FIELD(SUN8I_I2S_CHAN_CFG_REG, 0, 2),
+	.field_chcfg_rx_slot_num = REG_FIELD(SUN8I_I2S_CHAN_CFG_REG, 4, 6),
+	.has_chsel_tx_chen	= true,
+	.field_chsel_tx_chen	= REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 4, 11),
+	.has_chsel_offset	= true,
+	.field_chsel_offset	= REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 12, 13),
+	.field_fmt_set_wss	= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
+	.field_fmt_set_sr	= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
+	.field_fmt_set_bclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.field_fmt_set_lrclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
+	.field_fmt_set_mode	= REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
+	.field_txchansel	= REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
+	.field_rxchansel	= REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
+};
+
 static int sun4i_i2s_init_regmap_fields(struct sun4i_i2s *i2s)
 {
 	i2s->field_fmt_set_wss =
@@ -795,6 +956,43 @@ static int sun4i_i2s_init_regmap_fields(struct sun4i_i2s *i2s)
 	if (IS_ERR(i2s->field_rxchansel))
 		return PTR_ERR(i2s->field_rxchansel);
 
+	if (i2s->variant->has_fmt_set_lrck_period) {
+		i2s->field_fmt_set_lrck_period =
+			devm_regmap_field_alloc(i2s->dev, i2s->regmap,
+				i2s->variant->field_fmt_set_lrck_period);
+		if (IS_ERR(i2s->field_fmt_set_lrck_period))
+			return PTR_ERR(i2s->field_fmt_set_lrck_period);
+	}
+
+	if (i2s->variant->has_chcfg) {
+		i2s->field_chcfg_tx_slot_num =
+			devm_regmap_field_alloc(i2s->dev, i2s->regmap,
+				i2s->variant->field_chcfg_tx_slot_num);
+		if (IS_ERR(i2s->field_chcfg_tx_slot_num))
+			return PTR_ERR(i2s->field_chcfg_tx_slot_num);
+		i2s->field_chcfg_rx_slot_num =
+			devm_regmap_field_alloc(i2s->dev, i2s->regmap,
+				i2s->variant->field_chcfg_rx_slot_num);
+		if (IS_ERR(i2s->field_chcfg_rx_slot_num))
+			return PTR_ERR(i2s->field_chcfg_rx_slot_num);
+	}
+
+	if (i2s->variant->has_chsel_tx_chen) {
+		i2s->field_chsel_tx_chen =
+			devm_regmap_field_alloc(i2s->dev, i2s->regmap,
+				i2s->variant->field_chsel_tx_chen);
+		if (IS_ERR(i2s->field_chsel_tx_chen))
+			return PTR_ERR(i2s->field_chsel_tx_chen);
+	}
+
+	if (i2s->variant->has_chsel_offset) {
+		i2s->field_chsel_offset =
+			devm_regmap_field_alloc(i2s->dev, i2s->regmap,
+				i2s->variant->field_chsel_offset);
+		if (IS_ERR(i2s->field_chsel_offset))
+			return PTR_ERR(i2s->field_chsel_offset);
+	}
+
 	return 0;
 }
 
@@ -936,6 +1134,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
 		.compatible = "allwinner,sun6i-a31-i2s",
 		.data = &sun6i_a31_i2s_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-h3-i2s",
+		.data = &sun8i_h3_i2s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
-- 
2.13.3
