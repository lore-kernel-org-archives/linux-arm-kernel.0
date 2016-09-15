From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 23:19:26 +0800
Subject: [PATCH v3 3/3] ASoC: sun4i-codec: Add custom regmap configs for
 the A10 and A20 variants.
In-Reply-To: <20160915143922.4890-4-dannym@scratchpost.org>
References: <20160915143922.4890-1-dannym@scratchpost.org>
 <20160915143922.4890-4-dannym@scratchpost.org>
Message-ID: <CAGb2v64jTGa-z6yXOEoKiY2NyHdu=Y42EYGm7tiK1dyPstYn1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 10:39 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> ASoC: sun4i-codec: Add custom regmap configs for the A10 and A20 variants.

The commit message should be a straight forward description about what
the patch does and why you did it, not a direct copy of the subject.

Something along the lines of "The A20 has a few extra registers that
the A10 doesn't have ..." will do for the why.

Regards
ChenYu

>
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 3b53b78..c5d6d84c 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -682,12 +682,37 @@ static const struct regmap_config sun4i_codec_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
>         .val_bits       = 32,
> +       .max_register   = SUN4I_CODEC_ADC_RXCNT,
> +};
> +
> +static const struct regmap_config sun7i_codec_regmap_config = {
> +       .reg_bits       = 32,
> +       .reg_stride     = 4,
> +       .val_bits       = 32,
>         .max_register   = SUN7I_CODEC_AC_MIC_PHONE_CAL,
>  };
>
> +struct sun4i_codec_quirks {
> +       const struct regmap_config *regmap_config;
> +};
> +
> +static const struct sun4i_codec_quirks sun4i_codec_quirks = {
> +       .regmap_config = &sun4i_codec_regmap_config,
> +};
> +
> +static const struct sun4i_codec_quirks sun7i_codec_quirks = {
> +       .regmap_config = &sun7i_codec_regmap_config,
> +};
> +
>  static const struct of_device_id sun4i_codec_of_match[] = {
> -       { .compatible = "allwinner,sun4i-a10-codec" },
> -       { .compatible = "allwinner,sun7i-a20-codec" },
> +       {
> +               .compatible = "allwinner,sun4i-a10-codec",
> +               .data = &sun4i_codec_quirks,
> +       },
> +       {
> +               .compatible = "allwinner,sun7i-a20-codec",
> +               .data = &sun7i_codec_quirks,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
> @@ -760,6 +785,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  {
>         struct snd_soc_card *card;
>         struct sun4i_codec *scodec;
> +       const struct sun4i_codec_quirks *quirks;
>         struct resource *res;
>         void __iomem *base;
>         int ret;
> @@ -777,8 +803,9 @@ static int sun4i_codec_probe(struct platform_device *pdev)
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
