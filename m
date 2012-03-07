From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 6 Mar 2012 18:53:27 -0600
Subject: [PATCH 4/9] dmaengine: consolidate assignment of DMA cookies
In-Reply-To: <E1S52xy-0002Ms-Ud@rmk-PC.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52xy-0002Ms-Ud@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559AB@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 06, 2012 3:35 PM, Russell King wrote:
>
> Everyone deals with assigning DMA cookies in the same way (it's part of
> the API so they should be), so lets consolidate the common code into a
> helper function to avoid this duplication.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

>  drivers/dma/dmaengine.h     |   20 ++++++++++++++++++++

<snip>

>  drivers/dma/ep93xx_dma.c    |    9 +--------

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 968570d..7692c86 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -7,4 +7,24 @@
>  
>  #include <linux/dmaengine.h>
>  
> +/**
> + * dma_cookie_assign - assign a DMA engine cookie to the descriptor
> + * @tx: descriptor needing cookie
> + *
> + * Assign a unique non-zero per-channel cookie to the descriptor.
> + * Note: caller is expected to hold a lock to prevent concurrency.
> + */
> +static inline dma_cookie_t dma_cookie_assign(struct dma_async_tx_descriptor *tx)
> +{
> +	struct dma_chan *chan = tx->chan;
> +	dma_cookie_t cookie;
> +
> +	cookie = chan->cookie + 1;
> +	if (cookie < DMA_MIN_COOKIE)
> +		cookie = DMA_MIN_COOKIE;
> +	tx->cookie = chan->cookie = cookie;
> +
> +	return cookie;
> +}
> +
>  #endif

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 3260198..e5aaae8 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -783,17 +783,10 @@ static dma_cookie_t ep93xx_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&edmac->lock, flags);
> -
> -	cookie = edmac->chan.cookie;
> -
> -	if (++cookie < 0)
> -		cookie = 1;
> +	cookie = dma_cookie_assign(tx);
>  
>  	desc = container_of(tx, struct ep93xx_dma_desc, txd);
>  
> -	edmac->chan.cookie = cookie;
> -	desc->txd.cookie = cookie;
> -
>  	/*
>  	 * If nothing is currently prosessed, we push this descriptor
>  	 * directly to the hardware. Otherwise we put the descriptor

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
