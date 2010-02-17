From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 17 Feb 2010 22:46:20 +0100
Subject: PL-330 DMA driver
In-Reply-To: <20100217203114.GC30033@n2100.arm.linux.org.uk>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<63386a3d1002171026h51f34d4buc9ba0293ea08c004@mail.gmail.com>
	<20100217203114.GC30033@n2100.arm.linux.org.uk>
Message-ID: <63386a3d1002171346t274d1488vb5cfa6e2c84898dc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> One of the problems with the DMA engine APIs are that the data needed to
> setup the non-device side is opaque - in other words, it's specific to
> the DMA engine being used.
>
> This means primecell drivers can't define this data; they don't know what
> kind of DMA engine will be used - and I'm not sure passing it in from
> the platform side of things makes much sense either.
>
> Unless... we define a base structure for DMA engines used with primecell
> peripherals...

Yes I get the point. I haven't seen much such non-device side stuff
that's actually needed for the driver to specify in the platforms I've
seen. I would say that things like burst size, throttling mechanisms
etc are not generic at all and that knowledge has to be tied to the
channel and DMA engine, however the address and the width of the
endpoint is very generic.

For U300 we have two such parameters in the
DMA engine config for each DMA channel. It's the memory address
where the DMA transaction ends up, like (for PL180) this:

const struct coh_dma_channel chan_config[U300_DMA_CHANNELS] = {
 		.priority_high = 0,
> 		.dev_addr =  U300_MMCSD_BASE + 0x080,
 		.param.config = COH901318_CX_CFG_CH_DISABLE |
(...)
			COH901318_CX_CTRL_BURST_COUNT_32_BYTES | \
>			COH901318_CX_CTRL_SRC_BUS_SIZE_32_BITS | \
			COH901318_CX_CTRL_SRC_ADDR_INC_ENABLE | \
>			COH901318_CX_CTRL_DST_BUS_SIZE_32_BITS | \

It would indeed be better if the physical .dev_addr for TX or RX
could come in from the PrimeCell itself.

This is the most obvious thing, I guess things like burst size could
be equally relevant on some peripheral but haven't seen such a
thing yet.

Would it be good if I went in and defined some struct in
include/linux/amba/bus.h like this:

struct amba_dma_params {
	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
	void *dma_rx_param;
	void *dma_tx_param;
	dma_addr_t phy_rx_addr;
	dma_addr_t phy_tx_addr;
	int rx_width;
	int tx_width;
};

dma_addr_t could just as well be struct resource (as the
platform_device does it) if that is preferred. But why...
Then we include that into e.g. struct mmci_platform_data
etc.

We could pass a subset of this for as the void * parameter
to the dma_request_channel(), for example this:

struct amba_dma_channel_request {
	void *dma_param;
	dma_addr_t phy_addr;
	int width;
	/* extend here with stuff needed to request PrimeCell channels */
};

It's also quite simple to make a pair of macros for wrapping the
rx or tx part into an amba_dma_channel_request.

In this case the DMA engine implementation
has to know which channels are primecell channels and
dereference these into amba_dma_params. This could be
the defined base structure of DMA engines supporting primecells
I guess.

Otherwise we can require that all DMA engines that
support PrimeCells also support an additional function call:
dma_request_amba_channel(dma_cap_mask_t *mask,
  dma_filter_fn fn,
  struct amba_dma_channel_request *ar);

I can make a quick fix on the MMCI driver as example for either
path, but I need some rough consensus.

Yours,
Linus Walleij
