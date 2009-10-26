From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Oct 2009 18:40:14 +0000
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20091025133918.GB32406@n2100.arm.linux.org.uk>
References: <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20091015145753.GC14817@n2100.arm.linux.org.uk>
	<1255620022.10164.74.camel@pc1117.cambridge.arm.com>
	<20091015152852.GD14817@n2100.arm.linux.org.uk>
	<1255622179.10164.92.camel@pc1117.cambridge.arm.com>
	<1256038748.32578.14.camel@pc1117.cambridge.arm.com>
	<20091025133918.GB32406@n2100.arm.linux.org.uk>
Message-ID: <1256582415.5282.155.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2009-10-25 at 13:39 +0000, Russell King - ARM Linux wrote:
> On Tue, Oct 20, 2009 at 12:39:08PM +0100, Catalin Marinas wrote:
> > BTW, the cache flushing code in Linux can be optimised a bit more on
> > VIPT caches:
> > 
> >       * __cpuc_flush_dcache_page() could cope with just D-cache clean
> >         rather than clean+invalidate
> 
> No it can not - that breaks shared mappings.  The problem is that
> flush_dcache_page() is used in two circumstances.  These are described
> in more detail in cachetlb.txt, but briefly:
> 
> 1. After the kernel writes to its mapping for a page cache page, and needs
>    to ensure that those writes are visible to shared mmap()s in userspace.
> 
> 2. Before the kernel reads from its mapping for a page cache page, and
>    needs to ensure that it reads up to date data written by userspace
>    into those mappings.
> 
> So just cleaning the D-cache means that (2) will return stale data.

I was referring to VIPT (non-aliasing) case only. Point (2) above is
still valid even if only cleaning the D-cache lines. Shared mappings use
the same cache lines according to the physical address.


> >       * whole I-cache invalidation was needed for some ARM1136 erratum.
> >         We can conditionally revert it to invalidating a range
> 
> That's not what the commit (826cbda) says which implemented it.  Also,
> since we have broken I-cache flushes even with the erratum enabled,
> let's fix the work-around and re-evaluate the situation before changing
> anything.

The commit doesn't say but there was an earlier commit (141fa40cff9088)
which was changing from I-cache inv by MVA to full I-cache inv because
of some ARM1136 erratum (371025). When I sent the second, I just
followed the same idea. We could make this conditional but need to run
some benchmarks to check whether there is a real benefit.

> > Flush the D-cache during copy_user_highpage()
> > 
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > The I and D caches for copy-on-write pages on processors with
> > write-allocate caches become incoherent causing problems on application
> > relying on CoW for text pages (dynamic linker relocating symbols in a
> > text page). This patch flushes the D-cache for such pages (possibly
> > lazily via update_mmu_cache which also takes care of the I-cache).
> 
> Actually, I think this is caused by a missing I-cache flush in
> flush_cache_range().  Adding that flush should resolve this problem
> in hand (and make VIPT aliasing and VIPT non-aliasing behave in the
> same manner.)  That's something which my patch previously posted in
> this thread did.

I think the I-cache flush would later be done via update_mmu_cache(), if
I recall the call trace correctly.

Anyway, flushing both D and I caches in flush_cache_range() would have
the same impact.

> Note also that with ASID tagged VIVT I-cache, we are missing out
> on cache flushing.  As you've identified, it's entirely possible
> for text page translations to be changed, and according to B3.4.1
> bullet 2, a flush is required.

We can do this conditionally at run-time. I don't have such CPU to test
it.

-- 
Catalin
