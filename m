From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 05 Nov 2009 15:47:03 +0000
Subject: [RFC PATCH] ARMv7: Use lazy cache flushing if hardware
	broadcasts cache operations
In-Reply-To: <20091105150529.GD21681@n2100.arm.linux.org.uk>
References: <20091105125059.2762.57284.stgit@pc1117.cambridge.arm.com>
	<20091105130048.GA21681@n2100.arm.linux.org.uk>
	<1257427861.26730.37.camel@pc1117.cambridge.arm.com>
	<20091105150529.GD21681@n2100.arm.linux.org.uk>
Message-ID: <1257436023.11671.3.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-11-05 at 15:05 +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 05, 2009 at 01:31:00PM +0000, Catalin Marinas wrote:
> > -#ifndef CONFIG_SMP
> > -	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
> > +	if (!cache_ops_need_broadcast() &&
> > +	    test_and_clear_bit(PG_dcache_dirty, &page->flags))
> 
> We really don't need the additional check here - there's only one
> place where PG_dcache_dirty gets set, and that's flush_dcache_page().
> If we avoid setting the bit for hardware which doesn't broadcast,
> we won't call __flush_dcache_page().

OK. This was meant as slight optimisation for the ARMv6 MP case but I
removed that from the cache_ops_need_broadcast() definition (you never
know, someone may build an ARMv6 MP with cache broadcasting in hw).

Here's the updated patch:


ARMv7: Use lazy cache flushing if hardware broadcasts cache operations

From: Catalin Marinas <catalin.marinas@arm.com>

ARMv7 processors like Cortex-A9 broadcast the cache maintenance
operations in hardware. The patch adds the CPU ID checks for such
feature and allows the flush_dcache_page/update_mmu_cache pair to work
in lazy flushing mode similar to the UP case.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/smp_plat.h |    9 +++++++++
 arch/arm/mm/fault-armv.c        |    2 --
 arch/arm/mm/flush.c             |    9 ++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

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
index d0d17b6..bb60117 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -153,10 +153,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 
 	page = pfn_to_page(pfn);
 	mapping = page_mapping(page);
-#ifndef CONFIG_SMP
 	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
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
