From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 02 Mar 2010 18:32:23 +0000
Subject: [RFC PATCH] ARM: Allow lazy cache flushing on ARM11MPCore
Message-ID: <20100302183223.25018.29363.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM11MPCore doesn't broadcast the cache maintenance operations in
hardware, therefore the flush_dcache_page() currently performs the cache
flushing non-lazily. But since not all drivers call this function after
writing to a page cache page, the kernel needs a different approach like
using read-for-ownership on the CPU flushing the cache to force the
dirty cache lines migration from other CPUs. This way the cache flushing
operation can be done lazily in update_mmu_cache().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 arch/arm/include/asm/smp_plat.h |    9 ---------
 arch/arm/mm/cache-v6.S          |    4 ++++
 arch/arm/mm/flush.c             |    3 +--
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 963a338..59303e2 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -13,13 +13,4 @@ static inline int tlb_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
 }
 
-#if !defined(CONFIG_SMP) || __LINUX_ARM_ARCH__ >= 7
-#define cache_ops_need_broadcast()	0
-#else
-static inline int cache_ops_need_broadcast(void)
-{
-	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
-}
-#endif
-
 #endif
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 25ef05a..66b5366 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -170,6 +170,10 @@ ENDPROC(v6_coherent_kern_range)
 ENTRY(v6_flush_kern_dcache_area)
 	add	r1, r0, r1
 1:
+#ifdef CONFIG_SMP
+	/* no cache maintenance broadcasting on ARM11MPCore */
+	ldr	r2, [r0]			@ read for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
 #else
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index b829d30..e3347c1 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -207,8 +207,7 @@ void flush_dcache_page(struct page *page)
 
 	mapping = page_mapping(page);
 
-	if (!cache_ops_need_broadcast() &&
-	    !PageHighMem(page) && mapping && !mapping_mapped(mapping))
+	if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
 		clear_bit(PG_dcache_clean, &page->flags);
 	else {
 		__flush_dcache_page(mapping, page);
