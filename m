From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 6 Mar 2012 18:56:45 -0600
Subject: [PATCH 5/9] dmaengine: provide a common function for completing
 a dma descriptor
In-Reply-To: <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559AD@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 06, 2012 3:35 PM, Russell King wrote:
>
> Provide a common function to do the cookie mechanics for completing
> a DMA descriptor.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

>  drivers/dma/dmaengine.h     |   18 ++++++++++++++++++

<snip>

>  drivers/dma/ep93xx_dma.c    |    2 +-

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 7692c86..47e0997 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -5,6 +5,7 @@
>  #ifndef DMAENGINE_H
>  #define DMAENGINE_H
>  
> +#include <linux/bug.h>
>  #include <linux/dmaengine.h>
>  
>  /**
> @@ -27,4 +28,21 @@ static inline dma_cookie_t dma_cookie_assign(struct dma_async_tx_descriptor *tx)
>  	return cookie;
>  }
>  
> +/**
> + * dma_cookie_complete - complete a descriptor
> + * @tx: descriptor to complete
> + *
> + * Mark this descriptor complete by updating the channels completed
> + * cookie marker.  Zero the descriptors cookie to prevent accidental
> + * repeated completions.
> + *
> + * Note: caller is expected to hold a lock to prevent concurrency.
> + */
> +static inline void dma_cookie_complete(struct dma_async_tx_descriptor *tx)
> +{
> +	BUG_ON(tx->cookie < DMA_MIN_COOKIE);
> +	tx->chan->completed_cookie = tx->cookie;
> +	tx->cookie = 0;
> +}
> +
>  #endif

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index e5aaae8..1c56f75 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -703,7 +703,7 @@ static void ep93xx_dma_tasklet(unsigned long data)
>  	desc = ep93xx_dma_get_active(edmac);
>  	if (desc) {
>  		if (desc->complete) {
> -			edmac->chan.completed_cookie = desc->txd.cookie;
> +			dma_cookie_complete(&desc->txd);
>  			list_splice_init(&edmac->active, &list);
>  		}
>  		callback = desc->txd.callback;

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
