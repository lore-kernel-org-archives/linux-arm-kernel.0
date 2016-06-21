From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 21 Jun 2016 21:31:39 +0530
Subject: [PATCH 7/8] dmaengine: tegra20-apb-dma: Only calculate residue
 if txstate exists.
In-Reply-To: <5757DCAD.1090106@nvidia.com>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-8-git-send-email-peter.griffin@linaro.org>
 <5757DCAD.1090106@nvidia.com>
Message-ID: <20160621160139.GC16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 09:51:57AM +0100, Jon Hunter wrote:
> Hi Peter,
> 
> On 07/06/16 18:38, Peter Griffin wrote:
> > There is no point calculating the residue if there is
> > no txstate to store the value.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/dma/tegra20-apb-dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> > index 01e316f..7f4af8c 100644
> > --- a/drivers/dma/tegra20-apb-dma.c
> > +++ b/drivers/dma/tegra20-apb-dma.c
> > @@ -814,7 +814,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
> >  	unsigned int residual;
> >  
> >  	ret = dma_cookie_status(dc, cookie, txstate);
> > -	if (ret == DMA_COMPLETE)
> > +	if (ret == DMA_COMPLETE || !txstate)
> >  		return ret;
> 
> Thanks for reporting this. I agree that we should not do this, however, 
> looking at the code for Tegra, I am wondering if this could change the
> actual state that is returned. Looking at dma_cookie_status() it will
> call dma_async_is_complete() which will return either DMA_COMPLETE or
> DMA_IN_PROGRESS. It could be possible that the actual state for the
> DMA transfer in the tegra driver is DMA_ERROR, so I am wondering if we
> should do something like the following  ...

This one is stopping code execution when residue is not valid. Do notice
that it check for DMA_COMPLETE OR txstate. In other cases, wit will return
'that' state when txstate is NULL.

I am going to apply this.

> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 01e316f73559..45edab7418d0 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -822,13 +822,8 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>         /* Check on wait_ack desc status */
>         list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
>                 if (dma_desc->txd.cookie == cookie) {
> -                       residual =  dma_desc->bytes_requested -
> -                                       (dma_desc->bytes_transferred %
> -                                               dma_desc->bytes_requested);
> -                       dma_set_residue(txstate, residual);
>                         ret = dma_desc->dma_status;
> -                       spin_unlock_irqrestore(&tdc->lock, flags);
> -                       return ret;
> +                       goto found;
>                 }
>         }
>  
> @@ -836,17 +831,23 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>         list_for_each_entry(sg_req, &tdc->pending_sg_req, node) {
>                 dma_desc = sg_req->dma_desc;
>                 if (dma_desc->txd.cookie == cookie) {
> -                       residual =  dma_desc->bytes_requested -
> -                                       (dma_desc->bytes_transferred %
> -                                               dma_desc->bytes_requested);
> -                       dma_set_residue(txstate, residual);
>                         ret = dma_desc->dma_status;
> -                       spin_unlock_irqrestore(&tdc->lock, flags);
> -                       return ret;
> +                       goto found;
>                 }
>         }
>  
> -       dev_dbg(tdc2dev(tdc), "cookie %d does not found\n", cookie);
> +       dev_warn(tdc2dev(tdc), "cookie %d not found\n", cookie);
> +       spin_unlock_irqrestore(&tdc->lock, flags);
> +       return ret;
> +
> +found:
> +       if (txstate) {
> +               residual = dma_desc->bytes_requested -
> +                          (dma_desc->bytes_transferred %
> +                           dma_desc->bytes_requested);
> +               dma_set_residue(txstate, residual);
> +       }
> +

I feel this optimizes stuff, which seems okay. Feel free to send as proper
patch.

>         spin_unlock_irqrestore(&tdc->lock, flags);
>         return ret;
>  }
> 
> Cheers
> Jon
> 
> -- 
> nvpublic

-- 
~Vinod
