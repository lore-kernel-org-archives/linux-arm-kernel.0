From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 26 Aug 2011 09:39:09 +0000
Subject: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking for each DAIs
	separately
In-Reply-To: <1314351351-1018-1-git-send-email-b29396@freescale.com>
References: <1314351351-1018-1-git-send-email-b29396@freescale.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772225ECA@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Dong Aisheng
> Sent: Friday, August 26, 2011 5:36 PM
> To: alsa-devel at alsa-project.org
> Cc: lars at metafoo.de; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; w.sang at pengutronix.de; lrg at ti.com;
> linux-arm-kernel at lists.infradead.org
> Subject: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking for each DAIs
> separately
> 
> The orginal code does not cover the case that one DAI such as codec may
> be shared between other two DAIs(CPU).
> When do symmetry checking, altough the codec DAI requires symmetry, the
> two CPU DAIs may still be configured to run on different rates.
> 
> We change to check each DAI's state separately instead of only checking
> the dai link to prevent this issue.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
>  include/sound/soc-dai.h |    3 ++
>  include/sound/soc.h     |    2 -
>  sound/soc/soc-pcm.c     |   64 +++++++++++++++++++++++++++++++++--------
> -----
>  3 files changed, 49 insertions(+), 20 deletions(-)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h index
> 5ad5f3a..844d4ed 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -242,6 +242,9 @@ struct snd_soc_dai {
>  	void *playback_dma_data;
>  	void *capture_dma_data;
> 
> +	/* Symmetry data */
> +	unsigned int rate;
> +
>  	/* parent platform/codec */
>  	union {
>  		struct snd_soc_platform *platform;
> diff --git a/include/sound/soc.h b/include/sound/soc.h index
> 3fe658e..5449139 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -849,8 +849,6 @@ struct snd_soc_pcm_runtime  {
>  	unsigned int complete:1;
>  	unsigned int dev_registered:1;
> 
> -	/* Symmetry data - only valid if symmetry is being enforced */
> -	unsigned int rate;
>  	long pmdown_time;
> 
>  	/* runtime devices */
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c index
> 1aee9fc..3f7ded7 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -32,33 +32,54 @@ static int soc_pcm_apply_symmetry(struct
> snd_pcm_substream *substream)
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	unsigned int race;
> +	unsigned int force_rate;
>  	int ret;
> 
> +	race = 0;
> +	force_rate = 0;
> +
>  	if (!codec_dai->driver->symmetric_rates &&
>  	    !cpu_dai->driver->symmetric_rates &&
>  	    !rtd->dai_link->symmetric_rates)
>  		return 0;
> 
> +	if (codec_dai->active && codec_dai->driver->symmetric_rates ||
> +	     codec_dai->active && rtd->dai_link->symmetric_rates) {
> +		if (codec_dai->rate != 0)
> +			force_rate = codec_dai->rate;
> +		else
> +			race = 1;
> +	}
> +
> +	if (cpu_dai->active && cpu_dai->driver->symmetric_rates ||
> +	    codec_dai->active && rtd->dai_link->symmetric_rates) {
> +		if (cpu_dai->rate != 0)
> +			force_rate = cpu_dai->rate;
> +		else
> +			race = 1;
> +	}
One concern is that I'm not sure about the original purpose of
dai_link->symmetric_rates, from the code visually, i guess that if the
dai link requires symmetry, the pcm open will force symmetry unconditionly
no matter whether CPU DAIs or Codec DAIs have symmetry constraints.
So i just follow that idea in this patch.
But it seems it may bring a little complex since we already have DAIs
Symmetry checking.

So i wonder can we remove the symmetric_rates for dai link?
Then we may just check DAIs symmetry to decide whether we should do
force symmetry.

> +	if (force_rate) {
> +		dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n", rtd->rate);
> +
> +		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
> +				SNDRV_PCM_HW_PARAM_RATE,
> +				force_rate, force_rate);
> +		if (ret < 0) {
> +			dev_err(&rtd->dev,
> +				"Unable to apply rate symmetry constraint: %d\n",
> ret);
> +			return ret;
> +		}
> +	}
> +
>  	/* This can happen if multiple streams are starting simultaneously
> -
>  	 * the second can need to get its constraints before the first has
>  	 * picked a rate.  Complain and allow the application to carry on.
>  	 */
> -	if (!rtd->rate) {
> +	if (race)
>  		dev_warn(&rtd->dev,
> -			 "Not enforcing symmetric_rates due to race\n");
> -		return 0;
> -	}
> -
> -	dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n", rtd->rate);
> -
> -	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
> -					   SNDRV_PCM_HW_PARAM_RATE,
> -					   rtd->rate, rtd->rate);
> -	if (ret < 0) {
> -		dev_err(&rtd->dev,
> -			"Unable to apply rate symmetry constraint: %d\n", ret);
> -		return ret;
> -	}
> +			"Not enforcing symmetric_rates due to race\n");
> 
>  	return 0;
>  }
> @@ -287,9 +308,14 @@ static int soc_pcm_close(struct snd_pcm_substream
> *substream)
>  	cpu_dai->active--;
>  	codec_dai->active--;
>  	codec->active--;
> +	rtd->active--;
> +
> +	/* clear the corresponding DAIs rate when inactive */
> +	if (!cpu_dai->active)
> +		cpu_dai->rate = 0;
> 
> -	if (!cpu_dai->active && !codec_dai->active)
> -		rtd->rate = 0;
> +	if (!codec_dai->active)
> +		codec_dai->rate = 0;
> 
>  	/* Muting the DAC suppresses artifacts caused during digital
>  	 * shutdown, for example from stopping clocks.
> @@ -447,7 +473,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream
> *substream,
>  		}
>  	}
> 
> -	rtd->rate = params_rate(params);
> +	/* store the rate for each DAIs */
> +	cpu_dai->rate = params_rate(params);
> +	codec_dai->rate = params_rate(params);
> 
>  out:
>  	mutex_unlock(&rtd->pcm_mutex);
> --
> 1.7.0.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
