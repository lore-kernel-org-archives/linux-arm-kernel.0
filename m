From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Oct 2009 18:18:27 +0000
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20091025130439.GA32406@n2100.arm.linux.org.uk>
References: <20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20091015145753.GC14817@n2100.arm.linux.org.uk>
	<1255620022.10164.74.camel@pc1117.cambridge.arm.com>
	<20091025130439.GA32406@n2100.arm.linux.org.uk>
Message-ID: <1256581107.5282.140.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2009-10-25 at 13:04 +0000, Russell King - ARM Linux wrote:
> On Thu, Oct 15, 2009 at 04:20:22PM +0100, Catalin Marinas wrote:
> > On Thu, 2009-10-15 at 15:57 +0100, Russell King - ARM Linux wrote:
> > > On Mon, Sep 21, 2009 at 11:07:51AM +0100, Russell King - ARM Linux wrote:
> > > > On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
> > > > > We would need to fix this somehow as well. We currently handle the
> > > > > I-cache in update_mmu_cache() when a page is first mapped if it has
> > > > > VM_EXEC set.
> > > > 
> > > > The reason I'm pushing you hard to separate the two issues is that the
> > > > two should be treated separately.  I think we need to consider ensuring
> > > > that freed pages do not have any I-cache lines associated with them,
> > > > rather than waiting for them to be allocated and then dealing with the
> > > > I-cache problem.
> > > 
> > > Having now benchmarked this (making flush_cache_* always invalidate
> > > the I-cache, so free'd pages are I-cache clean), and to me, the results
> > > quite look promising - please try out this patch.
> > > 
> > > diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> > > index d0d17b6..b9c1cd4 100644
> > > --- a/arch/arm/mm/fault-armv.c
> > > +++ b/arch/arm/mm/fault-armv.c
> > > @@ -160,8 +160,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
> > >  	if (mapping) {
> > >  		if (cache_is_vivt())
> > >  			make_coherent(mapping, vma, addr, pfn);
> > > -		else if (vma->vm_flags & VM_EXEC)
> > > -			__flush_icache_all();
> > >  	}
> > >  }
> > 
> > Before trying the patch, I don't entirely agree with the approach. You
> > will get speculative fetches in the I-cache via the kernel linear
> > mapping (where NX is always cleared) on newer processors and may end up
> > with random faults in user space (not that likely but not impossible
> > either).
> 
> BTW, if this is your view, we should get rid of the I-cache flushing for
> the aliasing VIPT caches in the flush_cache_* functions - to make them
> behave in the same way as VIPT non-aliasing.

I lost my memory on why these were added in the first instance. As I
understand (now), they were added to avoid having freed page cache pages
with stale I-cache lines. But if we invalidate the I-cache when mapping
pages, I agree, we should have the same behaviour for both aliasing and
non-aliasing caches.

> However, as a general point, Linux's cache flushing APIs are predicated
> on the notion that there is no speculative fetches going on - for
> instance, when mappings are removed, the following procedure is
> adhered to:
> 
> 	flush_cache();
> 	change page tables
> 	flush_tlb();
> 
> I suspect that the right solution to the problems with speculative
> fetches is that we need to invent a new cache API to adequately cover
> this - and since we'll be the only architecture needing the API, you
> can expect it to have a very high maintainence cost.

I don't think speculative prefetches is something specific to ARM.
Anything that can do branch prediction also does some form of
prefetching (I know Alpha even does speculative stores).

But in the case above I don't think it's a problem with VIPT
non-aliasing caches (and ARMv7 doesn't allow aliasing caches). Since we
can only have speculative reads, there is no way to get dirty cache
lines that would later need to be evicted (even so, I think the cache
keeps the physical address for a line so that it doesn't require another
TLB look-up for evicting lines; but this may be implementation
specific).

-- 
Catalin
