From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 04 Dec 2013 12:38:57 +0100
Subject: [PATCH 1/2] ASoC: atmel_ssc_dai: add dai trigger ops
In-Reply-To: <1386124624-22414-2-git-send-email-voice.shen@atmel.com>
References: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
 <1386124624-22414-2-git-send-email-voice.shen@atmel.com>
Message-ID: <529F1451.1060800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2013 03:37, Bo Shen wrote:
> According to the SSC specifiation, it should be enabled after DMA is
> enabled. So, add trigger operation to make sure the right sequence.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c |   30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 8697ced..1ead3c9 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -648,7 +648,7 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
>  
>  	dma_params = ssc_p->dma_params[dir];
>  
> -	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
> +	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
>  	ssc_writel(ssc_p->ssc->regs, IDR, dma_params->mask->ssc_error);
>  
>  	pr_debug("%s enabled SSC_SR=0x%08x\n",
> @@ -657,6 +657,33 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> +static int atmel_ssc_trigger(struct snd_pcm_substream *substream,
> +			     int cmd, struct snd_soc_dai *dai)
> +{
> +	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
> +	struct atmel_pcm_dma_params *dma_params;
> +	int dir;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		dir = 0;
> +	else
> +		dir = 1;
> +
> +	dma_params = ssc_p->dma_params[dir];
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
> +		break;
> +	default:
> +		ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
> +		break;
> +	}
> +
> +	return 0;
> +}
>  
>  #ifdef CONFIG_PM
>  static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
> @@ -731,6 +758,7 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
>  	.startup	= atmel_ssc_startup,
>  	.shutdown	= atmel_ssc_shutdown,
>  	.prepare	= atmel_ssc_prepare,
> +	.trigger	= atmel_ssc_trigger,
>  	.hw_params	= atmel_ssc_hw_params,
>  	.set_fmt	= atmel_ssc_set_dai_fmt,
>  	.set_clkdiv	= atmel_ssc_set_dai_clkdiv,
> 

Tested-by: Richard Genoud <richard.genoud@gmail.com>
on at91sam9g35-ek with 3.12-rc2 + "ASoC: wm8731: fix dsp mode configuration"
