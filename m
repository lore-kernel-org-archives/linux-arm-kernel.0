From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 25 Jun 2011 10:09:04 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106242122390.2142@xanadu.home>
References: <alpine.LFD.2.00.1106201306210.2142@xanadu.home>
	<201106211325.16777.arnd@arndb.de>
	<alpine.LFD.2.00.1106242122390.2142@xanadu.home>
Message-ID: <201106251009.04624.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 June 2011, Nicolas Pitre wrote:
> > which means that the dma_buf variable is dereferenced before the
> > volatile mmio_reg variable, which opens up a race: An interrupt may have
> > signalled us that a DMA is in progress, so we read a MMIO register from
> > the device (this is guaranteed to flush the DMA on PCI and similar buses).
> > If we read the dma_buf before we read the mmio register, the data we get
> > back may be stale.
> > 
> > Adding a barrier() between the two turns the assembly into the expected
> > 
> >         ldr     r3, [r1, #0]
> >         ldr     r0, [r0, #0]
> >         bx      lr
> 
> But isn't the usual dma_unmap_*() API call providing that barrier 
> already?

Yes, for the streaming mapping that would be sufficient, but not
for a coherent mapping, which doesn't need dma_unmap_* or dma_sync*
calls before accessing the buffer.

	Arnd
