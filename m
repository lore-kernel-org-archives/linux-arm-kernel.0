From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Aug 2012 18:37:07 +0100
Subject: [PATCH] ARM: mm: only flush both pmd entries for classic MMU
Message-ID: <1345138627-8140-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPAE does not use two pmd entries for a pte, so the additional tlb
flushing is not required.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlb.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 314d466..7dce8a6 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -199,6 +199,9 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	pgtable_page_dtor(pte);
 
+#ifdef CONFIG_ARM_LPAE
+	tlb_add_flush(tlb, addr)
+#else
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
 	 * entries, each covering 1MB.
@@ -206,6 +209,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	addr &= PMD_MASK;
 	tlb_add_flush(tlb, addr + SZ_1M - PAGE_SIZE);
 	tlb_add_flush(tlb, addr + SZ_1M);
+#endif
 
 	tlb_remove_page(tlb, pte);
 }
-- 
1.7.4.1
