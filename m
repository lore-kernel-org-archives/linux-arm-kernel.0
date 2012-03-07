From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 6 Mar 2012 19:07:37 -0600
Subject: [PATCH 7/9] dmaengine: consolidate initialization of cookies
In-Reply-To: <E1S52yx-0002N5-Bc@rmk-PC.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yx-0002N5-Bc@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559B0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 06, 2012 3:36 PM, Russell King wrote:
>
> Provide a common function to initialize a channels cookie values.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

>  drivers/dma/dmaengine.h     |   10 ++++++++++

<snip>

>  drivers/dma/ep93xx_dma.c    |    3 +--

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 1ca5e0e..17f983a 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -9,6 +9,16 @@
>  #include <linux/dmaengine.h>
>  
>  /**
> + * dma_cookie_init - initialize the cookies for a DMA channel
> + * @chan: dma channel to initialize
> + */
> +static inline void dma_cookie_init(struct dma_chan *chan)
> +{
> +	chan->cookie = DMA_MIN_COOKIE;
> +	chan->completed_cookie = DMA_MIN_COOKIE;
> +}
> +
> +/**
>   * dma_cookie_assign - assign a DMA engine cookie to the descriptor
>   * @tx: descriptor needing cookie
>   *

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 142ebf0..f25e83b 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -854,8 +854,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
>  		goto fail_clk_disable;
>  
>  	spin_lock_irq(&edmac->lock);
> -	edmac->chan.completed_cookie = 1;
> -	edmac->chan.cookie = 1;
> +	dma_cookie_init(&edmac->chan);
>  	ret = edmac->edma->hw_setup(edmac);
>  	spin_unlock_irq(&edmac->lock);
>  

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
