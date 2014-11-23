From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 23 Nov 2014 19:26:50 +0300
Subject: [PATCH] Fix PXA2xx sound DMA autoincrementation flags
In-Reply-To: <54718713.1050902@tul.cz>
References: <54718713.1050902@tul.cz>
Message-ID: <54720ACA.2070506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/23/2014 10:04 AM, Petr Cvek wrote:

> Fix for address auto-incrementation flags for DMA transmissions for PXA2xx sound.

> Old version used playback settings for recording, so it wrongly read from
> whole register space (instead of one FIFO register) and wrote into single word
> in memory.

> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>   sound/arm/pxa2xx-pcm-lib.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

> diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
> index a61d7a9..5d3a415 100644
> --- a/sound/arm/pxa2xx-pcm-lib.c
> +++ b/sound/arm/pxa2xx-pcm-lib.c
> @@ -45,7 +45,13 @@ int __pxa2xx_pcm_hw_params(struct snd_pcm_substream
> *substream,
>       size_t period = params_period_bytes(params);
>       pxa_dma_desc *dma_desc;
>       dma_addr_t dma_buff_phys, next_desc_phys;
> -    u32 dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
> +    u32 dcmd = 0;
> +
> +    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +        dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
> +    } else {
> +        dcmd = DCMD_INCTRGADDR | DCMD_FLOWSRC;
> +    }
[...]

    Your patch has all tabs replaced by spaces, so can't be applied.

WBR, Sergei
