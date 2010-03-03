From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 03 Mar 2010 10:43:53 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100303124624Z.fujita.tomonori@lab.ntt.co.jp>
References: <20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<1267572594.2173.25.camel@pasglop>
	<20100303124624Z.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <1267613033.15589.58.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-03 at 03:47 +0000, FUJITA Tomonori wrote:
> On Wed, 03 Mar 2010 10:29:54 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Tue, 2010-03-02 at 17:05 +0000, Catalin Marinas wrote:
> >
> > > The viable solutions so far:
> > >
> > >      1. Implement a PIO mapping API similar to the DMA API which takes
> > >         care of the D-cache flushing. This means that PIO drivers would
> > >         need to be modified to use an API like pio_kmap()/pio_kunmap()
> > >         before writing to a page cache page.
> > >      2. Invert the meaning of PG_arch_1 to denote a clean page. This
> > >         means that by default newly allocated page cache pages are
> > >         considered dirty and even if there isn't a call to
> > >         flush_dcache_page(), update_mmu_cache() would flush the D-cache.
> > >         This is the PowerPC approach.
> >
> > I don't see the point of a "PIO" API. I would thus vote for 2 :-) Note
> 
> Yeah, as powerpc and ia64 do, arm can flush D cache and invalidate I
> cache when inserting a executable page to pte, IIUC. No need for the
> new API for I/D consistency.

I can see that IA-64 uses the PG_arch_1 bit to mark a clean page rather
than dirty (as we did for ARM). The Documentation/cachetlb.txt needs
updating.

Thanks.

-- 
Catalin
