From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 15:46:43 +0100
Subject: [PATCH v4 4/4] ARM: Use lazy cache flushing on ARMv7 SMP systems
In-Reply-To: <20100621144409.26309.87173.stgit@e102109-lin.cambridge.arm.com>
References: <20100621144409.26309.87173.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621144643.26309.74292.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 processors like Cortex-A9 broadcast the cache maintenance
operations in hardware. This patch allows the
flush_dcache_page/update_mmu_cache pair to work in lazy flushing mode
similar to the UP case.

Note that cache flushing on SMP systems now takes place via the
set_pte_at() call (__sync_icache_dcache) and there is no race with other
CPUs executing code from the new PTE before the cache flushing took
place.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/smp_plat.h |    4 ++++
 arch/arm/mm/flush.c             |   13 ++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)

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
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 18a8467..2d08a5e 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -17,6 +17,7 @@
 #include <asm/smp_plat.h>
 #include <asm/system.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_plat.h>
 
 #include "mm.h"
 
@@ -93,12 +94,10 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 #define flush_pfn_alias(pfn,vaddr)	do { } while (0)
 #endif
 
-#ifdef CONFIG_SMP
 static void flush_ptrace_access_other(void *args)
 {
 	__flush_icache_all();
 }
-#endif
 
 static
 void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
@@ -122,11 +121,9 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 	if (vma->vm_flags & VM_EXEC) {
 		unsigned long addr = (unsigned long)kaddr;
 		__cpuc_coherent_kern_range(addr, addr + len);
-#ifdef CONFIG_SMP
 		if (cache_ops_need_broadcast())
 			smp_call_function(flush_ptrace_access_other,
 					  NULL, 1);
-#endif
 	}
 }
 
@@ -261,12 +258,10 @@ void flush_dcache_page(struct page *page)
 
 	mapping = page_mapping(page);
 
-#ifndef CONFIG_SMP
-	if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
+	if (!cache_ops_need_broadcast() &&
+	    !PageHighMem(page) && mapping && !mapping_mapped(mapping))
 		clear_bit(PG_dcache_clean, &page->flags);
-	else
-#endif
-	{
+	else {
 		__flush_dcache_page(mapping, page);
 		if (mapping && cache_is_vivt())
 			__flush_dcache_aliases(mapping, page);
