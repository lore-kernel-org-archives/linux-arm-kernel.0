From: gdavis@mvista.com (gdavis at mvista.com)
Date: Thu,  6 Oct 2011 01:08:33 -0400
Subject: [RFC/PATCH 6/7] ARM: ARM11 MPCore: DMA_CACHE_RWFO operations are not
	preempt safe
In-Reply-To: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
Message-ID: <1317877714-11355-7-git-send-email-gdavis@mvista.com>
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

This changes depends on "ARM: Move get_thread_info macro definition
to <asm/assembler.h>".

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/mm/cache-v6.S |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 74c2e5a..445349c 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -205,6 +205,13 @@ ENTRY(v6_flush_kern_dcache_area)
  */
 v6_dma_inv_range:
 #ifdef CONFIG_DMA_CACHE_RWFO
+#ifdef CONFIG_PREEMPT
+	stmdb	sp!, {r4, r10, r11}
+	get_thread_info r10
+	ldr	r4, [r10, #TI_PREEMPT]		@ get preempt count
+	add	r11, r4, #1			@ increment it
+	str	r11, [r10, #TI_PREEMPT]		@ disable preempt
+#endif
 	ldrb	r2, [r0]			@ read for ownership
 	strb	r2, [r0]			@ write for ownership
 #endif
@@ -241,6 +248,10 @@ v6_dma_inv_range:
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	str	r4, [r10, #TI_PREEMPT]		@ restore preempt count
+	ldmia	sp!, {r4, r10, r11}
+#endif
 	mov	pc, lr
 
 /*
@@ -249,6 +260,13 @@ v6_dma_inv_range:
  *	- end     - virtual end address of region
  */
 v6_dma_clean_range:
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	stmdb	sp!, {r4, r10, r11}
+	get_thread_info r10
+	ldr	r4, [r10, #TI_PREEMPT]		@ get preempt count
+	add	r11, r4, #1			@ increment it
+	str	r11, [r10, #TI_PREEMPT]		@ disable preempt
+#endif
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
 #ifdef CONFIG_DMA_CACHE_RWFO
@@ -264,6 +282,10 @@ v6_dma_clean_range:
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	str	r4, [r10, #TI_PREEMPT]		@ restore preempt count
+	ldmia	sp!, {r4, r10, r11}
+#endif
 	mov	pc, lr
 
 /*
@@ -273,6 +295,13 @@ v6_dma_clean_range:
  */
 ENTRY(v6_dma_flush_range)
 #ifdef CONFIG_DMA_CACHE_RWFO
+#ifdef CONFIG_PREEMPT
+	stmdb	sp!, {r4, r10, r11}
+	get_thread_info r10
+	ldr	r4, [r10, #TI_PREEMPT]		@ get preempt count
+	add	r11, r4, #1			@ increment it
+	str	r11, [r10, #TI_PREEMPT]		@ disable preempt
+#endif
 	ldrb	r2, [r0]		@ read for ownership
 	strb	r2, [r0]		@ write for ownership
 #endif
@@ -292,6 +321,10 @@ ENTRY(v6_dma_flush_range)
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
+	str	r4, [r10, #TI_PREEMPT]		@ restore preempt count
+	ldmia	sp!, {r4, r10, r11}
+#endif
 	mov	pc, lr
 
 /*
-- 
1.7.4.4
