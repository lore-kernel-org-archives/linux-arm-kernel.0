From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 18 Oct 2011 09:47:33 -0400
Subject: [RFC/PATCH v4 6/7] ARM: ARM11 MPCore: DMA_CACHE_RWFO operations are
	not preempt safe
In-Reply-To: <1318945654-548-1-git-send-email-gdavis@mvista.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
Message-ID: <1318945654-548-7-git-send-email-gdavis@mvista.com>
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
 arch/arm/mm/cache-v6.S |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 74c2e5a..a5cc9a0 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -205,6 +205,12 @@ ENTRY(v6_flush_kern_dcache_area)
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
@@ -241,6 +247,13 @@ v6_dma_inv_range:
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
+	teq	r3, #0				@ preempt count == 0?
+	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
+	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
+	bne	preempt_schedule		@ ret via preempt_schedule
+#endif
 	mov	pc, lr
 
 /*
@@ -249,6 +262,12 @@ v6_dma_inv_range:
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
@@ -264,6 +283,13 @@ v6_dma_clean_range:
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
+	teq	r3, #0				@ preempt count == 0?
+	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
+	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
+	bne	preempt_schedule		@ ret via preempt_schedule
+#endif
 	mov	pc, lr
 
 /*
@@ -273,6 +299,12 @@ v6_dma_clean_range:
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
@@ -292,6 +324,13 @@ ENTRY(v6_dma_flush_range)
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
+	teq	r3, #0				@ preempt count == 0?
+	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
+	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
+	bne	preempt_schedule		@ ret via preempt_schedule
+#endif
 	mov	pc, lr
 
 /*
-- 
1.7.4.4
