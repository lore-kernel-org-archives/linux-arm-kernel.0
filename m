From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2009 16:20:22 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20091015145753.GC14817@n2100.arm.linux.org.uk>
References: <20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20091015145753.GC14817@n2100.arm.linux.org.uk>
Message-ID: <1255620022.10164.74.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-15 at 15:57 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2009 at 11:07:51AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
> > > We would need to fix this somehow as well. We currently handle the
> > > I-cache in update_mmu_cache() when a page is first mapped if it has
> > > VM_EXEC set.
> > 
> > The reason I'm pushing you hard to separate the two issues is that the
> > two should be treated separately.  I think we need to consider ensuring
> > that freed pages do not have any I-cache lines associated with them,
> > rather than waiting for them to be allocated and then dealing with the
> > I-cache problem.
> 
> Having now benchmarked this (making flush_cache_* always invalidate
> the I-cache, so free'd pages are I-cache clean), and to me, the results
> quite look promising - please try out this patch.
> 
> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> index d0d17b6..b9c1cd4 100644
> --- a/arch/arm/mm/fault-armv.c
> +++ b/arch/arm/mm/fault-armv.c
> @@ -160,8 +160,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>  	if (mapping) {
>  		if (cache_is_vivt())
>  			make_coherent(mapping, vma, addr, pfn);
> -		else if (vma->vm_flags & VM_EXEC)
> -			__flush_icache_all();
>  	}
>  }

Before trying the patch, I don't entirely agree with the approach. You
will get speculative fetches in the I-cache via the kernel linear
mapping (where NX is always cleared) on newer processors and may end up
with random faults in user space (not that likely but not impossible
either).

-- 
Catalin
