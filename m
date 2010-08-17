From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Aug 2010 10:58:00 +0100
Subject: [PATCH 1/3] ASoC: add 88pm860x codec driver
In-Reply-To: <AANLkTi=i5H_oJvXzMv71ofxyw9FFXpiXU=pgzf+rdgk0@mail.gmail.com>
References: <AANLkTi=i5H_oJvXzMv71ofxyw9FFXpiXU=pgzf+rdgk0@mail.gmail.com>
Message-ID: <20100817095800.GD18622@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 03:47:59PM +0800, Haojian Zhuang wrote:

> +enum {
> +	FILTER_BYPASS = 0,
> +	FILTER_LOW_PASS_1,
> +	FILTER_LOW_PASS_2,
> +	FILTER_HIGH_PASS_3,
> +	FILTER_MAX,
> +};

This looks to be unused.

> +/* DAPM Widget Events */
> +static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
> +			      struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	/* unmute DAC */
> +	snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, 0);

Can you explain what's going on with this mute handling please?

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_update_bits(codec, PM860X_ADC_EN_1, en1, en1);
> +		snd_soc_update_bits(codec, PM860X_ADC_EN_2, en2, en2);

I still don't follow why you need a custom event for this.

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (dac) {
> +			dac |= MODULATOR;
> +			/* mute */
> +			snd_soc_update_bits(codec, PM860X_DAC_OFFSET,
> +					    DAC_MUTE, DAC_MUTE);

This mute handling looks very suspicious.

> +static int pm860x_mic1_event(struct snd_soc_dapm_widget *w,
> +			     struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		/* Enable Mic1 Bias & MICDET, HSDET */
> +		snd_soc_update_bits(codec, PM860X_ADC_ANA_1, MIC1BIAS_MASK,
> +				    MIC1BIAS_MASK);

As I said last time you should handle this via DAPM.

> +		pm860x_set_bits(codec->control_data, REG_MIC_DET,
> +				MICDET_MASK, MICDET_MASK);
> +		pm860x_set_bits(codec->control_data, REG_HS_DET,
> +				EN_HS_DET, EN_HS_DET);

This should be associated with enabling microphone detection.

> +	/* set master/slave audio interface */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		if (pm860x->dir == PM860X_CLK_DIR_OUT)
> +			*inf |= PCM_INF2_MASTER;
> +		else
> +			return -EINVAL;
> +		break;

You're setting the same register configuration for two different DAI
clock master configurations here.  Presumably one of the settings is
inaccurate?

> +static int pm860x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				 int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
> +
> +	if (dir == PM860X_CLK_DIR_OUT)
> +		pm860x->dir = PM860X_CLK_DIR_OUT;
> +	else
> +		pm860x->dir = PM860X_CLK_DIR_IN;
> +
> +	return 0;
> +}

What is this actually setting - which clock is being configured here?

> +static irqreturn_t pm860x_codec_handler(int irq, void *data)
> +{
> +	struct pm860x_priv *pm860x = data;
> +	int status, shrt, report = 0;
> +
> +	status = pm860x_reg_read(pm860x->i2c, REG_STATUS_1);
> +	shrt = pm860x_reg_read(pm860x->i2c, REG_SHORTS);
> +
> +	if (status & HEADSET_STATUS)
> +		report |= PM860X_DET_HEADSET;
> +	if (status & MIC_STATUS)
> +		report |= PM860X_DET_MIC;
> +	if (status & HOOK_STATUS)
> +		report |= PM860X_DET_HOOK;
> +	if (shrt & (SHORT_LO1 | SHORT_LO2))
> +		report |= PM860X_SHORT_LINEOUT;
> +	if (shrt & (SHORT_HS1 | SHORT_HS2))
> +		report |= PM860X_SHORT_HEADSET;
> +	dev_dbg(pm860x->codec->dev, "report:0x%x\n", report);
> +	return IRQ_HANDLED;

It would seem better to just remove the interrupt handling support
entirely if you're not going to implement jack detection.  Right now all
the curernt code will do is waste power by enabling the feature but
ignoring the result.
