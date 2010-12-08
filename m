From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Dec 2010 13:05:58 +0000
Subject: [PATCH 2/3] ASoC: CS4271 codec support
In-Reply-To: <1291809772.31916.4.camel@r60e>
References: <1291809772.31916.4.camel@r60e>
Message-ID: <20101208130558.GE16418@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 03:02:52PM +0300, Alexander wrote:

> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Added support for CS4271 codec to ASoC.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

Overall this looks very good but a few issues below, mostly coding
style/clarity.

> +static int cs4271_set_dai_fmt(struct snd_soc_dai *codec_dai,
> +			      unsigned int format)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
> +
> +	cs4271->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
> +
> +	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
> +	default:
> +		dev_err(codec->dev, "Invalid DAI format\n");
> +		return -EINVAL;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		cs4271->master = 0;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		cs4271->master = 1;
> +	}

Missing break;  It's also much more usual to have the default: case be
the last one.  Similarly for your other switch statements.

> +	/* Configure ADC */
> +	snd_soc_update_bits(codec, CS4271_ADCCTL, CS4271_ADCCTL_ADC_DIF_MASK,
> +		(cs4271->mode == SND_SOC_DAIFMT_I2S) ?
> +		CS4271_ADCCTL_ADC_DIF_I2S : CS4271_ADCCTL_ADC_DIF_LJ);

Please don't use the ternery operator like this, it's not terribly
legible.

> +static const char *cs4271_de_texts[] = {"None", "44.1KHz", "48KHz", "32KHz"};
> +static const struct soc_enum cs4271_de_enum =
> +	SOC_ENUM_SINGLE(CS4271_DACCTL, 4, 4, cs4271_de_texts);

Ideally the deemphasis would be managed based on the sample rate.

> +struct snd_soc_dai_driver cs4271_dai = {
> +	.name = "cs4271-hifi",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = SNDRV_PCM_RATE_8000_96000,
> +		.rate_min = 8000,
> +		.rate_max = 96000,

No need to set rate_min and rate_max if rates is set.

Looking at the code above I suspect you need to set symmetric_rates on
the DAI too - it looks like the playback and capture must be at the same
rate.

> +/*
> + * This function writes all writeble registers from cache to codec.
> + * It's used to setup initial config and restore after suspend.
> + */
> +static int cs4271_write_cache(struct snd_soc_codec *codec)
> +{
> +	int i, ret;
> +
> +	for (i = CS4271_LASTREG; i >= CS4271_FIRSTREG; i--) {
> +		ret = snd_soc_write(codec, i, snd_soc_read(codec, i));
> +		if (ret) {
> +			dev_err(codec->dev, "Cache write failed\n");
> +			return ret;
> +		}
> +	}

If you use the standard cache code in soc-cache.c there's a standard
cache sync implementation you could use - snd_soc_cache_sync().

> +#ifdef CONFIG_PM
> +static int cs4271_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
> +{
> +	/* Set power-down bit */
> +	snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN,
> +		CS4271_MODE2_PDN);
> +
> +	return 0;
> +}
> +#else
> +#define cs4271_soc_suspend	NULL
> +#endif /* CONFIG_PM */
> +
> +static int cs4271_soc_resume(struct snd_soc_codec *codec)
> +{

A comment explaining why this isn't in the ifdef above would be useful.
I guessed why it was being done before I searched but it'd be good to be
clear.

> +	if ((gpio_disable >= 0) &&
> +		gpio_request(gpio_disable, "CS4271 Disable"))
> +		gpio_disable = -EINVAL;
> +	if (gpio_disable >= 0)
> +		gpio_direction_output(gpio_disable, 0);

This is quite hard to read.  One issue is that the indentation of the
second argument to the && is very confusing as it's lined up with the
contents of the if statement, the other is that non-explicit check on
the return value of gpio_request() means the expected value is not so
clear as it could be.

> +static struct i2c_driver cs4271_i2c_driver = {
> +	.driver = {
> +		.name	= "cs4271-codec",

No need for the -codec.
