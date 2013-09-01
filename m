From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 01 Sep 2013 19:32:42 +0200
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901120454.GP6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130901064216.GN6617@n2100.arm.linux.org.uk> <5222EFE5.3010306@metafoo.de>
 <20130901085121.GO6617@n2100.arm.linux.org.uk> <52231225.8080704@metafoo.de>
 <20130901120454.GP6617@n2100.arm.linux.org.uk>
Message-ID: <52237A3A.7060805@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2013 02:04 PM, Russell King - ARM Linux wrote:
> On Sun, Sep 01, 2013 at 12:08:37PM +0200, Lars-Peter Clausen wrote:
>> On 09/01/2013 10:51 AM, Russell King - ARM Linux wrote:
>>> If you'd look at my other responses, you'll see that this is what I tried
>>> back in May, and I was unhappy about that solution because:
>>>
>>> 1. there is no guarantee that they couldn't be used at the same time.
>>> 2. this results in two entirely separate "CPU DAI"s, each with their
>>>    own independent sample rate/format settings, which if they happen
>>>    to be used together will result in fighting over the same register(s).
>>
>> I know, but you can make it policy that only one of them may be used at a
>> time. Furthermore you can add a check to the startup() callback to return an
>> error, if the other DAI is active.
> 
> Okay, but can you confirm a few things:
> 
> 1. It is my understanding that the startup() callback will be called when
>    the ALSA control device is opened (/dev/snd/controlC*).

Yes.

> 
> 2. With two CPU DAIs, won't this cause there to be two ALSA PCM and ALSA
>    control devices if they are both bound?  IOW, /dev/snd/controlC0 and
>    /dev/snd/controlC1 ?  It is my understanding that one ALSA PCM
>    instance is registered for each CPU DAI which is "linked up" via a
>    DAI link.
> 

Yes, but only if you create a link for both the I2S and and the SPDIF DAI.
And as I understood you you don't necessarily need to do that and it is more
of a nice to have.

> If that is so, then it's not going to behave well with pulseaudio should
> both end up being bound - with that running, pulseaudio will try to open
> every /dev/snd/controlC* file that it finds, and any errors that it
> finds, it just retries as fast as it possibly can.
> 
>>> Moreover, this results in a completely different set of changes to the
>>> driver which are in an opposing direction to the DPCM approach.
>>>
>>
>> I think the patch is actually going to be maybe a 100 lines or so and it
>> gives you something to work with and unlike your current approach is not
>> trying to work around the framework. Then you can add the other patches
>> adding the SPDIF controls on top of it. Once that's done you can concentrate
>> on trying to get DPCM running.
> 
> Yes, which will mean effectively reverting the diff below - it is my
> understanding that this set plus the split in the DAI links is the full
> DPCM configuration required from the driver layers of ASoC.
> 
> However, I'm much less certain that the result of applying this delta
> is correct for existing platforms - particularly the CPU DAI names in
> their DAI link structures.  As I don't have any of those platforms,
> that's something I can't test.

Instead of that custom name generation you implemented in your patch the
name of the DAIs should always be the same and not depend on the platform
device id. Then in the link config use both cpu_name and cpu_dai_name.

E.g.

{
	...
	.cpu_name = "mvebu-audio.0"
	.cpu_dai_name = "mvebu-audio-spdif",
	...
}

cpu_name is the dev_name() of the device and cpu_dai_name the name of the DAI.

And well for devicetree phandles should be used.

> 
> In my opinion, this is a large delta to put in and then have to take
> back out again when the problems with DPCM get resolved.  Linus'
> objections over pointless churn which have been levelled at the ARM
> community come to mind.

I wouldn't worry about that, the patch below is against your working branch,
the patch should be a lot smaller against the ASoC tree.

- Lars

> 
>  sound/soc/kirkwood/kirkwood-i2s.c    |  318 ++++++++++++++++------------------
>  sound/soc/kirkwood/kirkwood-openrd.c |   10 +-
>  sound/soc/kirkwood/kirkwood-t5325.c  |    6 +-
>  sound/soc/kirkwood/kirkwood.h        |    5 +-
>  4 files changed, 157 insertions(+), 182 deletions(-)
> 
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index 11f51e0..6a441cc 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -211,19 +211,44 @@ static int kirkwood_i2s_startup(struct snd_pcm_substream *substream,
>  {
>  	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
>  
> +	if (priv->active_dai && priv->active_dai != dai)
> +		return -EBUSY;
> +	priv->active_dai = dai;
> +
>  	snd_soc_dai_set_dma_data(dai, substream, priv);
>  	return 0;
>  }
>  
> +static void kirkwood_i2s_shutdown(struct snd_pcm_substream *substream,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
> +
> +	if (priv->active_dai == dai)
> +		priv->active_dai = NULL;
> +}
> +
>  static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
>  				 struct snd_pcm_hw_params *params,
>  				 struct snd_soc_dai *dai)
>  {
>  	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
> -	uint32_t ctl_play, ctl_rec;
> +	uint32_t ctl_play, ctl_rec, ctl_play_mask, ctl_rec_mask;
>  	unsigned int i2s_reg;
>  	unsigned long i2s_value;
>  
> +	/*
> +	 * Select the playback/record enable masks according to which
> +	 * DAI is being used.
> +	 */
> +	if (dai->id == 0) {
> +		ctl_play_mask = KIRKWOOD_PLAYCTL_I2S_EN;
> +		ctl_rec_mask = KIRKWOOD_RECCTL_I2S_EN;
> +	} else {
> +		ctl_play_mask = KIRKWOOD_PLAYCTL_SPDIF_EN;
> +		ctl_rec_mask = KIRKWOOD_RECCTL_SPDIF_EN;
> +	}
> +
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  		i2s_reg = KIRKWOOD_I2S_PLAYCTL;
>  	} else {
> @@ -242,38 +267,27 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
>  		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_16;
> -		ctl_play = KIRKWOOD_PLAYCTL_SIZE_16_C |
> -			   KIRKWOOD_PLAYCTL_I2S_EN |
> -			   KIRKWOOD_PLAYCTL_SPDIF_EN;
> -		ctl_rec = KIRKWOOD_RECCTL_SIZE_16_C |
> -			  KIRKWOOD_RECCTL_I2S_EN;
> +		ctl_play = KIRKWOOD_PLAYCTL_SIZE_16_C | ctl_play_mask;
> +		ctl_rec = KIRKWOOD_RECCTL_SIZE_16_C | ctl_rec_mask;
>  		break;
>  	/*
>  	 * doesn't work... S20_3LE != kirkwood 20bit format ?
>  	 *
>  	case SNDRV_PCM_FORMAT_S20_3LE:
>  		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_20;
> -		ctl_play = KIRKWOOD_PLAYCTL_SIZE_20 |
> -			   KIRKWOOD_PLAYCTL_I2S_EN |
> -			   KIRKWOOD_PLAYCTL_SPDIF_EN;
> -		ctl_rec = KIRKWOOD_RECCTL_SIZE_20 |
> -			  KIRKWOOD_RECCTL_I2S_EN;
> +		ctl_play = KIRKWOOD_PLAYCTL_SIZE_20 | ctl_play_mask;
> +		ctl_rec = KIRKWOOD_RECCTL_SIZE_20 | ctl_rec_mask;
>  		break;
>  	*/
>  	case SNDRV_PCM_FORMAT_S24_LE:
>  		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_24;
> -		ctl_play = KIRKWOOD_PLAYCTL_SIZE_24 |
> -			   KIRKWOOD_PLAYCTL_I2S_EN |
> -			   KIRKWOOD_PLAYCTL_SPDIF_EN;
> -		ctl_rec = KIRKWOOD_RECCTL_SIZE_24 |
> -			  KIRKWOOD_RECCTL_I2S_EN;
> +		ctl_play = KIRKWOOD_PLAYCTL_SIZE_24 | ctl_play_mask;
> +		ctl_rec = KIRKWOOD_RECCTL_SIZE_24 | ctl_rec_mask;
>  		break;
>  	case SNDRV_PCM_FORMAT_S32_LE:
>  		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_32;
> -		ctl_play = KIRKWOOD_PLAYCTL_SIZE_32 |
> -			   KIRKWOOD_PLAYCTL_I2S_EN;
> -		ctl_rec = KIRKWOOD_RECCTL_SIZE_32 |
> -			  KIRKWOOD_RECCTL_I2S_EN;
> +		ctl_play = KIRKWOOD_PLAYCTL_SIZE_32 | ctl_play_mask;
> +		ctl_rec = KIRKWOOD_RECCTL_SIZE_32 | ctl_rec_mask;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -286,11 +300,12 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
>  			ctl_play |= KIRKWOOD_PLAYCTL_MONO_OFF;
>  
>  		priv->ctl_play &= ~(KIRKWOOD_PLAYCTL_MONO_MASK |
> -				    KIRKWOOD_PLAYCTL_ENABLE_MASK |
> +				    ctl_play_mask |
>  				    KIRKWOOD_PLAYCTL_SIZE_MASK);
>  		priv->ctl_play |= ctl_play;
>  	} else {
> -		priv->ctl_rec &= ~KIRKWOOD_RECCTL_SIZE_MASK;
> +		priv->ctl_rec &= ~(KIRKWOOD_RECCTL_SIZE_MASK |
> +				   ctl_rec_mask);
>  		priv->ctl_rec |= ctl_rec;
>  	}
>  
> @@ -303,7 +318,13 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
>  				int cmd, struct snd_soc_dai *dai)
>  {
>  	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
> -	uint32_t ctl, value;
> +	uint32_t ctl, value, mute_mask;
> +
> +	if (dai->id == 0) {
> +		mute_mask = KIRKWOOD_PLAYCTL_I2S_MUTE;
> +	} else {
> +		mute_mask = KIRKWOOD_PLAYCTL_SPDIF_MUTE;
> +	}
>  
>  	ctl = readl(priv->io + KIRKWOOD_PLAYCTL);
>  	if (ctl & KIRKWOOD_PLAYCTL_PAUSE) {
> @@ -329,7 +350,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  		/* configure */
> -		ctl = priv->ctl_play & priv->ctl_play_mask;
> +		ctl = priv->ctl_play;
>  		value = ctl & ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
>  		writel(value, priv->io + KIRKWOOD_PLAYCTL);
>  
> @@ -344,7 +365,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
>  
>  	case SNDRV_PCM_TRIGGER_STOP:
>  		/* stop audio, disable interrupts */
> -		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
> +		ctl |= KIRKWOOD_PLAYCTL_PAUSE | mute_mask;
>  		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
>  
>  		value = readl(priv->io + KIRKWOOD_INT_MASK);
> @@ -358,13 +379,13 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
>  
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
> -		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
> +		ctl |= KIRKWOOD_PLAYCTL_PAUSE | mute_mask;
>  		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
>  		break;
>  
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE);
> +		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | mute_mask);
>  		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
>  		break;
>  
> @@ -447,151 +468,56 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>  	return 0;
>  }
>  
> -static int kirkwood_i2s_play_i2s(struct snd_soc_dapm_widget *w,
> -	struct snd_kcontrol *ctl, int event)
> -{
> -	/* CPU DAI is not available, so use driver data from device */
> -	struct kirkwood_dma_data *priv = dev_get_drvdata(w->dapm->dev);
> -
> -	if (SND_SOC_DAPM_EVENT_ON(event))
> -		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_I2S_EN;
> -	else
> -		priv->ctl_play_mask &= ~KIRKWOOD_PLAYCTL_I2S_EN;
> -
> -	return 0;
> -}
> -
> -static int kirkwood_i2s_play_spdif(struct snd_soc_dapm_widget *w,
> -	struct snd_kcontrol *ctl, int event)
> -{
> -	/* CPU DAI is not available, so use driver data from device */
> -	struct kirkwood_dma_data *priv = dev_get_drvdata(w->dapm->dev);
> -
> -	if (SND_SOC_DAPM_EVENT_ON(event))
> -		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_SPDIF_EN;
> -	else
> -		priv->ctl_play_mask &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;
> -
> -	return 0;
> -}
> -
> -static const struct snd_soc_dapm_widget widgets[] = {
> -	/* These widget names come from the names from the functional spec */
> -	SND_SOC_DAPM_AIF_OUT_E("i2sdo", "dma-tx",
> -		0, SND_SOC_NOPM, 0, 0, kirkwood_i2s_play_i2s,
> -		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> -	SND_SOC_DAPM_AIF_OUT_E("spdifdo", "dma-tx",
> -		0, SND_SOC_NOPM, 0, 0, kirkwood_i2s_play_spdif,
> -		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> -	SND_SOC_DAPM_AIF_IN("i2sdi", "dma-rx",
> -		0, SND_SOC_NOPM, 0, 0),
> -};
> -
> -static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
> -{
> -	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
> -	unsigned long value;
> -	unsigned int reg_data;
> -	int ret;
> -
> -	ret = snd_soc_add_dai_controls(dai, kirkwood_i2s_iec958_controls,
> -				ARRAY_SIZE(kirkwood_i2s_iec958_controls));
> -	if (ret) {
> -		dev_err(dai->dev,
> -			"unable to add soc card controls: %d\n", ret);
> -		return ret;
> -	}
> -
> -	/* It appears that these can't be attached to the CPU DAI */
> -	snd_soc_dapm_new_controls(&dai->dapm, widgets, ARRAY_SIZE(widgets));
> -
> -	/* put system in a "safe" state : */
> -	/* disable audio interrupts */
> -	writel(0xffffffff, priv->io + KIRKWOOD_INT_CAUSE);
> -	writel(0, priv->io + KIRKWOOD_INT_MASK);
> -
> -	reg_data = readl(priv->io + 0x1200);
> -	reg_data &= (~(0x333FF8));
> -	reg_data |= 0x111D18;
> -	writel(reg_data, priv->io + 0x1200);
> -
> -	msleep(500);
> -
> -	reg_data = readl(priv->io + 0x1200);
> -	reg_data &= (~(0x333FF8));
> -	reg_data |= 0x111D18;
> -	writel(reg_data, priv->io + 0x1200);
> -
> -	priv->ctl_play_mask = ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
> -
> -	/* disable playback/record */
> -	value = readl(priv->io + KIRKWOOD_PLAYCTL);
> -	value &= ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
> -	writel(value, priv->io + KIRKWOOD_PLAYCTL);
> -
> -	value = readl(priv->io + KIRKWOOD_RECCTL);
> -	value &= ~(KIRKWOOD_RECCTL_I2S_EN | KIRKWOOD_RECCTL_SPDIF_EN);
> -	writel(value, priv->io + KIRKWOOD_RECCTL);
> -
> -	return 0;
> -
> -}
> -
> -static int kirkwood_i2s_remove(struct snd_soc_dai *dai)
> -{
> -	return 0;
> -}
> -
>  static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
>  	.startup	= kirkwood_i2s_startup,
> +	.shutdown	= kirkwood_i2s_shutdown,
>  	.trigger	= kirkwood_i2s_trigger,
>  	.hw_params      = kirkwood_i2s_hw_params,
>  	.set_fmt        = kirkwood_i2s_set_fmt,
>  };
>  
> +static int kirkwood_spdif_probe(struct snd_soc_dai *dai)
> +{
> +	int ret = snd_soc_add_dai_controls(dai, kirkwood_i2s_iec958_controls,
> +				ARRAY_SIZE(kirkwood_i2s_iec958_controls));
> +	if (ret)
> +		dev_err(dai->dev, "unable to add soc card controls\n");
>  
> -static struct snd_soc_dai_driver kirkwood_i2s_dai = {
> -	.probe = kirkwood_i2s_probe,
> -	.remove = kirkwood_i2s_remove,
> -	.playback = {
> -		.stream_name = "dma-tx",
> -		.channels_min = 1,
> -		.channels_max = 2,
> -		.rates = KIRKWOOD_I2S_RATES,
> -		.formats = KIRKWOOD_I2S_FORMATS,
> -	},
> -	.capture = {
> -		.stream_name = "dma-rx",
> -		.channels_min = 1,
> -		.channels_max = 2,
> -		.rates = KIRKWOOD_I2S_RATES,
> -		.formats = KIRKWOOD_I2S_FORMATS,
> -	},
> -	.ops = &kirkwood_i2s_dai_ops,
> -};
> +	return ret;
> +}
>  
> -static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
> -	.probe = kirkwood_i2s_probe,
> -	.remove = kirkwood_i2s_remove,
> -	.playback = {
> -		.stream_name = "dma-tx",
> -		.channels_min = 1,
> -		.channels_max = 2,
> -		.rates = SNDRV_PCM_RATE_8000_192000 |
> -			 SNDRV_PCM_RATE_CONTINUOUS |
> -			 SNDRV_PCM_RATE_KNOT,
> -		.formats = KIRKWOOD_I2S_FORMATS,
> -	},
> -	.capture = {
> -		.stream_name = "dma-rx",
> -		.channels_min = 1,
> -		.channels_max = 2,
> -		.rates = SNDRV_PCM_RATE_8000_192000 |
> -			 SNDRV_PCM_RATE_CONTINUOUS |
> -			 SNDRV_PCM_RATE_KNOT,
> -		.formats = KIRKWOOD_I2S_FORMATS,
> +static struct snd_soc_dai_driver kirkwood_dais[KIRKWOOD_NUM_DAIS] = {
> +	{
> +		.name = "kirkwood-i2s.%d",
> +		.ops = &kirkwood_i2s_dai_ops,
> +		.playback = {
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = KIRKWOOD_I2S_RATES,
> +			.formats = KIRKWOOD_I2S_FORMATS,
> +		},
> +		.capture = {
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = KIRKWOOD_I2S_RATES,
> +			.formats = KIRKWOOD_I2S_FORMATS,
> +		},
> +		.symmetric_rates = 1,
> +	}, {
> +		.name = "kirkwood-spdif.%d",
> +		.probe = kirkwood_spdif_probe,
> +		.ops = &kirkwood_i2s_dai_ops,
> +		.playback = {
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = KIRKWOOD_I2S_RATES,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +				   SNDRV_PCM_FMTBIT_S24_LE |
> +				   SNDRV_PCM_FMTBIT_S32_LE |
> +				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE |
> +				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE,
> +		},
>  	},
> -	.ops = &kirkwood_i2s_dai_ops,
>  };
>  
>  static const struct snd_soc_component_driver kirkwood_i2s_component = {
> @@ -601,10 +527,10 @@ static const struct snd_soc_component_driver kirkwood_i2s_component = {
>  static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>  {
>  	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
> -	struct snd_soc_dai_driver *soc_dai = &kirkwood_i2s_dai;
>  	struct kirkwood_dma_data *priv;
>  	struct resource *mem;
> -	int err;
> +	int i, err;
> +	u32 val;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv) {
> @@ -613,6 +539,24 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>  	}
>  	dev_set_drvdata(&pdev->dev, priv);
>  
> +	memcpy(priv->dai_driver, kirkwood_dais, sizeof(priv->dai_driver));
> +
> +	/* format the DAI names according to the platform device ID */
> +	for (i = 0; i < KIRKWOOD_NUM_DAIS; i++) {
> +		const char *fmt = priv->dai_driver[i].name;
> +		char *name, *p;
> +
> +		if (pdev->id < 0) {
> +			name = kstrdup(fmt, GFP_KERNEL);
> +			p = strchr(name, '.');
> +			if (p)
> +				*p = '\0';
> +		} else {
> +			name = kasprintf(GFP_KERNEL, fmt, pdev->id);
> +		}
> +		priv->dai_driver[i].name = name;
> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->io = devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(priv->io))
> @@ -647,9 +591,23 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>  			devm_clk_put(&pdev->dev, priv->extclk);
>  			priv->extclk = ERR_PTR(-EINVAL);
>  		} else {
> +			int i;
> +
>  			dev_info(&pdev->dev, "found external clock\n");
>  			clk_prepare_enable(priv->extclk);
> -			soc_dai = &kirkwood_i2s_dai_extclk;
> +
> +			for (i = 0; i < KIRKWOOD_NUM_DAIS; i++) {
> +				if (priv->dai_driver[i].playback.rates)
> +					priv->dai_driver[i].playback.rates =
> +						SNDRV_PCM_RATE_8000_192000 |
> +						SNDRV_PCM_RATE_CONTINUOUS |
> +						SNDRV_PCM_RATE_KNOT;
> +				if (priv->dai_driver[i].capture.rates)
> +					priv->dai_driver[i].capture.rates =
> +						SNDRV_PCM_RATE_8000_192000 |
> +						SNDRV_PCM_RATE_CONTINUOUS |
> +						SNDRV_PCM_RATE_KNOT;
> +			}
>  		}
>  	}
>  
> @@ -666,8 +624,35 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>  		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_128;
>  	}
>  
> +	/* put system in a "safe" state : disable audio interrupts */
> +	writel(0xffffffff, priv->io + KIRKWOOD_INT_CAUSE);
> +	writel(0, priv->io + KIRKWOOD_INT_MASK);
> +
> +	val = readl(priv->io + 0x120c);
> +	val = readl(priv->io + 0x1200);
> +	val &= (~(0x333FF8));
> +	val |= 0x111D18;
> +	writel(val, priv->io + 0x1200);
> +
> +	msleep(500);
> +
> +	val = readl(priv->io + 0x1200);
> +	val &= (~(0x333FF8));
> +	val |= 0x111D18;
> +	msleep(500);
> +	writel(val, priv->io + 0x1200);
> +
> +	/* disable playback/record */
> +	val = readl(priv->io + KIRKWOOD_PLAYCTL);
> +	val &= ~(KIRKWOOD_PLAYCTL_I2S_EN|KIRKWOOD_PLAYCTL_SPDIF_EN);
> +	writel(val, priv->io + KIRKWOOD_PLAYCTL);
> +
> +	val = readl(priv->io + KIRKWOOD_RECCTL);
> +	val &= ~(KIRKWOOD_RECCTL_I2S_EN | KIRKWOOD_RECCTL_SPDIF_EN);
> +	writel(val, priv->io + KIRKWOOD_RECCTL);
> +
>  	err = snd_soc_register_component(&pdev->dev, &kirkwood_i2s_component,
> -					 soc_dai, 1);
> +					 priv->dai_driver, KIRKWOOD_NUM_DAIS);
>  	if (err) {
>  		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
>  		goto err_component;
> @@ -679,7 +664,6 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>  		goto err_platform;
>  	}
>  	return 0;
> -
>   err_platform:
>  	snd_soc_unregister_component(&pdev->dev);
>   err_component:
> diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
> index 258fcce..c92f42a 100644
> --- a/sound/soc/kirkwood/kirkwood-openrd.c
> +++ b/sound/soc/kirkwood/kirkwood-openrd.c
> @@ -50,12 +50,11 @@ static struct snd_soc_ops openrd_client_ops = {
>  };
>  
>  
> -/* This will need to be updated when DPCM support works. */
>  static struct snd_soc_dai_link openrd_client_dai[] = {
>  {
>  	.name = "CS42L51",
>  	.stream_name = "CS42L51 HiFi",
> -	.cpu_dai_name = "mvebu-audio",
> +	.cpu_dai_name = "kirkwood-i2s.0",
>  	.platform_name = "mvebu-audio",
>  	.codec_dai_name = "cs42l51-hifi",
>  	.codec_name = "cs42l51-codec.0-004a",
> @@ -64,19 +63,12 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
>  },
>  };
>  
> -static const struct snd_soc_dapm_route routes[] = {
> -	/* Connect the codec streams to the I2S connections */
> -	{ "Playback", NULL, "i2sdo" },
> -	{ "i2sdi", NULL, "Capture" },
> -};
>  
>  static struct snd_soc_card openrd_client = {
>  	.name = "OpenRD Client",
>  	.owner = THIS_MODULE,
>  	.dai_link = openrd_client_dai,
>  	.num_links = ARRAY_SIZE(openrd_client_dai),
> -	.dapm_routes = routes,
> -	.num_dapm_routes = ARRAY_SIZE(routes),
>  };
>  
>  static int openrd_probe(struct platform_device *pdev)
> diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
> index 5f5ae08..02911f7 100644
> --- a/sound/soc/kirkwood/kirkwood-t5325.c
> +++ b/sound/soc/kirkwood/kirkwood-t5325.c
> @@ -52,9 +52,6 @@ static const struct snd_soc_dapm_route t5325_route[] = {
>  
>  	{ "MIC1",		NULL,	"Mic Jack" },
>  	{ "MIC2",		NULL,	"Mic Jack" },
> -
> -	{ "i2sdi",		NULL,	"Capture" },
> -	{ "Playback",		NULL,	"i2sdo" },
>  };
>  
>  static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
> @@ -69,12 +66,11 @@ static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
>  	return 0;
>  }
>  
> -/* This will need to be updated when DPCM support works. */
>  static struct snd_soc_dai_link t5325_dai[] = {
>  {
>  	.name = "ALC5621",
>  	.stream_name = "ALC5621 HiFi",
> -	.cpu_dai_name = "mvebu-audio",
> +	.cpu_dai_name = "kirkwood-i2s.0",
>  	.platform_name = "mvebu-audio",
>  	.codec_dai_name = "alc5621-hifi",
>  	.codec_name = "alc562x-codec.0-001a",
> diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
> index 17b48a6..595e0fe 100644
> --- a/sound/soc/kirkwood/kirkwood.h
> +++ b/sound/soc/kirkwood/kirkwood.h
> @@ -161,13 +161,16 @@
>  #define KIRKWOOD_SND_MAX_BUFFER_BYTES		(KIRKWOOD_SND_MAX_PERIOD_BYTES \
>  						 * KIRKWOOD_SND_MAX_PERIODS)
>  
> +#define KIRKWOOD_NUM_DAIS 2
> +
>  struct kirkwood_dma_data {
>  	void __iomem *io;
>  	struct clk *clk;
>  	struct clk *extclk;
> -	uint32_t ctl_play_mask;
>  	uint32_t ctl_play;
>  	uint32_t ctl_rec;
> +	struct snd_soc_dai *active_dai;
> +	struct snd_soc_dai_driver dai_driver[KIRKWOOD_NUM_DAIS];
>  	struct snd_pcm_substream *substream_play;
>  	struct snd_pcm_substream *substream_rec;
>  	int irq;
> 
