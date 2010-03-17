From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Mar 2010 22:03:52 +0000
Subject: mapping uncached memory
In-Reply-To: <d73d4eaf1003171426y35f9c431l93182fa73b3a5084@mail.gmail.com>
References: <d73d4eaf1003171426y35f9c431l93182fa73b3a5084@mail.gmail.com>
Message-ID: <1268863432.32682.2.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-17 at 21:26 +0000, Colin Cross wrote:
> On Wed, Mar 17, 2010 at 1:15 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Mar 17, 2010 at 10:02:09AM +0200, Budhee Jamaich wrote:
> >> On Wed, Mar 17, 2010 at 1:54 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> from Documentation/DMA-API.txt:
> >>
> >> "void *
> >> dma_alloc_coherent(struct device *dev, size_t size,
> >>                              dma_addr_t *dma_handle, gfp_t flag)
> >>
> >> Consistent memory is memory for which a write by either the device or
> >> the processor can immediately be read by the processor or device
> >> without having to worry about caching effects.  (You may however need
> >> to make sure to flush the processor's write buffers before telling
> >> devices to read that memory.)"
> >>
> >>
> >>
> >> That last sentence - what does it really say ? That I still need to
> >> manually clean/invalidate the caches myself ?
> >
> > No - if it did, it would contradict the previous sentence.  What it's
> > referring to is that on weakly ordered CPUs, you may need barriers.
> 
> Tegra2 needs a wmb() and an L2 cache sync on dma_alloc_coherent memory
> before handing it to the device.  

RealView boards with an L2 cache needs such thing as well.

> Currently, I am using Catalin's
> patches for machine-specific wmb() implementations to do both
> operations using a wmb() and keep the L2 details out of the drivers.
> Is that the correct use of those patches?  

Yes, the driver should only invoke a barrier rather than the L2 cache
specific functions.

> Is there any other way to
> handle dma_alloc_coherent memory on ARMv7?

I'm not aware of a different way. You could use streaming DMA API via
the dma_map_*() etc functions but this is cached memory and the
corresponding functions perform the flushing.

-- 
Catalin
