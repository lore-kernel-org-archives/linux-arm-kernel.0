From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 03 Mar 2010 10:40:17 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267572594.2173.25.camel@pasglop>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<1267572594.2173.25.camel@pasglop>
Message-ID: <1267612817.15589.55.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-02 at 23:29 +0000, Benjamin Herrenschmidt wrote:
> On Tue, 2010-03-02 at 17:05 +0000, Catalin Marinas wrote:
> 
> > The viable solutions so far:
> >
> >      1. Implement a PIO mapping API similar to the DMA API which takes
> >         care of the D-cache flushing. This means that PIO drivers would
> >         need to be modified to use an API like pio_kmap()/pio_kunmap()
> >         before writing to a page cache page.
> >      2. Invert the meaning of PG_arch_1 to denote a clean page. This
> >         means that by default newly allocated page cache pages are
> >         considered dirty and even if there isn't a call to
> >         flush_dcache_page(), update_mmu_cache() would flush the D-cache.
> >         This is the PowerPC approach.
[...]
> > Option 2 above looks pretty appealing to me since it can be done in the
> > ARM code exclusively. I've done some tests and it indeed solves the
> > cache coherency with a rootfs on a USB stick. As Russell suggested, it
> > can be optimised to mark a page as clean when the DMA API is involved to
> > avoid duplicate flushing.
> 
> That wouldn't solve the need for invalidating the I-cache... Unless we
> use another bit.

Indeed. We currently always invalidate the I-cache when the page is
mapped. With PG_arch_2, we could optimise this but I'm not sure it is
worth since I think we only get an update_mmu_cache() call for a page
(unless it is unmapped and re-mapped again).

-- 
Catalin
