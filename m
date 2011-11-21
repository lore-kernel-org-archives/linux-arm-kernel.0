From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 21 Nov 2011 14:02:06 +0530
Subject: [PATCH v2 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <20111121080158.GA2713@mwesterb-mobl.ger.corp.intel.com>
References: <cover.1306662317.git.mika.westerberg@iki.fi>
 <3ea8d56034f25cbe3fd8a4c31d7d0d1540b6ac7e.1306662317.git.mika.westerberg@iki.fi>
 <4EC27EED.4030108@metasoft.pl>
 <20111116065512.GB2703@mwesterb-mobl.ger.corp.intel.com>
 <4EC374F0.8000400@metasoft.pl>
 <20111119123837.GA2711@mwesterb-mobl.ger.corp.intel.com>
 <4ECA0147.4020806@metasoft.pl>
 <20111121080158.GA2713@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <1321864326.1516.211.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-21 at 10:01 +0200, Mika Westerberg wrote:
> On Mon, Nov 21, 2011 at 08:44:07AM +0100, Rafal Prylowski wrote:
> > 
> > I'm calling dma_terminate_all from interrupt. It seems that tasklet_kill is not
> > allowed to be called from this context.
> 
> Ah, right.
> 
> One more try - this time we set a flag which prevents the tasktlet from
> referencing an empty list.
Rather than this why not actually check for list_empty and process only
when it is not empty?
Also you should check the return of the ep93xx_dma_get_active() which
should return NULL if it didn't find anything in active list
> 
> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 6181811..f7244b3 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -155,6 +155,8 @@ struct ep93xx_dma_chan {
>  	unsigned long			flags;
>  /* Channel is configured for cyclic transfers */
>  #define EP93XX_DMA_IS_CYCLIC		0
> +/* Channel is enabled */
> +#define EP93xx_DMA_IS_RUNNING		1
>  
>  	int				buffer;
>  	dma_cookie_t			last_completed;
> @@ -673,6 +675,9 @@ static void ep93xx_dma_tasklet(unsigned long data)
>  	void *callback_param;
>  	LIST_HEAD(list);
>  
> +	if (!test_bit(EP93XX_DMA_IS_RUNNING, &edmac->flags))
> +		return;
> +
>  	spin_lock_irq(&edmac->lock);
>  	desc = ep93xx_dma_get_active(edmac);
>  	if (desc->complete) {
> @@ -758,6 +763,8 @@ static dma_cookie_t ep93xx_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>  	edmac->chan.cookie = cookie;
>  	desc->txd.cookie = cookie;
>  
> +	set_bit(EP93XX_DMA_IS_RUNNING, &edmac->flags);
> +
>  	/*
>  	 * If nothing is currently prosessed, we push this descriptor
>  	 * directly to the hardware. Otherwise we put the descriptor
> @@ -1106,6 +1113,7 @@ static int ep93xx_dma_terminate_all(struct ep93xx_dma_chan *edmac)
>  	spin_lock_irqsave(&edmac->lock, flags);
>  	/* First we disable and flush the DMA channel */
>  	edmac->edma->hw_shutdown(edmac);
> +	clear_bit(EP93XX_DMA_IS_RUNNING, &edmac->flags);
>  	clear_bit(EP93XX_DMA_IS_CYCLIC, &edmac->flags);
>  	list_splice_init(&edmac->active, &list);
>  	list_splice_init(&edmac->queue, &list);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
~Vinod
