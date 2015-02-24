From: fkan@apm.com (Feng Kan)
Date: Tue, 24 Feb 2015 15:40:21 -0800
Subject: [PATCH] arm64: enable PTE type bit in the mask for pte_modify
Message-ID: <1424821221-16396-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caught during Trinity testing. The pte_modify does not allow
modification for PTE type bit. This cause the test to hang
the system. It is found that the PTE can't transit from an
inaccessible page (b00) to a valid page (b11) because the mask
does not allow it. This happens when a big block of mmaped
memory is set the PROT_NONE, then the a small piece is broken
off and set to PROT_WRITE | PROT_READ cause a huge page split.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a26a574..8255b52 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -462,7 +462,7 @@ static inline pud_t *pud_offset(pgd_t *pgd, unsigned long addr)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE;
+			      PTE_PROT_NONE | PTE_WRITE | PTE_TYPE_MASK;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
-- 
1.9.1
