From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Nov 2010 16:01:47 +0100
Subject: [PATCH] ARM: add clean and flush_dcache_all to ARM cache API
Message-ID: <1288969307-30948-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>

This patch adds functions to flush and clean the entire data cache.
Since the existing flush/clean range functions take more time to
flush/clean the entire data cache, they cannot be used in
performance-critical situations:

Whenever the range of data to be flushed/cleaned from the data cache
is more than some threshold value, it is better to do the entire data
flush/clean, this will reduce the time taken and effectively
increases the performance of the system.

The actual cache clean/flush is only implemented for v7 in this
patch, the other cpu versions are just dummy functions.

Signed-off-by: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Since we cannot easily test CPU < v7 this is a bit of RFC. Maybe
ARM people would like to take this over?

We really need this stuff, the usecase is buffer handling in
contigous memory for graphic buffers, which is being discussed
over at the V4L2 mailing list.
---
 arch/arm/include/asm/cacheflush.h |   17 ++++++
 arch/arm/mm/cache-fa.S            |   20 ++++++++
 arch/arm/mm/cache-v3.S            |   20 ++++++++
 arch/arm/mm/cache-v4.S            |   20 ++++++++
 arch/arm/mm/cache-v4wb.S          |   20 ++++++++
 arch/arm/mm/cache-v4wt.S          |   20 ++++++++
 arch/arm/mm/cache-v6.S            |   20 ++++++++
 arch/arm/mm/cache-v7.S            |   98 ++++++++++++++++++++++++++++++++++---
 arch/arm/mm/proc-v7.S             |    2 +-
 9 files changed, 228 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 3acd8fa..c004005 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -201,6 +201,14 @@
  *		- kaddr  - page address
  *		- size   - region size
  *
+ *	clean_dcache_all()
+ *
+ *		Cleans the entire d-cache.
+ *
+ *	flush_dcache_all()
+ *
+ *		Flushes the entire d-cache.
+ *
  *	DMA Cache Coherency
  *	===================
  *
@@ -221,6 +229,9 @@ struct cpu_cache_fns {
 	void (*coherent_user_range)(unsigned long, unsigned long);
 	void (*flush_kern_dcache_area)(void *, size_t);
 
+	void (*clean_dcache_all)(void);
+	void (*flush_dcache_all)(void);
+
 	void (*dma_map_area)(const void *, size_t, int);
 	void (*dma_unmap_area)(const void *, size_t, int);
 
@@ -241,6 +252,8 @@ extern struct cpu_cache_fns cpu_cache;
 #define __cpuc_coherent_kern_range	cpu_cache.coherent_kern_range
 #define __cpuc_coherent_user_range	cpu_cache.coherent_user_range
 #define __cpuc_flush_dcache_area	cpu_cache.flush_kern_dcache_area
+#define __cpuc_clean_dcache_all		cpu_cache.clean_dcache_all
+#define __cpuc_flush_dcache_all		cpu_cache.flush_dcache_all
 
 /*
  * These are private to the dma-mapping API.  Do not use directly.
@@ -261,6 +274,8 @@ extern struct cpu_cache_fns cpu_cache;
 #define __cpuc_coherent_kern_range	__glue(_CACHE,_coherent_kern_range)
 #define __cpuc_coherent_user_range	__glue(_CACHE,_coherent_user_range)
 #define __cpuc_flush_dcache_area	__glue(_CACHE,_flush_kern_dcache_area)
+#define __cpuc_clean_dcache_all		__glue(_CACHE,_clean_dcache_all)
+#define __cpuc_flush_dcache_all		__glue(_CACHE,_flush_dcache_all)
 
 extern void __cpuc_flush_icache_all(void);
 extern void __cpuc_flush_kern_all(void);
@@ -269,6 +284,8 @@ extern void __cpuc_flush_user_range(unsigned long, unsigned long, unsigned int);
 extern void __cpuc_coherent_kern_range(unsigned long, unsigned long);
 extern void __cpuc_coherent_user_range(unsigned long, unsigned long);
 extern void __cpuc_flush_dcache_area(void *, size_t);
+extern void __cpuc_clean_dcache_all(void);
+extern void __cpuc_flush_dcache_all(void);
 
 /*
  * These are private to the dma-mapping API.  Do not use directly.
diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 1fa6f71..e82b373 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -240,6 +240,24 @@ ENTRY(fa_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(fa_dma_unmap_area)
 
+/*
+ *	clean_dcache_all()
+ *
+ *	Clean the whole D-cache.
+ */
+ENTRY(fa_clean_dcache_all)
+	mov	pc, lr
+ENDPROC(fa_clean_dcache_all)
+
+/*
+ *	flush_dcache_all()
+ *
+ *	Flush the whole D-cache.
+ */
+ENTRY(fa_flush_dcache_all)
+	mov	pc, lr
+ENDPROC(fa_flush_dcache_all)
+
 	__INITDATA
 
 	.type	fa_cache_fns, #object
@@ -251,6 +269,8 @@ ENTRY(fa_cache_fns)
 	.long	fa_coherent_kern_range
 	.long	fa_coherent_user_range
 	.long	fa_flush_kern_dcache_area
+	.long	fa_clean_dcache_all
+	.long	fa_flush_dcache_all
 	.long	fa_dma_map_area
 	.long	fa_dma_unmap_area
 	.long	fa_dma_flush_range
diff --git a/arch/arm/mm/cache-v3.S b/arch/arm/mm/cache-v3.S
index 2e2bc40..bf38b9b 100644
--- a/arch/arm/mm/cache-v3.S
+++ b/arch/arm/mm/cache-v3.S
@@ -127,6 +127,24 @@ ENTRY(v3_dma_map_area)
 ENDPROC(v3_dma_unmap_area)
 ENDPROC(v3_dma_map_area)
 
+/*
+ *	clean_dcache_all()
+ *
+ *	Clean the whole D-cache.
+ */
+ENTRY(v3_clean_dcache_all)
+	mov	pc, lr
+ENDPROC(v3_clean_dcache_all)
+
+/*
+ *	flush_dcache_all()
+ *
+ *	Flush the whole D-cache.
+ */
+ENTRY(v3_flush_dcache_all)
+	mov	pc, lr
+ENDPROC(v3_flush_dcache_all)
+
 	__INITDATA
 
 	.type	v3_cache_fns, #object
@@ -138,6 +156,8 @@ ENTRY(v3_cache_fns)
 	.long	v3_coherent_kern_range
 	.long	v3_coherent_user_range
 	.long	v3_flush_kern_dcache_area
+	.long	v3_clean_dcache_all
+	.long	v3_flush_dcache_all
 	.long	v3_dma_map_area
 	.long	v3_dma_unmap_area
 	.long	v3_dma_flush_range
diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index a8fefb5..242dbd8 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -139,6 +139,24 @@ ENTRY(v4_dma_map_area)
 ENDPROC(v4_dma_unmap_area)
 ENDPROC(v4_dma_map_area)
 
+/*
+ *	clean_dcache_all()
+ *
+ *	Clean the whole D-cache.
+ */
+ENTRY(v4_clean_dcache_all)
+	mov	pc, lr
+ENDPROC(v4_clean_dcache_all)
+
+/*
+ *	flush_dcache_all()
+ *
+ *	Flush the whole D-cache.
+ */
+ENTRY(v4_flush_dcache_all)
+	mov	pc, lr
+ENDPROC(v4_flush_dcache_all)
+
 	__INITDATA
 
 	.type	v4_cache_fns, #object
@@ -150,6 +168,8 @@ ENTRY(v4_cache_fns)
 	.long	v4_coherent_kern_range
 	.long	v4_coherent_user_range
 	.long	v4_flush_kern_dcache_area
+	.long	v4_clean_dcache_all
+	.long	v4_flush_dcache_all
 	.long	v4_dma_map_area
 	.long	v4_dma_unmap_area
 	.long	v4_dma_flush_range
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index d3644db..0847304 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -251,6 +251,24 @@ ENTRY(v4wb_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(v4wb_dma_unmap_area)
 
+/*
+ *	clean_dcache_all()
+ *
+ *	Clean the whole D-cache.
+ */
+ENTRY(v4wb_clean_dcache_all)
+	mov	pc, lr
+ENDPROC(v4wb_clean_dcache_all)
+
+/*
+ *	flush_dcache_all()
+ *
+ *	Flush the whole D-cache.
+ */
+ENTRY(v4wb_flush_dcache_all)
+	mov	pc, lr
+ENDPROC(v4wb_flush_dcache_all)
+
 	__INITDATA
 
 	.type	v4wb_cache_fns, #object
@@ -262,6 +280,8 @@ ENTRY(v4wb_cache_fns)
 	.long	v4wb_coherent_kern_range
 	.long	v4wb_coherent_user_range
 	.long	v4wb_flush_kern_dcache_area
+	.long	v4wb_clean_dcache_all
+	.long	v4wb_flush_dcache_all
 	.long	v4wb_dma_map_area
 	.long	v4wb_dma_unmap_area
 	.long	v4wb_dma_flush_range
diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index 49c2b66..dab4533 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -195,6 +195,24 @@ ENTRY(v4wt_dma_map_area)
 ENDPROC(v4wt_dma_unmap_area)
 ENDPROC(v4wt_dma_map_area)
 
+/*
+ *	clean_dcache_all()
+ *
+ *	Clean the whole D-cache.
+ */
+ENTRY(v4wt_clean_dcache_all)
+	mov	pc, lr
+ENDPROC(v4wt_clean_dcache_all)
+
+/*
+ *	flush_dcache_all()
+ *
+ *	Flush the whole D-cache.
+ */
+ENTRY(v4wt_flush_dcache_all)
+	mov	pc, lr
+ENDPROC(v4wt_flush_dcache_all)
+
 	__INITDATA
 
 	.type	v4wt_cache_fns, #object
@@ -206,6 +224,8 @@ ENTRY(v4wt_cache_fns)
 	.long	v4wt_coherent_kern_range
 	.long	v4wt_coherent_user_range
 	.long	v4wt_flush_kern_dcache_area
+	.long	v4wt_clean_dcache_all
+	.long	v4wt_flush_dcache_all
 	.long	v4wt_dma_map_area
 	.long	v4wt_dma_unmap_area
 	.long	v4wt_dma_flush_range
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 99fa688..e2cd64a 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -315,6 +315,24 @@ ENTRY(v6_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(v6_dma_unmap_area)
 
+/*
+ *	clean_dcache_all()
+ *
+ *	Clean the whole D-cache.
+ */
+ENTRY(v6_clean_dcache_all)
+	mov	pc, lr
+ENDPROC(v6_clean_dcache_all)
+
+/*
+ *	flush_dcache_all()
+ *
+ *	Flush the whole D-cache.
+ */
+ENTRY(v6_flush_dcache_all)
+	mov	pc, lr
+ENDPROC(v6_flush_dcache_all)
+
 	__INITDATA
 
 	.type	v6_cache_fns, #object
@@ -326,6 +344,8 @@ ENTRY(v6_cache_fns)
 	.long	v6_coherent_kern_range
 	.long	v6_coherent_user_range
 	.long	v6_flush_kern_dcache_area
+	.long	v6_clean_dcache_all
+	.long	v6_flush_dcache_all
 	.long	v6_dma_map_area
 	.long	v6_dma_unmap_area
 	.long	v6_dma_flush_range
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a3ebf7a..477a94c 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -33,15 +33,13 @@ ENTRY(v7_flush_icache_all)
 ENDPROC(v7_flush_icache_all)
 
 /*
- *	v7_flush_dcache_all()
+ *	__v7_flush_dcache_all()
  *
  *	Flush the whole D-cache.
  *
  *	Corrupted registers: r0-r7, r9-r11 (r6 only in Thumb mode)
- *
- *	- mm    - mm_struct describing address space
  */
-ENTRY(v7_flush_dcache_all)
+ENTRY(__v7_flush_dcache_all)
 	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
 	ands	r3, r0, #0x7000000		@ extract loc from clidr
@@ -88,9 +86,93 @@ finished:
 	dsb
 	isb
 	mov	pc, lr
+ENDPROC(__v7_flush_dcache_all)
+
+/*
+ *	__v7_clean_dcache_all()
+ *
+ *	Clean the whole D-cache.
+ *
+ *	Corrupted registers: r0-r7, r9-r11 (r6 only in Thumb mode)
+ */
+ENTRY(__v7_clean_dcache_all)
+	dmb					@ ensure ordering with previous memory accesses
+	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
+	ands	r3, r0, #0x7000000		@ extract loc from clidr
+	mov	r3, r3, lsr #23			@ left align loc bit field
+	beq	finished1			@ if loc is 0, then no need to clean
+	mov	r10, #0				@ start clean at cache level 0
+loop21:
+	add	r2, r10, r10, lsr #1		@ work out 3x current cache level
+	mov	r1, r0, lsr r2			@ extract cache type bits from clidr
+	and	r1, r1, #7			@ mask of the bits for current cache only
+	cmp	r1, #2				@ see what cache we have@this level
+	blt	skip1				@ skip if no cache, or just i-cache
+	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
+	isb					@ isb to sych the new cssr&csidr
+	mrc	p15, 1, r1, c0, c0, 0		@ read the new csidr
+	and	r2, r1, #7			@ extract the length of the cache lines
+	add	r2, r2, #4			@ add 4 (line length offset)
+	ldr	r4, =0x3ff
+	ands	r4, r4, r1, lsr #3		@ find maximum number on the way size
+	clz	r5, r4				@ find bit position of way size increment
+	ldr	r7, =0x7fff
+	ands	r7, r7, r1, lsr #13		@ extract max number of the index size
+loop22:
+	mov	r9, r4				@ create working copy of max way size
+loop23:
+ ARM(	orr	r11, r10, r9, lsl r5	)	@ factor way and cache number into r11
+ THUMB(	lsl	r6, r9, r5		)
+ THUMB(	orr	r11, r10, r6		)	@ factor way and cache number into r11
+ ARM(	orr	r11, r11, r7, lsl r2	)	@ factor index number into r11
+ THUMB(	lsl	r6, r7, r2		)
+ THUMB(	orr	r11, r11, r6		)	@ factor index number into r11
+	mcr	p15, 0, r11, c7, c10, 2		@ clean by set/way
+	subs	r9, r9, #1			@ decrement the way
+	bge	loop23
+	subs	r7, r7, #1			@ decrement the index
+	bge	loop22
+skip1:
+	add	r10, r10, #2			@ increment cache number
+	cmp	r3, r10
+	bgt	loop21
+finished1:
+	mov	r10, #0				@ swith back to cache level 0
+	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
+	dsb
+	isb
+	mov	pc, lr
+ENDPROC(__v7_clean_dcache_all)
+
+/*
+ *	v7_flush_dcache_all()
+ *
+ *	Flush the whole D-cache.
+ */
+ENTRY(v7_flush_dcache_all)
+ ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
+	bl	__v7_flush_dcache_all
+ ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
+	mov	pc, lr
 ENDPROC(v7_flush_dcache_all)
 
 /*
+ *	v7_clean_dcache_all()
+ *
+ *	Clean the whole D-cache.
+ */
+ENTRY(v7_clean_dcache_all)
+ ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
+	bl	__v7_clean_dcache_all
+ ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
+	mov	pc, lr
+ENDPROC(v7_clean_dcache_all)
+
+/*
  *	v7_flush_cache_all()
  *
  *	Flush the entire cache system.
@@ -102,14 +184,12 @@ ENDPROC(v7_flush_dcache_all)
  *
  */
 ENTRY(v7_flush_kern_cache_all)
- ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
- THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
+	stmfd	sp!, {lr}
 	bl	v7_flush_dcache_all
 	mov	r0, #0
 	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)	@ invalidate I-cache inner shareable
 	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)	@ I+BTB cache invalidate
- ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
- THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
+	ldmfd	sp!, {lr}
 	mov	pc, lr
 ENDPROC(v7_flush_kern_cache_all)
 
@@ -325,6 +405,8 @@ ENTRY(v7_cache_fns)
 	.long	v7_coherent_kern_range
 	.long	v7_coherent_user_range
 	.long	v7_flush_kern_dcache_area
+	.long	v7_clean_dcache_all
+	.long	v7_flush_dcache_all
 	.long	v7_dma_map_area
 	.long	v7_dma_unmap_area
 	.long	v7_dma_flush_range
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 53cbe22..753783e 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -196,7 +196,7 @@ __v7_ca9mp_setup:
 __v7_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
-	bl	v7_flush_dcache_all
+	bl	__v7_flush_dcache_all
 	ldmia	r12, {r0-r5, r7, r9, r11, lr}
 
 	mrc	p15, 0, r0, c0, c0, 0		@ read main ID register
-- 
1.6.3.3
