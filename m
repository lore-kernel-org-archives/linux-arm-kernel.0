From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Jan 2013 09:27:18 +0000
Subject: [PATCH v6 07/10] dmaengine: add dma_request_slave_channel_compat()
In-Reply-To: <1359529229-22207-8-git-send-email-mporter@ti.com>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
 <1359529229-22207-8-git-send-email-mporter@ti.com>
Message-ID: <201301300927.18509.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013, Matt Porter wrote:
> Adds a dma_request_slave_channel_compat() wrapper which accepts
> both the arguments from dma_request_channel() and
> dma_request_slave_channel(). Based on whether the driver is
> instantiated via DT, the appropriate channel request call will be
> made.
> 
> This allows for a much cleaner migration of drivers to the
> dmaengine DT API as platforms continue to be mixed between those
> that boot using DT and those that do not.
> 
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Matt Porter <mporter@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> @@ -1001,6 +1001,22 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
>  struct dma_chan *net_dma_find_channel(void);
>  #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
> +#define dma_request_slave_channel_compat(mask, x, y, dev, name) \
> +	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
> +
> +static inline struct dma_chan
> +*__dma_request_slave_channel_compat(dma_cap_mask_t *mask, dma_filter_fn fn,
> +				  void *fn_param, struct device *dev,
> +				  char *name)
> +{
> +	struct dma_chan *chan;
> +
> +	chan = dma_request_slave_channel(dev, name);
> +	if (chan)
> +		return chan;
> +
> +	return __dma_request_channel(mask, fn, fn_param);
> +}

After I have spent some more time with implementing the code for dw_dma,
I think the mask is actually unnecessary here, the helper could just
always set it to DMA_SLAVE before calling __dma_request_channel.

It's not a bug to do it this way though, and it may help convert drivers
a little easier if there is less to change.

	Arnd
