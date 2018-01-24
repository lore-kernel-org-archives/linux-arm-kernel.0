From: codekipper@gmail.com (Code Kipper)
Date: Wed, 24 Jan 2018 18:41:30 +0100
Subject: [PATCH 3/3] ASoC: sun4i-i2s: Add regmap field to sign extend
 sample
In-Reply-To: <20180124141101.12867-4-codekipper@gmail.com>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-4-codekipper@gmail.com>
Message-ID: <CAEKpxBnfBBrFPA+b3e27+A406_om6Eh5UyeZgV0LkeDJK89p7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2018 at 15:11,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs this is set by default to transfer a 0 after
> each sample in each slot. Add the regmap field to configure this
> and set it so that it pads the sample with 0s.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
NACK missing regmap field from A83t.
CK
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 626679057d0f..9fda1240b717 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -139,6 +139,7 @@
>   * @field_fmt_bclk: regmap field to set clk polarity.
>   * @field_fmt_lrclk: regmap field to set frame polarity.
>   * @field_fmt_mode: regmap field to set the operational mode.
> + * @field_fmt_sext: regmap field to set the sign extension.
>   * @field_txchanmap: location of the tx channel mapping register.
>   * @field_rxchanmap: location of the rx channel mapping register.
>   * @field_txchansel: location of the tx channel select bit fields.
> @@ -164,6 +165,7 @@ struct sun4i_i2s_quirks {
>         struct reg_field                field_fmt_bclk;
>         struct reg_field                field_fmt_lrclk;
>         struct reg_field                field_fmt_mode;
> +       struct reg_field                field_fmt_sext;
>         struct reg_field                field_txchanmap;
>         struct reg_field                field_rxchanmap;
>         struct reg_field                field_txchansel;
> @@ -188,6 +190,7 @@ struct sun4i_i2s {
>         struct regmap_field     *field_fmt_bclk;
>         struct regmap_field     *field_fmt_lrclk;
>         struct regmap_field     *field_fmt_mode;
> +       struct regmap_field     *field_fmt_sext;
>         struct regmap_field     *field_txchanmap;
>         struct regmap_field     *field_rxchanmap;
>         struct regmap_field     *field_txchansel;
> @@ -358,6 +361,9 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>                                    SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
>                                    SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
>
> +       /* Set sign extension to pad out LSB with 0 */
> +       regmap_field_write(i2s->field_fmt_sext, 0);
> +
>         return 0;
>  }
>
> @@ -929,6 +935,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
>         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>         .has_slave_select_bit   = true,
>         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
>         .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>         .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>         .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -946,6 +953,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>         .has_slave_select_bit   = true,
>         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
>         .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>         .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>         .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -986,6 +994,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
>         .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
>         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
> +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
>         .field_txchanmap        = REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
>         .field_rxchanmap        = REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
>         .field_txchansel        = REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -1031,6 +1040,12 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
>         if (IS_ERR(i2s->field_fmt_mode))
>                 return PTR_ERR(i2s->field_fmt_mode);
>
> +       i2s->field_fmt_sext =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_fmt_sext);
> +       if (IS_ERR(i2s->field_fmt_sext))
> +               return PTR_ERR(i2s->field_fmt_sext);
> +
>         i2s->field_txchanmap =
>                         devm_regmap_field_alloc(dev, i2s->regmap,
>                                                 i2s->variant->field_txchanmap);
> --
> 2.16.0
>
