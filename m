From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 18:19:29 +0200
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAGsJ_4wOQddus_Vz5zUjy-4ETOeaiZ+STRD22SwRy+yr4YLaRA@mail.gmail.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<201109081652.20552.arnd@arndb.de>
	<CAGsJ_4wOQddus_Vz5zUjy-4ETOeaiZ+STRD22SwRy+yr4YLaRA@mail.gmail.com>
Message-ID: <201109081819.30035.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011, Barry Song wrote:
> i am not sure whether i have other way to require a special channel
> for a special device. it seems dma_request_channel only gives me a
> chance to use a filter function since my all channels have same DMA
> cap masks.
> 
> this filter is used by all drivers with DMA since every dma channel is
> fixed to be assigned to one device.
> 
> i did do some copy from coh901318.c:
> bool coh901318_filter_id(struct dma_chan *chan, void *chan_id)
> {
>     unsigned int ch_nr = (unsigned int) chan_id;
> 
>     if (ch_nr == to_coh901318_chan(chan)->id)
>         return true;
> 
>     return false;
> }
> EXPORT_SYMBOL(coh901318_filter_id);
> 
> if it does become a common filter,  we might have a function like:
> 
> bool dmaengine_filter_match_channel_id(struct dma_chan *chan, void *chan_id)
> {
>     if (ch_nr == chan->chan_id)
>         return true;
> 
>     return false;
> }
> EXPORT_SYMBOL(dmaengine_filter_match_channel_id);

Ok, I see now. I think it would be best to introduce a generic
'filter by device tree property' function or alternatively an
dma_of_request_channel function like this:

struct dma_chan *dma_of_request_channel(struct device *dev, unsigned int index)
{
	struct dma_device *dmadev;
	struct {
		unsigned int phandle;
		unsigned int channel_num;
	} *property;
	int lenp;

	property = of_get_property(dev->of_node, "dma-channel", &lenp);
	if (lenp < (index * sizeof (*property))
		return -EINVAL;

	property += index;

	dmadev = dma_find_device(of_find_node_by_phandle(property->phandle));
	if (!dmadev)
		return -ENODEV;

	return dma_get_channel(dmadev, property->channel_num);
}

This way, you can link a device to its dma_channel in the device tree without
the device driver even understanding what a dma_device or a channel id
is.

	Arnd
