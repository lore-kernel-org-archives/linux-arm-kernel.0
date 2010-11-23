From: vbarshak@mvista.com (Valentine Barshak)
Date: Wed, 24 Nov 2010 01:28:06 +0300
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range RWFO fix
Message-ID: <20101123222806.GA22936@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cache ownership must be acqired by reading/writing data from the
cache line to make cache operation have the desired effect on the
SMP MPCore CPU. However, the ownership is never aquired in the
v6_dma_inv_range function when cleaning the first line and
flushing the last one, in case the address is not aligned
to D_CACHE_LINE_SIZE boundary.
Fix this by reading/writing data if needed, before performing
cache operations.

Signed-off-by: Valentine Barshak <vbarshak@mvista.com>
Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/mm/cache-v6.S |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 99fa688..e0e5c6b 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -205,6 +205,10 @@ ENTRY(v6_flush_kern_dcache_area)
 v6_dma_inv_range:
 	tst	r0, #D_CACHE_LINE_SIZE - 1
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
+#ifdef CONFIG_DMA_CACHE_RWFO
+	ldr	r2, [r0]			@ read for ownership
+	str	r2, [r0]			@ write for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcrne	p15, 0, r0, c7, c10, 1		@ clean D line
 #else
@@ -212,16 +216,16 @@ v6_dma_inv_range:
 #endif
 	tst	r1, #D_CACHE_LINE_SIZE - 1
 	bic	r1, r1, #D_CACHE_LINE_SIZE - 1
+#ifdef CONFIG_DMA_CACHE_RWFO
+	ldrne	r2, [r1]			@ read for ownership
+	strne	r2, [r1]			@ write for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D line
 #else
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
-- 
1.6.0.6
