From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Mar 2010 16:38:03 +0000
Subject: [PATCH 4/6] ARMv7: Use lazy cache flushing if
	hardwarebroadcastscache operations
In-Reply-To: <20100308163125.GA13856@n2100.arm.linux.org.uk>
References: <20091207141339.30429.28247.stgit@pc1117.cambridge.arm.com>
	<1268065501.25012.28.camel@e102109-lin.cambridge.arm.com>
	<20100308163125.GA13856@n2100.arm.linux.org.uk>
Message-ID: <1268066283.25012.35.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-08 at 16:31 +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 08, 2010 at 04:25:01PM +0000, Catalin Marinas wrote:
> > Hi Russell,
> >
> > On Mon, 2009-12-07 at 14:13 +0000, Catalin Marinas wrote:
> > > ARMv7 processors like Cortex-A9 broadcast the cache maintenance
> > > operations in hardware. The patch adds the CPU ID checks for such
> > > feature and allows the flush_dcache_page/update_mmu_cache pair to work
> > > in lazy flushing mode similar to the UP case.
> >
> > It looks like I haven't got a final ok from you on this patch (I had the
> > impression that it's in the patch system already but rebased my patches
> > and found that it's not in mainline).
> 
> It needs to be updated - we have a cache_ops_need_broadcast() in
> smp_plat.h now for the ptrace issues.

I noticed that when rebasing. Here's the updated patch:

ARMv7: Use lazy cache flushing if hardware broadcasts cache operations

From: Catalin Marinas <catalin.marinas@arm.com>

ARMv7 processors like Cortex-A9 broadcast the cache maintenance
operations in hardware. The patch adds the CPU ID checks for such
feature and allows the flush_dcache_page/update_mmu_cache pair to work
in lazy flushing mode similar to the UP case.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/smp_plat.h |    4 ++++
 arch/arm/mm/fault-armv.c        |    2 --
 arch/arm/mm/flush.c             |    9 ++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index e621530..963a338 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -13,9 +13,13 @@ static inline int tlb_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
 }
 
+#if !defined(CONFIG_SMP) || __LINUX_ARM_ARCH__ >= 7
+#define cache_ops_need_broadcast()	0
+#else
 static inline int cache_ops_need_broadcast(void)
 {
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
+#endif
 
 #endif
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index c9b97e9..0866ffd 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -169,10 +169,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 		return;
 
 	mapping = page_mapping(page);
-#ifndef CONFIG_SMP
 	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
 		__flush_dcache_page(mapping, page);
-#endif
 	if (mapping) {
 		if (cache_is_vivt())
 			make_coherent(mapping, vma, addr, ptep, pfn);
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index e34f095..c2cea53 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -16,6 +16,7 @@
 #include <asm/smp_plat.h>
 #include <asm/system.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_plat.h>
 
 #include "mm.h"
 
@@ -241,12 +242,10 @@ void flush_dcache_page(struct page *page)
 
 	mapping = page_mapping(page);
 
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
