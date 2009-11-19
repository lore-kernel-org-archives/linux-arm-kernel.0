From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 19 Nov 2009 19:30:08 +0000
Subject: [alsa-devel] [PATCH 03/12] add a mc13783 codec driver
In-Reply-To: <1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20091119193008.GC2814@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 04:48:17PM +0100, Sascha Hauer wrote:

This looks pretty good - the main non-nitpick issue here is that you've
got a bunch of controls in here which look like they're routing and
power control for the CODEC but which are just regular controls and are
implemented as hand crafted code.

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -114,6 +114,9 @@ config SND_SOC_CX20442
>  config SND_SOC_L3
>         tristate
>  
> +config SND_SOC_MC13783
> +	tristate
> +
>  config SND_SOC_PCM3008
>         tristate
>  

Add this to SND_SOC_ALL_CODECS too please.

> --- /dev/null
> +++ b/sound/soc/codecs/mc13783.c
> @@ -0,0 +1,739 @@
> +/*
> + * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
> + * Copyright 2009 Sascha Hauer, s.hauer at pengutronix.de
> + *
> + * Initial development of this code was funded by
> + * Phytec Messtechnik GmbH, http://www.phytec.de

Is this based on the FSL code at all - some of the code (eg, the name of
the define used in the header) makes it look like it's based off
something else?  If so it should probably credit them too.

> +static int mc13783_write(struct snd_soc_codec *codec,
> +	unsigned int reg, unsigned int value)
> +{
> +	struct mc13783_priv *priv = codec->private_data;
> +
> +	priv->reg_cache[reg] = value;
> +
> +	mc13783_reg_write(mc13783, reg, value);
> +
> +	return 0;
> +}

Pass back the return code of the core function?

> +/* sample rates supported by PMIC for stereo playback operations on StDac. */
> +static unsigned int mc13783_rates[] = {
> +	8000, 11025, 12000, 16000,
> +	22050, 24000, 32000,44100,
> +	48000, 64000, 96000
> +};

It'd be good to add a comment explaining that this is used to look up
configurations.

> +			if (rate == mc13783_rates[i]) {
> +				reg = mc13783_read(codec, PMIC_AUDIO_DAC);
> +				/* setup the clock speed */
> +				reg &= ~(0xf << 17);
> +				reg |= i << 17;
> +				mc13783_write(codec, PMIC_AUDIO_DAC, reg);

snd_soc_update_bits() (older drivers don't use this but it really helps
with legibility and will also supress no-change writes for you).

> +static int mc13783_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	unsigned int reg;
> +
> +	if (dai->id == 1)

Some defines in the header for the DAIs might help legibility, both here
and in the machine drivers.

> +static int mc13783_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{

> +	reg |= STEREO_DAC_STD_C_EN;	/* DAC power up */

The DAC power shouldn't need to be controlled here?

> +static int mc13783_set_tdm_slot_codec(struct snd_soc_dai *dai,
> +	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	unsigned int reg;
> +
> +	if (slots != 4)
> +		return -EINVAL;
> +
> +	reg = mc13783_read(codec, PMIC_SSI_NETWORK);
> +
> +	reg &= ~(0xfff << 0);
> +	reg |= (0x00 << 2);	/* primary timeslot RX/TX(?) is 0 */
> +	reg |= (0x01 << 4);	/* secondary timeslot TX is 1 */
> +	reg |= (0x01 << 6);	/* secondary timeslot RX is 1 */

This appears to be pretty much ignoring the supplied arguments and using
a fixed configuration?

> +static int mc13783_asp_val;
> +static int mc13783_alsp_val;

Put these in the CODEC private data.

> +static int mc13783_pcm_get(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
> +	int val;
> +
> +	val = mc13783_read(codec, PMIC_AUDIO_RX_0);
> +	ucontrol->value.enumerated.item[0] = (val >> 22) & 1;
> +
> +        return 0;

Look to be some tab/space problem here and elsewhere in the custom
control code.

> +static struct snd_kcontrol_new mc13783_control_list[] = {
> +	/* Output Routing */
> +	SOC_ENUM_EXT("Asp Source", mc13783_enum[0], mc13783_get_asp, mc13783_put_asp),
> +	SOC_ENUM_EXT("Alsp Source", mc13783_enum[1], mc13783_get_alsp, mc13783_put_alsp),
> +	SOC_ENUM("Ahs Source", mc13783_enum[2]),

Don't use an array of enums - declare individual variables.  For
historical reasons some of the older drivers do do this but it is a bit
hard to read and prone to off by one errors.

> +	SOC_SINGLE("Ahsr enable", PMIC_AUDIO_RX_0, 9, 1, 0),
> +	SOC_SINGLE("Ahsl enable", PMIC_AUDIO_RX_0, 10, 1, 0),
> +	SOC_ENUM("Arxout Source", mc13783_enum[3]),
> +	SOC_SINGLE("ArxoutR enable", PMIC_AUDIO_RX_0, 16, 1, 0),
> +	SOC_SINGLE("ArxoutL enable", PMIC_AUDIO_RX_0, 15, 1, 0),

These controls all look like they should be part of some DAPM routing
configuration for the device and either DAPM controls exposed to users
to set the routing or DAPM widgets automatically managed by the core.
The enums probably want to be muxes, the enables either switches on
mixers or widgets of some kind.

I'm also not sure why these are implemented as hand crafted controls
rather than using the standard register manipulation widgets but I have
to confess I skipped over a lot of them since I couldn't tell what they
were doing from the names alone as I read through the file.

> +	SOC_ENUM("3D Control - Switch", mc13783_enum[5]),

No Switch - Switch means on/off to ALSA.  There's some brief naming
documentation in Documentation/sound/alsa/ControlNames.txt.

> +	/* VAUDIOON -> supply audio part, BIAS enable */
> +	priv->reg_cache[PMIC_AUDIO_RX_0] |= 0x3;

Bias would normally be managed in a set_bias_level() function.

> +#define MC13783_RATES_PLAYBACK (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> +	SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
> +	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)

SNDRV_PCM_RATE_8000_96000 is probably what you want here.

> +/*
> + * OK, this stinks. We currently only can support one MC13783.
> + * Lets take it as an intermediate to turn this stuff into SoC
> + * Audio.
> + */
> +static int mc13783_codec_probe(struct platform_device *pdev)
> +{
> +	struct mc13783_priv *priv;
> +	struct snd_soc_codec *codec;
> +	int ret;
> +
> +	printk(KERN_INFO "MC13783 Audio Codec\n");

Please remove this, it doesn't really add anything.

> +	ret = snd_soc_register_dais(mc13783_dai, ARRAY_SIZE(mc13783_dai));
> +	if (ret)
> +		goto out;
> +
> +	ret = snd_soc_register_codec(codec);
> +	if (ret)
> +		goto out;

You should register the CODEC first then the DAIs since that's what
everything else does (so it'll be less fragile in the future) and
logically the DAIs hang off the CODEC.

> +static int mc13783_codec_remove(struct platform_device *pdev)
> +{
> +	mc13783 = NULL;
> +

Should unregister the things you registered here.
