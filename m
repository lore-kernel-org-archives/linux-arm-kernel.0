From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon,  7 Nov 2011 16:16:52 +0000
Subject: [PATCH v8 10/16] ARM: LPAE: Invalidate the TLB before freeing the PMD
In-Reply-To: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1320682618-1182-11-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to the PTE freeing, this patch introduced __pmd_free_tlb() which
invalidates the TLB before freeing a PMD page. This is needed because on
newer processors the entry in the upper page table may be cached by the
TLB and point to random data after the PMD has been freed.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/tlb.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b509e44..5d3ed7e3 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -202,8 +202,17 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	tlb_remove_page(tlb, pte);
 }
 
+static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
+				  unsigned long addr)
+{
+#ifdef CONFIG_ARM_LPAE
+	tlb_add_flush(tlb, addr);
+	tlb_remove_page(tlb, virt_to_page(pmdp));
+#endif
+}
+
 #define pte_free_tlb(tlb, ptep, addr)	__pte_free_tlb(tlb, ptep, addr)
-#define pmd_free_tlb(tlb, pmdp, addr)	pmd_free((tlb)->mm, pmdp)
+#define pmd_free_tlb(tlb, pmdp, addr)	__pmd_free_tlb(tlb, pmdp, addr)
 #define pud_free_tlb(tlb, pudp, addr)	pud_free((tlb)->mm, pudp)
 
 #define tlb_migrate_finish(mm)		do { } while (0)
