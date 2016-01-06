From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 6 Jan 2016 14:43:23 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix double IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag
In-Reply-To: <1450875495-2229-1-git-send-email-rsahu@apm.com>
References: <1450875495-2229-1-git-send-email-rsahu@apm.com>
Message-ID: <20160106091323.GP2940@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 06:28:15PM +0530, Rameshswar Prasad Sahu wrote:
> From: Rameshwar Prasad Sahu <rsahu@apm.com>
> 
> For interrupt controller that doesn't support irq_disable and hardware
> with level interrupt, an extra interrupt can be pending. This patch fixes
> the issue by setting IRQ_DISABLE_UNLAZY flag for the interrupt line.
> 
> Reference: http://git.kernel.org/tip/e9849777d0e27cdd2902805be51da73e7c79578c

I seem to have got this patch thrice :(

> 
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> ---
>  drivers/dma/xgene-dma.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
> index 9dfa2b0..6363e84 100644
> --- a/drivers/dma/xgene-dma.c
> +++ b/drivers/dma/xgene-dma.c
> @@ -29,6 +29,7 @@
>  #include <linux/dmapool.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> 
> @@ -1610,6 +1611,7 @@ static int xgene_dma_request_irqs(struct xgene_dma *pdma)
>  	/* Register DMA channel rx irq */
>  	for (i = 0; i < XGENE_DMA_MAX_CHANNEL; i++) {
>  		chan = &pdma->chan[i];
> +		irq_set_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);

Why not use irq_settings_disable_unlazy(), at least read the reference you
pointed out!

>  		ret = devm_request_irq(chan->dev, chan->rx_irq,
>  				       xgene_dma_chan_ring_isr,
>  				       0, chan->name, chan);
> @@ -1620,6 +1622,7 @@ static int xgene_dma_request_irqs(struct xgene_dma *pdma)
> 
>  			for (j = 0; j < i; j++) {
>  				chan = &pdma->chan[i];
> +				irq_clear_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
>  				devm_free_irq(chan->dev, chan->rx_irq, chan);
>  			}
> 
> @@ -1640,6 +1643,7 @@ static void xgene_dma_free_irqs(struct xgene_dma *pdma)
> 
>  	for (i = 0; i < XGENE_DMA_MAX_CHANNEL; i++) {
>  		chan = &pdma->chan[i];
> +		irq_clear_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
>  		devm_free_irq(chan->dev, chan->rx_irq, chan);
>  	}
>  }
> --
> 1.7.1

-- 
~Vinod
