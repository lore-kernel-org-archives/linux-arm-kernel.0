From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Feb 2013 20:50:14 +0000
Subject: [PATCH 03/12] dma: mxs-dma: move to generic device tree binding
In-Reply-To: <1361978748-25281-4-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <201302272050.14338.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013, Shawn Guo wrote:
> @@ -139,6 +140,9 @@ struct mxs_dma_engine {
>  	struct dma_device		dma_device;
>  	struct device_dma_parameters	dma_parms;
>  	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
> +	struct platform_device		*pdev;
> +	struct of_dma_filter_info	filter_info;
> +	unsigned int			nr_channels;
>  };

I don't think using of_dma_filter_info makes sense when we are not
using the generic xlate function:

> @@ -665,8 +667,59 @@ err_out:
>  	return ret;
>  }
>  
> +struct mxs_dma_filter_param {
> +	struct device_node *of_node;
> +	unsigned int chan_id;
> +};
> +
> +struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
> +			       struct of_dma *ofdma)
> +{
> +	struct mxs_dma_engine *mxs_dma = ofdma->of_dma_data;
> +	struct of_dma_filter_info *info = &mxs_dma->filter_info;
> +	struct mxs_dma_filter_param param;
> +	int count = dma_spec->args_count;
> +
> +	if (!info || !info->filter_fn)
> +		return NULL;
> +
> +	if (count != 1)
> +		return NULL;
> +
> +	param.of_node = ofdma->of_node;
> +	param.chan_id = dma_spec->args[0];
> +
> +	if (param.chan_id >= mxs_dma->nr_channels)
> +		return NULL;
> +
> +	return dma_request_channel(info->dma_cap, info->filter_fn, &param);
> +}
> +
> +static bool mxs_dma_filter_fn(struct dma_chan *chan, void *fn_param)

You already know the value of info->filter_fn, it's always &mxs_dma_filter_fn,
so if you reorder these two functions, you can pass it directly into
dma_request_channel.

> +	struct mxs_dma_filter_param *param = fn_param;
> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	int chan_irq;
> +
> +	if (mxs_dma->dma_device.dev->of_node != param->of_node)
> +		return false;
> +
> +	if (chan->chan_id != param->chan_id)
> +		return false;

It would be nice if we could just get a pointer to the right channel
structure from the xlate() function, rather than having to walk the
list of channels and trying each one. Your method is what everyone
else is doing as well, so we can stick with it for now, but at some
point I'd like to open up this discussion again.

	Arnd
