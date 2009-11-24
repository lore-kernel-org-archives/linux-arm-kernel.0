From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Nov 2009 16:47:41 +0000
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091123172722.GE18142@n2100.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
Message-ID: <1259081261.16239.28.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-11-23 at 17:27 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2009 at 05:25:06PM +0200, saeed bishara wrote:
> > > +       if (dir == DMA_FROM_DEVICE) {
> > > +               outer_inv_range(paddr, paddr + size);
> > > +               dmac_inv_range(kaddr, kaddr + size);
> > it's not clear why outer cache invalidated before inner cache, and, I
> > think that it may be incorrect, how can you be sure that a dirty line
> > that is in inner cache can't be moved down to outer cache?
> 
> I think you have a point, but also see Catalin's point.  When we are
> invalidating, we have to invalidate the outer caches before the inner
> caches, otherwise there is a danger that the inner caches could
> prefetch from the outer between the two operations.

Good point. In the cpu_to_dev case, we can invalidate the inner cache
before the outer cache as it may be faster than cleaning. We also don't
care about speculative fetches at this point, only about random cache
line evictions.

In the dev_to_cpu case, we must invalidate the outer cache before the
inner cache.

Otherwise I'm ok with the patch.

-- 
Catalin
