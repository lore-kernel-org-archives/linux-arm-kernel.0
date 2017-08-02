From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 12:37:15 +0800
Subject: [linux-sunxi] [PATCH v3 12/12] ASoC: sun4i-i2s: Add support for H3
In-Reply-To: <20170729141753.20174-13-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-13-codekipper@gmail.com>
Message-ID: <CAGb2v67ySahkiM043zr3F-RcBcZsPW_XDU5u7HA0jx9ycrzQMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The sun8i-h3 introduces a lot of changes to the i2s block such
> as different register locations, extended clock division and
> more operational modes. As we have to consider the earlier
> implementation then these changes need to be isolated.

Can you describe which parts are already supported, and what
remains to be done? For example, you don't seem to support
the extended clock division, nor the new operational modes.

Please also leave TODO notes in the code.

>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
>  sound/soc/sunxi/sun4i-i2s.c                        | 173 +++++++++++++++++++++
>  2 files changed, 175 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> index ee21da865771..fc5da6080759 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -8,6 +8,7 @@ Required properties:
>  - compatible: should be one of the following:
>     - "allwinner,sun4i-a10-i2s"
>     - "allwinner,sun6i-a31-i2s"
> +   - "allwinner,sun8i-h3-i2s"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: should contain the I2S interrupt.
> @@ -22,6 +23,7 @@ Required properties:
>
>  Required properties for the following compatibles:
>         - "allwinner,sun6i-a31-i2s"
> +       - "allwinner,sun8i-h3-i2s"
>  - resets: phandle to the reset line for this codec
>
>  Example:
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d8bcd3d9c2b6..87dfb5017c25 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -92,11 +92,43 @@
>  #define SUN4I_I2S_RX_CHAN_SEL_REG      0x38
>  #define SUN4I_I2S_RX_CHAN_MAP_REG      0x3c
>
> +/* Defines required for sun8i-h3 support */
> +#define SUN8I_I2S_CTRL_BCLK_OUT                        BIT(18)
> +#define SUN8I_I2S_CTRL_LRCK_OUT                        BIT(17)
> +
> +#define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK                GENMASK(17, 8)
> +#define SUN8I_I2S_FMT0_LRCK_PERIOD(period)     (period << 8)
> +
> +#define SUN8I_I2S_INT_STA_REG          0x0c
> +#define SUN8I_I2S_FIFO_TX_REG          0x20
> +
> +#define SUN8I_I2S_CLK_DIV_MCLK_EN              8
> +
> +#define SUN8I_I2S_CHAN_CFG_REG         0x30
> +#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK    GENMASK(6, 4)
> +#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)   (chan - 1)
> +#define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK    GENMASK(2, 0)
> +#define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(chan)   (chan - 1)
> +
> +#define SUN8I_I2S_TX_CHAN_MAP_REG      0x44
> +#define SUN8I_I2S_TX_CHAN_SEL_REG      0x34
> +#define SUN8I_I2S_TX_CHAN_OFFSET_MASK          GENMASK(13,11)
> +#define SUN8I_I2S_TX_CHAN_OFFSET(offset)       (offset << 12)
> +#define SUN8I_I2S_TX_CHAN_EN_MASK              GENMASK(11, 4)
> +#define SUN8I_I2S_TX_CHAN_EN(num_chan)         (((1 << num_chan) - 1) << 4)
> +
> +#define SUN8I_I2S_RX_CHAN_SEL_REG      0x54
> +#define SUN8I_I2S_RX_CHAN_MAP_REG      0x58
> +
>  /**
>   * struct sun4i_i2s_quirks - Differences between SoC variants.
>   *
>   * @has_reset: SoC needs reset deasserted.
>   * @has_slave_select_bit: SoC has a bit to enable slave mode.
> + * @has_fmt_set_lrck_period: SoC requires lrclk period to be set.
> + * @has_chcfg: tx and rx slot number need to be set.
> + * @has_chsel_tx_chen: requires lrclk period to be set.
> + * @has_chsel_offset: requires lrclk period to be set.

The last two descriptions don't match up.

>   * @reg_offset_txdata: offset of the tx fifo.
>   * @sun4i_i2s_regmap: regmap config to use.
>   * @mclk_offset: Value by which mclkdiv needs to be adjusted.
> @@ -116,6 +148,10 @@
>  struct sun4i_i2s_quirks {
>         bool                            has_reset;
>         bool                            has_slave_select_bit;
> +       bool                            has_fmt_set_lrck_period;
> +       bool                            has_chcfg;
> +       bool                            has_chsel_tx_chen;
> +       bool                            has_chsel_offset;
>         unsigned int                    reg_offset_txdata;      /* TX FIFO */
>         const struct regmap_config      *sun4i_i2s_regmap;
>         unsigned int                    mclk_offset;
> @@ -291,6 +327,12 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
>
>         regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
>
> +       /* Set sync period */
> +       if (i2s->variant->has_fmt_set_lrck_period)
> +               regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> +                                  SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> +                                  SUN8I_I2S_FMT0_LRCK_PERIOD(0x1f));

Please use the actual number (32) here, and let the macro handle
the register value offset.

> +
>         return 0;
>  }
>
> @@ -305,6 +347,15 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>         if (params_channels(params) != 2)
>                 return -EINVAL;
>
> +       if (i2s->variant->has_chcfg) {
> +               regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> +                                  SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> +                                  SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(params_channels(params)));
> +               regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> +                                  SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
> +                                  SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(params_channels(params)));
> +       }
> +
>         /* Map the channels for playback and capture */
>         regmap_field_write(i2s->field_txchanmap, 0x76543210);
>         regmap_field_write(i2s->field_rxchanmap, 0x00003210);
> @@ -316,6 +367,10 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>         regmap_field_write(i2s->field_rxchansel,
>                            SUN4I_I2S_CHAN_SEL(params_channels(params)));
>
> +       if (i2s->variant->has_chsel_tx_chen)
> +               regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> +                                  SUN8I_I2S_TX_CHAN_EN_MASK,
> +                                  SUN8I_I2S_TX_CHAN_EN(params_channels(params)));
>
>         switch (params_physical_width(params)) {
>         case 16:
> @@ -349,6 +404,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  {
>         struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>         u32 val;
> +       u32 offset = 0;
>         u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
>         u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
>
> @@ -356,6 +412,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>         switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>         case SND_SOC_DAIFMT_I2S:
>                 val = SUN4I_I2S_FMT0_FMT_I2S;
> +               offset = 1;
>                 break;
>         case SND_SOC_DAIFMT_LEFT_J:
>                 val = SUN4I_I2S_FMT0_FMT_LEFT_J;
> @@ -367,6 +424,21 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                 return -EINVAL;
>         }
>
> +       if (i2s->variant->has_chsel_offset) {
> +               /*
> +                * offset being set indicates that we're connected to an i2s
> +                * device, however offset is only used on the sun8i block and
> +                * i2s shares the same setting with the LJ format. Increment
> +                * val so that the bit to value to write is correct.
> +                */
> +               if (offset > 0)
> +                       val++;
> +               /* blck offset determines whether i2s or LJ */
> +               regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> +                                  SUN8I_I2S_TX_CHAN_OFFSET_MASK,
> +                                  SUN8I_I2S_TX_CHAN_OFFSET(offset));
> +       }
> +
>         regmap_field_write(i2s->field_fmt_set_mode, val);
>
>         /* DAI clock polarity */
> @@ -410,6 +482,29 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                 regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
>                                    SUN4I_I2S_CTRL_MODE_MASK,
>                                    val);
> +       } else {
> +               /*
> +                * The newer i2s block does not have a slave select bit,
> +                * instead the clk pins are configured as inputs.
> +                */
> +               /* DAI clock master masks */
> +               switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +               case SND_SOC_DAIFMT_CBS_CFS:
> +                       /* BCLK and LRCLK master */
> +                       val = SUN8I_I2S_CTRL_BCLK_OUT |
> +                               SUN8I_I2S_CTRL_LRCK_OUT;
> +                       break;
> +               case SND_SOC_DAIFMT_CBM_CFM:
> +                       /* BCLK and LRCLK slave */
> +                       val = 0;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +               regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +                                  SUN8I_I2S_CTRL_BCLK_OUT |
> +                                  SUN8I_I2S_CTRL_LRCK_OUT,
> +                                  val);
>         }
>
>         /* Set significant bits in our FIFOs */
> @@ -651,6 +746,28 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>         }
>  }
>
> +static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case SUN8I_I2S_FIFO_TX_REG:
> +               return false;
> +
> +       default:
> +               return true;
> +       }
> +}
> +
> +static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +
> +       if (reg == SUN8I_I2S_INT_STA_REG)
> +               return true;
> +       if (reg == SUN8I_I2S_FIFO_TX_REG)
> +               return false;
> +
> +       return sun4i_i2s_volatile_reg(dev, reg);
> +}
> +
>  static const struct reg_default sun4i_i2s_reg_defaults[] = {
>         { SUN4I_I2S_CTRL_REG, 0x00000000 },
>         { SUN4I_I2S_FMT0_REG, 0x0000000c },
> @@ -664,6 +781,20 @@ static const struct reg_default sun4i_i2s_reg_defaults[] = {
>         { SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210 },
>  };
>
> +static const struct reg_default sun8i_i2s_reg_defaults[] = {
> +       { SUN4I_I2S_CTRL_REG, 0x00060000 },
> +       { SUN4I_I2S_FMT0_REG, 0x00000033 },
> +       { SUN4I_I2S_FMT1_REG, 0x00000030 },
> +       { SUN4I_I2S_FIFO_CTRL_REG, 0x000400f0 },
> +       { SUN4I_I2S_DMA_INT_CTRL_REG, 0x00000000 },
> +       { SUN4I_I2S_CLK_DIV_REG, 0x00000000 },
> +       { SUN8I_I2S_CHAN_CFG_REG, 0x00000000 },
> +       { SUN8I_I2S_TX_CHAN_SEL_REG, 0x00000000 },
> +       { SUN8I_I2S_TX_CHAN_MAP_REG, 0x00000000 },
> +       { SUN8I_I2S_RX_CHAN_SEL_REG, 0x00000000 },
> +       { SUN8I_I2S_RX_CHAN_MAP_REG, 0x00000000 },
> +};
> +
>  static const struct regmap_config sun4i_i2s_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
> @@ -678,6 +809,19 @@ static const struct regmap_config sun4i_i2s_regmap_config = {
>         .volatile_reg   = sun4i_i2s_volatile_reg,
>  };
>
> +static const struct regmap_config sun8i_i2s_regmap_config = {
> +       .reg_bits       = 32,
> +       .reg_stride     = 4,
> +       .val_bits       = 32,
> +       .max_register   = SUN8I_I2S_RX_CHAN_MAP_REG,
> +       .cache_type     = REGCACHE_FLAT,
> +       .reg_defaults   = sun8i_i2s_reg_defaults,
> +       .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
> +       .writeable_reg  = sun4i_i2s_wr_reg,
> +       .readable_reg   = sun8i_i2s_rd_reg,
> +       .volatile_reg   = sun8i_i2s_volatile_reg,
> +};
> +
>  static int sun4i_i2s_runtime_resume(struct device *dev)
>  {
>         struct sun4i_i2s *i2s = dev_get_drvdata(dev);
> @@ -754,6 +898,31 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>         .field_rxchansel        = REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
>  };
>
> +static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
> +       .has_reset              = true,
> +       .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
> +       .sun4i_i2s_regmap       = &sun8i_i2s_regmap_config,
> +       .mclk_offset            = 1,
> +       .bclk_offset            = 2,
> +       .fmt_offset             = 3,
> +       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG,
> +                                           SUN8I_I2S_CLK_DIV_MCLK_EN,
> +                                           SUN8I_I2S_CLK_DIV_MCLK_EN),
> +       .has_fmt_set_lrck_period = true,
> +       .has_chcfg              = true,
> +       .has_chsel_tx_chen      = true,
> +       .has_chsel_offset       = true,
> +       .field_fmt_set_wss      = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
> +       .field_fmt_set_sr       = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> +       .field_fmt_set_bclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> +       .field_fmt_set_lrclk_polarity = REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
> +       .field_fmt_set_mode     = REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),

Comments from previous patches also apply here.

Regards,
ChenYu

> +       .field_txchanmap        = REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
> +       .field_rxchanmap        = REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
> +       .field_txchansel        = REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
> +       .field_rxchansel        = REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
> +};
> +
>  static int sun4i_i2s_init_regmap_fields(struct device *dev, struct sun4i_i2s *i2s)
>  {
>         i2s->field_fmt_set_wss =
> @@ -956,6 +1125,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
>                 .compatible = "allwinner,sun6i-a31-i2s",
>                 .data = &sun6i_a31_i2s_quirks,
>         },
> +       {
> +               .compatible = "allwinner,sun8i-h3-i2s",
> +               .data = &sun8i_h3_i2s_quirks,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
> --
> 2.13.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
