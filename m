From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 7 Dec 2015 16:15:56 +0100
Subject: [PATCH 1/1] dmaengine: at_xdmac: fix at_xdmac_prep_dma_memcpy()
In-Reply-To: <eec3de73336bf67938fab83951c04b33b7dfba49.1449500175.git.cyrille.pitchen@atmel.com>
References: <eec3de73336bf67938fab83951c04b33b7dfba49.1449500175.git.cyrille.pitchen@atmel.com>
Message-ID: <20151207151556.GD27886@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 03:58:56PM +0100, Cyrille Pitchen wrote:
> This patch fixes at_xdmac_prep_dma_memcpy(). Indeed the data width field
> of the Channel Configuration register was not updated properly in the
> loop: the bits of the dwidth field were not cleared before adding their
> new value.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Thanks.

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: e1f7c9eee70 ("dmaengine: at_xdmac: creation of the atmel eXtended
DMA Controller driver")
Cc: stable at vger.kernel.org #4.1 and later (minor conflict due to the introduction of at_xdmac_align_width() in 4.2 to factorize code)

> ---
>  drivers/dma/at_xdmac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 90040e99f5f3..39f59666f93f 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1096,6 +1096,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  		/* Check remaining length and change data width if needed. */
>  		dwidth = at_xdmac_align_width(chan,
>  					      src_addr | dst_addr | xfer_size);
> +		chan_cc &= ~AT_XDMAC_CC_DWIDTH_MASK;
>  		chan_cc |= AT_XDMAC_CC_DWIDTH(dwidth);
>  
>  		ublen = xfer_size >> dwidth;
> -- 
> 1.8.2.2
> 
