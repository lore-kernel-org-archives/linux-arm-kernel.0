From: kwangwoo.lee@sk.com (Kwangwoo Lee)
Date: Wed, 10 Aug 2016 11:32:46 +0900
Subject: [PATCH v4] arm64: mm: convert __dma_* routines to use start, size
Message-ID: <1470796366-2102-1-git-send-email-kwangwoo.lee@sk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__dma_* routines have been converted to use start and size instread of
start and end addresses. The patch was origianlly for adding
__clean_dcache_area_poc() which will be used in pmem driver to clean
dcache to the PoC(Point of Coherency) in arch_wb_cache_pmem().

The functionality of __clean_dcache_area_poc()  was equivalent to
__dma_clean_range(). The difference was __dma_clean_range() uses the end
address, but __clean_dcache_area_poc() uses the size to clean.

Thus, __clean_dcache_area_poc() has been revised with a fallthrough
function of __dma_clean_range() after the change that __dma_* routines
use start and size instead of using start and end.

As a consequence of using start and size, the name of __dma_* routines
has also been altered following the terminology below:
    area: takes a start and size
    range: takes a start and end

Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
---
v4)
add Reviewed-by: and Cc: lines

v3)
clean up in __dma_clean_area() based on 823066d9edcd dcache_by_line_op fix

v2)
change the names of __dma_* rountines to use area instead of range
fix to use __dma_flush_area() in dma-mapping.c

v1)
change __dma_* routines to use start, size
add __clean_dcache_area_poc() as a fallthrough of __dma_clean_range()

 arch/arm64/include/asm/cacheflush.h |  3 +-
 arch/arm64/mm/cache.S               | 82 ++++++++++++++++++-------------------
 arch/arm64/mm/dma-mapping.c         |  6 +--
 3 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index c64268d..2e5fb97 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -68,6 +68,7 @@
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
+extern void __clean_dcache_area_poc(void *addr, size_t len);
 extern void __clean_dcache_area_pou(void *addr, size_t len);
 extern long __flush_cache_user_range(unsigned long start, unsigned long end);
 
@@ -85,7 +86,7 @@ static inline void flush_cache_page(struct vm_area_struct *vma,
  */
 extern void __dma_map_area(const void *, size_t, int);
 extern void __dma_unmap_area(const void *, size_t, int);
-extern void __dma_flush_range(const void *, const void *);
+extern void __dma_flush_area(const void *, size_t);
 
 /*
  * Copy user data from/to a page which is mapped into a different
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 07d7352..58b5a90 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -105,19 +105,20 @@ ENTRY(__clean_dcache_area_pou)
 ENDPROC(__clean_dcache_area_pou)
 
 /*
- *	__inval_cache_range(start, end)
- *	- start   - start address of region
- *	- end     - end address of region
+ *	__dma_inv_area(start, size)
+ *	- start   - virtual start address of region
+ *	- size    - size in question
  */
-ENTRY(__inval_cache_range)
+__dma_inv_area:
+	add	x1, x1, x0
 	/* FALLTHROUGH */
 
 /*
- *	__dma_inv_range(start, end)
- *	- start   - virtual start address of region
- *	- end     - virtual end address of region
+ *	__inval_cache_range(start, end)
+ *	- start   - start address of region
+ *	- end     - end address of region
  */
-__dma_inv_range:
+ENTRY(__inval_cache_range)
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -136,46 +137,43 @@ __dma_inv_range:
 	dsb	sy
 	ret
 ENDPIPROC(__inval_cache_range)
-ENDPROC(__dma_inv_range)
+ENDPROC(__dma_inv_area)
+
+/*
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
 
 /*
- *	__dma_clean_range(start, end)
+ *	__dma_clean_area(start, size)
  *	- start   - virtual start address of region
- *	- end     - virtual end address of region
+ *	- size    - size in question
  */
-__dma_clean_range:
-	dcache_line_size x2, x3
-	sub	x3, x2, #1
-	bic	x0, x0, x3
-1:
-alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
-	dc	cvac, x0
-alternative_else
-	dc	civac, x0
-alternative_endif
-	add	x0, x0, x2
-	cmp	x0, x1
-	b.lo	1b
-	dsb	sy
+__dma_clean_area:
+	dcache_by_line_op cvac, sy, x0, x1, x2, x3
 	ret
-ENDPROC(__dma_clean_range)
+ENDPIPROC(__clean_dcache_area_poc)
+ENDPROC(__dma_clean_area)
 
 /*
- *	__dma_flush_range(start, end)
+ *	__dma_flush_area(start, size)
+ *
+ *	clean & invalidate D / U line
+ *
  *	- start   - virtual start address of region
- *	- end     - virtual end address of region
+ *	- size    - size in question
  */
-ENTRY(__dma_flush_range)
-	dcache_line_size x2, x3
-	sub	x3, x2, #1
-	bic	x0, x0, x3
-1:	dc	civac, x0			// clean & invalidate D / U line
-	add	x0, x0, x2
-	cmp	x0, x1
-	b.lo	1b
-	dsb	sy
+ENTRY(__dma_flush_area)
+	dcache_by_line_op civac, sy, x0, x1, x2, x3
 	ret
-ENDPIPROC(__dma_flush_range)
+ENDPIPROC(__dma_flush_area)
 
 /*
  *	__dma_map_area(start, size, dir)
@@ -184,10 +182,9 @@ ENDPIPROC(__dma_flush_range)
  *	- dir	- DMA direction
  */
 ENTRY(__dma_map_area)
-	add	x1, x1, x0
 	cmp	w2, #DMA_FROM_DEVICE
-	b.eq	__dma_inv_range
-	b	__dma_clean_range
+	b.eq	__dma_inv_area
+	b	__dma_clean_area
 ENDPIPROC(__dma_map_area)
 
 /*
@@ -197,8 +194,7 @@ ENDPIPROC(__dma_map_area)
  *	- dir	- DMA direction
  */
 ENTRY(__dma_unmap_area)
-	add	x1, x1, x0
 	cmp	w2, #DMA_TO_DEVICE
-	b.ne	__dma_inv_range
+	b.ne	__dma_inv_area
 	ret
 ENDPIPROC(__dma_unmap_area)
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index f6c55af..88922e8 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -168,7 +168,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
 		return ptr;
 
 	/* remove any dirty cache lines on the kernel alias */
-	__dma_flush_range(ptr, ptr + size);
+	__dma_flush_area(ptr, size);
 
 	/* create a coherent mapping */
 	page = virt_to_page(ptr);
@@ -387,7 +387,7 @@ static int __init atomic_pool_init(void)
 		void *page_addr = page_address(page);
 
 		memset(page_addr, 0, atomic_pool_size);
-		__dma_flush_range(page_addr, page_addr + atomic_pool_size);
+		__dma_flush_area(page_addr, atomic_pool_size);
 
 		atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
 		if (!atomic_pool)
@@ -548,7 +548,7 @@ fs_initcall(dma_debug_do_init);
 /* Thankfully, all cache ops are by VA so we can ignore phys here */
 static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
 {
-	__dma_flush_range(virt, virt + PAGE_SIZE);
+	__dma_flush_area(virt, PAGE_SIZE);
 }
 
 static void *__iommu_alloc_attrs(struct device *dev, size_t size,
-- 
2.5.0
