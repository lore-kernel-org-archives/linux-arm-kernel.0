From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 26 Oct 2010 15:35:44 +0300
Subject: [PATCH] ARM: cache: implement flush_icache_all for rest of the CPUs
Message-ID: <mailman.3.1288097460.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 81d11955bf0 ("ARM: 6405/1: Handle __flush_icache_all for
CONFIG_SMP_ON_UP") added a new function to struct cpu_cache_fns:
flush_icache_all(). It also implemented this for v6 and v7 but not
for v5 and backwards. Without the function pointer in place, we
will be calling totally wrong cache functions.

So implement flush_icache_all() for the rest of the supported CPUs.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mm/cache-fa.S    |   12 ++++++++++++
 arch/arm/mm/cache-v3.S    |   10 ++++++++++
 arch/arm/mm/cache-v4.S    |   14 ++++++++++++++
 arch/arm/mm/cache-v4wb.S  |   12 ++++++++++++
 arch/arm/mm/cache-v4wt.S  |   12 ++++++++++++
 arch/arm/mm/proc-arm920.S |   12 ++++++++++++
 6 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 7148e53..19061e8 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -38,6 +38,17 @@
 #define CACHE_DLIMIT	(CACHE_DSIZE * 2)
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(fa_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(fa_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Clean and invalidate all cache entries in a particular address
@@ -233,6 +244,7 @@ ENDPROC(fa_dma_unmap_area)
 
 	.type	fa_cache_fns, #object
 ENTRY(fa_cache_fns)
+	.long	fa_flush_icache_all
 	.long	fa_flush_kern_cache_all
 	.long	fa_flush_user_cache_all
 	.long	fa_flush_user_cache_range
diff --git a/arch/arm/mm/cache-v3.S b/arch/arm/mm/cache-v3.S
index c2ff3c5..2e2bc40 100644
--- a/arch/arm/mm/cache-v3.S
+++ b/arch/arm/mm/cache-v3.S
@@ -13,6 +13,15 @@
 #include "proc-macros.S"
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(v3_flush_icache_all)
+	mov	pc, lr
+ENDPROC(v3_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -122,6 +131,7 @@ ENDPROC(v3_dma_map_area)
 
 	.type	v3_cache_fns, #object
 ENTRY(v3_cache_fns)
+	.long	v3_flush_icache_all
 	.long	v3_flush_kern_cache_all
 	.long	v3_flush_user_cache_all
 	.long	v3_flush_user_cache_range
diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index 4810f7e..529ac27 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -13,6 +13,19 @@
 #include "proc-macros.S"
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(v4_flush_icache_all)
+#ifdef CONFIG_CPU_CP15
+	mov	r0, #0
+	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
+#endif
+	mov	pc, lr
+ENDPROC(v4_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -134,6 +147,7 @@ ENDPROC(v4_dma_map_area)
 
 	.type	v4_cache_fns, #object
 ENTRY(v4_cache_fns)
+	.long	v4_flush_icache_all
 	.long	v4_flush_kern_cache_all
 	.long	v4_flush_user_cache_all
 	.long	v4_flush_user_cache_range
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index df8368a..9d956cd 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -51,6 +51,17 @@ flush_base:
 	.text
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(v4wb_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(v4wb_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Clean and invalidate all cache entries in a particular address
@@ -244,6 +255,7 @@ ENDPROC(v4wb_dma_unmap_area)
 
 	.type	v4wb_cache_fns, #object
 ENTRY(v4wb_cache_fns)
+	.long	v4wb_flush_icache_all
 	.long	v4wb_flush_kern_cache_all
 	.long	v4wb_flush_user_cache_all
 	.long	v4wb_flush_user_cache_range
diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index 45c7031..64aa8aa 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -41,6 +41,17 @@
 #define CACHE_DLIMIT	16384
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(v4wt_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(v4wt_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -188,6 +199,7 @@ ENDPROC(v4wt_dma_map_area)
 
 	.type	v4wt_cache_fns, #object
 ENTRY(v4wt_cache_fns)
+	.long	v4wt_flush_icache_all
 	.long	v4wt_flush_kern_cache_all
 	.long	v4wt_flush_user_cache_all
 	.long	v4wt_flush_user_cache_range
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index fecf570..1894f63 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -110,6 +110,17 @@ ENTRY(cpu_arm920_do_idle)
 #ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
 
 /*
+ *	flush_icache_all()
+ *
+ *	Unconditionally clean and invalidate the entire icache.
+ */
+ENTRY(arm920_flush_icache_all)
+	mov	r0, #0
+	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
+	mov	pc, lr
+ENDPROC(arm920_flush_icache_all)
+
+/*
  *	flush_user_cache_all()
  *
  *	Invalidate all cache entries in a particular address
@@ -305,6 +316,7 @@ ENTRY(arm920_dma_unmap_area)
 ENDPROC(arm920_dma_unmap_area)
 
 ENTRY(arm920_cache_fns)
+	.long	arm920_flush_icache_all
 	.long	arm920_flush_kern_cache_all
 	.long	arm920_flush_user_cache_all
 	.long	arm920_flush_user_cache_range
-- 
1.5.6.5


--GID0FwUMdk1T2AWN--
