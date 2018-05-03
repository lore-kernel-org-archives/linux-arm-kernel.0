From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 16:46:19 +0200
Subject: [PATCH v14 3/8] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls
In-Reply-To: <20180502210800.1971-4-dannym@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-4-dannym@scratchpost.org>
Message-ID: <20180503144618.oojhvmey44dtg5fa@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 11:07:55PM +0200, Danny Milosavljevic wrote:
> Since it's now possible to have a DAPM mixer control with multiple channels,
> use it to cut down the total number of controls.
> 
> Keep "Left Mixer Left DAC Playback Switch" and "Right Mixer Right DAC Playback
> Switch" name & layout the same as before for compatibility.
> 
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 4af286f44a67..b62af407967f 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -715,15 +715,15 @@ static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
>  		       sun7i_codec_micin_preamp_gain_scale),
>  };
>  
> -static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
> -	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> -			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> -};
> -
> -static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
> -	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> -			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
> -	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
> +	SOC_DAPM_SINGLE("Left Mixer Left DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
> +			1, 0),
> +	SOC_DAPM_SINGLE("Right Mixer Right DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL, SUN4I_CODEC_DAC_ACTL_RDACRMIXS,
> +			1, 0),
> +	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
> +			SUN4I_CODEC_DAC_ACTL,
>  			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
>  };
>  
> @@ -759,11 +759,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
>  
>  	/* Mixers */
>  	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
> -			   sun4i_codec_left_mixer_controls,
> -			   ARRAY_SIZE(sun4i_codec_left_mixer_controls)),
> +			   sun4i_codec_mixer_controls,
> +			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
>  	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
> -			   sun4i_codec_right_mixer_controls,
> -			   ARRAY_SIZE(sun4i_codec_right_mixer_controls)),
> +			   sun4i_codec_mixer_controls,
> +			   ARRAY_SIZE(sun4i_codec_mixer_controls)),

Doesn't that mean that the controls will be shared between the right
and left mixers now, which wasn't the case before? And also, wouldn't
the controls be called "Left Mixer Left Mixer Left DAC Playback
Switch" (for the first one) now?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/12d5896a/attachment.sig>
