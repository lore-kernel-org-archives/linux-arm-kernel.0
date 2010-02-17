From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 17 Feb 2010 22:32:32 +0100 (CET)
Subject: PL-330 DMA driver
In-Reply-To: <20100217203114.GC30033@n2100.arm.linux.org.uk>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<63386a3d1002171026h51f34d4buc9ba0293ea08c004@mail.gmail.com>
	<20100217203114.GC30033@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.1002172220080.4623@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Feb 2010, Russell King - ARM Linux wrote:

> On Wed, Feb 17, 2010 at 07:26:00PM +0100, Linus Walleij wrote:
> > 2010/2/17 jassi brar <jassisinghbrar@gmail.com>:
> > 
> > > Could maintainers please suggest what is the best place for the PL330
> > > controller driver?
> > 
> > drivers/dma/amba-pl033.c would be my bet.
> > 
> > I have patches to support MMCI (PL180/PL181) using the generic DMA
> > engine pending, I will attempt to submit patches for spi/amba-pl022.c and
> > serial/amba-pl011.c when I get the time.
> 
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

Having implemented support for IDMAC on i.MX31 under drivers/dma and slave 
DMA support for drivers/dma/shdma.c, my current opinion is, that basically 
only for controllers, that provide generic DMA operations (memcpy, 
xor,...) it makes sense to put them under dmaengine, and even then your 
slave DMA support will have to struggle. If a DMA controller only supports 
slave type DMA (to / from onboard and external peripherals) it normally 
doesn't make sense to implement it using dmaengine API. Granted, inventing 
a good proprietary API might be difficult, but having done that reasonably 
well, you end up with an API, better suitable for your hardware. It might 
even make sense to implement generic functions using dmaengine API and 
slave DMA using hardware-specific extensions.

Of course, there's also a problem of reusing peripheral drivers with 
different DMA controllers...

my 2p.

Thanks
Guennadi
---
Guennadi Liakhovetski
