From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Tue, 26 Nov 2013 13:59:53 +0000
Subject: [PATCH V3] dma: add channel request API that supports deferred
 probe
In-Reply-To: <1385416039-3170-1-git-send-email-swarren@wwwdotorg.org>
References: <1385416039-3170-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1385474368.1871.6.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-11-25 at 14:47 -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> dma_request_slave_channel() simply returns NULL whenever DMA channel
> lookup fails. Lookup could fail for two distinct reasons:
> 
> a) No DMA specification exists for the channel name.
>    This includes situations where no DMA specifications exist at all, or
>    other general lookup problems.
> 
> b) A DMA specification does exist, yet the driver for that channel is not
>    yet registered.
> 
> Case (b) should trigger deferred probe in client drivers. However, since
> they have no way to differentiate the two situations, it cannot.
> 
> Implement new function dma_request_slave_channel_or_err(), which performs
> identically to dma_request_slave_channel(), except that it returns an
> error-pointer rather than NULL, which allows callers to detect when
> deferred probe should occur.
> 
> Eventually, all drivers should be converted to this new API, the old API
> removed, and the new API renamed to the more desirable name. This patch
> doesn't convert the existing API and all drivers in one go, since some
> drivers call dma_request_slave_channel() then dma_request_channel() if
> that fails. That would require either modifying dma_request_channel() in
> the same way, or adding extra error-handling code to all affected
> drivers, and there are close to 100 drivers using the other API, rather
> than just the 15-20 or so that use dma_request_slave_channel(), which
> might be tenable in a single patch.
> 
> acpi_dma_request_slave_chan_by_name() doesn't currently implement
> deferred probe. It should, but this will be addressed later.

Couple of comments below.

[]

> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c

[]

> @@ -152,17 +152,18 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>  	struct of_dma		*ofdma;
>  	struct dma_chan		*chan;
>  	int			count, i;
> +	int			ret_no_channel = -ENODEV;

Could we re-use chan for the error as well?

>  	if (!np || !name) {
>  		pr_err("%s: not enough information provided\n", __func__);
> -		return NULL;
> +		return ERR_PTR(-ENODEV);
>  	}
>  
>  	count = of_property_count_strings(np, "dma-names");
>  	if (count < 0) {
>  		pr_err("%s: dma-names property of node '%s' missing or empty\n",
>  			__func__, np->full_name);
> -		return NULL;
> +		return ERR_PTR(-ENODEV);
>  	}
>  
>  	for (i = 0; i < count; i++) {
> @@ -174,8 +175,10 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>  
>  		if (ofdma)

if (ofdma) {
...

>  			chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
> -		else
> +		else {

} else {

to keep style.

> +			ret_no_channel = -EPROBE_DEFER;
>  			chan = NULL;
> +		}
>  
>  		mutex_unlock(&of_dma_lock);
>  
> @@ -185,7 +188,7 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>  			return chan;
>  	}
>  
> -	return NULL;
> +	return ERR_PTR(ret_no_channel);
>  }


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
