From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Aug 2010 15:19:15 +0100
Subject: [alsa-devel] [PATCH 1/3] ASoC: add 88pm860x codec driver
In-Reply-To: <AANLkTimBPhvukwqDGY8iORhY+wg8OnHi9+eOedJB2E8k@mail.gmail.com>
References: <AANLkTimBPhvukwqDGY8iORhY+wg8OnHi9+eOedJB2E8k@mail.gmail.com>
Message-ID: <20100818141914.GC15536@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 18, 2010 at 09:49:26PM +0800, Haojian Zhuang wrote:

> +		if (dac) {
> +			/* automute is set before operating DAC. Anti-pop */
> +			mutex_lock(&pm860x->mutex);
> +			pm860x->automute = 1;
> +			dac |= MODULATOR;
> +			/* mute */
> +			snd_soc_update_bits(codec, PM860X_DAC_OFFSET,
> +					    DAC_MUTE, DAC_MUTE);
> +			snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
> +					    RSYNC_CHANGE, RSYNC_CHANGE);
> +			mutex_unlock(&pm860x->mutex);
> +			/* update dac */
> +			snd_soc_update_bits(codec, PM860X_DAC_EN_2,
> +					    dac, dac);
> +		}


I still can't follow what this automute variable is supposed to be
doing.  In both the PMU and the PMD cases you set automute, and the fact
that you forcibly clear it when you apply the change means that it
doesn't look like it's doing anything I'd recognise as automute,
suggesting that the variable is misnamed.  It's very difficult to follow
what all this is supposed to be doing.

As I said last time what I'd expect to see is a user visible mute
control which sets a variable in the driver which is then updated in the
chip only while the DAC is powered.  The other option is to tie the
control to the DAC power, in which case things should be handleable in
the widget event without the variable.

> +static int pm860x_digital_mute(struct snd_soc_dai *codec_dai, int mute)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	int data = 0;
> +
> +	if (mute)
> +		data = DAC_MUTE;
> +	snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, data);

This isn't joined up at all with the automute code above...

> +	/* set master/slave audio interface */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		if (pm860x->dir == PM860X_CLK_DIR_OUT) {
> +			inf |= PCM_INF2_MASTER;
> +			ret = 0;

This is still setting the same register value for two different DAI
formats.  You need to fix this, and in the other set_fmt() function.

You're also missing a default: case.

> +	if ((pm860x->det.hs_shrt & SND_JACK_BTN_0)
> +		&& (shrt & (SHORT_HS1 | SHORT_HS2)))
> +		report |= SND_JACK_BTN_0;
> +
> +	if ((pm860x->det.hook_det & SND_JACK_BTN_1)
> +		&& (status & HOOK_STATUS))
> +		report |= SND_JACK_BTN_1;
> +
> +	if ((pm860x->det.lo_shrt & SND_JACK_BTN_2)
> +		&& (shrt & (SHORT_LO1 | SHORT_LO2)))
> +		report |= SND_JACK_BTN_2;

You should ideally allow the user to override these via platform data if
the buttons have specific functions.

One other thing you should do is split the jack configuration for
headphone and microphone - a system may have two physical jacks, one for
each, so you should allow the user to configure the detection onto
separate jacks if they want to.
