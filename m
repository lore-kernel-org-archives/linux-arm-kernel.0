From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 09:59:56 +0100
Subject: [PATCH 2/2] arm64: Use last level TLBI for user pte changes
In-Reply-To: <1437728396-5408-1-git-send-email-catalin.marinas@arm.com>
References: <1437728396-5408-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1437728396-5408-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flush_tlb_page() function is used on user address ranges when PTEs
(or PMDs/PUDs for huge pages) were changed (attributes or clearing). For
such cases, it is more efficient to invalidate only the last level of
the TLB with the "tlbi vale1is" instruction.

In the TLB shoot-down case, the TLB caching of the intermediate page
table levels (pmd, pud, pgd) is handled by __flush_tlb_pgtable() via the
__(pte|pmd|pud)_free_tlb() functions and it is not deferred to
tlb_finish_mmu() (as of commit 285994a62c80 - "arm64: Invalidate the TLB
corresponding to intermediate page table levels"). The tlb_flush()
function only needs to invalidate the TLB for the last level of page
tables; a new arm64-specific __flush_tlb_page_range() function performs
only the last level TLBI.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h      |  7 ++++++-
 arch/arm64/include/asm/tlbflush.h | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 3a0242c7eb8d..93c70e99a1f2 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -41,7 +41,12 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		flush_tlb_mm(tlb->mm);
 	} else {
 		struct vm_area_struct vma = { .vm_mm = tlb->mm, };
-		flush_tlb_range(&vma, tlb->start, tlb->end);
+		/*
+		 * The intermediate page table levels are already handled by
+		 * the __(pte|pmd|pud)_free_tlb() functions, so leaf TLBI is
+		 * sufficient here.
+		 */
+		__flush_tlb_page_range(&vma, tlb->start, tlb->end);
 	}
 }
 
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 1643908eb5f3..48794ab79cc0 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -87,7 +87,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 		((unsigned long)ASID(vma->vm_mm) << 48);
 
 	dsb(ishst);
-	asm("tlbi	vae1is, %0" : : "r" (addr));
+	asm("tlbi	vale1is, %0" : : "r" (addr));
 	dsb(ish);
 }
 
@@ -97,6 +97,26 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
  */
 #define MAX_TLB_RANGE	(1024UL << PAGE_SHIFT)
 
+static inline void __flush_tlb_page_range(struct vm_area_struct *vma,
+					  unsigned long start, unsigned long end)
+{
+	unsigned long asid = (unsigned long)ASID(vma->vm_mm) << 48;
+	unsigned long addr;
+
+	if ((end - start) > MAX_TLB_RANGE) {
+		flush_tlb_mm(vma->vm_mm);
+		return;
+	}
+
+	start = asid | (start >> 12);
+	end = asid | (end >> 12);
+
+	dsb(ishst);
+	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
+		asm("tlbi vale1is, %0" : : "r"(addr));
+	dsb(ish);
+}
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
