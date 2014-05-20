From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 20 May 2014 11:10:59 +0530
Subject: [PATCH] sound: soc: samsung: dma.c: Fix for possible null pointer
 dereference
In-Reply-To: <1400535443-5886-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1400535443-5886-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <537AEAEB.8040803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2014 03:07 AM, Rickard Strandqvist wrote:
> There is otherwise a risk of a possible null pointer dereference.
> 
> Was largely found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  sound/soc/samsung/dma.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
> index dc09b71..1d9bcaa 100644
> --- a/sound/soc/samsung/dma.c
> +++ b/sound/soc/samsung/dma.c
> @@ -115,17 +115,19 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
>  static void audio_buffdone(void *data)
>  {
>  	struct snd_pcm_substream *substream = data;
> -	struct runtime_data *prtd = substream->runtime->private_data;
> +	struct runtime_data *prtd = NULL;

I am not sure if this check is required as audio_buffdone() is set as a
callback function with known valid parameter during dma_enqueue().

>  
>  	pr_debug("Entered %s\n", __func__);
>  
> -	if (prtd->state & ST_RUNNING) {
> +	if (substream)
> +		prtd = substream->runtime->private_data;
> +
> +	if (prtd && prtd->state & ST_RUNNING) {

ditto as above

>  		prtd->dma_pos += prtd->dma_period;
>  		if (prtd->dma_pos >= prtd->dma_end)
>  			prtd->dma_pos = prtd->dma_start;
>  
> -		if (substream)
> -			snd_pcm_period_elapsed(substream);
> +		snd_pcm_period_elapsed(substream);

This check certainly can be removed as snd_pcm_period_elapsed() also
checks the validity of the argument.

-- 
Tushar Behera
