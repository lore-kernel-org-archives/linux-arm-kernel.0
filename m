From: florian.meier@koalo.de (Florian Meier)
Date: Sun, 17 Nov 2013 17:37:53 +0100
Subject: [PATCHv7] dmaengine: Add support for BCM2835
In-Reply-To: <1384704123.2727.8.camel@joe-AO722>
References: <5288E327.8050809@koalo.de> <1384704123.2727.8.camel@joe-AO722>
Message-ID: <5288F0E1.3020101@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2013 17:02, Joe Perches wrote:
> On Sun, 2013-11-17 at 16:39 +0100, Florian Meier wrote:
>> Add support for DMA controller of BCM2835 as used in the Raspberry Pi.
>> Currently it only supports cyclic DMA.
> []
>> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> []
>> +static int bcm2835_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>> +	unsigned long arg)
>> +{
>> +	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>> +	int ret;
>> +
>> +	switch (cmd) {
>> +	case DMA_SLAVE_CONFIG:
>> +		return bcm2835_dma_slave_config(c,
>> +				(struct dma_slave_config *)arg);
>> +
>> +	case DMA_TERMINATE_ALL:
>> +		bcm2835_dma_terminate_all(c);
>> +		break;
>> +
>> +	default:
>> +		ret = -ENXIO;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> case DMA_TERMINATE_ALL returns an uninitialized ret;

Oh yes - stupid mistake. Thank you!

> []
> 
>> +static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
>> +					   struct of_dma *ofdma)
>> +{
>> +	struct bcm2835_dmadev *d = ofdma->of_dma_data;
>> +	struct dma_chan *chan, *candidate;
>> +
>> +retry:
>> +	candidate = NULL;
>> +
>> +	/* Walk the list of channels registered with the current instance and
>> +	 * find one that is currently unused */
>> +	list_for_each_entry(chan, &d->ddev.channels, device_node)
>> +		if (chan->client_count == 0) {
>> +			candidate = chan;
>> +			break;
>> +		}
>> +
>> +	if (!candidate)
>> +		return NULL;
>> +
>> +	/* dma_get_slave_channel will return NULL if we lost a race between
>> +	 * the lookup and the reservation */
>> +	chan = dma_get_slave_channel(candidate);
> 
> Can that race happen consistently?
> Does this avoid being a tight loop?

I would say this can not happen.
If I get everything right, the conflicting process will not
get NULL (because it has won the race). In the worst case,
a new process enters the race, but this will only continue until all
channels are used. In that case no candidate exists and the loop will
exit.

At least, the code is directly taken from mmp_pdma.c ;-)

Greetings,
Florian
