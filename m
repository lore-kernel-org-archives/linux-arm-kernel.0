From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 24 Oct 2009 22:36:36 +0100
Subject: [RFC 02/11] ARM: Fix errata 411920 workarounds
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <6af8ea18ac64a74700e374489751a63e643ac394.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Errata 411920 indicates that any "invalidate entire instruction cache"
operation can fail if the right conditions are present.  This is not
limited just to those operations in flush.c, but elsewhere.  Place the
workaround in the already existing __flush_icache_all() function
instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/cacheflush.h |    5 +++++
 arch/arm/mm/context.c             |    4 ++--
 arch/arm/mm/flush.c               |   31 ++++++-------------------------
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 3147f75..af0624c 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -412,9 +412,14 @@ extern void flush_dcache_page(struct page *);
 
 static inline void __flush_icache_all(void)
 {
+#ifdef CONFIG_ARM_ERRATA_411920
+	extern void v6_icache_inval_all(void);
+	v6_icache_inval_all();
+#else
 	asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"
 	    :
 	    : "r" (0));
+#endif
 }
 
 #define ARCH_HAS_FLUSH_ANON_PAGE
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 6bda76a..d4f8275 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -50,8 +50,8 @@ void __new_context(struct mm_struct *mm)
 		isb();
 		flush_tlb_all();
 		if (icache_is_vivt_asid_tagged()) {
-			asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"
-			    "mcr	p15, 0, %0, c7, c5, 6	@ flush BTAC/BTB\n"
+			__flush_icache_all();
+			asm("mcr	p15, 0, %0, c7, c5, 6	@ flush BTAC/BTB"
 			    :
 			    : "r" (0));
 			dsb();
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index b279429..7f294f3 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -18,10 +18,6 @@
 
 #include "mm.h"
 
-#ifdef CONFIG_ARM_ERRATA_411920
-extern void v6_icache_inval_all(void);
-#endif
-
 #ifdef CONFIG_CPU_CACHE_VIPT
 
 #define ALIAS_FLUSH_START	0xffff4000
@@ -35,16 +31,11 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 	flush_tlb_kernel_page(to);
 
 	asm(	"mcrr	p15, 0, %1, %0, c14\n"
-	"	mcr	p15, 0, %2, c7, c10, 4\n"
-#ifndef CONFIG_ARM_ERRATA_411920
-	"	mcr	p15, 0, %2, c7, c5, 0\n"
-#endif
+	"	mcr	p15, 0, %2, c7, c10, 4"
 	    :
 	    : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
 	    : "cc");
-#ifdef CONFIG_ARM_ERRATA_411920
-	v6_icache_inval_all();
-#endif
+	__flush_icache_all();
 }
 
 void flush_cache_mm(struct mm_struct *mm)
@@ -57,16 +48,11 @@ void flush_cache_mm(struct mm_struct *mm)
 
 	if (cache_is_vipt_aliasing()) {
 		asm(	"mcr	p15, 0, %0, c7, c14, 0\n"
-		"	mcr	p15, 0, %0, c7, c10, 4\n"
-#ifndef CONFIG_ARM_ERRATA_411920
-		"	mcr	p15, 0, %0, c7, c5, 0\n"
-#endif
+		"	mcr	p15, 0, %0, c7, c10, 4"
 		    :
 		    : "r" (0)
 		    : "cc");
-#ifdef CONFIG_ARM_ERRATA_411920
-		v6_icache_inval_all();
-#endif
+		__flush_icache_all();
 	}
 }
 
@@ -81,16 +67,11 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 
 	if (cache_is_vipt_aliasing()) {
 		asm(	"mcr	p15, 0, %0, c7, c14, 0\n"
-		"	mcr	p15, 0, %0, c7, c10, 4\n"
-#ifndef CONFIG_ARM_ERRATA_411920
-		"	mcr	p15, 0, %0, c7, c5, 0\n"
-#endif
+		"	mcr	p15, 0, %0, c7, c10, 4"
 		    :
 		    : "r" (0)
 		    : "cc");
-#ifdef CONFIG_ARM_ERRATA_411920
-		v6_icache_inval_all();
-#endif
+		__flush_icache_all();
 	}
 }
 
-- 
1.6.2.5
