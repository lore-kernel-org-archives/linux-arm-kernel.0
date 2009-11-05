From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 05 Nov 2009 13:31:00 +0000
Subject: [RFC PATCH] ARMv7: Use lazy cache flushing if hardware
	broadcasts cache operations
In-Reply-To: <20091105130048.GA21681@n2100.arm.linux.org.uk>
References: <20091105125059.2762.57284.stgit@pc1117.cambridge.arm.com>
	<20091105130048.GA21681@n2100.arm.linux.org.uk>
Message-ID: <1257427861.26730.37.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-11-05 at 13:00 +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 05, 2009 at 12:50:59PM +0000, Catalin Marinas wrote:
> > diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
> > index d3a4c2c..3d5d1c9 100644
> > --- a/arch/arm/include/asm/cachetype.h
> > +++ b/arch/arm/include/asm/cachetype.h
> > @@ -1,6 +1,8 @@
[...]
> > +#ifndef CONFIG_SMP
> > +#define cache_ops_hw_broadcast()	1
> > +#elif __LINUX_ARM_ARCH__ <= 6
> > +#define cache_ops_hw_broadcast()	0
> > +#else
> > +static inline int cache_ops_hw_broadcast(void)
> > +{
> > +	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) >= 1;
> > +}
> > +#endif
> 
> Please place this in asm/smp_plat.h, and let's have it in the same sense
> as the TLB ops version as well for consistency (so we don't have to
> individually remember how each of these functions work and their sense.)

I was looking at this for a slightly different perspective since we
don't do in-software cache broadcasting. But I'm ok with change the name
to be the same as the tlb one.

If we place this in smp_plat.h, we need to include this header in
fault-armv.c and flush.c and also add the non-SMP
cache_ops_need_broadcast() variant (or use #ifdefs at the calling site
though I don't think it would look nice).


ARMv7: Use lazy cache flushing if hardware broadcasts cache operations

From: Catalin Marinas <catalin.marinas@arm.com>

ARMv7 processors like Cortex-A9 broadcast the cache maintenance
operations in hardware. The patch adds the CPU ID checks for such
feature and allows the flush_dcache_page/update_mmu_cache pair to work
in lazy flushing mode similar to the UP case.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/smp_plat.h |    9 +++++++++
 arch/arm/mm/fault-armv.c        |    6 +++---
 arch/arm/mm/flush.c             |    9 ++++-----
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 59303e2..e587167 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -13,4 +13,13 @@ static inline int tlb_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
 }
 
+#ifndef CONFIG_SMP
+#define cache_ops_need_broadcast()	0
+#else
+static inline int cache_ops_need_broadcast(void)
+{
+	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
+}
+#endif
+
 #endif
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index d0d17b6..a7f5c69 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -22,6 +22,7 @@
 #include <asm/cachetype.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_plat.h>
 
 static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
 
@@ -153,10 +154,9 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 
 	page = pfn_to_page(pfn);
 	mapping = page_mapping(page);
-#ifndef CONFIG_SMP
-	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
+	if (!cache_ops_need_broadcast() &&
+	    test_and_clear_bit(PG_dcache_dirty, &page->flags))
 		__flush_dcache_page(mapping, page);
-#endif
 	if (mapping) {
 		if (cache_is_vivt())
 			make_coherent(mapping, vma, addr, pfn);
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7f294f3..2d3325d 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -15,6 +15,7 @@
 #include <asm/cachetype.h>
 #include <asm/system.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_plat.h>
 
 #include "mm.h"
 
@@ -198,12 +199,10 @@ void flush_dcache_page(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 
-#ifndef CONFIG_SMP
-	if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
+	if (!cache_ops_need_broadcast() &&
+	    !PageHighMem(page) && mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
-	else
-#endif
-	{
+	else {
 		__flush_dcache_page(mapping, page);
 		if (mapping && cache_is_vivt())
 			__flush_dcache_aliases(mapping, page);

-- 
Catalin
