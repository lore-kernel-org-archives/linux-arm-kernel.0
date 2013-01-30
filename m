From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jan 2013 14:27:45 +0000
Subject: [PATCH 2/6] ARM: cache: remove ARMv3 support code
In-Reply-To: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
Message-ID: <1359556069-28289-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only used by 740t, which is a v4 core and (by my reading of the
datasheet for the CPU) ignores CRm for the cp15 cache flush operation,
making the v4 cache implementation in cache-v4.S sufficient for this
CPU.

Tested with 740T core-tile on Integrator/AP baseboard.

Cc: Hyok S. Choi <hyok.choi@samsung.com>
Cc: Greg Ungerer <gerg@uclinux.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/glue-cache.h |   8 ---
 arch/arm/mm/Kconfig               |   5 +-
 arch/arm/mm/Makefile              |   1 -
 arch/arm/mm/cache-v3.S            | 137 --------------------------------------
 arch/arm/mm/proc-arm740.S         |   2 +-
 5 files changed, 2 insertions(+), 151 deletions(-)
 delete mode 100644 arch/arm/mm/cache-v3.S

diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index cca9f15..ea289e1 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -19,14 +19,6 @@
 #undef _CACHE
 #undef MULTI_CACHE
 
-#if defined(CONFIG_CPU_CACHE_V3)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE v3
-# endif
-#endif
-
 #if defined(CONFIG_CPU_CACHE_V4)
 # ifdef _CACHE
 #  define MULTI_CACHE 1
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3fd629d..c430f46 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -43,7 +43,7 @@ config CPU_ARM740T
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
-	select CPU_CACHE_V3	# although the core is v4t
+	select CPU_CACHE_V4
 	select CPU_CP15_MPU
 	select CPU_PABRT_LEGACY
 	help
@@ -469,9 +469,6 @@ config CPU_PABRT_V7
 	bool
 
 # The cache model
-config CPU_CACHE_V3
-	bool
-
 config CPU_CACHE_V4
 	bool
 
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 8a9c4cb..c0fd3c1 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_CPU_PABRT_LEGACY)	+= pabort-legacy.o
 obj-$(CONFIG_CPU_PABRT_V6)	+= pabort-v6.o
 obj-$(CONFIG_CPU_PABRT_V7)	+= pabort-v7.o
 
-obj-$(CONFIG_CPU_CACHE_V3)	+= cache-v3.o
 obj-$(CONFIG_CPU_CACHE_V4)	+= cache-v4.o
 obj-$(CONFIG_CPU_CACHE_V4WT)	+= cache-v4wt.o
 obj-$(CONFIG_CPU_CACHE_V4WB)	+= cache-v4wb.o
diff --git a/arch/arm/mm/cache-v3.S b/arch/arm/mm/cache-v3.S
deleted file mode 100644
index 8a3fade..0000000
--- a/arch/arm/mm/cache-v3.S
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- *  linux/arch/arm/mm/cache-v3.S
- *
- *  Copyright (C) 1997-2002 Russell king
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <asm/page.h>
-#include "proc-macros.S"
-
-/*
- *	flush_icache_all()
- *
- *	Unconditionally clean and invalidate the entire icache.
- */
-ENTRY(v3_flush_icache_all)
-	mov	pc, lr
-ENDPROC(v3_flush_icache_all)
-
-/*
- *	flush_user_cache_all()
- *
- *	Invalidate all cache entries in a particular address
- *	space.
- *
- *	- mm	- mm_struct describing address space
- */
-ENTRY(v3_flush_user_cache_all)
-	/* FALLTHROUGH */
-/*
- *	flush_kern_cache_all()
- *
- *	Clean and invalidate the entire cache.
- */
-ENTRY(v3_flush_kern_cache_all)
-	/* FALLTHROUGH */
-
-/*
- *	flush_user_cache_range(start, end, flags)
- *
- *	Invalidate a range of cache entries in the specified
- *	address space.
- *
- *	- start - start address (may not be aligned)
- *	- end	- end address (exclusive, may not be aligned)
- *	- flags	- vma_area_struct flags describing address space
- */
-ENTRY(v3_flush_user_cache_range)
-	mov	ip, #0
-	mcreq	p15, 0, ip, c7, c0, 0		@ flush ID cache
-	mov	pc, lr
-
-/*
- *	coherent_kern_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start  - virtual start address
- *	- end	 - virtual end address
- */
-ENTRY(v3_coherent_kern_range)
-	/* FALLTHROUGH */
-
-/*
- *	coherent_user_range(start, end)
- *
- *	Ensure coherency between the Icache and the Dcache in the
- *	region described by start.  If you have non-snooping
- *	Harvard caches, you need to implement this function.
- *
- *	- start  - virtual start address
- *	- end	 - virtual end address
- */
-ENTRY(v3_coherent_user_range)
-	mov	r0, #0
-	mov	pc, lr
-
-/*
- *	flush_kern_dcache_area(void *page, size_t size)
- *
- *	Ensure no D cache aliasing occurs, either with itself or
- *	the I cache
- *
- *	- addr	- kernel address
- *	- size	- region size
- */
-ENTRY(v3_flush_kern_dcache_area)
-	/* FALLTHROUGH */
-
-/*
- *	dma_flush_range(start, end)
- *
- *	Clean and invalidate the specified virtual address range.
- *
- *	- start  - virtual start address
- *	- end	 - virtual end address
- */
-ENTRY(v3_dma_flush_range)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c0, 0		@ flush ID cache
-	mov	pc, lr
-
-/*
- *	dma_unmap_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(v3_dma_unmap_area)
-	teq	r2, #DMA_TO_DEVICE
-	bne	v3_dma_flush_range
-	/* FALLTHROUGH */
-
-/*
- *	dma_map_area(start, size, dir)
- *	- start	- kernel virtual start address
- *	- size	- size of region
- *	- dir	- DMA direction
- */
-ENTRY(v3_dma_map_area)
-	mov	pc, lr
-ENDPROC(v3_dma_unmap_area)
-ENDPROC(v3_dma_map_area)
-
-	.globl	v3_flush_kern_cache_louis
-	.equ	v3_flush_kern_cache_louis, v3_flush_kern_cache_all
-
-	__INITDATA
-
-	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
-	define_cache_functions v3
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index dc5de5d..2088234 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -145,5 +145,5 @@ __arm740_proc_info:
 	.long	arm740_processor_functions
 	.long	0
 	.long	0
-	.long	v3_cache_fns			@ cache model
+	.long	v4_cache_fns			@ cache model
 	.size	__arm740_proc_info, . - __arm740_proc_info
-- 
1.8.0
