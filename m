From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 12 Jun 2012 16:40:17 -0400
Subject: [RFC/PATCH v5 6/7] ARM: ARM11 MPCore: Make DMA_CACHE_RWFO operations
 preempt safe
In-Reply-To: <1339533618-15969-1-git-send-email-gdavis@mvista.com>
References: <1318945654-548-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-1-git-send-email-gdavis@mvista.com>
Message-ID: <1339533618-15969-7-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George G. Davis <gdavis@mvista.com>

The DMA_CACHE_RWFO operations are not preempt safe.  If preemption
occurs immediately following a RWFO operation on a cache line of
CPU A, it is possible for task migration to occur on resume at
which point the subsequent cache maintenance operation on the
same cache line of CPU B will have no affect on the CPU A cache
line leading to inconsistent memory and/or cache state.  To prevent
this, disable preemption during RWFO operations.

This change depends on "ARM: Move get_thread_info macro definition
to <asm/assembler.h>".

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/mm/cache-v6.S |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 4b10760..ee36b6c 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -203,6 +203,12 @@ ENTRY(v6_flush_kern_dcache_area)
  */
 v6_dma_inv_range:
 #ifdef CONFIG_DMA_CACHE_RWFO
+#ifdef CONFIG_PREEMPT
+	get_thread_info ip
+	ldr	r3, [ip, #TI_PREEMPT]		@ get preempt count
+	add	r2, r3, #1			@ increment it
+	str	r2, [ip, #TI_PREEMPT]		@ disable preempt
+#endif
 	ldrb	r2, [r0]			@ read for ownership
 	strb	r2, [r0]			@ write for ownership
 #endif
@@ -239,6 +245,15 @@ v6_dma_inv_range:
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	teq	r3, #0				@ preempt count == 0?
+	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
+	bne	99f				@ done if non-zero
+	ldr	r3, [ip, #TI_FLAGS]		@ else check flags
+	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
+	bne	preempt_schedule		@ yes, do preempt_schedule
+99:
+#endif
 	mov	pc, lr
 
 /*
@@ -247,6 +262,12 @@ v6_dma_inv_range:
  *	- end     - virtual end address of region
  */
 v6_dma_clean_range:
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	get_thread_info ip
+	ldr	r3, [ip, #TI_PREEMPT]		@ get preempt count
+	add	r2, r3, #1			@ increment it
+	str	r2, [ip, #TI_PREEMPT]		@ disable preempt
+#endif
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
 #ifdef CONFIG_DMA_CACHE_RWFO
@@ -262,6 +283,15 @@ v6_dma_clean_range:
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	teq	r3, #0				@ preempt count == 0?
+	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
+	bne	99f				@ done if non-zero
+	ldr	r3, [ip, #TI_FLAGS]		@ else check flags
+	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
+	bne	preempt_schedule		@ yes, do preempt_schedule
+99:
+#endif
 	mov	pc, lr
 
 /*
@@ -271,6 +301,12 @@ v6_dma_clean_range:
  */
 ENTRY(v6_dma_flush_range)
 #ifdef CONFIG_DMA_CACHE_RWFO
+#ifdef CONFIG_PREEMPT
+	get_thread_info ip
+	ldr	r3, [ip, #TI_PREEMPT]		@ get preempt count
+	add	r2, r3, #1			@ increment it
+	str	r2, [ip, #TI_PREEMPT]		@ disable preempt
+#endif
 	ldrb	r2, [r0]		@ read for ownership
 	strb	r2, [r0]		@ write for ownership
 #endif
@@ -290,6 +326,15 @@ ENTRY(v6_dma_flush_range)
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	teq	r3, #0				@ preempt count == 0?
+	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
+	bne	99f				@ done if non-zero
+	ldr	r3, [ip, #TI_FLAGS]		@ else check flags
+	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
+	bne	preempt_schedule		@ yes, do preempt_schedule
+99:
+#endif
 	mov	pc, lr
 
 /*
-- 
1.7.4.4
