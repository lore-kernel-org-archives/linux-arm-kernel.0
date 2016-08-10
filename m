From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 10 Aug 2016 16:19:46 +0200
Subject: [PATCH -next] dmaengine: at_xdmac: fix to pass correct device
 identity to free_irq()
In-Reply-To: <1470799029-2613-1-git-send-email-weiyj.lk@gmail.com>
References: <1470799029-2613-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160810141946.GB3674@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 03:17:09AM +0000, Wei Yongjun wrote:
> free_irq() expects the same device identity that was passed to
> corresponding request_irq(), otherwise the IRQ is not freed.
> 
> Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel
> eXtended DMA Controller driver")
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
>  drivers/dma/at_xdmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 2badc57..b7d7f2d 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -2067,7 +2067,7 @@ err_dma_unregister:
>  err_clk_disable:
>  	clk_disable_unprepare(atxdmac->clk);
>  err_free_irq:
> -	free_irq(atxdmac->irq, atxdmac->dma.dev);
> +	free_irq(atxdmac->irq, atxdmac);
>  	return ret;
>  }
>  
> @@ -2081,7 +2081,7 @@ static int at_xdmac_remove(struct platform_device *pdev)
>  	dma_async_device_unregister(&atxdmac->dma);
>  	clk_disable_unprepare(atxdmac->clk);
>  
> -	free_irq(atxdmac->irq, atxdmac->dma.dev);
> +	free_irq(atxdmac->irq, atxdmac);
>  
>  	for (i = 0; i < atxdmac->dma.chancnt; i++) {
>  		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
> 
