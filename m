From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 4 Nov 2013 15:21:35 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <527814E4.9050204@wwwdotorg.org>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <2443024.JdDKnfkC18@wuerfel> <5277CD33.6030003@wwwdotorg.org>
 <1704730.RnIqE1USnv@wuerfel>
 <20131104212930.GB9638@obsidianresearch.com>
 <527814E4.9050204@wwwdotorg.org>
Message-ID: <20131104222135.GA10711@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 02:43:00PM -0700, Stephen Warren wrote:
> On 11/04/2013 02:29 PM, Jason Gunthorpe wrote:
> > On Mon, Nov 04, 2013 at 09:43:22PM +0100, Arnd Bergmann wrote:
> > 
> >> /*
> >>  * this lists all properties we access from the driver. The list
> >>  * is interpreted by devm_probe() and can be programmatically
> >>  * verified to match the binding.
> >>  */
> >> static const struct devm_probe foo_probe_list[] = {
> >> 	DEVM_ALLOC(foo_priv),
> >> 	DEVM_IOMAP(foo_priv, regs, 0, 0),
> >> 	DEVM_PROP_BOOL(foo_priv, oldstyle_dma, "foo,oldstyle-dma"),
> >> 	DEVM_DMA_SLAVE(foo_priv, rxdma, "rx");
> >> 	DEVM_DMA_SLAVE(foo_priv, txdma, "tx");
> >> 	DEVM_GPIO(foo_priv, gpio, 0);
> >> 	DEVM_IRQ_NAMED(foo_priv, irq, foo_irq_handler, "fifo", IRQF_SHARED),
> >> 	{},
> >> };
> > 
> > Drivers are required to gain control of, and disable the device before
> > they bind and enable things like DMA or interrupts.
> > 
> > At the very least the action list above needs an explicit callback to
> > do that step..
> 
> For IRQs, it looks like Arnd's code was simply parsing the IRQ
> specifier, and converting it to the Linux-internal number. The actual
> request of the IRQ was presumably left to probe(). I think theren's no
> issue here.

The handler is an argument to DEMV_IRQ_* so it can be passed to
request_irq..

int devm_probe_irq(struct device *dev, const struct devm_probe *probe)
{
[..]
	return devm_request_irq(dev, irq, probe->arg, probe->flags, name, probe->dev);
}

Which is nice because it gives a chance to centralize the error
handling printks as well.

> For DMA, it does look like Arnd's code was requesting it too, but that
> should also be fine; as long as no transactions are actually issued
> against that DMA slave channel, then the HW state shouldn't matter?

TBH, I'm not really familiar with how the DMA slave API works.

As long as the API and HW guarantees that the channel cannot do any
DMAs no matter what the connected IP does, it is obviously fine..

But not all DMA is like that, eg bus master DMA in PCI requires
drivers to call pci_enable_device only after they disable DMA in the
device, which is why I mentioned it..

It would be nice to see a general API like this unambiguously make
clear the steps required:

- Gain access to registers
- Gain control of the device
- Enable DMA, bind interrupts, etc
- Finalize device setup
- Make the device visible to the rest of the system

I've seen lots of drivers where the above is just not done right.

Regards,
Jason
