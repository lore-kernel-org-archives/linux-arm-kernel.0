From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 05 Nov 2009 12:50:59 +0000
Subject: [RFC PATCH] ARMv7: Use lazy cache flushing if hardware broadcasts
	cache operations
Message-ID: <20091105125059.2762.57284.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 processors like Cortex-A9 broadcast the cache maintenance
operations in hardware. The patch adds the CPU ID checks for such
feature and allows the flush_dcache_page/update_mmu_cache pair to work
in lazy flushing mode similar to the UP case.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/cachetype.h |   16 ++++++++++++++++
 arch/arm/mm/fault-armv.c         |    5 ++---
 arch/arm/mm/flush.c              |    8 +++-----
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index d3a4c2c..3d5d1c9 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_ARM_CACHETYPE_H
 #define __ASM_ARM_CACHETYPE_H
 
+#include <asm/cputype.h>
+
 #define CACHEID_VIVT			(1 << 0)
 #define CACHEID_VIPT_NONALIASING	(1 << 1)
 #define CACHEID_VIPT_ALIASING		(1 << 2)
@@ -49,4 +51,18 @@ static inline unsigned int __attribute__((pure)) cacheid_is(unsigned int mask)
 	       (~__CACHEID_NEVER & __CACHEID_ARCH_MIN & mask & cacheid);
 }
 
+/*
+ * Cache maintenance operations hardware broadcasting.
+ */
+#ifndef CONFIG_SMP
+#define cache_ops_hw_broadcast()	1
+#elif __LINUX_ARM_ARCH__ <= 6
+#define cache_ops_hw_broadcast()	0
+#else
+static inline int cache_ops_hw_broadcast(void)
+{
+	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) >= 1;
+}
+#endif
+
 #endif
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index d0d17b6..214c3ed 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -153,10 +153,9 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 
 	page = pfn_to_page(pfn);
 	mapping = page_mapping(page);
-#ifndef CONFIG_SMP
-	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
+	if (cache_ops_hw_broadcast() &&
+	    test_and_clear_bit(PG_dcache_dirty, &page->flags))
 		__flush_dcache_page(mapping, page);
-#endif
 	if (mapping) {
 		if (cache_is_vivt())
 			make_coherent(mapping, vma, addr, pfn);
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7f294f3..4e63786 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -198,12 +198,10 @@ void flush_dcache_page(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 
-#ifndef CONFIG_SMP
-	if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
+	if (cache_ops_hw_broadcast() &&
+	    !PageHighMem(page) && mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
-	else
-#endif
-	{
+	else {
 		__flush_dcache_page(mapping, page);
 		if (mapping && cache_is_vivt())
 			__flush_dcache_aliases(mapping, page);
