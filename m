From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Feb 2013 22:16:21 +0000
Subject: [PATCH V2] dma: imx-dma: Add oftree support
In-Reply-To: <1361638770-29235-1-git-send-email-mpa@pengutronix.de>
References: <1361543838-12604-1-git-send-email-mpa@pengutronix.de>
 <1361638770-29235-1-git-send-email-mpa@pengutronix.de>
Message-ID: <201302232216.22113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 February 2013, Markus Pargmann wrote:

> +Required properties:
> +- compatible : Should be "fsl,<chip>-dma". chip can be imx1, imx21 or imx27
> +- reg : Should contain DMA registers location and length
> +- interrupts : First item should be DMA interrupt, second one is optional and
> +    should contain DMA Error interrupt
> +- #dma-cells : Has to be 1. imx-dma does not support anything else.

Hmm, so #dma-cells is 1

> @@ -996,13 +1020,33 @@ static void imxdma_issue_pending(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&imxdma->lock, flags);
>  }
>  
> +bool imxdma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	struct imx_dma_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	printk("%s\n", __func__);
> +
> +	if (!data)
> +		return false;
> +
> +	data->dma_request = *(unsigned *) param;
> +	data->alloc_ctl_filter = true;
> +	chan->private = data;
> +
> +	return true;
> +}

which matches the usage here, but 

> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index f6d30cc..762a7d0 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -51,6 +51,9 @@ struct imx_dma_data {
>  	int dma_request; /* DMA request line */
>  	enum sdma_peripheral_type peripheral_type;
>  	int priority;
> +
> +	/* Did the controller's filter function allocated this object? */
> +	bool alloc_ctl_filter;
>  };

There are actually two more members in the imx_dma_data structure. Shouldn't those
be encoded in the dma specifier as well?
  
>  static inline int imx_dma_is_ipu(struct dma_chan *chan)
> @@ -63,7 +66,8 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
>  	return strstr(dev_name(chan->device->dev), "sdma") ||
>  		!strcmp(dev_name(chan->device->dev), "imx1-dma") ||
>  		!strcmp(dev_name(chan->device->dev), "imx21-dma") ||
> -		!strcmp(dev_name(chan->device->dev), "imx27-dma");
> +		!strcmp(dev_name(chan->device->dev), "imx27-dma") ||
> +		!strcmp(chan->device->dev->driver->name, "imx-dma");
>  }

Also, your filter function does not actually check
imx_dma_is_general_purpose() as the old style filter functions
in the slave drivers do, which breaks when you have more than one dma engine
in the system.

I think you have to provide your own xlate function, and pass the controller
and multiple cells into the filter function, or use no filter at all but instead
find a way to get a channel directly.

	Arnd
