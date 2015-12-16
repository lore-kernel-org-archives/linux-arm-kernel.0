From: ashoks@broadcom.com (Ashok Kumar)
Date: Wed, 16 Dec 2015 02:11:30 -0800
Subject: [PATCH v3 2/2] arm64: Use PoU cache instr for I/D coherency
In-Reply-To: <1450260690-5431-1-git-send-email-ashoks@broadcom.com>
References: <1450260690-5431-1-git-send-email-ashoks@broadcom.com>
Message-ID: <1450260690-5431-3-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In systems with three levels of cache(PoU at L1 and PoC at L3),
PoC cache flush instructions flushes L2 and L3 caches which could affect
performance.
For cache flushes for I and D coherency, PoU should suffice.
So changing all I and D coherency related cache flushes to PoU.

Introduced a new __clean_dcache_area_pou API for dcache flush till PoU
and provided a common macro for __flush_dcache_area and
__clean_dcache_area_pou.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 50 +++++++++++++++++++++++++++++--------
 arch/arm64/mm/flush.c               | 33 +++++++++++++-----------
 3 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index c75b8d0..6a5ecbd 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -68,6 +68,7 @@
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
+extern void __clean_dcache_area_pou(void *addr, size_t len);
 extern long __flush_cache_user_range(unsigned long start, unsigned long end);
 
 static inline void flush_cache_mm(struct mm_struct *mm)
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index eb48d5d..b700a97 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -79,28 +79,56 @@ ENDPROC(flush_icache_range)
 ENDPROC(__flush_cache_user_range)
 
 /*
+ * Macro to perform a data cache maintenance for the interval
+ * [kaddr, kaddr + size)
+ *
+ * 	op:		operation passed to dc instruction
+ * 	domain:		domain used in dsb instruciton
+ * 	kaddr:		starting virtual address of the region
+ * 	size:		size of the region
+ * 	Corrupts: 	kaddr, size, tmp1, tmp2
+ */
+	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
+	dcache_line_size \tmp1, \tmp2
+	add	\size, \kaddr, \size
+	sub	\tmp2, \tmp1, #1
+	bic	\kaddr, \kaddr, \tmp2
+1:	dc	\op, \kaddr
+	add	\kaddr, \kaddr, \tmp1
+	cmp	\kaddr, \size
+	b.lo	1b
+	dsb	\domain
+	.endm
+
+/*
  *	__flush_dcache_area(kaddr, size)
  *
- *	Ensure that the data held in the page kaddr is written back to the
- *	page in question.
+ *	Ensure that any D-cache lines for the interval [kaddr, kaddr+size)
+ *	are cleaned and invalidated to the PoC.
  *
  *	- kaddr   - kernel address
  *	- size    - size in question
  */
 ENTRY(__flush_dcache_area)
-	dcache_line_size x2, x3
-	add	x1, x0, x1
-	sub	x3, x2, #1
-	bic	x0, x0, x3
-1:	dc	civac, x0			// clean & invalidate D line / unified line
-	add	x0, x0, x2
-	cmp	x0, x1
-	b.lo	1b
-	dsb	sy
+	dcache_by_line_op civac, sy, x0, x1, x2, x3
 	ret
 ENDPROC(__flush_dcache_area)
 
 /*
+ *	__clean_dcache_area_pou(kaddr, size)
+ *
+ * 	Ensure that any D-cache lines for the interval [kaddr, kaddr+size)
+ * 	are cleaned to the PoU.
+ *
+ *	- kaddr   - kernel address
+ *	- size    - size in question
+ */
+ENTRY(__clean_dcache_area_pou)
+	dcache_by_line_op cvau, ish, x0, x1, x2, x3
+	ret
+ENDPROC(__clean_dcache_area_pou)
+
+/*
  *	__inval_cache_range(start, end)
  *	- start   - start address of region
  *	- end     - end address of region
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index c26b804..46649d6 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -34,19 +34,24 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 		__flush_icache_all();
 }
 
+static void sync_icache_aliases(void *kaddr, unsigned long len)
+{
+	unsigned long addr = (unsigned long)kaddr;
+
+	if (icache_is_aliasing()) {
+		__clean_dcache_area_pou(kaddr, len);
+		__flush_icache_all();
+	} else {
+		flush_icache_range(addr, addr + len);
+	}
+}
+
 static void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 				unsigned long uaddr, void *kaddr,
 				unsigned long len)
 {
-	if (vma->vm_flags & VM_EXEC) {
-		unsigned long addr = (unsigned long)kaddr;
-		if (icache_is_aliasing()) {
-			__flush_dcache_area(kaddr, len);
-			__flush_icache_all();
-		} else {
-			flush_icache_range(addr, addr + len);
-		}
-	}
+	if (vma->vm_flags & VM_EXEC)
+		sync_icache_aliases(kaddr, len);
 }
 
 /*
@@ -74,13 +79,11 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
 	if (!page_mapping(page))
 		return;
 
-	if (!test_and_set_bit(PG_dcache_clean, &page->flags)) {
-		__flush_dcache_area(page_address(page),
-				PAGE_SIZE << compound_order(page));
+	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+		sync_icache_aliases(page_address(page),
+				    PAGE_SIZE << compound_order(page));
+	else if (icache_is_aivivt())
 		__flush_icache_all();
-	} else if (icache_is_aivivt()) {
-		__flush_icache_all();
-	}
 }
 
 /*
-- 
2.1.0
