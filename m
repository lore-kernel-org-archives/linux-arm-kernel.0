From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 24 Aug 2011 11:24:34 +0200
Subject: [alsa-devel] [PATCH 1/1] ASoC: soc-core: check rate for symmetry
	only when pcm is ongoing
In-Reply-To: <1314172640-26972-1-git-send-email-b29396@freescale.com>
References: <1314172640-26972-1-git-send-email-b29396@freescale.com>
Message-ID: <4E54C352.8030106@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2011 09:57 AM, Dong Aisheng wrote:
> For the playback and record using different dai links,
> checking !rtd->rate for symmetry may not be accurate because that
> pcm may be acutually not running and the default new open rate is 0,
> then the warning message "Not enforcing symmetric_rates" will
> happen each time with running arecord | aplay.
> 
> Now we only check rate for symmetry when the pcm is really ongoing
> which seems more sensible.


This will break the common case where playback and record are using the same
link. You'll need at least ref-counting for whether the pcm is active or not too.

But what is your setup anyway. You have two dai links and both refer to the
same dais? Or how does it come that the dai is active while rtd->rate is not
set while you are using different links?

> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  include/sound/soc.h |    1 +
>  sound/soc/soc-pcm.c |    5 +++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 3fe658e..8e9931c 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -851,6 +851,7 @@ struct snd_soc_pcm_runtime  {
>  
>  	/* Symmetry data - only valid if symmetry is being enforced */
>  	unsigned int rate;
> +	unsigned int ongoing;
>  	long pmdown_time;
>  
>  	/* runtime devices */
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 1aee9fc..f3c1a66 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -39,6 +39,9 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
>  	    !rtd->dai_link->symmetric_rates)
>  		return 0;
>  
> +	if (!rtd->ongoing)
> +		return 0;
> +
>  	/* This can happen if multiple streams are starting simultaneously -
>  	 * the second can need to get its constraints before the first has
>  	 * picked a rate.  Complain and allow the application to carry on.
> @@ -209,6 +212,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
>  	cpu_dai->active++;
>  	codec_dai->active++;
>  	rtd->codec->active++;
> +	rtd->ongoing = 1;
>  	mutex_unlock(&rtd->pcm_mutex);
>  	return 0;
>  
> @@ -322,6 +326,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
>  			SND_SOC_DAPM_STREAM_STOP);
>  	}
>  
> +	rtd->ongoing = 0;
>  	mutex_unlock(&rtd->pcm_mutex);
>  	return 0;
>  }
