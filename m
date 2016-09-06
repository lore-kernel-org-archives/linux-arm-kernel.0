From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Sep 2016 08:39:07 +0200
Subject: [PATCH] ASoC: sun4i-codec: Distinguish sun4i from sun7i
In-Reply-To: <20160905192404.13871-2-dannym@scratchpost.org>
References: <20160905192404.13871-1-dannym@scratchpost.org>
 <20160905192404.13871-2-dannym@scratchpost.org>
Message-ID: <20160906063907.GA9040@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 05, 2016 at 09:24:04PM +0200, Danny Milosavljevic wrote:
> ASoC: sun4i-codec: Distinguish sun4i from sun7i
> 
> Introduce mechanism to detect sun7i and provide a different regmap, codec
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
>  sound/soc/sunxi/sun4i-codec.c | 66 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 0e19c50..8531c93 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -96,8 +96,8 @@
>  /* Other various ADC registers */
>  #define SUN4I_CODEC_DAC_TXCNT			(0x30)
>  #define SUN4I_CODEC_ADC_RXCNT			(0x34)
> -#define SUN4I_CODEC_AC_SYS_VERI			(0x38)
> -#define SUN4I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
> +#define SUN7I_CODEC_AC_DAC_CAL			(0x38)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
>  
>  struct sun4i_codec {
>  	struct device	*dev;
> @@ -509,10 +509,17 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>  
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
>  
> -static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
> -	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
> -		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
> -		       sun4i_codec_pa_volume_scale),
> +#define SUN4I_COMMON_CODEC_CONTROLS \
> +	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
> +		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
> +		       sun4i_codec_pa_volume_scale)
> +
> +static const struct snd_kcontrol_new sun4i_codec_controls[] = {
> +	SUN4I_COMMON_CODEC_CONTROLS,
> +};
> +
> +static const struct snd_kcontrol_new sun7i_codec_controls[] = {
> +	SUN4I_COMMON_CODEC_CONTROLS,
>  };
>  
>  static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
> @@ -629,8 +636,19 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
>  
>  static struct snd_soc_codec_driver sun4i_codec_codec = {
>  	.component_driver = {
> -		.controls		= sun4i_codec_widgets,
> -		.num_controls		= ARRAY_SIZE(sun4i_codec_widgets),
> +		.controls		= sun4i_codec_controls,
> +		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
> +		.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
> +		.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
> +		.dapm_routes		= sun4i_codec_codec_dapm_routes,
> +		.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
> +	},
> +};
> +
> +static struct snd_soc_codec_driver sun7i_codec_codec = {
> +	.component_driver = {
> +		.controls		= sun7i_codec_controls,
> +		.num_controls		= ARRAY_SIZE(sun7i_codec_controls),
>  		.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
>  		.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
>  		.dapm_routes		= sun4i_codec_codec_dapm_routes,
> @@ -682,12 +700,34 @@ static const struct regmap_config sun4i_codec_regmap_config = {
>  	.reg_bits	= 32,
>  	.reg_stride	= 4,
>  	.val_bits	= 32,
> -	.max_register	= SUN4I_CODEC_AC_MIC_PHONE_CAL,
> +	.max_register	= SUN4I_CODEC_ADC_RXCNT,
> +};
> +
> +static const struct regmap_config sun7i_codec_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +};
> +
> +struct sun4i_quirks {
> +	const struct snd_soc_codec_driver *codec;
> +	const struct regmap_config *regmap_config;
> +};
> +
> +static const struct sun4i_quirks sun4i_quirks = {
> +	.codec = &sun4i_codec_codec,
> +	.regmap_config = &sun4i_codec_regmap_config,
> +};
> +
> +static const struct sun4i_quirks sun7i_quirks = {
> +	.codec = &sun7i_codec_codec,
> +	.regmap_config = &sun7i_codec_regmap_config,
>  };
>  
>  static const struct of_device_id sun4i_codec_of_match[] = {
> -	{ .compatible = "allwinner,sun4i-a10-codec" },
> -	{ .compatible = "allwinner,sun7i-a20-codec" },
> +	{ .compatible = "allwinner,sun4i-a10-codec", .data = &sun4i_quirks },
> +	{ .compatible = "allwinner,sun7i-a20-codec", .data = &sun7i_quirks },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
> @@ -760,6 +800,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_card *card;
>  	struct sun4i_codec *scodec;
> +	struct sun4i_quirks *quirks;
>  	struct resource *res;
>  	void __iomem *base;
>  	int ret;
> @@ -777,8 +818,9 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  		return PTR_ERR(base);
>  	}
>  
> +	quirks = of_device_get_match_data(&pdev->dev);
>  	scodec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> -					     &sun4i_codec_regmap_config);
> +					       quirks->regmap_config);

I think you also wanted to pass quirks->codec to
snd_soc_register_codec?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/ad07b250/attachment.sig>
