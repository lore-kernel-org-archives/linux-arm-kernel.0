From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Aug 2011 10:19:03 +0100
Subject: [PATCH 1/1] ASoC: soc-core: check rate for symmetry only when
	pcm is ongoing
In-Reply-To: <1314172640-26972-1-git-send-email-b29396@freescale.com>
References: <1314172640-26972-1-git-send-email-b29396@freescale.com>
Message-ID: <20110824091902.GR9232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 03:57:20PM +0800, Dong Aisheng wrote:

> Now we only check rate for symmetry when the pcm is really ongoing
> which seems more sensible.

There's a genuine issue here due to the raciness of the ALSA APIs -
we're not enforcing constraints and we should be.  If the two programs
end up setting incompatible rates we need to handle that.

>  	/* Symmetry data - only valid if symmetry is being enforced */
>  	unsigned int rate;
> +	unsigned int ongoing;

This isn't a clear name, I don't understand it.

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

What happens when the stream in one direction is stopped but not the
other?  For example, capture stops but playback continues.
