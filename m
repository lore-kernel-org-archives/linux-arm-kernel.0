From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 18 Mar 2010 12:01:53 +0000
Subject: [PATCH 4/5] ASoc: support codec via ssp interface in aspenite
In-Reply-To: <771cded01003171931s6b2a9502o379492396e41e82b@mail.gmail.com>
References: <771cded01003171931s6b2a9502o379492396e41e82b@mail.gmail.com>
Message-ID: <20100318120153.GG3080@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 10:31:43PM -0400, Haojian Zhuang wrote:

>  sound/soc/pxa/Kconfig      |   15 ++-
>  sound/soc/pxa/Makefile     |    4 +
>  sound/soc/pxa/aspenite.c   |  200 +++++++++++++++++++++++
>  sound/soc/pxa/pxa168-ssp.c |  383 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/pxa/pxa168-ssp.h |   42 +++++

As I said when you posted this patch previously you need to split this
up into two separate patches, one adding support for the SSP DAI and the
other adding the machine driver.  The PXA168 support is a separate thing
to the Aspenite machine support.  Please address this for the next
iteration of the patch.

> +	/* Speaker connected to LOUT2/OUT4 & OUT3/ROUT2 */
> +	{"Headset Speaker", NULL, "LOUT2"},
> +	{"Headset Speaker", NULL, "OUT4"},
> +	{"Headset Speaker", NULL, "OUT3"},
> +	{"Headset Speaker", NULL, "ROUT2"},

This looks like it's two speakers rahter than a single one?

> +static int aspenite_hifi_hw_params(struct snd_pcm_substream *substream,
> +				   struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	unsigned int rate, width, channel;
> +	int index, mclk, ret;
> +
> +	rate =  params_rate(params);
> +	width = snd_pcm_format_physical_width(params_format(params));
> +	channel = params_channels(params);
> +	ret = seek_mclk_conf(rate, width, channel);
> +	if (ret < 0)
> +		return ret;

seek_mclk_conf() hasn't been prototyped or declared at this point.

Probably better to include some blank space betwen the assignment of
width and channel and this stuff for legibility.

> +	index = ret;
> +	mclk = get_mclk(ret);
> +
> +	/* set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
> +				  | SND_SOC_DAIFMT_NB_IF
> +				  | SND_SOC_DAIFMT_CBS_CFS);
> +	if (ret < 0)
> +		return ret;

As I said last time it seems odd that you are using an inverted frame
clock here - why is this?  A comment explaining the decision would be
better.

> +static int aspenite_hifi_hw_free(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

As I said last time please remove this function if it's empty.  It is
very disappointing to see all these review comments from last time which
have not been addressed.

> +/* Seek the index of MCLK configuration table */
> +int seek_mclk_conf(int rate, int format, int channel)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mclk_conf); i++) {
> +		if ((mclk_conf[i].rate == rate)
> +			&& (mclk_conf[i].format == format)
> +			&& (mclk_conf[i].channel == channel))
> +			return i;
> +	}
> +	return -EINVAL;
> +}

These functions should all be either static or namespaced.  If they're
supposed to be used by machine drivers they need EXPORT_SYMBOL_GPL().

> + * Set the SSP ports SYSCLK only from Audio SYSCLK.
> + */
> +static int pxa168_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
> +				     unsigned int freq, int dir)
> +{
> +	struct ssp_priv *priv = cpu_dai->private_data;
> +	struct ssp_device *ssp = priv->ssp;
> +	unsigned int sscr0, data, asysdr, asspdr;
> +
> +	dev_dbg(&ssp->pdev->dev, "%s id: %d, clk_id %d, freq %u\n",
> +		__func__, cpu_dai->id, clk_id, freq);
> +
> +	switch (clk_id) {
> +	case PXA168_ASYSCLK_MASTER:
> +	case PXA168_ASYSCLK_SLAVE:
> +		break;

Are these really two different clocks, or is it the same clock as an
input and and ouput in which case the dir parameter should be being
used.

> +	ssp_disable(ssp);
> +	clk_disable(ssp->clk);			/* SSP port internal clock */
> +
> +	/* clear ECS, NCS, MOD, ACS */
> +	sscr0 = ssp_read_reg(ssp, SSCR0);
> +	data = sscr0 & ~(SSCR0_ECS | SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
> +	if (sscr0 != data)
> +		ssp_write_reg(ssp, SSCR0, data);
> +
> +	/* update divider register in MPMU */
> +	__raw_writel(asysdr, MPMU_ASYSDR);
> +	__raw_writel(asspdr, MPMU_ASSPDR);
> +
> +	clk_enable(ssp->clk);			/* SSP port internal clock */
> +	ssp_enable(ssp);

Should the clock enable perhaps be folded into ssp_enable()?

> +static int pxa168_ssp_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{

Does this really need to be different to the PXA2xx SSP port?  I'm not
spotting anything in here that looks outrageously different.  I'm not
spotting anything in here that looks outrageously different.  I'm not
spotting anything in here that looks outrageously different.  I'm not
spotting anything in here that looks outrageously different.

> +struct snd_soc_dai pxa168_ssp_dai[PXA168_DAI_SSP_MAX];
> +EXPORT_SYMBOL(pxa168_ssp_dai);

EXPORT_SYMBOL_GPL, the ASoC core is _GPL.

> +	for (i = 0; i < PXA168_DAI_SSP_MAX; i++) {
> +		dai = &pxa168_ssp_dai[i];
> +		dai->name = "pxa168-ssp";
> +		dai->id = i;
> +		dai->playback.channels_min = 1;
> +		dai->playback.channels_max = 2;
> +		dai->playback.rates = PXA168_SSP_RATES;
> +		dai->playback.formats = PXA168_SSP_FORMATS;
> +		dai->capture.channels_min = 1;
> +		dai->capture.channels_max = 2;
> +		dai->capture.rates = PXA168_SSP_RATES;
> +		dai->capture.formats = PXA168_SSP_FORMATS;
> +		dai->ops = &pxa168_ssp_dai_ops;

Why are these being initialised at runtime?  There's no system
dependencies in the initialisation.

> +
> +#define PXA168_SSP_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |	\
> +			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
> +			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
> +			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |	\
> +			SNDRV_PCM_RATE_96000)

This is SNDRV_PCM_RATE_8000_96000.  Neither this nor the format define
should be being exported to others drivers.

> +/* pxa DAI SSP IDs */
> +enum {
> +	PXA168_DAI_SSP1,
> +	PXA168_DAI_SSP2,
> +	PXA168_DAI_SSP3,
> +	PXA168_DAI_SSP4,
> +	PXA168_DAI_SSP5,
> +	PXA168_DAI_SSP_MAX,
> +};

...

> +extern struct snd_soc_dai pxa168_ssp_dai[5];

These two aren't joined up with each other.
