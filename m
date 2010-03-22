From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Mar 2010 15:19:39 +0000
Subject: [PATCH 1/5] ARM: Use lazy cache flushing on ARMv7 SMP systems
In-Reply-To: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100322151939.6353.7646.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 processors like Cortex-A9 broadcast the cache maintenance
operations in hardware. This patch allows the
flush_dcache_page/update_mmu_cache pair to work in lazy flushing mode
similar to the UP case.

The standard ICIALLU and BPIALL operations are not automatically
broadcast to the other CPUs in an MP system. The patch adds the Inner
Shareable variants, ICIALLUIS and BPIALLIS, if ARMv7 and SMP.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/cacheflush.h |    4 ++++
 arch/arm/include/asm/smp_plat.h   |    4 ++++
 arch/arm/include/asm/tlbflush.h   |   29 ++++++++++++++++++++++++++++-
 arch/arm/mm/cache-v7.S            |    4 ++++
 arch/arm/mm/fault-armv.c          |    2 --
 arch/arm/mm/flush.c               |    9 ++++-----
 arch/arm/mm/tlb-v7.S              |    8 ++++++++
 7 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 0d08d41..4656a24 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -371,6 +371,10 @@ static inline void __flush_icache_all(void)
 #ifdef CONFIG_ARM_ERRATA_411920
 	extern void v6_icache_inval_all(void);
 	v6_icache_inval_all();
+#elif defined(CONFIG_SMP) && __LINUX_ARM_ARCH__ >= 7
+	asm("mcr	p15, 0, %0, c7, c1, 0	@ invalidate I-cache inner shareable\n"
+	    :
+	    : "r" (0));
 #else
 	asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"
 	    :
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
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index e085e2c..bd863d8 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -46,6 +46,9 @@
 #define TLB_V7_UIS_FULL (1 << 20)
 #define TLB_V7_UIS_ASID (1 << 21)
 
+/* Inner Shareable BTB operation (ARMv7 MP extensions) */
+#define TLB_V7_IS_BTB	(1 << 22)
+
 #define TLB_L2CLEAN_FR	(1 << 29)		/* Feroceon */
 #define TLB_DCLEAN	(1 << 30)
 #define TLB_WB		(1 << 31)
@@ -183,7 +186,7 @@
 #endif
 
 #ifdef CONFIG_SMP
-#define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BTB | \
+#define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
 			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
 #else
 #define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BTB | \
@@ -339,6 +342,12 @@ static inline void local_flush_tlb_all(void)
 		dsb();
 		isb();
 	}
+	if (tlb_flag(TLB_V7_IS_BTB)) {
+		/* flush the branch target cache */
+		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+		dsb();
+		isb();
+	}
 }
 
 static inline void local_flush_tlb_mm(struct mm_struct *mm)
@@ -376,6 +385,12 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
 		dsb();
 	}
+	if (tlb_flag(TLB_V7_IS_BTB)) {
+		/* flush the branch target cache */
+		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+		dsb();
+		isb();
+	}
 }
 
 static inline void
@@ -416,6 +431,12 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
 		dsb();
 	}
+	if (tlb_flag(TLB_V7_IS_BTB)) {
+		/* flush the branch target cache */
+		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+		dsb();
+		isb();
+	}
 }
 
 static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
@@ -454,6 +475,12 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 		dsb();
 		isb();
 	}
+	if (tlb_flag(TLB_V7_IS_BTB)) {
+		/* flush the branch target cache */
+		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+		dsb();
+		isb();
+	}
 }
 
 /*
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index bcd64f2..06a90dc 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -167,7 +167,11 @@ ENTRY(v7_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mov	r0, #0
+#ifdef CONFIG_SMP
+	mcr	p15, 0, r0, c7, c1, 6		@ invalidate BTB Inner Shareable
+#else
 	mcr	p15, 0, r0, c7, c5, 6		@ invalidate BTB
+#endif
 	dsb
 	isb
 	mov	pc, lr
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
diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index 0cb1848..f3f288a 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -50,7 +50,11 @@ ENTRY(v7wbi_flush_user_tlb_range)
 	cmp	r0, r1
 	blo	1b
 	mov	ip, #0
+#ifdef CONFIG_SMP
+	mcr	p15, 0, ip, c7, c1, 6		@ flush BTAC/BTB Inner Shareable
+#else
 	mcr	p15, 0, ip, c7, c5, 6		@ flush BTAC/BTB
+#endif
 	dsb
 	mov	pc, lr
 ENDPROC(v7wbi_flush_user_tlb_range)
@@ -79,7 +83,11 @@ ENTRY(v7wbi_flush_kern_tlb_range)
 	cmp	r0, r1
 	blo	1b
 	mov	r2, #0
+#ifdef CONFIG_SMP
+	mcr	p15, 0, r2, c7, c1, 6		@ flush BTAC/BTB Inner Shareable
+#else
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
+#endif
 	dsb
 	isb
 	mov	pc, lr
