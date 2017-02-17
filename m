From: andrew_gabbasov@mentor.com (Andrew Gabbasov)
Date: Fri, 17 Feb 2017 06:09:37 -0700
Subject: [PATCH 1/3] ARM: mm: Add a separate API function for DCCMVAU cache
 operation
In-Reply-To: <1487336979-14245-1-git-send-email-andrew_gabbasov@mentor.com>
References: <1487336979-14245-1-git-send-email-andrew_gabbasov@mentor.com>
Message-ID: <1487336979-14245-2-git-send-email-andrew_gabbasov@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7+ uses DCCMVAU operation (Clean data cache line to point of
unification) when synchronizing data to instruction cache in a single
function together with instruction cache line invalidation. However,
in case of instruction cache aliasing, this operation is needed
as a separate function to be used with the whole instuction cache
invalidation. Similar separate function is implemented for arm64
architecture.

Since the operation implementation is different for at least armv7
and armv7m, this function is included in cache operations API for
all cache types. For caches earlier than armv7 it is actually never
called (no cache aliasing), but is implemented as an equivalent
of data cache line clean and invalidate operation.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 arch/arm/include/asm/cacheflush.h |  3 +++
 arch/arm/include/asm/glue-cache.h |  3 +++
 arch/arm/mm/cache-fa.S            |  3 +++
 arch/arm/mm/cache-nop.S           |  3 +++
 arch/arm/mm/cache-v4.S            |  3 +++
 arch/arm/mm/cache-v4wb.S          |  3 +++
 arch/arm/mm/cache-v4wt.S          |  3 +++
 arch/arm/mm/cache-v6.S            |  3 +++
 arch/arm/mm/cache-v7.S            | 27 +++++++++++++++++++++++++++
 arch/arm/mm/cache-v7m.S           | 23 +++++++++++++++++++++++
 arch/arm/mm/proc-arm1020.S        |  3 +++
 arch/arm/mm/proc-arm1020e.S       |  3 +++
 arch/arm/mm/proc-arm1022.S        |  3 +++
 arch/arm/mm/proc-arm1026.S        |  3 +++
 arch/arm/mm/proc-arm920.S         |  3 +++
 arch/arm/mm/proc-arm922.S         |  3 +++
 arch/arm/mm/proc-arm925.S         |  3 +++
 arch/arm/mm/proc-arm926.S         |  3 +++
 arch/arm/mm/proc-arm940.S         |  3 +++
 arch/arm/mm/proc-arm946.S         |  3 +++
 arch/arm/mm/proc-feroceon.S       |  6 ++++++
 arch/arm/mm/proc-macros.S         |  1 +
 arch/arm/mm/proc-mohawk.S         |  3 +++
 arch/arm/mm/proc-xsc3.S           |  3 +++
 arch/arm/mm/proc-xscale.S         |  4 ++++
 25 files changed, 121 insertions(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index bdd283b..20f7017 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -111,6 +111,7 @@ struct cpu_cache_fns {
 	void (*coherent_kern_range)(unsigned long, unsigned long);
 	int  (*coherent_user_range)(unsigned long, unsigned long);
 	void (*flush_kern_dcache_area)(void *, size_t);
+	void (*flush_kern_dcache_area_pou)(void *, size_t);
 
 	void (*dma_map_area)(const void *, size_t, int);
 	void (*dma_unmap_area)(const void *, size_t, int);
@@ -133,6 +134,7 @@ extern struct cpu_cache_fns cpu_cache;
 #define __cpuc_coherent_kern_range	cpu_cache.coherent_kern_range
 #define __cpuc_coherent_user_range	cpu_cache.coherent_user_range
 #define __cpuc_flush_dcache_area	cpu_cache.flush_kern_dcache_area
+#define __cpuc_flush_dcache_area_pou	cpu_cache.flush_kern_dcache_area_pou
 
 /*
  * These are private to the dma-mapping API.  Do not use directly.
@@ -152,6 +154,7 @@ extern void __cpuc_flush_user_range(unsigned long, unsigned long, unsigned int);
 extern void __cpuc_coherent_kern_range(unsigned long, unsigned long);
 extern int  __cpuc_coherent_user_range(unsigned long, unsigned long);
 extern void __cpuc_flush_dcache_area(void *, size_t);
+extern void __cpuc_flush_dcache_area_pou(void *, size_t);
 
 /*
  * These are private to the dma-mapping API.  Do not use directly.
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index 01c3d92..6f58de3 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -137,6 +137,7 @@ static inline void nop_coherent_kern_range(unsigned long a, unsigned long b) { }
 static inline int nop_coherent_user_range(unsigned long a,
 		unsigned long b) { return 0; }
 static inline void nop_flush_kern_dcache_area(void *a, size_t s) { }
+static inline void nop_flush_kern_dcache_area_pou(void *a, size_t s) { }
 
 static inline void nop_dma_flush_range(const void *a, const void *b) { }
 
@@ -153,6 +154,8 @@ static inline void nop_dma_unmap_area(const void *s, size_t l, int f) { }
 #define __cpuc_coherent_kern_range	__glue(_CACHE,_coherent_kern_range)
 #define __cpuc_coherent_user_range	__glue(_CACHE,_coherent_user_range)
 #define __cpuc_flush_dcache_area	__glue(_CACHE,_flush_kern_dcache_area)
+#define __cpuc_flush_dcache_area_pou	\
+				__glue(_CACHE,_flush_kern_dcache_area_pou)
 
 #define dmac_flush_range		__glue(_CACHE,_dma_flush_range)
 #endif
diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 2f0c588..d923250 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -244,6 +244,9 @@ ENDPROC(fa_dma_unmap_area)
 	.globl	fa_flush_kern_cache_louis
 	.equ	fa_flush_kern_cache_louis, fa_flush_kern_cache_all
 
+	.globl	fa_flush_kern_dcache_area_pou
+	.equ	fa_flush_kern_dcache_area_pou, fa_flush_kern_dcache_area
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-nop.S b/arch/arm/mm/cache-nop.S
index f1cc986..583f69a 100644
--- a/arch/arm/mm/cache-nop.S
+++ b/arch/arm/mm/cache-nop.S
@@ -36,6 +36,9 @@ ENDPROC(nop_coherent_user_range)
 	.globl nop_flush_kern_dcache_area
 	.equ nop_flush_kern_dcache_area, nop_flush_icache_all
 
+	.globl nop_flush_kern_dcache_area_pou
+	.equ nop_flush_kern_dcache_area_pou, nop_flush_icache_all
+
 	.globl nop_dma_flush_range
 	.equ nop_dma_flush_range, nop_flush_icache_all
 
diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index 91e3adf..fdccbbd 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -144,6 +144,9 @@ ENDPROC(v4_dma_map_area)
 	.globl	v4_flush_kern_cache_louis
 	.equ	v4_flush_kern_cache_louis, v4_flush_kern_cache_all
 
+	.globl	v4_flush_kern_dcache_area_pou
+	.equ	v4_flush_kern_dcache_area_pou, v4_flush_kern_dcache_area
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index 2522f8c..c49ed69 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -255,6 +255,9 @@ ENDPROC(v4wb_dma_unmap_area)
 	.globl	v4wb_flush_kern_cache_louis
 	.equ	v4wb_flush_kern_cache_louis, v4wb_flush_kern_cache_all
 
+	.globl	v4wb_flush_kern_dcache_area_pou
+	.equ	v4wb_flush_kern_dcache_area_pou, v4wb_flush_kern_dcache_area
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index a0982ce..358e29b 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -200,6 +200,9 @@ ENDPROC(v4wt_dma_map_area)
 	.globl	v4wt_flush_kern_cache_louis
 	.equ	v4wt_flush_kern_cache_louis, v4wt_flush_kern_cache_all
 
+	.globl	v4wt_flush_kern_dcache_area_pou
+	.equ	v4wt_flush_kern_dcache_area_pou, v4wt_flush_kern_dcache_area
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 2465995..b601723 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -329,6 +329,9 @@ ENDPROC(v6_dma_unmap_area)
 	.globl	v6_flush_kern_cache_louis
 	.equ	v6_flush_kern_cache_louis, v6_flush_kern_cache_all
 
+	.globl	v6_flush_kern_dcache_area_pou
+	.equ	v6_flush_kern_dcache_area_pou, v6_flush_kern_dcache_area
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a134d8a..fed2577 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -340,6 +340,33 @@ ENTRY(v7_flush_kern_dcache_area)
 ENDPROC(v7_flush_kern_dcache_area)
 
 /*
+ *	v7_flush_kern_dcache_area_pou(void *addr, size_t size)
+ *
+ *	Ensure that the D cache data of the specified region
+ *	is cleaned to the point of unification.
+ *
+ *	- addr	- kernel address
+ *	- size	- region size
+ */
+ENTRY(v7_flush_kern_dcache_area_pou)
+	dcache_line_size r2, r3
+	add	r1, r0, r1
+	sub	r3, r2, #1
+	bic	r0, r0, r3
+#ifdef CONFIG_ARM_ERRATA_764369
+	ALT_SMP(W(dsb))
+	ALT_UP(W(nop))
+#endif
+1:
+	mcr	p15, 0, r0, c7, c11, 1		@ clean D line to the point of unification
+	add	r0, r0, r2
+	cmp	r0, r1
+	blo	1b
+	dsb	ishst
+	ret	lr
+ENDPROC(v7_flush_kern_dcache_area_pou)
+
+/*
  *	v7_dma_inv_range(start,end)
  *
  *	Invalidate the data cache within the specified region; we will
diff --git a/arch/arm/mm/cache-v7m.S b/arch/arm/mm/cache-v7m.S
index 816a7e4..b2d919c 100644
--- a/arch/arm/mm/cache-v7m.S
+++ b/arch/arm/mm/cache-v7m.S
@@ -354,6 +354,29 @@ ENTRY(v7m_flush_kern_dcache_area)
 ENDPROC(v7m_flush_kern_dcache_area)
 
 /*
+ *      v7m_flush_kern_dcache_area_pou(void *addr, size_t size)
+ *
+ *      Ensure that the D cache data of the specified region
+ *      is cleaned to the point of unification.
+ *
+ *      - addr  - kernel address
+ *      - size  - region size
+ */
+ENTRY(v7m_flush_kern_dcache_area_pou)
+	dcache_line_size r2, r3
+	add	r1, r0, r1
+	sub	r3, r2, #1
+	bic	r0, r0, r3
+1:
+	dccmvau r0, r3		@ clean D line to the point of unification
+	add	r0, r0, r2
+	cmp	r0, r1
+	blo	1b
+	dsb	ishst
+	ret	lr
+ENDPROC(v7m_flush_kern_dcache_area_pou)
+
+/*
  *	v7m_dma_inv_range(start,end)
  *
  *	Invalidate the data cache within the specified region; we will
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 774ef13..3691849 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -369,6 +369,9 @@ ENDPROC(arm1020_dma_unmap_area)
 	.globl	arm1020_flush_kern_cache_louis
 	.equ	arm1020_flush_kern_cache_louis, arm1020_flush_kern_cache_all
 
+	.globl	arm1020_flush_kern_dcache_area_pou
+	.equ	arm1020_flush_kern_dcache_area_pou, arm1020_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm1020
 
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index ae3c27b..3c7292e 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -355,6 +355,9 @@ ENDPROC(arm1020e_dma_unmap_area)
 	.globl	arm1020e_flush_kern_cache_louis
 	.equ	arm1020e_flush_kern_cache_louis, arm1020e_flush_kern_cache_all
 
+	.globl	arm1020e_flush_kern_dcache_area_pou
+	.equ	arm1020e_flush_kern_dcache_area_pou, arm1020e_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm1020e
 
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index dbb2413..70427c9 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -346,6 +346,9 @@ ENDPROC(arm1022_dma_unmap_area)
 	.globl	arm1022_flush_kern_cache_louis
 	.equ	arm1022_flush_kern_cache_louis, arm1022_flush_kern_cache_all
 
+	.globl	arm1022_flush_kern_dcache_area_pou
+	.equ	arm1022_flush_kern_dcache_area_pou, arm1022_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm1022
 
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 0b37b2c..258f583 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -340,6 +340,9 @@ ENDPROC(arm1026_dma_unmap_area)
 	.globl	arm1026_flush_kern_cache_louis
 	.equ	arm1026_flush_kern_cache_louis, arm1026_flush_kern_cache_all
 
+	.globl	arm1026_flush_kern_dcache_area_pou
+	.equ	arm1026_flush_kern_dcache_area_pou, arm1026_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm1026
 
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 7a14bd4..2345898 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -322,6 +322,9 @@ ENDPROC(arm920_dma_unmap_area)
 	.globl	arm920_flush_kern_cache_louis
 	.equ	arm920_flush_kern_cache_louis, arm920_flush_kern_cache_all
 
+	.globl	arm920_flush_kern_dcache_area_pou
+	.equ	arm920_flush_kern_dcache_area_pou, arm920_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm920
 #endif
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index edccfcd..63f4ac7 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -324,6 +324,9 @@ ENDPROC(arm922_dma_unmap_area)
 	.globl	arm922_flush_kern_cache_louis
 	.equ	arm922_flush_kern_cache_louis, arm922_flush_kern_cache_all
 
+	.globl	arm922_flush_kern_dcache_area_pou
+	.equ	arm922_flush_kern_dcache_area_pou, arm922_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm922
 #endif
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 32a47cc..07431b0 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -379,6 +379,9 @@ ENDPROC(arm925_dma_unmap_area)
 	.globl	arm925_flush_kern_cache_louis
 	.equ	arm925_flush_kern_cache_louis, arm925_flush_kern_cache_all
 
+	.globl	arm925_flush_kern_dcache_area_pou
+	.equ 	arm925_flush_kern_dcache_area_pou, arm925_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm925
 
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index fb827c6..37f5f43 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -342,6 +342,9 @@ ENDPROC(arm926_dma_unmap_area)
 	.globl	arm926_flush_kern_cache_louis
 	.equ	arm926_flush_kern_cache_louis, arm926_flush_kern_cache_all
 
+	.globl	arm926_flush_kern_dcache_area_pou
+	.equ	arm926_flush_kern_dcache_area_pou, arm926_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm926
 
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index ee5b66f..e46d75f 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -270,6 +270,9 @@ ENDPROC(arm940_dma_unmap_area)
 	.globl	arm940_flush_kern_cache_louis
 	.equ	arm940_flush_kern_cache_louis, arm940_flush_kern_cache_all
 
+	.globl	arm940_flush_kern_dcache_area_pou
+	.equ	arm940_flush_kern_dcache_area_pou, arm940_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm940
 
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 7361837e..e6fb545 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -313,6 +313,9 @@ ENDPROC(arm946_dma_unmap_area)
 	.globl	arm946_flush_kern_cache_louis
 	.equ	arm946_flush_kern_cache_louis, arm946_flush_kern_cache_all
 
+	.globl	arm946_flush_kern_dcache_area_pou
+	.equ	arm946_flush_kern_dcache_area_pou, arm946_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions arm946
 
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 92e08bf..78194cf 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -418,6 +418,9 @@ ENDPROC(feroceon_dma_unmap_area)
 	.globl	feroceon_flush_kern_cache_louis
 	.equ	feroceon_flush_kern_cache_louis, feroceon_flush_kern_cache_all
 
+	.globl	feroceon_flush_kern_dcache_area_pou
+	.equ	feroceon_flush_kern_dcache_area_pou, feroceon_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions feroceon
 
@@ -440,6 +443,9 @@ ENDPROC(feroceon_dma_unmap_area)
 	range_alias coherent_user_range
 	range_alias dma_unmap_area
 
+	.globl	feroceon_range_flush_kern_dcache_area_pou
+	.equ	feroceon_range_flush_kern_dcache_area_pou, feroceon_range_flush_kern_dcache_area
+
 	define_cache_functions feroceon_range
 
 	.align	5
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 0d40c28..d317ada 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -323,6 +323,7 @@ ENTRY(\name\()_cache_fns)
 	.long	\name\()_coherent_kern_range
 	.long	\name\()_coherent_user_range
 	.long	\name\()_flush_kern_dcache_area
+	.long	\name\()_flush_kern_dcache_area_pou
 	.long	\name\()_dma_map_area
 	.long	\name\()_dma_unmap_area
 	.long	\name\()_dma_flush_range
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 6f07d2e..431c882 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -306,6 +306,9 @@ ENDPROC(mohawk_dma_unmap_area)
 	.globl	mohawk_flush_kern_cache_louis
 	.equ	mohawk_flush_kern_cache_louis, mohawk_flush_kern_cache_all
 
+	.globl	mohawk_flush_kern_dcache_area_pou
+	.equ	mohawk_flush_kern_dcache_area_pou, mohawk_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions mohawk
 
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 293dcc2..f3c23ed 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -340,6 +340,9 @@ ENDPROC(xsc3_dma_unmap_area)
 	.globl	xsc3_flush_kern_cache_louis
 	.equ	xsc3_flush_kern_cache_louis, xsc3_flush_kern_cache_all
 
+	.globl	xsc3_flush_kern_dcache_area_pou
+	.equ	xsc3_flush_kern_dcache_area_pou, xsc3_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions xsc3
 
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index b6bbfdb..65a89cf 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -413,6 +413,9 @@ ENDPROC(xscale_dma_unmap_area)
 	.globl	xscale_flush_kern_cache_louis
 	.equ	xscale_flush_kern_cache_louis, xscale_flush_kern_cache_all
 
+	.globl	xscale_flush_kern_dcache_area_pou
+	.equ	xscale_flush_kern_dcache_area_pou, xscale_flush_kern_dcache_area
+
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions xscale
 
@@ -447,6 +450,7 @@ ENDPROC(xscale_dma_unmap_area)
 	a0_alias coherent_kern_range
 	a0_alias coherent_user_range
 	a0_alias flush_kern_dcache_area
+	a0_alias flush_kern_dcache_area_pou
 	a0_alias dma_flush_range
 	a0_alias dma_unmap_area
 
-- 
2.1.0
