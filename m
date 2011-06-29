From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2011 12:56:27 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106261027070.2142@xanadu.home>
References: <alpine.LFD.2.00.1106201306210.2142@xanadu.home>
	<201106251009.04624.arnd@arndb.de>
	<alpine.LFD.2.00.1106261027070.2142@xanadu.home>
Message-ID: <201106291256.27746.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 June 2011, Nicolas Pitre wrote:
> On Sat, 25 Jun 2011, Arnd Bergmann wrote:
> 
> > On Saturday 25 June 2011, Nicolas Pitre wrote:
> > > > which means that the dma_buf variable is dereferenced before the
> > > > volatile mmio_reg variable, which opens up a race: An interrupt may have
> > > > signalled us that a DMA is in progress, so we read a MMIO register from
> > > > the device (this is guaranteed to flush the DMA on PCI and similar buses).
> > > > If we read the dma_buf before we read the mmio register, the data we get
> > > > back may be stale.
> > > > 
> > > > Adding a barrier() between the two turns the assembly into the expected
> > > > 
> > > >         ldr     r3, [r1, #0]
> > > >         ldr     r0, [r0, #0]
> > > >         bx      lr
> > > 
> > > But isn't the usual dma_unmap_*() API call providing that barrier 
> > > already?
> > 
> > Yes, for the streaming mapping that would be sufficient, but not
> > for a coherent mapping, which doesn't need dma_unmap_* or dma_sync*
> > calls before accessing the buffer.
> 
> OK, so that leaves only that case.  Obviously that must not be all that 
> critical in practice given the time it has been "broken" already.

It's not all that critical for a number reasons:

* In many cases, the compiler does not actually reorder the accesses,
  even if it is allowed to. Whether it does or not depends a lot on
  the toolchain version and compiler flags.
* Even if the code is reordered, the race is very small, and in a lot
  of cases the data will already be there anyway.
* Most drivers that rely on the ordering guarantees of readl() are
  probably for PCI hardware, which explicitly defines its interface
  in these terms. Most ARM implementations nowadays don't have PCI,
  or are used with a very limited set of PCI hardware.

None of these however mean that we shouldn't try to fix the problem.

I'm also not convinced that the case I constructed is the only one
that is broken now or in the future, as gcc is adding more
optimizations. Even if I was not able to construct a case where
memory accesses are reorganized around a writel() in practice,
I think it's clear that the compiler is allowed to do it in the
current definition (without a wmb()), while the PCI driver API
assumes that there is a barrier.

> So I'm wondering if this might be a better idea to augment the API with 
> explicit barriers to cover the case above which is still a much less 
> frequent pattern than successive readl()/writel()'s where the implicit 
> memory barrier is really badly affecting the generated code.

Didn't we just introduce the _relaxed() variants specifically to avoid
the extra barriers? Surely the effect of the outer_flush() for writel
on modern cores must be much more severe than the memory barrier
implied by it.

I think the best solution would be to have a set of architecture-
independent I/O accessors that do not observe strict PCI ordering
rules of iowrite32 and writel but instead put that in the hands of
the driver writer.
This can be either the writel_relaxed() family we have on arm
and sh, or out_le32 as on m68k, microblaze, powerpc and extensa,
or something new.

We should probably also define a variant that is native-endian,
to provide a replacement for the __raw_writel family.

	Arnd
