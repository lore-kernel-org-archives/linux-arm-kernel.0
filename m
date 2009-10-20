From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Oct 2009 12:39:08 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1255622179.10164.92.camel@pc1117.cambridge.arm.com>
References: <20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20091015145753.GC14817@n2100.arm.linux.org.uk>
	<1255620022.10164.74.camel@pc1117.cambridge.arm.com>
	<20091015152852.GD14817@n2100.arm.linux.org.uk>
	<1255622179.10164.92.camel@pc1117.cambridge.arm.com>
Message-ID: <1256038748.32578.14.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-15 at 16:56 +0100, Catalin Marinas wrote:
> On Thu, 2009-10-15 at 16:28 +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 15, 2009 at 04:20:22PM +0100, Catalin Marinas wrote:
> > > On Thu, 2009-10-15 at 15:57 +0100, Russell King - ARM Linux wrote:
> > > > On Mon, Sep 21, 2009 at 11:07:51AM +0100, Russell King - ARM Linux wrote:
> > > > > On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
> > > > > > We would need to fix this somehow as well. We currently handle the
> > > > > > I-cache in update_mmu_cache() when a page is first mapped if it has
> > > > > > VM_EXEC set.
> > > > > 
> > > > > The reason I'm pushing you hard to separate the two issues is that the
> > > > > two should be treated separately.  I think we need to consider ensuring
> > > > > that freed pages do not have any I-cache lines associated with them,
> > > > > rather than waiting for them to be allocated and then dealing with the
> > > > > I-cache problem.
> > > > 
> > > > Having now benchmarked this (making flush_cache_* always invalidate
> > > > the I-cache, so free'd pages are I-cache clean), and to me, the results
> > > > quite look promising - please try out this patch.
[...]
> > > Before trying the patch, I don't entirely agree with the approach. You
> > > will get speculative fetches in the I-cache via the kernel linear
> > > mapping (where NX is always cleared) on newer processors and may end up
> > > with random faults in user space (not that likely but not impossible
> > > either).
> > 
> > That means we have no option but to flush the I-cache every time a page
> > is placed into userspace - we might as well make update_mmu_cache
> > unconditionally flush the I-cache every time its called.
[...]
> We can flush the D-cache in copy_user_page(), maybe lazily via
> flush_dcache_page() and invalidate the I-cache in update_mmu_cache() if
> PG_arch_1 (ignoring VM_EXEC).

Something like below (based on your original suggestion for flushing the
D-cache in copy_user_highpage).

BTW, the cache flushing code in Linux can be optimised a bit more on
VIPT caches:

      * __cpuc_flush_dcache_page() could cope with just D-cache clean
        rather than clean+invalidate
      * whole I-cache invalidation was needed for some ARM1136 erratum.
        We can conditionally revert it to invalidating a range
      * Cortex-A9 SMP kernels can go back to lazy cache flushing (I have
        a patch for this that works fine but I need to add some extra
        safety checks of the CPU ID registers to make sure that the
        feature is present)



Flush the D-cache during copy_user_highpage()

From: Catalin Marinas <catalin.marinas@arm.com>

The I and D caches for copy-on-write pages on processors with
write-allocate caches become incoherent causing problems on application
relying on CoW for text pages (dynamic linker relocating symbols in a
text page). This patch flushes the D-cache for such pages (possibly
lazily via update_mmu_cache which also takes care of the I-cache).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/copypage-v6.c |    1 +
 arch/arm/mm/fault-armv.c  |    3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index 4127a7b..e61fdc8 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -43,6 +43,7 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
 	copy_page(kto, kfrom);
 	kunmap_atomic(kto, KM_USER1);
 	kunmap_atomic(kfrom, KM_USER0);
+	flush_dcache_page(to);
 }
 
 /*
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index d0d17b6..4e37ab6 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -160,8 +160,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 	if (mapping) {
 		if (cache_is_vivt())
 			make_coherent(mapping, vma, addr, pfn);
-		else if (vma->vm_flags & VM_EXEC)
-			__flush_icache_all();
+		__flush_icache_all();
 	}
 }
 

-- 
Catalin
