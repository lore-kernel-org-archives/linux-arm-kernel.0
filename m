From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 12:14:37 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <20110215113242.GD4152@n2100.arm.linux.org.uk>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
	<20110215103127.GC4152@n2100.arm.linux.org.uk>
	<1297767748.14691.15.camel@e102109-lin.cambridge.arm.com>
	<20110215113242.GD4152@n2100.arm.linux.org.uk>
Message-ID: <20110215121437.GG4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 11:32:42AM +0000, Russell King - ARM Linux wrote:
> The point of TLB shootdown is that we unmap the entries from the page
> tables, then issue the TLB flushes, and then free the pages and page
> tables after that.  All that Peter's patch tries to do is to get ARM to
> use the generic stuff.

As Peter's patch preserves the current behaviour, that's not sufficient.
So, let's do this our own way and delay pages and page table frees on
ARMv6 and v7.  Untested.

Note that the generic code doesn't allow us to delay frees on UP as it
assumes that if there's no TLB entry, the CPU won't speculatively
prefetch.  This seems to be where ARM differs from the rest of the
planet.  Please confirm that this is indeed the case.

 arch/arm/include/asm/tlb.h |   79 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index f41a6f5..1ca3e16 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -30,6 +30,16 @@
 #include <asm/pgalloc.h>
 
 /*
+ * As v6 and v7 speculatively prefetch, which can drag new entries into the
+ * TLB, we need to delay freeing pages and page tables.
+ */
+#if defined(CONFIG_CPU_32v6) || defined(CONFIG_CPU_32v7)
+#define tlb_fast_mode(tlb)	0
+#else
+#define tlb_fast_mode(tlb)	1
+#endif
+
+/*
  * TLB handling.  This allows us to remove pages from the page
  * tables, and efficiently handle the TLB issues.
  */
@@ -38,10 +48,42 @@ struct mmu_gather {
 	unsigned int		fullmm;
 	unsigned long		range_start;
 	unsigned long		range_end;
+	unsigned int		nr;
+	struct page		*pages[FREE_PTE_NR];
 };
 
 DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
 
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	if (tlb->fullmm)
+		flush_tlb_mm(tlb->mm);
+	else if (tlb->range_end > 0) {
+		flush_tlb_range(vma, tlb->range_start, tlb->range_end);
+		tlb->range_start = TASK_SIZE;
+		tlb->range_end = 0;
+	}
+}
+
+static inline void tlb_add_flush(struct mmu_gather *tlb, unsigned long addr)
+{
+	if (!tlb->fullmm) {
+		if (addr < tlb->range_start)
+			tlb->range_start = addr;
+		if (addr + PAGE_SIZE > tlb->range_end)
+			tlb->range_end = addr + PAGE_SIZE;
+	}
+}
+
+static inline void tlb_flush_mmu(struct mmu_gather *tlb)
+{
+	tlb_flush(tlb);
+	if (!tlb_fast_mode(tlb)) {
+		free_pages_and_swap_cache(tlb->pages, tlb->nr);
+		tlb->nr = 0;
+	}
+}
+
 static inline struct mmu_gather *
 tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
@@ -49,6 +91,7 @@ tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 
 	tlb->mm = mm;
 	tlb->fullmm = full_mm_flush;
+	tlb->nr = 0;
 
 	return tlb;
 }
@@ -56,8 +99,7 @@ tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 static inline void
 tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
-	if (tlb->fullmm)
-		flush_tlb_mm(tlb->mm);
+	tlb_flush_mmu(tlb);
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
@@ -71,12 +113,7 @@ tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 static inline void
 tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep, unsigned long addr)
 {
-	if (!tlb->fullmm) {
-		if (addr < tlb->range_start)
-			tlb->range_start = addr;
-		if (addr + PAGE_SIZE > tlb->range_end)
-			tlb->range_end = addr + PAGE_SIZE;
-	}
+	tlb_add_flush(tlb, addr);
 }
 
 /*
@@ -97,12 +134,30 @@ tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 static inline void
 tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
-	if (!tlb->fullmm && tlb->range_end > 0)
-		flush_tlb_range(vma, tlb->range_start, tlb->range_end);
+	if (!tlb->fullmm)
+		tlb_flush(tlb);
+}
+
+static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+{
+	if (tlb_fast_mode(tlb)) {
+		free_page_and_swap_cache(page);
+	} else {
+		tlb->pages[tlb->nr++] = page;
+		if (tlb->nr >= FREE_PTE_NR)
+			tlb_flush_mmu(tlb);
+	}
+}
+
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
+	unsigned long addr)
+{
+	pgtable_page_dtor(pte);
+	tlb_add_flush(addr);
+	tlb_remove_page(tlb, pte);
 }
 
-#define tlb_remove_page(tlb,page)	free_page_and_swap_cache(page)
-#define pte_free_tlb(tlb, ptep, addr)	pte_free((tlb)->mm, ptep)
+#define pte_free_tlb(tlb, ptep, addr)	__pte_free_tlb(tlb, ptep, addr)
 #define pmd_free_tlb(tlb, pmdp, addr)	pmd_free((tlb)->mm, pmdp)
 
 #define tlb_migrate_finish(mm)		do { } while (0)
