From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 23 Nov 2017 11:11:53 +0100
Subject: [PATCH] dmaengine: at_hdmac: fix potential NULL pointer
 dereference in atc_prep_dma_interleaved
In-Reply-To: <20171120142814.GA3315@embeddedor.com>
References: <20171120142814.GA3315@embeddedor.com>
Message-ID: <20171123101153.ghjlhdhahvuanwnj@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 08:28:14AM -0600, Gustavo A. R. Silva wrote:
> _xt_ is being dereferenced before it is null checked, hence there is a
> potential null pointer dereference.
> 
> Fix this by moving the pointer dereference after _xt_ has been null
> checked.
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 4483320e241c ("dmaengine: Use Pointer xt after NULL check.")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/dma/at_hdmac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index fbab271..a861b5b 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -708,7 +708,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
>  			 unsigned long flags)
>  {
>  	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
> -	struct data_chunk	*first = xt->sgl;
> +	struct data_chunk	*first;
>  	struct at_desc		*desc = NULL;
>  	size_t			xfer_count;
>  	unsigned int		dwidth;
> @@ -720,6 +720,8 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
>  	if (unlikely(!xt || xt->numf != 1 || !xt->frame_size))
>  		return NULL;
>  
> +	first = xt->sgl;
> +
>  	dev_info(chan2dev(chan),
>  		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
>  		__func__, &xt->src_start, &xt->dst_start, xt->numf,
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
