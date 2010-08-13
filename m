From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Aug 2010 15:23:01 +0100
Subject: [PATCH 4/5] ASoC: add 88pm860x codec driver
In-Reply-To: <AANLkTi=kyxr_0ObZfSLET0Vi2Hp13=H=C1kM9Q2t-eU0@mail.gmail.com>
References: <AANLkTi=kyxr_0ObZfSLET0Vi2Hp13=H=C1kM9Q2t-eU0@mail.gmail.com>
Message-ID: <20100813142301.GD6449@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 09:55:44PM +0800, Haojian Zhuang wrote:

> +static int snd_soc_put_equalizer(struct snd_kcontrol *kcontrol,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
> +
> +	if (ucontrol->value.integer.value[0] >= FILTER_MAX)
> +		return -EINVAL;
> +	pm860x->filter = ucontrol->value.integer.value[0];
> +	switch (pm860x->filter) {
> +	case FILTER_BYPASS:
> +		snd_soc_update_bits(codec, PM860X_I2S_IFACE_4, I2S_EQU_BYP,
> +				    I2S_EQU_BYP);
> +		snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0);
> +		snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0);
> +		snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0);
> +		snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0);
> +		snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0);
> +		snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0);
> +		snd_soc_update_bits(codec, PM860X_EAR_CTRL_2, RSYNC_CHANGE,
> +				    RSYNC_CHANGE);
> +		return 0;

Rather than hard coding every possible set of EQ configurations into the
driver it would be much better to allow the user to supply these via
platform data.  That way if users want to supply their own EQ
coefficients they will be able to.  Several Wolfson CODEC drivers have
examples of doing this.

It's fine to provide a default set of configurations in case the user
doesn't specify anything in platform data.

> +	case FILTER_HIGH_PASS_3:
> +		snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0x55);
> +		snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0x39);
> +		snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0x5a);
> +		snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0xf3);
> +		snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0x7e);
> +		snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0x53);
> +		break;
> +	}

You're also missing a default.

> +/* DAPM Widget Events */
> +static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
> +			      struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
> +
> +	/* unmute DAC */
> +	if (pm860x->automute) {
> +		snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, 0);
> +		pm860x->automute = 0;
> +	}
> +	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
> +			    RSYNC_CHANGE, RSYNC_CHANGE);
> +	return 0;
> +}

What's this doing?  There's also some similar code in the DAC widget
event - I think some comments explaining what's being done here are
required at the very least.

> +static int pm860x_adc_event(struct snd_soc_dapm_widget *w,
> +			    struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	unsigned int en1 = 0, en2 = 0;
> +
> +	if (!strcmp(w->name, "Left ADC")) {
> +		en1 = ADC_MOD_LEFT;
> +		en2 = ADC_LEFT;
> +	}
> +	if (!strcmp(w->name, "Right ADC")) {
> +		en1 = ADC_MOD_RIGHT;
> +		en2 = ADC_RIGHT;
> +	}
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_update_bits(codec, PM860X_ADC_EN_1, en1, en1);
> +		snd_soc_update_bits(codec, PM860X_ADC_EN_2, en2, en2);

Can you do this more simply by using a supply widget for the en1
register bits?

> +static int pm860x_spk_event(struct snd_soc_dapm_widget *w,
> +			    struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	dev_dbg(codec->dev, "event:%x\n", event);
> +	return 0;
> +}

Remove this, it's purely for debug.

> +static const struct soc_enum pm860x_enum[] = {
> +	SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 5, 4, pm860x_opamp_texts),

Don't put your enums in an array, it is error prone and hard to read.
Just define variables for each enum.

> +	SOC_DOUBLE_R_EXT_TLV("Sidetone Capture Volume", PM860X_SIDETONE_L_GAIN,
> +			     PM860X_SIDETONE_R_GAIN, 0, ARRAY_SIZE(st_table)-1,
> +			     0, snd_soc_get_volsw_2r_st,
> +			     snd_soc_put_volsw_2r_st, st_tlv),

The use of Capture in the name looks wrong - Sidetone paths usually go
to the output.  I'd just say Sidetone by itself.

> +/* Headset 1 Mux / Mux15 */
> +static const char *in_text[] = {
> +	"DIGITAL", "ANALOG",

Why ALL CAPS?

> +static int set_dai_fmt(struct pm860x_priv *pm860x, unsigned int fmt,
> +		       unsigned char *inf, unsigned char *mask)
> +{
> +	int ret = 0;

> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	if (ret)
> +		return ret;

It'd be as easy to just return immediately rather than deferring the
return - probably more legible too.

> +	case SND_SOC_DAIFMT_I2S:
> +		*inf |= PCM_EXACT_I2S;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		*inf |= PCM_LEFT_I2S;
> +		break;
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		*inf |= PCM_RIGHT_I2S;
> +		break;

This is wrong - left and right justfied formats are not I2S.  Either the
device doesn't support them or there's some missing configuration.

> +	data = snd_soc_read(codec, PM860X_PCM_IFACE_2) & ~mask;
> +	data |= inf;
> +	snd_soc_write(codec, PM860X_PCM_IFACE_2, data);

snd_soc_update_bits().

> +static int pm860x_pcm_hw_free(struct snd_pcm_substream *substream,
> +			      struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	/* disable PCM interface */
> +	snd_soc_update_bits(codec, PM860X_ADC_EN_2, 1, 0);
> +	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
> +			    RSYNC_CHANGE, RSYNC_CHANGE);
> +	return 0;
> +}

This looks like it should be done by DAPM.

> +static int pm860x_i2s_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	unsigned char inf;
> +	int data;
> +
> +	/*
> +	 * Enable LDO15 for VDD_CODEC, audio charger pump for VDDSTP/VDDSTN
> +	 * and reset audio module.
> +	 */
> +	data = LDO15_EN | CPUMP_EN | AUDIO_EN;
> +	snd_soc_update_bits(codec, PM860X_AUDIO_SUPPLIES_2, data, data);

These look like they should all be handled via DAPM, probably supply
widgets.

> +static int pm860x_i2s_hw_free(struct snd_pcm_substream *substream,
> +			      struct snd_soc_dai *dai)
> +{

This also looks like DAPM stuff.

> +			/* Enable Mic1 Bias & MICDET, HSDET */
> +			pm860x_set_bits(codec->control_data, REG_ADC_ANA_1,
> +					MIC1BIAS_MASK, MIC1BIAS_MASK);
> +			pm860x_set_bits(codec->control_data, REG_MIC_DET,
> +					MICDET_MASK, MICDET_MASK);
> +			pm860x_set_bits(codec->control_data, REG_HS_DET,
> +					EN_HS_DET, EN_HS_DET);

The microphone bias should be handled via DAPM.

> +EXPORT_SYMBOL_GPL(pm860x_dai);

No need to export in multi-component.

> +static irqreturn_t pm860x_codec_handler(int irq, void *data)
> +{
> +	struct pm860x_priv *pm860x = data;
> +	int status, shrt, report = 0;
> +
> +	status = pm860x_reg_read(pm860x->i2c, REG_STATUS_1);
> +	shrt = pm860x_reg_read(pm860x->i2c, REG_SHORTS);
> +
> +	if (pm860x->hsdet.det & PM860X_DET_HEADSET) {
> +		if (status & HEADSET_STATUS)
> +			report |= PM860X_DET_HEADSET;
> +	}
> +	if (pm860x->hsdet.det & PM860X_DET_MIC) {
> +		if (status & MIC_STATUS)
> +			report |= PM860X_DET_MIC;
> +	}
> +	if (pm860x->hsdet.det & PM860X_DET_HOOK) {
> +		if (status & HOOK_STATUS)
> +			report |= PM860X_DET_HOOK;
> +	}
> +	if (pm860x->hsdet.det & PM860X_SHORT_LINEOUT) {
> +		if (shrt & (SHORT_LO1 | SHORT_LO2))
> +			report |= PM860X_SHORT_LINEOUT;
> +	}
> +	if (pm860x->hsdet.det & PM860X_SHORT_HEADSET) {
> +		if (shrt & (SHORT_HS1 | SHORT_HS2))
> +			report |= PM860X_SHORT_HEADSET;
> +	}
> +	snd_soc_jack_report(pm860x->hsdet.jack, report, PM860X_DET_MASK);

This looks very wrong - you're injecting PM860X specific report codes
into the jack subsystem.  You should be reporting codes supplied by the
user, or standard codes at the very least.

> +/*
> + * Enable headset detection via 88PM860x IRQ
> + *
> + * Enable headset detection via IRQ on 88PM860x. If GPIOs are being used to
> + * bring out signals to the processor then processor GPIOs should be
> + * configured using snd_soc_jack_add_gpios() instead.

Is direct export of signals supported by this device, the comment looks
like cut'n'paste from one of my drivers.

> +/* bits definition */
> +#define MUTE_ALL			(1 << 7)

Namespacing.
