From: vbarshak@mvista.com (Valentine Barshak)
Date: Fri, 10 Dec 2010 21:24:42 +0300
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range and v6_dma_flush_range
	RWFO fix (take 2)
Message-ID: <20101210182442.GA8293@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleaned up v6_dma_inv_range change a bit, preseving the order of
start/end address processing.

Cache ownership must be acquired by reading/writing data from the
cache line to make cache operation have the desired effect on the
SMP MPCore CPU. However, the ownership is never acquired in the
v6_dma_inv_range function when cleaning the first line and
flushing the last one, in case the address is not aligned
to D_CACHE_LINE_SIZE boundary.
Fix this by reading/writing data if needed, before performing
cache operations.
While at it, fix v6_dma_flush_range to prevent RWFO outside
the buffer.

Signed-off-by: Valentine Barshak <vbarshak@mvista.com>
Signed-off-by: George G. Davis <gdavis@mvista.com>
Cc: stable at kernel.org
---
 arch/arm/mm/cache-v6.S |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 99fa688..c96fa1b 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -203,6 +203,10 @@ ENTRY(v6_flush_kern_dcache_area)
  *	- end     - virtual end address of region
  */
 v6_dma_inv_range:
+#ifdef CONFIG_DMA_CACHE_RWFO
+	ldrb	r2, [r0]			@ read for ownership
+	strb	r2, [r0]			@ write for ownership
+#endif
 	tst	r0, #D_CACHE_LINE_SIZE - 1
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 #ifdef HARVARD_CACHE
@@ -211,6 +215,10 @@ v6_dma_inv_range:
 	mcrne	p15, 0, r0, c7, c11, 1		@ clean unified line
 #endif
 	tst	r1, #D_CACHE_LINE_SIZE - 1
+#ifdef CONFIG_DMA_CACHE_RWFO
+	ldrneb	r2, [r1, #-1]			@ read for ownership
+	strneb	r2, [r1, #-1]			@ write for ownership
+#endif
 	bic	r1, r1, #D_CACHE_LINE_SIZE - 1
 #ifdef HARVARD_CACHE
 	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D line
@@ -218,10 +226,6 @@ v6_dma_inv_range:
 	mcrne	p15, 0, r1, c7, c15, 1		@ clean & invalidate unified line
 #endif
 1:
-#ifdef CONFIG_DMA_CACHE_RWFO
-	ldr	r2, [r0]			@ read for ownership
-	str	r2, [r0]			@ write for ownership
-#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line
 #else
@@ -229,6 +233,10 @@ v6_dma_inv_range:
 #endif
 	add	r0, r0, #D_CACHE_LINE_SIZE
 	cmp	r0, r1
+#ifdef CONFIG_DMA_CACHE_RWFO
+	ldrlo	r2, [r0]			@ read for ownership
+	strlo	r2, [r0]			@ write for ownership
+#endif
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
@@ -263,12 +271,12 @@ v6_dma_clean_range:
  *	- end     - virtual end address of region
  */
 ENTRY(v6_dma_flush_range)
-	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
-1:
 #ifdef CONFIG_DMA_CACHE_RWFO
-	ldr	r2, [r0]			@ read for ownership
-	str	r2, [r0]			@ write for ownership
+	ldrb	r2, [r0]		@ read for ownership
+	strb	r2, [r0]		@ write for ownership
 #endif
+	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
+1:
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
 #else
@@ -276,6 +284,10 @@ ENTRY(v6_dma_flush_range)
 #endif
 	add	r0, r0, #D_CACHE_LINE_SIZE
 	cmp	r0, r1
+#ifdef CONFIG_DMA_CACHE_RWFO
+	ldrlob	r2, [r0]			@ read for ownership
+	strlob	r2, [r0]			@ write for ownership
+#endif
 	blo	1b
 	mov	r0, #0
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
-- 
1.6.0.6
