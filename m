From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 19 May 2014 12:52:52 +0200
Subject: [PATCH] Fix for possible null pointer dereference in dma.c
In-Reply-To: <1400191076-28279-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1400191076-28279-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <5379E284.7030700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rickard,

On 15.05.2014 23:57, Rickard Strandqvist wrote:
> There is otherwise a risk of a possible null pointer dereference.
> 
> Was largely found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  sound/soc/samsung/dma.c |   10 ++++++----
>  1 fil ?ndrad, 6 till?gg(+), 4 borttagningar(-)
> 
> diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
> index dc09b71..b1f6757 100644
> --- a/sound/soc/samsung/dma.c
> +++ b/sound/soc/samsung/dma.c
> @@ -115,17 +115,19 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
>  static void audio_buffdone(void *data)
>  {
>  	struct snd_pcm_substream *substream = data;
> -	struct runtime_data *prtd = substream->runtime->private_data;
> +	struct runtime_data *prtd = NULL;
>  
>  	pr_debug("Entered %s\n", __func__);
>  
> -	if (prtd->state & ST_RUNNING) {
> +	if(substream)
> +		prtd = substream->runtime->private_data;
> +
> +	if (prtd && prtd->state & ST_RUNNING) {
>  		prtd->dma_pos += prtd->dma_period;
>  		if (prtd->dma_pos >= prtd->dma_end)
>  			prtd->dma_pos = prtd->dma_start;
>  
> -		if (substream)
> -			snd_pcm_period_elapsed(substream);
> +		snd_pcm_period_elapsed(substream);
>  
>  		spin_lock(&prtd->lock);
>  		if (!samsung_dma_has_circular()) {
> 

Can you find a path (or use case, if possible) on which any of affected
pointers will be NULL?

Best regards,
Tomasz
