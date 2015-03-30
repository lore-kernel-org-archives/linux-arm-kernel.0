From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 30 Mar 2015 23:19:10 +0530
Subject: [PATCH 5/5] dmaengine: moxart-dma: Fix memory leak when stopping
 a running transfer
In-Reply-To: <1427456155-28990-6-git-send-email-peter.ujfalusi@ti.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
 <1427456155-28990-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150330174910.GO7192@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 01:35:55PM +0200, Peter Ujfalusi wrote:
> The vd->node is removed from the lists when the transfer started so the
> vchan_get_all_descriptors() will not find it. This results memory leak.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Jonas Jensen <jonas.jensen@gmail.com>
Applied, thanks

-- 
~Vinod

> ---
>  drivers/dma/moxart-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
> index 15cab7d79525..b4634109e010 100644
> --- a/drivers/dma/moxart-dma.c
> +++ b/drivers/dma/moxart-dma.c
> @@ -193,8 +193,10 @@ static int moxart_terminate_all(struct dma_chan *chan)
>  
>  	spin_lock_irqsave(&ch->vc.lock, flags);
>  
> -	if (ch->desc)
> +	if (ch->desc) {
> +		moxart_dma_desc_free(&ch->desc->vd);
>  		ch->desc = NULL;
> +	}
>  
>  	ctrl = readl(ch->base + REG_OFF_CTRL);
>  	ctrl &= ~(APB_DMA_ENABLE | APB_DMA_FIN_INT_EN | APB_DMA_ERR_INT_EN);
> -- 
> 2.3.3
> 

-- 
