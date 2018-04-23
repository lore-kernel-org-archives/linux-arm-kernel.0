From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 23 Apr 2018 07:46:12 +0200
Subject: [PATCH 1/6] dmaengine: at_hdmac: simplify getting .drvdata
In-Reply-To: <20180422091415.7587-2-wsa+renesas@sang-engineering.com>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
 <20180422091415.7587-2-wsa+renesas@sang-engineering.com>
Message-ID: <20180423054612.GE13305@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2018 at 11:14:09AM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks
> ---
> 
> Build tested only. buildbot is happy. Please apply to your tree directly.
> 
>  drivers/dma/at_hdmac.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index a861b5b4d443..75f38d19fcbe 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -2041,8 +2041,7 @@ static void at_dma_shutdown(struct platform_device *pdev)
>  
>  static int at_dma_prepare(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct at_dma *atdma = platform_get_drvdata(pdev);
> +	struct at_dma *atdma = dev_get_drvdata(dev);
>  	struct dma_chan *chan, *_chan;
>  
>  	list_for_each_entry_safe(chan, _chan, &atdma->dma_common.channels,
> @@ -2076,8 +2075,7 @@ static void atc_suspend_cyclic(struct at_dma_chan *atchan)
>  
>  static int at_dma_suspend_noirq(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct at_dma *atdma = platform_get_drvdata(pdev);
> +	struct at_dma *atdma = dev_get_drvdata(dev);
>  	struct dma_chan *chan, *_chan;
>  
>  	/* preserve data */
> @@ -2118,8 +2116,7 @@ static void atc_resume_cyclic(struct at_dma_chan *atchan)
>  
>  static int at_dma_resume_noirq(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct at_dma *atdma = platform_get_drvdata(pdev);
> +	struct at_dma *atdma = dev_get_drvdata(dev);
>  	struct dma_chan *chan, *_chan;
>  
>  	/* bring back DMA controller */
> -- 
> 2.11.0
> 
