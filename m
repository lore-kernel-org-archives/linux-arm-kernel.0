From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 26 Aug 2011 13:23:58 +0200
Subject: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking for each DAIs
	separately
In-Reply-To: <1314351351-1018-1-git-send-email-b29396@freescale.com>
References: <1314351351-1018-1-git-send-email-b29396@freescale.com>
Message-ID: <4E57824E.8000400@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2011 11:35 AM, Dong Aisheng wrote:
> [...]
>  	/* runtime devices */
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 1aee9fc..3f7ded7 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -32,33 +32,54 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
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

parenthesis, please, when mixing && and || in the same expression. Makes it
easier to comprehend and protects against accidental mistakes.

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
> +

If both dais are active and require symmetry we should call
snd_pcm_hw_constraint_minmax for both rates. This will ensure that if both are
already active and are running at different rates that there will be no valid
rate for the new pcm stream. Maybe extend this function to take the dai as an
parameter and call it twice, once for the codec_dai and once for the cpu_dai.
This would allow to keep the current structure of the function.


> +	if (force_rate) {
> +		dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n", rtd->rate);
> +
> +		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
> +				SNDRV_PCM_HW_PARAM_RATE,
> +				force_rate, force_rate);
> +		if (ret < 0) {
> +			dev_err(&rtd->dev,
> +				"Unable to apply rate symmetry constraint: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	/* This can happen if multiple streams are starting simultaneously -
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
> @@ -287,9 +308,14 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
>  	cpu_dai->active--;
>  	codec_dai->active--;
>  	codec->active--;
> +	rtd->active--;

I guess the line above is a leftover from the previous patch.

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
> @@ -447,7 +473,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
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
