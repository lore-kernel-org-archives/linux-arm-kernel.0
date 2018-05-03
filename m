From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 16:30:15 +0200
Subject: [PATCH v14 1/8] ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2,
 Mic Playback Volume
In-Reply-To: <20180502210800.1971-2-dannym@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-2-dannym@scratchpost.org>
Message-ID: <20180503143015.txtwdbt5icpeq4u5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 11:07:53PM +0200, Danny Milosavljevic wrote:
> Add MIC2 Pre-Amplifier, Mic2 input and Mic Playback Volume for Allwinner A10
> and Allwinner A20.

That's a general remark for all your commits here, but you should have
more context in your commit logs, for example to define what is the
usual use case for these microphones, if the playback volume applies
to all mic at once, or just a fraction of them, etc.

> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 9a3cb7704810..060a40b45ab0 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -64,6 +64,7 @@
>  #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
>  #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
>  #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
> +#define SUN4I_CODEC_DAC_ACTL_MICG			(20)
>  #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
>  #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
>  #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
> @@ -673,11 +674,16 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>  			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
>  
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
> +			    0);
>  
>  static const struct snd_kcontrol_new sun4i_codec_controls[] = {
>  	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
>  		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
>  		       sun4i_codec_pa_volume_scale),
> +	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
> +		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
> +		       sun4i_codec_micin_loopback_gain_scale),

This should probably go in a separate patch, it isn't directly related
to the rest of the patch.

Looks good otherwise, thanks!
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/165ebe99/attachment-0001.sig>
