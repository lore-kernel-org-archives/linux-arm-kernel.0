From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Aug 2013 22:49:31 +0200
Subject: [PATCH v7] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <1375713457-5562-1-git-send-email-jonas.jensen@gmail.com>
References: <1375450125-29767-1-git-send-email-jonas.jensen@gmail.com>
 <1375713457-5562-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201308052249.32174.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 August 2013, Jonas Jensen wrote:

> +bool moxart_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	struct moxart_dma_chan *mchan = to_moxart_dma_chan(chan);
> +	struct moxart_dma_container *mc = to_dma_container(mchan->chan.device);
> +
> +	if (chan->device->dev == mc->dma_slave.dev) {

This comparison seems rather pointless -- you only check that the
device owning the channel is the same as the device that belongs
to channel's "container", which would naturally be the case.

What you don't check here is that it matches the device that was passed
to of_dma_controller_register().

> +		struct moxart_dma_chan *mchan = to_moxart_dma_chan(chan);
> +		unsigned int ch_req = *(unsigned int *)param;
> +		dev_dbg(chan2dev(chan), "%s: mchan=%p ch_req=%d mchan->ch_num=%d\n",
> +			__func__, mchan, ch_req, mchan->ch_num);
> +		return ch_req == mchan->ch_num;
> +	} else {
> +		dev_dbg(chan2dev(chan), "%s: device not registered to this DMA engine\n",
> +			__func__);
> +		return false;
> +	}
> +}
> +
> +static struct of_dma_filter_info moxart_dma_info = {
> +	.filter_fn = moxart_dma_filter_fn,
> +};
> +
> +static struct dma_chan *moxart_of_xlate(struct of_phandle_args *dma_spec,
> +					struct of_dma *ofdma)
> +{
> +	struct dma_chan *chan;
> +	struct of_dma_filter_info *info = ofdma->of_dma_data;
> +
> +	if (!info || !info->filter_fn)
> +		return NULL;

This seems pointless too. Why do you pass a of_dma_filter_info pointer
as ofdma->of_dma_data? It's constant after all and you can just access
it a couple of lines higher.

> +	if (dma_spec->args_count != 2)
> +		return NULL;
> +
> +	chan = dma_request_channel(info->dma_cap, info->filter_fn,
> +				   &dma_spec->args[0]);

The filter function is also constant. However, you need to pass the
device pointer here so the filter can compare it.

> +	if (chan)
> +		to_moxart_dma_chan(chan)->line = dma_spec->args[1];
> +
> +	return chan;
> +}

There is still an open question here regarding whether or not the
channel number is actually required to be fixed or not. In most
dma engines, the channels are actually interchangeable, so you only
need to specify the request number, not the channel. Does this still
work if you just pick the first

	Arnd
