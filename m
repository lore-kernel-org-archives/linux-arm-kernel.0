From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:45 +0100
Subject: [RFC PATCH 10/11] arm64: tlb: Adjust stride and type of TLBI
 according to mmu_gather
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535125966-7666-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core mmu_gather code keeps track of both the levels of page
table cleared and also whether or not these entries correspond to
intermediate entries, we can use this in our tlb_flush() callback to
reduce the number of invalidations we issue as well as their scope.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index bd00017d529a..baca8dff6884 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -34,20 +34,21 @@ static void tlb_flush(struct mmu_gather *tlb);
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
+	bool last_level = !tlb->freed_tables;
+	unsigned long stride = tlb_get_unmap_granule(tlb);
 
 	/*
-	 * The ASID allocator will either invalidate the ASID or mark
-	 * it as used.
+	 * If we're tearing down the address space then we only care about
+	 * invalidating the walk-cache, since the ASID allocator won't
+	 * reallocate our ASID without invalidating the entire TLB.
 	 */
-	if (tlb->fullmm)
+	if (tlb->fullmm) {
+		if (!last_level)
+			flush_tlb_mm(tlb->mm);
 		return;
+	}
 
-	/*
-	 * The intermediate page table levels are already handled by
-	 * the __(pte|pmd|pud)_free_tlb() functions, so last level
-	 * TLBI is sufficient here.
-	 */
-	__flush_tlb_range(&vma, tlb->start, tlb->end, PAGE_SIZE, true);
+	__flush_tlb_range(&vma, tlb->start, tlb->end, stride, last_level);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
-- 
2.1.4
