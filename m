From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 9 Sep 2016 21:56:16 +0800
Subject: [linux-sunxi] [PATCH v2] ASoC: sun4i-codec: Distinguish sun4i
 from sun7i
In-Reply-To: <20160908195759.18485-1-dannym@scratchpost.org>
References: <20160908195759.18485-1-dannym@scratchpost.org>
Message-ID: <CAGb2v64cW8ik3UzSBP0-VqS=2eZZ+YmUvf4qPgD-MimfDyOv=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 9, 2016 at 3:57 AM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Introduce mechanism to detect sun7i and provide a different regmap
> and different controls for it - different compared to sun4i Allwinner A10.
>
> The controls will be extended in a forthcoming patch - it is necessary to
> distinguish between sun4i and sun7i controls because the mic gains are in
> different registers.
>
> Renamed SUN4I_CODEC_AC_SYS_VERI to SUN7I_CODEC_AC_DAC_CAL and renamed
> SUN4I_CODEC_AC_MIC_PHONE_CAL to SUN7I_CODEC_AC_MIC_PHONE_CAL because these
> are actually not present on Allwinner A10.
>
> Handle quirks by regmap config and codec and select the correct quirks
> automatically.
>
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 78 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 0e19c50..239e330 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -96,8 +96,8 @@
>  /* Other various ADC registers */
>  #define SUN4I_CODEC_DAC_TXCNT                  (0x30)
>  #define SUN4I_CODEC_ADC_RXCNT                  (0x34)
> -#define SUN4I_CODEC_AC_SYS_VERI                        (0x38)
> -#define SUN4I_CODEC_AC_MIC_PHONE_CAL           (0x3c)
> +#define SUN7I_CODEC_AC_DAC_CAL                 (0x38)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL           (0x3c)
>
>  struct sun4i_codec {
>         struct device   *dev;
> @@ -509,7 +509,7 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
>
> -static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
> +static const struct snd_kcontrol_new sun4i_codec_controls[] = {
>         SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
>                        SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
>                        sun4i_codec_pa_volume_scale),
> @@ -627,10 +627,60 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
>         { "Mic1", NULL, "VMIC" },
>  };
>
> +static const struct regmap_config sun4i_codec_regmap_config = {
> +       .reg_bits       = 32,
> +       .reg_stride     = 4,
> +       .val_bits       = 32,
> +       .max_register   = SUN4I_CODEC_ADC_RXCNT,
> +};
> +
> +static const struct regmap_config sun7i_codec_regmap_config = {
> +       .reg_bits       = 32,
> +       .reg_stride     = 4,
> +       .val_bits       = 32,
> +       .max_register   = SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +};
> +
> +struct sun4i_quirks {

Nit: use the driver name, sun4i_codec, as the prefix.

> +       const struct snd_kcontrol_new *controls;
> +       unsigned int num_controls;
> +       const struct regmap_config *regmap_config;
> +};
> +
> +static const struct sun4i_quirks sun4i_quirks = {
> +       .controls = NULL,
> +       .num_controls = 0U,

Nit: they default to NULL/0. You don't need to do it.

> +       .regmap_config = &sun4i_codec_regmap_config,
> +};
> +
> +static const struct sun4i_quirks sun7i_quirks = {
> +       .controls = NULL,
> +       .num_controls = 0U,
> +       .regmap_config = &sun7i_codec_regmap_config,
> +};
> +
> +static const struct of_device_id sun4i_codec_of_match[] = {
> +       { .compatible = "allwinner,sun4i-a10-codec", .data = &sun4i_quirks },
> +       { .compatible = "allwinner,sun7i-a20-codec", .data = &sun7i_quirks },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);

Nit: I would put the above at the very bottom, just above the platform driver
probe function, or where it was originally. Keep the file organized into
codec/card/platform driver sections.

ChenYu

> +
> +static int sun4i_codec_codec_probe(struct snd_soc_codec *scodec)
> +{
> +       const struct sun4i_quirks *quirks;
> +
> +       quirks = of_device_get_match_data(scodec->dev);
> +       return snd_soc_add_codec_controls(scodec,
> +                                         quirks->controls,
> +                                         quirks->num_controls);
> +}
> +
>  static struct snd_soc_codec_driver sun4i_codec_codec = {
> +       .probe = sun4i_codec_codec_probe,
>         .component_driver = {
> -               .controls               = sun4i_codec_widgets,
> -               .num_controls           = ARRAY_SIZE(sun4i_codec_widgets),
> +               .controls               = sun4i_codec_controls,
> +               .num_controls           = ARRAY_SIZE(sun4i_codec_controls),
>                 .dapm_widgets           = sun4i_codec_codec_dapm_widgets,
>                 .num_dapm_widgets       = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
>                 .dapm_routes            = sun4i_codec_codec_dapm_routes,
> @@ -678,20 +728,6 @@ static struct snd_soc_dai_driver dummy_cpu_dai = {
>          },
>  };
>
> -static const struct regmap_config sun4i_codec_regmap_config = {
> -       .reg_bits       = 32,
> -       .reg_stride     = 4,
> -       .val_bits       = 32,
> -       .max_register   = SUN4I_CODEC_AC_MIC_PHONE_CAL,
> -};
> -
> -static const struct of_device_id sun4i_codec_of_match[] = {
> -       { .compatible = "allwinner,sun4i-a10-codec" },
> -       { .compatible = "allwinner,sun7i-a20-codec" },
> -       {}
> -};
> -MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
> -
>  static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
>                                                         int *num_links)
>  {
> @@ -760,6 +796,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  {
>         struct snd_soc_card *card;
>         struct sun4i_codec *scodec;
> +       const struct sun4i_quirks *quirks;
>         struct resource *res;
>         void __iomem *base;
>         int ret;
> @@ -777,8 +814,9 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>                 return PTR_ERR(base);
>         }
>
> +       quirks = of_device_get_match_data(&pdev->dev);
>         scodec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> -                                            &sun4i_codec_regmap_config);
> +                                              quirks->regmap_config);
>         if (IS_ERR(scodec->regmap)) {
>                 dev_err(&pdev->dev, "Failed to create our regmap\n");
>                 return PTR_ERR(scodec->regmap);
> --
> 2.1.4
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
