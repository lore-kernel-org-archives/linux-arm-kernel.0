From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 10:53:54 +0200
Subject: [PATCH] dmaengine: xgene-dma: Disable memcpy operation due to
 performance drop
In-Reply-To: <1444292716-1877-1-git-send-email-rsahu@apm.com>
References: <1444292716-1877-1-git-send-email-rsahu@apm.com>
Message-ID: <57007053.YYaOe8h6ng@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 13:55:16 Rameshwar Prasad Sahu wrote:
> The DMA engine supports memory copy, RAID5 XOR, RAID6 PQ, and other
> computations. But the bandwidth of the entire DMA engine is shared
> among all channels. This patch re-configures operations availability
> such that one can achieve maximum performance for XOR and PQ
> computation by removing the memory offload operations.
> 
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> ---
>  drivers/dma/xgene-dma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
> index 8d57b1b..2998fcb 100644
> --- a/drivers/dma/xgene-dma.c
> +++ b/drivers/dma/xgene-dma.c
> @@ -154,6 +154,7 @@
>  #define XGENE_DMA_MAX_XOR_SRC          5
>  #define XGENE_DMA_16K_BUFFER_LEN_CODE  0x0
>  #define XGENE_DMA_INVALID_LEN_CODE     0x7800000000000000ULL
> +#undef XGENE_DMA_MEMCPY_ENABLE
> 
>  /* X-Gene DMA descriptor error codes */
>  #define ERR_DESC_AXI                   0x01
> @@ -1707,7 +1708,9 @@ static void xgene_dma_set_caps(struct xgene_dma_chan *chan,
>         dma_cap_zero(dma_dev->cap_mask);
> 
>         /* Set DMA device capability */
> +#ifdef XGENE_DMA_MEMCPY_ENABLE
>         dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +#endif
>         dma_cap_set(DMA_SG, dma_dev->cap_mask);
> 
>         /* Basically here, the X-Gene SoC DMA engine channel 0 supports XOR

I don't see what the #ifdef gains you here when the setting is
hardcoded. Why not just remove that DMA_MEMCPY capability completely
if you don't want to use it?

	Arnd
