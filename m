From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 09:59:55 +0100
Subject: [PATCH 1/2] arm64: Clean up __flush_tlb(_kernel)_range functions
In-Reply-To: <1437728396-5408-1-git-send-email-catalin.marinas@arm.com>
References: <1437728396-5408-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1437728396-5408-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the MAX_TLB_RANGE check into the
flush_tlb(_kernel)_range functions directly to avoid the
undescore-prefixed definitions (and for consistency with a subsequent
patch).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 47 +++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 934815d45eda..1643908eb5f3 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -91,11 +91,23 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 	dsb(ish);
 }
 
-static inline void __flush_tlb_range(struct vm_area_struct *vma,
-				     unsigned long start, unsigned long end)
+/*
+ * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
+ * necessarily a performance improvement.
+ */
+#define MAX_TLB_RANGE	(1024UL << PAGE_SHIFT)
+
+static inline void flush_tlb_range(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end)
 {
 	unsigned long asid = (unsigned long)ASID(vma->vm_mm) << 48;
 	unsigned long addr;
+
+	if ((end - start) > MAX_TLB_RANGE) {
+		flush_tlb_mm(vma->vm_mm);
+		return;
+	}
+
 	start = asid | (start >> 12);
 	end = asid | (end >> 12);
 
@@ -105,9 +117,15 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	dsb(ish);
 }
 
-static inline void __flush_tlb_kernel_range(unsigned long start, unsigned long end)
+static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
+
+	if ((end - start) > MAX_TLB_RANGE) {
+		flush_tlb_all();
+		return;
+	}
+
 	start >>= 12;
 	end >>= 12;
 
@@ -119,29 +137,6 @@ static inline void __flush_tlb_kernel_range(unsigned long start, unsigned long e
 }
 
 /*
- * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
- * necessarily a performance improvement.
- */
-#define MAX_TLB_RANGE	(1024UL << PAGE_SHIFT)
-
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end)
-{
-	if ((end - start) <= MAX_TLB_RANGE)
-		__flush_tlb_range(vma, start, end);
-	else
-		flush_tlb_mm(vma->vm_mm);
-}
-
-static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
-{
-	if ((end - start) <= MAX_TLB_RANGE)
-		__flush_tlb_kernel_range(start, end);
-	else
-		flush_tlb_all();
-}
-
-/*
  * Used to invalidate the TLB (walk caches) corresponding to intermediate page
  * table levels (pgd/pud/pmd).
  */
