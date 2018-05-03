From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 16:33:19 +0200
Subject: [PATCH v14 2/8] ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2
 Boost Volume
In-Reply-To: <20180502210800.1971-3-dannym@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-3-dannym@scratchpost.org>
Message-ID: <20180503143319.4vyh2y5sluatssnv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 11:07:54PM +0200, Danny Milosavljevic wrote:
> Add Mic1 Boost Volume and Mic2 Boost Volume for Allwinner A10 and Allwinner
> A20.  Also add support for extra controls to the sun4i_codec_quirks because
> the A10 and A20 have Mic1 Boost Volume at different places (likewise for
> Mic2 Boost Volume).

A good rule of thumb is that when you have "also" in your commit log,
you should do another patch instead doing that instead.

> 
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 66 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 060a40b45ab0..4af286f44a67 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -95,6 +95,8 @@
>  #define SUN4I_CODEC_ADC_ACTL_PREG1EN			(29)
>  #define SUN4I_CODEC_ADC_ACTL_PREG2EN			(28)
>  #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
> +#define SUN4I_CODEC_ADC_ACTL_PREG1			(25)
> +#define SUN4I_CODEC_ADC_ACTL_PREG2			(23)
>  #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
>  #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
>  #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
> @@ -111,6 +113,9 @@
>  /* Microphone controls (sun7i only) */
>  #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
>  
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1		(29)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2		(26)
> +
>  /*
>   * sun6i specific registers
>   *
> @@ -676,6 +681,12 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
>  			    0);
> +static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
> +			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +			    1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));
> +static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
> +			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
>  
>  static const struct snd_kcontrol_new sun4i_codec_controls[] = {
>  	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
> @@ -686,6 +697,24 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
>  		       sun4i_codec_micin_loopback_gain_scale),
>  };
>  
> +static const struct snd_kcontrol_new sun4i_codec_extra_controls[] = {
> +	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN4I_CODEC_ADC_ACTL,
> +		       SUN4I_CODEC_ADC_ACTL_PREG1, 3, 0,
> +		       sun4i_codec_micin_preamp_gain_scale),
> +	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN4I_CODEC_ADC_ACTL,
> +		       SUN4I_CODEC_ADC_ACTL_PREG2, 3, 0,
> +		       sun4i_codec_micin_preamp_gain_scale),
> +};
> +
> +static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
> +	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1, 7, 0,
> +		       sun7i_codec_micin_preamp_gain_scale),
> +	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2, 7, 0,
> +		       sun7i_codec_micin_preamp_gain_scale),
> +};
> +
>  static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
>  	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>  			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> @@ -807,7 +836,30 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
>  	{ "Mic2", NULL, "VMIC" },
>  };
>  
> +struct sun4i_codec_quirks {
> +	const struct regmap_config *regmap_config;
> +	const struct snd_soc_component_driver *codec;
> +	struct snd_soc_card * (*create_card)(struct device *dev);
> +	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
> +	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
> +	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
> +	bool has_reset;
> +	const struct snd_kcontrol_new *controls;
> +	unsigned int num_controls;
> +};
> +
> +static int sun4i_codec_component_driver_probe(struct snd_soc_component *codec)
> +{
> +	const struct sun4i_codec_quirks *quirks;
> +
> +	quirks = of_device_get_match_data(codec->dev);
> +	return snd_soc_add_component_controls(codec,
> +					      quirks->controls,
> +					      quirks->num_controls);

Why not just extending the sun4i_codec_controls to add it, and create
a duplicate one for the A20?


-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/c2b34e1c/attachment.sig>
