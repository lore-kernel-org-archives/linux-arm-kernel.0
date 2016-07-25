From: kwangwoo.lee@sk.com (Kwangwoo Lee)
Date: Mon, 25 Jul 2016 16:40:06 +0900
Subject: [PATCH RFC] arm64: mm: convert __dma_* routines to use start, size
Message-ID: <1469432406-27548-1-git-send-email-kwangwoo.lee@sk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__dma_* routines have been converted to use start and size instread of
start and end addresses. The patch was origianlly for adding
__clean_dcache_area_poc() which will be used in pmem driver to clean
dcache to the PoC(Point of Coherency) in arch_wb_cache_pmem().

The functionality of __clean_dcache_area_poc()  was equivalent to
__dma_clean_range(). The difference was __dma_clean_range() uses the end
address, but __clean_dcache_area_poc() uses the size to clean.

Thus, __clean_dcache_area_poc() has been revised with a fall through
function of __dma_clean_range() after the change that __dma_* routines
use start and size instead of using start and end.

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 53 +++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index c64268d..02b3039 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -68,6 +68,7 @@
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
+extern void __clean_dcache_area_poc(void *addr, size_t len);
 extern void __clean_dcache_area_pou(void *addr, size_t len);
 extern long __flush_cache_user_range(unsigned long start, unsigned long end);
 
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 50ff9ba..622a854 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -110,14 +110,16 @@ ENDPROC(__clean_dcache_area_pou)
  *	- end     - end address of region
  */
 ENTRY(__inval_cache_range)
+	sub	x1, x1, x0
 	/* FALLTHROUGH */
 
 /*
- *	__dma_inv_range(start, end)
+ *	__dma_inv_range(start, size)
  *	- start   - virtual start address of region
- *	- end     - virtual end address of region
+ *	- size    - size in question
  */
 __dma_inv_range:
+	add	x1, x1, x0
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -139,41 +141,42 @@ ENDPIPROC(__inval_cache_range)
 ENDPROC(__dma_inv_range)
 
 /*
- *	__dma_clean_range(start, end)
+ *	__clean_dcache_area_poc(kaddr, size)
+ *
+ * 	Ensure that any D-cache lines for the interval [kaddr, kaddr+size)
+ * 	are cleaned to the PoC.
+ *
+ *	- kaddr   - kernel address
+ *	- size    - size in question
+ */
+ENTRY(__clean_dcache_area_poc)
+	/* FALLTHROUGH */
+
+/*
+ *	__dma_clean_range(start, size)
  *	- start   - virtual start address of region
- *	- end     - virtual end address of region
+ *	- size    - size in question
  */
 __dma_clean_range:
-	dcache_line_size x2, x3
-	sub	x3, x2, #1
-	bic	x0, x0, x3
-1:
 alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
-	dc	cvac, x0
+	dcache_by_line_op cvac, sy, x0, x1, x2, x3
 alternative_else
-	dc	civac, x0
+	dcache_by_line_op civac, sy, x0, x1, x2, x3
 alternative_endif
-	add	x0, x0, x2
-	cmp	x0, x1
-	b.lo	1b
-	dsb	sy
 	ret
+ENDPIPROC(__clean_dcache_area_poc)
 ENDPROC(__dma_clean_range)
 
 /*
- *	__dma_flush_range(start, end)
+ *	__dma_flush_range(start, size)
+ *
+ *	clean & invalidate D / U line
+ *
  *	- start   - virtual start address of region
- *	- end     - virtual end address of region
+ *	- size    - size in question
  */
 ENTRY(__dma_flush_range)
-	dcache_line_size x2, x3
-	sub	x3, x2, #1
-	bic	x0, x0, x3
-1:	dc	civac, x0			// clean & invalidate D / U line
-	add	x0, x0, x2
-	cmp	x0, x1
-	b.lo	1b
-	dsb	sy
+	dcache_by_line_op civac, sy, x0, x1, x2, x3
 	ret
 ENDPIPROC(__dma_flush_range)
 
@@ -184,7 +187,6 @@ ENDPIPROC(__dma_flush_range)
  *	- dir	- DMA direction
  */
 ENTRY(__dma_map_area)
-	add	x1, x1, x0
 	cmp	w2, #DMA_FROM_DEVICE
 	b.eq	__dma_inv_range
 	b	__dma_clean_range
@@ -197,7 +199,6 @@ ENDPIPROC(__dma_map_area)
  *	- dir	- DMA direction
  */
 ENTRY(__dma_unmap_area)
-	add	x1, x1, x0
 	cmp	w2, #DMA_TO_DEVICE
 	b.ne	__dma_inv_range
 	ret
-- 
2.5.0
