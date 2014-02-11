From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Feb 2014 15:42:29 +0000
Subject: [RFC PATCH V2 3/4] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <1391703531-12845-4-git-send-email-steve.capper@linaro.org>
References: <1391703531-12845-1-git-send-email-steve.capper@linaro.org>
 <1391703531-12845-4-git-send-email-steve.capper@linaro.org>
Message-ID: <20140211154229.GF3748@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, Feb 06, 2014 at 04:18:50PM +0000, Steve Capper wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d4dd22..129bd6a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -28,6 +28,7 @@ config ARM64
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>  	select HAVE_MEMBLOCK
>  	select HAVE_PERF_EVENTS
> +	select HAVE_RCU_TABLE_FREE
>  	select IRQ_DOMAIN
>  	select MODULES_USE_ELF_RELA
>  	select NO_BOOTMEM
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 717031a..8999823 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -27,12 +27,33 @@
>  
>  #define MMU_GATHER_BUNDLE	8
>  
> +static inline void __tlb_remove_table(void *_table)
> +{
> +	free_page_and_swap_cache((struct page *)_table);
> +}

I think you can reduce your patch to just the above (and a linux/swap.h
include) after the arm64 conversion to generic mmu_gather below.

I cc'ed Peter Z for a sanity check, some of the code is close to
https://lkml.org/lkml/2011/3/7/302, only that it's under arch/arm64.

And, of course, it needs a lot more testing.

-------------8<---------------------------------------

>From 01a958dfc44eb7ec697625813b3b98a705bad324 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 11 Feb 2014 15:22:01 +0000
Subject: [PATCH] arm64: Convert asm/tlb.h to generic mmu_gather

Over the past couple of years, the generic mmu_gather gained range
tracking - 597e1c3580b7 (mm/mmu_gather: enable tlb flush range in generic
mmu_gather), 2b047252d087 (Fix TLB gather virtual address range
invalidation corner cases) - and tlb_fast_mode() has been removed -
29eb77825cc7 (arch, mm: Remove tlb_fast_mode()).

The new mmu_gather structure is now suitable for arm64 and this patch
converts the arch asm/tlb.h to the generic code. One functional
difference is the shift_arg_pages() case where previously the code was
flushing the full mm (no tlb_start_vma call) but now it flushes the
range given to tlb_gather_mmu() (possibly slightly more efficient
previously).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/arm64/include/asm/tlb.h | 136 +++++++------------------------------------
 1 file changed, 20 insertions(+), 116 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 717031a762c2..72cadf52ca80 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -19,115 +19,44 @@
 #ifndef __ASM_TLB_H
 #define __ASM_TLB_H
 
-#include <linux/pagemap.h>
-#include <linux/swap.h>
 
-#include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
-
-#define MMU_GATHER_BUNDLE	8
-
-/*
- * TLB handling.  This allows us to remove pages from the page
- * tables, and efficiently handle the TLB issues.
- */
-struct mmu_gather {
-	struct mm_struct	*mm;
-	unsigned int		fullmm;
-	struct vm_area_struct	*vma;
-	unsigned long		start, end;
-	unsigned long		range_start;
-	unsigned long		range_end;
-	unsigned int		nr;
-	unsigned int		max;
-	struct page		**pages;
-	struct page		*local[MMU_GATHER_BUNDLE];
-};
+#include <asm-generic/tlb.h>
 
 /*
- * This is unnecessarily complex.  There's three ways the TLB shootdown
- * code is used:
+ * There's three ways the TLB shootdown code is used:
  *  1. Unmapping a range of vmas.  See zap_page_range(), unmap_region().
  *     tlb->fullmm = 0, and tlb_start_vma/tlb_end_vma will be called.
- *     tlb->vma will be non-NULL.
  *  2. Unmapping all vmas.  See exit_mmap().
  *     tlb->fullmm = 1, and tlb_start_vma/tlb_end_vma will be called.
- *     tlb->vma will be non-NULL.  Additionally, page tables will be freed.
+ *     Page tables will be freed.
  *  3. Unmapping argument pages.  See shift_arg_pages().
  *     tlb->fullmm = 0, but tlb_start_vma/tlb_end_vma will not be called.
- *     tlb->vma will be NULL.
  */
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	if (tlb->fullmm || !tlb->vma)
+	if (tlb->fullmm) {
 		flush_tlb_mm(tlb->mm);
-	else if (tlb->range_end > 0) {
-		flush_tlb_range(tlb->vma, tlb->range_start, tlb->range_end);
-		tlb->range_start = TASK_SIZE;
-		tlb->range_end = 0;
+	} else if (tlb->end > 0) {
+		struct vm_area_struct vma = { .vm_mm = tlb->mm, };
+		flush_tlb_range(&vma, tlb->start, tlb->end);
+		tlb->start = TASK_SIZE;
+		tlb->end = 0;
 	}
 }
 
 static inline void tlb_add_flush(struct mmu_gather *tlb, unsigned long addr)
 {
 	if (!tlb->fullmm) {
-		if (addr < tlb->range_start)
-			tlb->range_start = addr;
-		if (addr + PAGE_SIZE > tlb->range_end)
-			tlb->range_end = addr + PAGE_SIZE;
-	}
-}
-
-static inline void __tlb_alloc_page(struct mmu_gather *tlb)
-{
-	unsigned long addr = __get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
-
-	if (addr) {
-		tlb->pages = (void *)addr;
-		tlb->max = PAGE_SIZE / sizeof(struct page *);
+		tlb->start = min(tlb->start, addr);
+		tlb->end = max(tlb->end, addr + PAGE_SIZE);
 	}
 }
 
-static inline void tlb_flush_mmu(struct mmu_gather *tlb)
-{
-	tlb_flush(tlb);
-	free_pages_and_swap_cache(tlb->pages, tlb->nr);
-	tlb->nr = 0;
-	if (tlb->pages == tlb->local)
-		__tlb_alloc_page(tlb);
-}
-
-static inline void
-tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm, unsigned long start, unsigned long end)
-{
-	tlb->mm = mm;
-	tlb->fullmm = !(start | (end+1));
-	tlb->start = start;
-	tlb->end = end;
-	tlb->vma = NULL;
-	tlb->max = ARRAY_SIZE(tlb->local);
-	tlb->pages = tlb->local;
-	tlb->nr = 0;
-	__tlb_alloc_page(tlb);
-}
-
-static inline void
-tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
-{
-	tlb_flush_mmu(tlb);
-
-	/* keep the page table cache within bounds */
-	check_pgt_cache();
-
-	if (tlb->pages != tlb->local)
-		free_pages((unsigned long)tlb->pages, 0);
-}
-
 /*
  * Memorize the range for the TLB flush.
  */
-static inline void
-tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep, unsigned long addr)
+static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
+					  unsigned long addr)
 {
 	tlb_add_flush(tlb, addr);
 }
@@ -137,38 +66,24 @@ tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep, unsigned long addr)
  * case where we're doing a full MM flush.  When we're doing a munmap,
  * the vmas are adjusted to only cover the region to be torn down.
  */
-static inline void
-tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
+static inline void tlb_start_vma(struct mmu_gather *tlb,
+				 struct vm_area_struct *vma)
 {
 	if (!tlb->fullmm) {
-		tlb->vma = vma;
-		tlb->range_start = TASK_SIZE;
-		tlb->range_end = 0;
+		tlb->start = TASK_SIZE;
+		tlb->end = 0;
 	}
 }
 
-static inline void
-tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
+static inline void tlb_end_vma(struct mmu_gather *tlb,
+			       struct vm_area_struct *vma)
 {
 	if (!tlb->fullmm)
 		tlb_flush(tlb);
 }
 
-static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
-{
-	tlb->pages[tlb->nr++] = page;
-	VM_BUG_ON(tlb->nr > tlb->max);
-	return tlb->max - tlb->nr;
-}
-
-static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
-{
-	if (!__tlb_remove_page(tlb, page))
-		tlb_flush_mmu(tlb);
-}
-
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
-	unsigned long addr)
+				  unsigned long addr)
 {
 	pgtable_page_dtor(pte);
 	tlb_add_flush(tlb, addr);
@@ -184,16 +99,5 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 }
 #endif
 
-#define pte_free_tlb(tlb, ptep, addr)	__pte_free_tlb(tlb, ptep, addr)
-#define pmd_free_tlb(tlb, pmdp, addr)	__pmd_free_tlb(tlb, pmdp, addr)
-#define pud_free_tlb(tlb, pudp, addr)	pud_free((tlb)->mm, pudp)
-
-#define tlb_migrate_finish(mm)		do { } while (0)
-
-static inline void
-tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
-{
-	tlb_add_flush(tlb, addr);
-}
 
 #endif
