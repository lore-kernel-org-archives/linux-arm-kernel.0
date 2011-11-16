From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Nov 2011 10:38:10 +0000
Subject: [PATCH] ARM: Add TLB flushing for both entries in a PMD
Message-ID: <20111116103810.12733.23637.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux uses two PMD entries for a PTE with the classic page table format,
covering 2MB range. However, the __pte_free_tlb() function only adds a
single TLB flush corresponding to 1MB range covering 'addr'. On
Cortex-A15, level 1 entries can be cached by the TLB independently of
the level 2 entries and without additional flushing a PMD entry would be
left pointing at the wrong PTE. The patch limits the TLB flushing range
to two 4KB pages around the 1MB boundary within PMD.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/tlb.h |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 265f908..0504364 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -198,7 +198,15 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	unsigned long addr)
 {
 	pgtable_page_dtor(pte);
-	tlb_add_flush(tlb, addr);
+
+	/*
+	 * With the classic ARM MMU, a pte page has two corresponding pmd
+	 * entries, each covering 1MB.
+	 */
+	addr &= PMD_MASK;
+	tlb_add_flush(tlb, addr + SZ_1M - PAGE_SIZE);
+	tlb_add_flush(tlb, addr + SZ_1M);
+
 	tlb_remove_page(tlb, pte);
 }
 
