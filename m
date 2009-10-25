From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Oct 2009 13:39:18 +0000
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1256038748.32578.14.camel@pc1117.cambridge.arm.com>
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
Message-ID: <20091025133918.GB32406@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2009 at 12:39:08PM +0100, Catalin Marinas wrote:
> On Thu, 2009-10-15 at 16:56 +0100, Catalin Marinas wrote:
> > On Thu, 2009-10-15 at 16:28 +0100, Russell King - ARM Linux wrote:
> > > On Thu, Oct 15, 2009 at 04:20:22PM +0100, Catalin Marinas wrote:
> > > > On Thu, 2009-10-15 at 15:57 +0100, Russell King - ARM Linux wrote:
> > > > > On Mon, Sep 21, 2009 at 11:07:51AM +0100, Russell King - ARM Linux wrote:
> > > > > > On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
> > > > > > > We would need to fix this somehow as well. We currently handle the
> > > > > > > I-cache in update_mmu_cache() when a page is first mapped if it has
> > > > > > > VM_EXEC set.
> > > > > > 
> > > > > > The reason I'm pushing you hard to separate the two issues is that the
> > > > > > two should be treated separately.  I think we need to consider ensuring
> > > > > > that freed pages do not have any I-cache lines associated with them,
> > > > > > rather than waiting for them to be allocated and then dealing with the
> > > > > > I-cache problem.
> > > > > 
> > > > > Having now benchmarked this (making flush_cache_* always invalidate
> > > > > the I-cache, so free'd pages are I-cache clean), and to me, the results
> > > > > quite look promising - please try out this patch.
> [...]
> > > > Before trying the patch, I don't entirely agree with the approach. You
> > > > will get speculative fetches in the I-cache via the kernel linear
> > > > mapping (where NX is always cleared) on newer processors and may end up
> > > > with random faults in user space (not that likely but not impossible
> > > > either).
> > > 
> > > That means we have no option but to flush the I-cache every time a page
> > > is placed into userspace - we might as well make update_mmu_cache
> > > unconditionally flush the I-cache every time its called.
> [...]
> > We can flush the D-cache in copy_user_page(), maybe lazily via
> > flush_dcache_page() and invalidate the I-cache in update_mmu_cache() if
> > PG_arch_1 (ignoring VM_EXEC).
> 
> Something like below (based on your original suggestion for flushing the
> D-cache in copy_user_highpage).
> 
> BTW, the cache flushing code in Linux can be optimised a bit more on
> VIPT caches:
> 
>       * __cpuc_flush_dcache_page() could cope with just D-cache clean
>         rather than clean+invalidate

No it can not - that breaks shared mappings.  The problem is that
flush_dcache_page() is used in two circumstances.  These are described
in more detail in cachetlb.txt, but briefly:

1. After the kernel writes to its mapping for a page cache page, and needs
   to ensure that those writes are visible to shared mmap()s in userspace.

2. Before the kernel reads from its mapping for a page cache page, and
   needs to ensure that it reads up to date data written by userspace
   into those mappings.

So just cleaning the D-cache means that (2) will return stale data.

>       * whole I-cache invalidation was needed for some ARM1136 erratum.
>         We can conditionally revert it to invalidating a range

That's not what the commit (826cbda) says which implemented it.  Also,
since we have broken I-cache flushes even with the erratum enabled,
let's fix the work-around and re-evaluate the situation before changing
anything.

It could be that some of the I-cache problems are caused by the improperly
fixed erratum.

> Flush the D-cache during copy_user_highpage()
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> The I and D caches for copy-on-write pages on processors with
> write-allocate caches become incoherent causing problems on application
> relying on CoW for text pages (dynamic linker relocating symbols in a
> text page). This patch flushes the D-cache for such pages (possibly
> lazily via update_mmu_cache which also takes care of the I-cache).

Actually, I think this is caused by a missing I-cache flush in
flush_cache_range().  Adding that flush should resolve this problem
in hand (and make VIPT aliasing and VIPT non-aliasing behave in the
same manner.)  That's something which my patch previously posted in
this thread did.

Note also that with ASID tagged VIVT I-cache, we are missing out
on cache flushing.  As you've identified, it's entirely possible
for text page translations to be changed, and according to B3.4.1
bullet 2, a flush is required.
