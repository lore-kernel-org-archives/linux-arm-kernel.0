From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Dec 2015 19:21:57 +0100
Subject: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line and Mic inputs
In-Reply-To: <20151221123416.51aa938e@dayas>
References: <20151221123148.1ab6480b@dayas>
 <20151221123416.51aa938e@dayas>
Message-ID: <20151227182157.GI30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 21, 2015 at 12:34:16PM +0100, Danny Milosavljevic wrote:
> This is the second part, actually adding FM, Line and Mic inputs.

Again, having a meaningful and standalone commit log would be nice.

> Signed-off-by: Danny Milosavljevic <dannym+a@scratchpost.org>
> ---
>  b/sound/soc/sunxi/sun4i-codec.c |  185 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 181 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 6628e6e..f23d8a9 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -59,9 +59,20 @@
>  #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
>  #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
>  #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
> +#define SUN4I_CODEC_DAC_ACTL_LNG			(26)
> +#define SUN4I_CODEC_DAC_ACTL_FMG			(23)
> +#define SUN4I_CODEC_DAC_ACTL_MICG			(20)
> +#define SUN4I_CODEC_DAC_ACTL_LLNS			(19)
> +#define SUN4I_CODEC_DAC_ACTL_RLNS			(18)
> +#define SUN4I_CODEC_DAC_ACTL_LFMS			(17)
> +#define SUN4I_CODEC_DAC_ACTL_RFMS			(16)
>  #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
>  #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
>  #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
> +#define SUN4I_CODEC_DAC_ACTL_MIC1LS			(12)
> +#define SUN4I_CODEC_DAC_ACTL_MIC1RS			(11)
> +#define SUN4I_CODEC_DAC_ACTL_MIC2LS			(10)
> +#define SUN4I_CODEC_DAC_ACTL_MIC2RS			(9)
>  #define SUN4I_CODEC_DAC_ACTL_DACPAS			(8)
>  #define SUN4I_CODEC_DAC_ACTL_MIXPAS			(7)
>  #define SUN4I_CODEC_DAC_ACTL_PA_MUTE			(6)
> @@ -87,8 +98,11 @@
>  #define SUN4I_CODEC_ADC_ACTL_PREG1EN			(29)
>  #define SUN4I_CODEC_ADC_ACTL_PREG2EN			(28)
>  #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
> -#define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
> +#define SUN4I_CODEC_ADC_ACTL_PREG1_A10			(25)
> +#define SUN4I_CODEC_ADC_ACTL_PREG2_A10			(23)

Why the A10 suffix?

> +#define SUN4I_CODEC_ADC_ACTL_ADCG			(20)
>  #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
> +#define SUN4I_CODEC_ADC_ACTL_LNRDF			(16)
>  #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
>  #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
>  #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
> @@ -100,6 +114,16 @@
>  #define SUN7I_CODEC_AC_DAC_CAL			(0x38)
>  #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
>  
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1      (29)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2      (26)
> +/* note: no idea where the output pins for the following are. */
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTG  (5)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTEN (4)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS3 (3)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS2 (2)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS1 (1)
> +#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS0 (0)

Are you using that PHONEOUT stuff anywhere?

> +
>  struct sun4i_codec {
>  	struct device	*dev;
>  	struct regmap	*regmap;
> @@ -509,19 +533,102 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
>  			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
>  
>  static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_linein_loopback_gain_scale,
> +			    -150,
> +			    150,
> +			    0);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_fmin_loopback_gain_scale,
> +			    -450,
> +			    150,
> +			    0);
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale,
> +			    -450,
> +			    150,
> +			    0);
> +static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale_a10,
> +			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +			    1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));
> +static DECLARE_TLV_DB_SCALE(sun4i_codec_adc_gain_scale, -450, 150, 0);
> +/* Sources:
> + *   A10 User Manual v1.5 20130820
> + *   A20 User Manual v1.4 20150510
> + */

There's no need to give your sources here.

> +static const char * const sun4i_codec_capture_source[] = {
> +	"Line-In",
> +	"FM",
> +	"Mic1",
> +	"Mic2",
> +	"Mic1,Mic2",
> +	"Mic1+Mic2",
> +	"Output Mixer",
> +	"Line-In,Mic1",
> +};
> +static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
> +			    SUN4I_CODEC_ADC_ACTL,
> +			    SUN4I_CODEC_ADC_ACTL_ADCIS,
> +			    sun4i_codec_capture_source);

Isn't it possible to expose this as two (shared) muxes with different
names to make it clear what will go to the left ADC and what will go
to the right?

> +static const struct snd_kcontrol_new sun4i_codec_capture_source_controls =
> +	SOC_DAPM_ENUM("Route", sun4i_codec_enum_capture_source);
>  
>  #define SUN4I_COMMON_CODEC_WIDGETS \
> -	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
> -		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
> -		       sun4i_codec_pa_volume_scale)
> +	SOC_SINGLE_TLV("Power Amplifier Playback Volume", SUN4I_CODEC_DAC_ACTL,\
> +		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0, \
> +		       sun4i_codec_pa_volume_scale), \

The power amplifier is only for the playback, so there's no need to
differentiate between playback and capture. The current name was fine.

> +	/* Line-In, FM, Mic1, Mic2 */ \
> +	SOC_SINGLE_TLV("Line-In Playback Volume", \
> +		       SUN4I_CODEC_DAC_ACTL, \
> +		       SUN4I_CODEC_DAC_ACTL_LNG, \
> +		       1, \
> +		       0, \
> +		       sun4i_codec_linein_loopback_gain_scale), \
> +	SOC_SINGLE_TLV("FM Playback Volume", \
> +		       SUN4I_CODEC_DAC_ACTL, \
> +		       SUN4I_CODEC_DAC_ACTL_FMG, \
> +		       3, \
> +		       0, \
> +		       sun4i_codec_fmin_loopback_gain_scale), \
> +	SOC_SINGLE_TLV("Mic Playback Volume", \
> +		       SUN4I_CODEC_DAC_ACTL, \
> +		       SUN4I_CODEC_DAC_ACTL_MICG, \
> +		       7, \
> +		       0, \
> +		       sun4i_codec_micin_loopback_gain_scale), \

Those are not volume it's gain, and it should probably be two
different shared controls for mic1 and mic2.

> +	/* ADC */ \
> +	SOC_SINGLE_TLV("Capture Volume", \
> +		       SUN4I_CODEC_ADC_ACTL, \
> +		       SUN4I_CODEC_ADC_ACTL_ADCG, \
> +		       4, \
> +		       0, \
> +		       sun4i_codec_adc_gain_scale)

This one is the ADC Gain. Please name it that way.

>  static const struct snd_kcontrol_new sun4i_codec_widgets_a10[] = {
>  	SUN4I_COMMON_CODEC_WIDGETS,
> +	SOC_SINGLE_TLV("Mic1 Capture Volume",
> +		       SUN4I_CODEC_ADC_ACTL,
> +		       SUN4I_CODEC_ADC_ACTL_PREG1_A10,
> +		       3,
> +		       0,
> +		       sun4i_codec_micin_preamp_gain_scale_a10),
> +	SOC_SINGLE_TLV("Mic2 Capture Volume",
> +		       SUN4I_CODEC_ADC_ACTL,
> +		       SUN4I_CODEC_ADC_ACTL_PREG2_A10,
> +		       3,
> +		       0,
> +		       sun4i_codec_micin_preamp_gain_scale_a10),

And those two are not capture volume, it's the pre-amplifier gain.

>  };
>  
>  static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
>  	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>  			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> +	SOC_DAPM_SINGLE("Left Line-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +			SUN4I_CODEC_DAC_ACTL_LLNS, 1, 0),
> +	SOC_DAPM_SINGLE("Left FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +			SUN4I_CODEC_DAC_ACTL_LFMS, 1, 0),
> +	SOC_DAPM_SINGLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +			SUN4I_CODEC_DAC_ACTL_MIC1LS, 1, 0),
> +	SOC_DAPM_SINGLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +			SUN4I_CODEC_DAC_ACTL_MIC2LS, 1, 0),
>  };
>  
>  static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
> @@ -529,6 +636,14 @@ static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
>  			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
>  	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>  			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
> +	SOC_DAPM_SINGLE("Right Line-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +			SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
> +	SOC_DAPM_SINGLE("Right FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
> +	SOC_DAPM_SINGLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
> +	SOC_DAPM_SINGLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
> +			SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
>  };
>  
>  static const struct snd_kcontrol_new sun4i_codec_pa_mixer_controls[] = {
> @@ -561,6 +676,10 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
>  	SND_SOC_DAPM_DAC("Right DAC", "Codec Playback", SUN4I_CODEC_DAC_ACTL,
>  			 SUN4I_CODEC_DAC_ACTL_DACAENR, 0),
>  
> +	/* MUX */
> +	SND_SOC_DAPM_MUX("Capture Source", SND_SOC_NOPM, 0, 0,
> +			 &sun4i_codec_capture_source_controls),
> +

Please call it "ADC Source"

>  	/* Mixers */
>  	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
>  			   sun4i_codec_left_mixer_controls,
> @@ -580,6 +699,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
>  	/* Mic Pre-Amplifiers */
>  	SND_SOC_DAPM_PGA("MIC1 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
>  			 SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),
> +	SND_SOC_DAPM_PGA("MIC2 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
> +			 SUN4I_CODEC_ADC_ACTL_PREG2EN, 0, NULL, 0),
>  
>  	/* Power Amplifier */
>  	SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
> @@ -590,9 +711,15 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
>  			    &sun4i_codec_pa_mute),
>  
>  	SND_SOC_DAPM_INPUT("Mic1"),
> +	SND_SOC_DAPM_INPUT("Mic2"),
>  
>  	SND_SOC_DAPM_OUTPUT("HP Right"),
>  	SND_SOC_DAPM_OUTPUT("HP Left"),
> +
> +	SND_SOC_DAPM_INPUT("Line-In Right"),
> +	SND_SOC_DAPM_INPUT("Line-In Left"),
> +	SND_SOC_DAPM_INPUT("FM Right"),
> +	SND_SOC_DAPM_INPUT("FM Left"),

Having all the inputs and all the outputs grouped together would be
nice.

>  };
>  
>  static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
> @@ -629,6 +756,39 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
>  	{ "Right ADC", NULL, "MIC1 Pre-Amplifier" },
>  	{ "MIC1 Pre-Amplifier", NULL, "Mic1"},
>  	{ "Mic1", NULL, "VMIC" },
> +	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
> +	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
> +

The right and left mixer routes should be in the matching sections.

> +	/* Mic2 Routes */
> +	{ "Left ADC", NULL, "MIC2 Pre-Amplifier" },
> +	{ "Right ADC", NULL, "MIC2 Pre-Amplifier" },
> +	{ "MIC2 Pre-Amplifier", NULL, "Mic2"},
> +	{ "Mic2", NULL, "VMIC" },
> +	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
> +	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },

Ditto.

> +
> +	/* Line-In, FM Routes */
> +	{ "Right Mixer", "Right Line-In Playback Switch", "Line-In Right" },
> +	{ "Left Mixer", "Left Line-In Playback Switch", "Line-In Left" },
> +	{ "Right Mixer", "Right FM Playback Switch", "FM Right" },
> +	{ "Left Mixer", "Left FM Playback Switch", "FM Left" },

Ditto.

> +
> +	/* ADC Capturing Sources */

"ADC Input Routes"

> +	{"Capture Source", "Line-In", "Line-In Left"},
> +	{"Capture Source", "Line-In", "Line-In Right"},
> +	{"Capture Source", "FM", "FM Left"},
> +	{"Capture Source", "FM", "FM Right"},
> +	{"Capture Source", "Mic1", "MIC1 Pre-Amplifier"},
> +	{"Capture Source", "Mic2", "MIC2 Pre-Amplifier"},
> +	{"Capture Source", "Mic1,Mic2", "MIC1 Pre-Amplifier"},
> +	{"Capture Source", "Mic1,Mic2", "MIC2 Pre-Amplifier"},
> +	{"Capture Source", "Mic1+Mic2", "MIC1 Pre-Amplifier"},
> +	{"Capture Source", "Mic1+Mic2", "MIC2 Pre-Amplifier"},
> +	{"Capture Source", "Output Mixer", "Left Mixer"},
> +	{"Capture Source", "Output Mixer", "Right Mixer"},
> +	{"Capture Source", "Line-In,Mic1", "Line-In Left"},
> +	{"Capture Source", "Line-In,Mic1", "Line-In Right"}, /* depends on LNRDF */
> +	{"Capture Source", "Line-In,Mic1", "MIC1 Pre-Amplifier"},
>  };

You should also have routes from the ADC Input to the Left and Right ADCs

>  static struct snd_soc_codec_driver sun4i_codec_codec_a10 = {
> @@ -757,8 +917,25 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
>  	return card;
>  };
>  
> +static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
> +	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
> +	1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0)
> +);
> +
>  static const struct snd_kcontrol_new sun7i_codec_widgets[] = {
>  	SUN4I_COMMON_CODEC_WIDGETS,
> +	SOC_SINGLE_TLV("Mic1 Capture Volume",
> +		       SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1,
> +		       7,
> +		       0,
> +		       sun7i_codec_micin_preamp_gain_scale),
> +	SOC_SINGLE_TLV("Mic2 Capture Volume",
> +		       SUN7I_CODEC_AC_MIC_PHONE_CAL,
> +		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2,
> +		       7,
> +		       0,
> +		       sun7i_codec_micin_preamp_gain_scale),

"Mic1 Pre-Amplifier Gain", "Mic2 Pre-Amplifier Gain".

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151227/3657a6d8/attachment.sig>
