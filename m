From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 9 Jul 2011 03:25:01 +0100
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using
	mc13783 codec
In-Reply-To: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
Message-ID: <20110709022501.GA26900@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 03:24:51PM +0200, J??rgen Lambrecht wrote:

Please read and try to follow the guidelines in SubmittingPatches:
- Provide a sensible changelog for your patch
- Send copies to the relevant maintainers
- Word wrap within 80 columns
- Follow the kernel coding style.

>  
>  if SND_IMX_SOC
>  
> -config SND_MXC_SOC_SSI
> -	tristate
> -

This appeears to be unrelated to adding new machine support and should
be a separate patch.

> +config SND_SOC_IMX_MC13783
> +	tristate
> +

Err...  what is this for?

>  config SND_MXC_SOC_WM1133_EV1
>  	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
>  	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
>  	select SND_SOC_WM8350
> -	select SND_MXC_SOC_SSI
>  	select SND_MXC_SOC_FIQ
>  	help

Again, this and all the other similar hunks are totally unrelated to
adding a machine.

> +config SND_SOC_IMX27_MC13783
> +	tristate "SoC Audio support for i.MX27 platforms with a MC13783 codec"
> +	depends on MACH_MX27_3DS

The dependency and the text disagree with each other...

> +	/* set codec and cpu DAI configuration */
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		ret = snd_soc_dai_set_fmt(codec_dai, FMT_PLAYBACK);
> +		if (ret) {
> +			pr_err("%s: failed set codec dai format\n", __func__);
> +			return ret;
> +		}
> +		ret = snd_soc_dai_set_fmt(cpu_dai, FMT_PLAYBACK);
> +		if (ret) {
> +			pr_err("%s: failed set cpu dai format\n", __func__);
> +			return ret;

Can we have some blank lines for legibility please?

> +		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0, 0, 4, 32); /* args are not used in mc13783 */
> +		if (ret)
> +			return ret;
> +	}

If the arguments are not used why are you supplying them, or even
calling this function?

> +//ok: checked; we use clia input pin; last arg is not used
> +	ret = snd_soc_dai_set_sysclk(codec_dai, MC13783_CLK_CLIA, 26000000, SND_SOC_CLOCK_OUT);
> +	if (ret) {
> +		pr_err("%s: failed setting codec sysclk\n", __func__);
> +		return ret;
> +	}

Coding style here and elsewhere.  You're also rather inconsistent about
error reporting.

> +static int imx_mc13783_audio_hifi_hw_free(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

Omit empty functions.

> +static int __init imx_mc13783_audio_init(void)
> +{
> +	int ret;
> +
> +	pr_info("IMX MC13783 Sound Card\n");

This is needlessly chatty.

> +	imx_mc13783_snd_device = platform_device_alloc("soc-audio", -1);
> +	if (!imx_mc13783_snd_device)
> +		return -ENOMEM;

Don't use soc-audio, use snd_soc_register_card().
