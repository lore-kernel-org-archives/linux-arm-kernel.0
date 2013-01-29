From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 13:44:10 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <20130129111850.GR23505@n2100.arm.linux.org.uk>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291050.23743.arnd@arndb.de>
 <20130129111850.GR23505@n2100.arm.linux.org.uk>
Message-ID: <201301291344.11066.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Russell King - ARM Linux wrote:
> > On Tuesday 29 January 2013, Andy Shevchenko wrote:
> > > On Mon, 2013-01-28 at 21:58 +0000, Arnd Bergmann wrote: 
> > > > - if ((last_dw == dw) && (last_bus_id == param))
> > > > + /* both the driver and the device must match */
> > > > +        if (chan->device->dev->driver != &dw_driver.driver)
> > > 
> > > Could we somehow pass the &.driver to the generic filter function (via
> > > *_dma_controller_register() ? ) and do this to each DMA driver?
> 
> How, and what driver gets passed?

of_dma_controller_register (see linux-next) already gets a device_node
of a device that is owned by the driver calling this function. This
driver could in theory pass its 'struct device_driver' as another
argument, although I would expect it to pass its own device specific
object (e.g. struct dw_dma or struct dma_pl330_dmac) as the 'data'
pointer, and from there it can easily check if the device matches.

> > My hope is still that we can avoid using filter functions entirely
> > when we use xlate() logic, and instead just go through the channels
> > of the dma engine we know we are looking at.
> 
> Has anyone yet determined whether any of these new DMA engine slave APIs
> are usable for implementations which have a separate MUX between the
> DMA engine and the DMA peripheral?

Can you give an example for this? We were careful to make sure it
works with platforms that connect a slave to multiple dma engines,
out of which any could be used for a given transfer. In the device
tree binding, you specify all possible controllers and give the
alternatives the same name, for example:

	serial at 10000000 {
		compatible = "arm,pl011", "arm,primecell";
		dmas = <dwdma0 7 0>, <dwdma0 8 1>, <&pl330 17>, <&pl330 15>;
		dma-names = "rx", "tx", "rx", "tx;
		...
	};

Here, you hve a UART that can use DMA for both receive and transmit, and
can use either the dw_dma or the pl330 controller for each channel.
The common dmaengine code will try to pick the first available channel
on either one. We can probably try to be smarter about making the decision
which one to use.

Is this what you are referring to?

	Arnd
