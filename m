From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 12 Aug 2017 20:08:55 +0800
Subject: [linux-sunxi] [PATCH v3 04/11] ASoC: sun4i-i2s: Add regmap fields
 for channels
In-Reply-To: <20170812110059.5115-5-codekipper@gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
 <20170812110059.5115-5-codekipper@gmail.com>
Message-ID: <CAGb2v66z9D-Y-wzWeNdUEkxOQ9RDZJ_3CVK2ao4n66mq9DfEXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 7:00 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the original i2s block the channel mapping and selection were
> configured for stereo audio by default: This is not the case with
> the newer SoCs and they are also located at different offsets.
>
> To support the newer SoC then regmap fields have been added to the
> quirks and these are initialised to their correct settings during
> probing.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 84 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 76 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index dfb794ffff92..a65dcb013247 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c

[...]

> @@ -681,14 +701,56 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
>         .has_reset              = false,
>         .reg_offset_txdata      = SUN4I_I2S_FIFO_TX_REG,
>         .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> +       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> +       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> +       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> +       .field_rxchansel        = REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
>  };
>
>  static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>         .has_reset              = true,
>         .reg_offset_txdata      = SUN4I_I2S_FIFO_TX_REG,
>         .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> +       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> +       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> +       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> +       .field_rxchansel        = REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
>  };
>
> +static int sun4i_i2s_init_regmap_fields(struct device *dev,
> +                                       struct sun4i_i2s *i2s)
> +{
> +       int ret;
> +
> +       i2s->field_txchanmap =
> +               devm_regmap_field_alloc(dev, i2s->regmap,
> +                                       i2s->variant->field_txchanmap);
> +       ret = PTR_ERR_OR_ZERO(i2s->field_txchanmap);
> +
> +       if (!ret) {
> +               i2s->field_rxchanmap =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_rxchanmap);
> +               ret = PTR_ERR_OR_ZERO(i2s->field_rxchanmap);
> +       }
> +
> +       if (!ret) {
> +               i2s->field_txchansel =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_txchansel);
> +               ret = PTR_ERR_OR_ZERO(i2s->field_txchansel);
> +       }
> +
> +       if (!ret) {
> +               i2s->field_rxchansel =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_rxchansel);
> +               ret = PTR_ERR_OR_ZERO(i2s->field_rxchansel);

I'm quite sure this was not what we meant when we recommended
the usage of PTR_ERR_OR_ZERO...

Rather you should have kept the

        if (PTR_ERR(...))
                return PTR_ERR(...);

for all but the last conditional blocks. For the last one just

        return PTR_ERR_OR_ZERO(...);

Returning early, as opposed to what you have here, is also
easier to read. People looking at it will notice early on
that if something wrong happens, you bail out. Instead with
this structure, people have to read down a long list of ifs
that aren't doing anything. Not to mention that you have to
indent every code block except the first one by one tab,
reducing any screen real estate you have.

ChenYu

> +       }
> +
> +       return ret;
> +}
> +
>  static int sun4i_i2s_probe(struct platform_device *pdev)
>  {
>         struct sun4i_i2s *i2s;

[...]
