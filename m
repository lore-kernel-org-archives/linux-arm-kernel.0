From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 19 Nov 2009 19:03:00 +0000
Subject: [alsa-devel] [PATCH 07/12] add phycore sound support
In-Reply-To: <1258645706-9071-8-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20091119190300.GB2814@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 04:48:21PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

> +	if (machine_is_pcm038() || machine_is_pcm037()) {

Just check when probing the driver.

> +		snd_soc_dai_set_fmt(cpu_dai,
> +				SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +				SND_SOC_DAIFMT_CBM_CFM);
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			snd_soc_dai_set_fmt(codec_dai,
> +				SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +				SND_SOC_DAIFMT_CBM_CFM);
> +		} else {
> +			snd_soc_dai_set_fmt(codec_dai,
> +				SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF |
> +				SND_SOC_DAIFMT_CBM_CFM);
> +			snd_soc_dai_set_tdm_slot(codec_dai, 0, 0, 4, 0);
> +		}

This looks very wrong.  The CPU is unconditionally configured to use I2S
mode but the CODEC may be configured to use either I2S or DSP mode
depending on the direction of audio.  The CPU and CODEC should at least
be in the same mode...

> +		/* Put DC field of STCCR to 1 (not zero) */
> +		ret = cpu_dai->ops->set_tdm_slot(cpu_dai, 0x0, 0xfffffffc, 4, 0);

That comment doesn't really clarify anything for me...

> +static int imx_phycore_hifi_hw_free(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

> +static int imx_phycore_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int imx_phycore_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Remove these if they have no content.

> +#ifdef CONFIG_SND_SOC_WM9712
> +static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
> +	{
> +		.name		= "HiFi",
> +		.stream_name	= "HiFi",
> +		.codec_dai	= &wm9712_dai[WM9712_DAI_AC97_HIFI],
> +		.ops		= &imx_phycore_hifi_ops,
> +	},
> +};
> +#endif

I'd make this a second machine driver, it doesn't appear to have
anything in common with the Atlas based system and the conditionals make
everything more complicated.
