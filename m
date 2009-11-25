From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2009 12:14:39 +0000
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091124200019.GH17481@n2100.arm.linux.org.uk>
References: <20091124200019.GH17481@n2100.arm.linux.org.uk>
Message-ID: <1259151279.30270.56.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-11-24 at 20:00 +0000, Russell King - ARM Linux wrote:
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

BTW, it would really help if you publish a volatile git branch
containing these patches. There's nothing wrong with it. Even the git
tool maintainer has a branch called "pu" for experimental stuff.

I'm getting confused. Can we not just implement a generic dma_map_range
and dma_unmap_range in terms of dma_clean_range and dma_inv_range as
low-level CPU support functions?

-- 
Catalin
