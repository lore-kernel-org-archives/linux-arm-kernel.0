From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 4 Mar 2010 14:51:28 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 2010-03-03 at 21:54 +0000, Pavel Machek wrote:
> > > With some drivers (those doing PIO) or subsystems (SCSI mass storage
> > > over USB HCD), there is no call to flush_dcache_page() for page cache
> > > pages, hence the ARM implementation of update_mmu_cache() doesn't flush
> > > the D-cache (and only invalidating the I-cache doesn't help).
> > >
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
> > What about option
> > 
> > 3. Forget about PG_arch_1 and always do the flush?
> > 
> > How big is the performance impact? Note that current code does not
> > even *work* so working, 10% slower code will be an improvement.
> 
> The driver fix is as simple as calling a flush_dcache_page() and I've
> been carrying such patches in my tree for some time now. The question is
> whether we need to do it in the driver or not (would need to update
> Documentation/cachetlb.txt as well).
> 
> The reason I'm not in favour always doing the flush is that we penalise
> DMA drivers where there is no need for extra D-cache flushing (already
> handled by the DMA API; option 1 above is similar, just that it is meant
> for PIO usage). An ARM patch I proposed for inverting the meaning of
> PG_arch_1 also marks a page as clean in the dma_map_* functions.

But you are not fixing driver bug, are you?

Seems like ARM has requirement other architectures do not, that is
a) not documented anywhere
b) causes problems

You could argue that performance improvement (how big is it, anyway?)
is worth it, but this should be agreed to by wider community...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
