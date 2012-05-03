From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 00:25:06 +0100
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FA30604.1030401@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA30604.1030401@wwwdotorg.org>
Message-ID: <20120503232506.GA4181@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 04:26:12PM -0600, Stephen Warren wrote:
> On 04/30/2012 03:17 PM, Jon Hunter wrote:
> > +Example:
> > +
> > +	sdma: dmaengine at 48000000 {
> > +		compatible = "ti,omap4-sdma"
> > +		reg = <0x48000000 0x1000>;
> > +		interrupts = <4>;
> > +		#dma-cells = <2>;
> > +		#dma-channels = <32>;
> > +		#dma-requests = <127>;
> > +	};
> > +
> > +
> > +* DMA client
> > +
> > +Client drivers should specify the DMA property using a phandle to the controller
> > +followed by the number of DMA request/channel and the transfer type of the
> 
> What exactly is "request/channel"? Is it a request ID, a channel ID,
> both packed into a single integer (which bits are used for each field),
> etc.?

Agreed - because with this definition, applied to the PL08x found on
Versatile platforms, it will be impossible to describe the DMA bindings
due to intervening MUX hardware.

> > +channel (eg. device-to-memory, memory-to-device, memory-to-memory, etc). Drivers
> > +should use the DMA Engine enum dma_transfer_direction (eg. DMA_DEV_TO_MEM,
> > +DMA_MEM_TO_DEV, etc) for specifying the transfer type.
> 
> The binding document should stand alone; you shouldn't need to go look
> up values in any particular OS/driver's source code. In other words,
> this should explicitly enumerate the values for DMA_DEV_TO_MEM etc.
> here. That said, I'm not sure it's appropriate to mandate that every DMA
> controller's DMA specifier actually include this information in DT (a
> controller might only support DEV_TO_MEM for example, and hence not need
> this information in DT at all).
> 
> The DMA client's binding should specify how many entries it needs in the
> dma property and what they mean, e.g. it should know that dma property
> index 0 is the TX DMA specifier, and index 1 is the RX specifier.

(Mostly to Jon)

Also bear in mind that as far as DMA engine is concerned, every channel
is _potentially_ bidirectional without it having to be released and
reacquired.  We have some drivers setup to behave like that too.  So
stuffing stuff like the transfer type into the selection adds
restrictions.

On platforms where the DMA transfer type does matter (such as OMAP),
that's normally because one DMA request signal is associated with a
particular DMA direction.  That makes it a property of the DMA request
signal, not of the requested channel.
