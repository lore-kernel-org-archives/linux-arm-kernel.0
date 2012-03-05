From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 5 Mar 2012 17:35:53 -0600
Subject: [PATCH 6/9] dmaengine: consolidate tx_status functions
In-Reply-To: <E1S4eKz-0000tE-FB@rmk-PC.arm.linux.org.uk>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <E1S4eKz-0000tE-FB@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF555AF@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 05, 2012 1:17 PM, Russell King wrote:
>
> Now that we have the completed cookie in the dma_chan structure, we
> can consolidate the tx_status functions by providing a function to set
> the txstate structure and returning the DMA status.  We also provide
> a separate helper to set the residue for cookies which are still in
> progress.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 47e0997..244a2c5 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -45,4 +45,35 @@ static inline void dma_cookie_complete(struct dma_async_tx_descriptor *tx)
>  	tx->cookie = 0;
>  }
>  
> +/**
> + * dma_cookie_status - report cookie status
> + * @chan: dma channel
> + * @cookie: cookie we are interested in
> + * @state: dma_tx_state structure to return last/used cookies
> + *
> + * Report the status of the cookie, filling in the state structure if
> + * non-NULL.  No locking is required.
> + */
> +static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
> +	dma_cookie_t cookie, struct dma_tx_state *state)
> +{
> +	dma_cookie_t used, complete;
> +
> +	used = chan->cookie;
> +	complete = chan->complete;

Is this supposed to be:

	complete = chan->completed_cookie;

Regards,
Hartley
