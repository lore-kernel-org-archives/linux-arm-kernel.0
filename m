From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 21:01:54 +0000
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <alpine.LFD.2.00.0911241523130.2059@xanadu.home>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
	<1259081261.16239.28.camel@pc1117.cambridge.arm.com>
	<20091124200019.GH17481@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911241523130.2059@xanadu.home>
Message-ID: <20091124210154.GI17481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 03:35:13PM -0500, Nicolas Pitre wrote:
> On Tue, 24 Nov 2009, Russell King - ARM Linux wrote:
> > Having looked into pushing the 3rd argument down into per-CPU code, I've
> > come up against two problems:
> > 
> > 1. the dmabounce (hacky, I wish it'd die) code wants to be able to place
> >    the cache in the same state as if the buffer was used for DMA - it
> >    does this by calling dmac_clean_range() and outer_clean_range().
> > 
> > 2. various MTD map drivers want the ARM private flush_ioremap_region,
> >    which is built on top of dmac_inv_cache.
> > 
> > You can't reliably implement either of these two functions using the new
> > dmac_(map|unmap)_range interfaces without making the callers knowledgeable
> > about the implementation of the map/unmap range interfaces.
> > 
> > This means we currently end up with five DMA operation pointers in the
> > cpu_cache_fns:
> > 
> >         void (*dma_map_range)(const void *, size_t, int);
> >         void (*dma_unmap_range)(const void *, size_t, int);
> >         void (*dma_inv_range)(const void *, const void *);
> >         void (*dma_clean_range)(const void *, const void *);
> >         void (*dma_flush_range)(const void *, const void *);
> > 
> > which is rather excessive, especially as two will no longer have anything
> > to do with DMA.
> > 
> > I'm tempted to say that for 2.6.33, we'll take the performance hit for CPUs
> > older than ARMv7 of needlessly doing DMA cache maintainence on both map and
> > unmap, and we'll try to sort it out for 2.6.34.
> > 
> > The alternative is that we persist with streaming DMA being broken on ARMv7
> > for 2.6.33.
> 
> What about simply having those two problematic cases above implemented 
> on top of dmac_(map|unmap)_range interfaces even if that implies inner 
> implementation details, and stick a big fat warning besides them until 
> they're properly sorted out?  That should affect a much reduced set of 
> users compared to all pre ARMv7 users.

My point was it doesn't work.  Not only will you have to select which
of the map/unmap functions you require, but also the 3rd argument to
get the desired behaviour depending on the CPU in use.
