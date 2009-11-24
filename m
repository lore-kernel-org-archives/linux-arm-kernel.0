From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 24 Nov 2009 15:35:13 -0500 (EST)
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091124200019.GH17481@n2100.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
	<1259081261.16239.28.camel@pc1117.cambridge.arm.com>
	<20091124200019.GH17481@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0911241523130.2059@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Nov 2009, Russell King - ARM Linux wrote:

> On Tue, Nov 24, 2009 at 04:47:41PM +0000, Catalin Marinas wrote:
> > On Mon, 2009-11-23 at 17:27 +0000, Russell King - ARM Linux wrote:
> > > On Mon, Nov 23, 2009 at 05:25:06PM +0200, saeed bishara wrote:
> > > > > +       if (dir == DMA_FROM_DEVICE) {
> > > > > +               outer_inv_range(paddr, paddr + size);
> > > > > +               dmac_inv_range(kaddr, kaddr + size);
> > > > it's not clear why outer cache invalidated before inner cache, and, I
> > > > think that it may be incorrect, how can you be sure that a dirty line
> > > > that is in inner cache can't be moved down to outer cache?
> > > 
> > > I think you have a point, but also see Catalin's point.  When we are
> > > invalidating, we have to invalidate the outer caches before the inner
> > > caches, otherwise there is a danger that the inner caches could
> > > prefetch from the outer between the two operations.
> > 
> > Good point. In the cpu_to_dev case, we can invalidate the inner cache
> > before the outer cache as it may be faster than cleaning. We also don't
> > care about speculative fetches at this point, only about random cache
> > line evictions.
> > 
> > In the dev_to_cpu case, we must invalidate the outer cache before the
> > inner cache.
> > 
> > Otherwise I'm ok with the patch.
> 
> Having looked into pushing the 3rd argument down into per-CPU code, I've
> come up against two problems:
> 
> 1. the dmabounce (hacky, I wish it'd die) code wants to be able to place
>    the cache in the same state as if the buffer was used for DMA - it
>    does this by calling dmac_clean_range() and outer_clean_range().
> 
> 2. various MTD map drivers want the ARM private flush_ioremap_region,
>    which is built on top of dmac_inv_cache.
> 
> You can't reliably implement either of these two functions using the new
> dmac_(map|unmap)_range interfaces without making the callers knowledgeable
> about the implementation of the map/unmap range interfaces.
> 
> This means we currently end up with five DMA operation pointers in the
> cpu_cache_fns:
> 
>         void (*dma_map_range)(const void *, size_t, int);
>         void (*dma_unmap_range)(const void *, size_t, int);
>         void (*dma_inv_range)(const void *, const void *);
>         void (*dma_clean_range)(const void *, const void *);
>         void (*dma_flush_range)(const void *, const void *);
> 
> which is rather excessive, especially as two will no longer have anything
> to do with DMA.
> 
> I'm tempted to say that for 2.6.33, we'll take the performance hit for CPUs
> older than ARMv7 of needlessly doing DMA cache maintainence on both map and
> unmap, and we'll try to sort it out for 2.6.34.
> 
> The alternative is that we persist with streaming DMA being broken on ARMv7
> for 2.6.33.

What about simply having those two problematic cases above implemented 
on top of dmac_(map|unmap)_range interfaces even if that implies inner 
implementation details, and stick a big fat warning besides them until 
they're properly sorted out?  That should affect a much reduced set of 
users compared to all pre ARMv7 users.


Nicolas
