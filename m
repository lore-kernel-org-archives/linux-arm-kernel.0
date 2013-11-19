From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 19 Nov 2013 17:35:28 +0000
Subject: [PATCH 2/3] ARM: mm: Make LPAE huge page ptes NG by default
In-Reply-To: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
References: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1384882529-28104-3-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now don't set the NG bit as we write the huge page entry, so set it
on huge page entry creation. This simplifies code, and obviates the
need for us to override pte_same.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable-3level.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 5689c18..d1318e1 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -199,7 +199,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,__pte(pte_val(pte)|(ext)))
 
 #define pte_huge(pte)		(pte_val(pte) && !(pte_val(pte) & PTE_TABLE_BIT))
-#define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
+#define pte_mkhuge(pte)		(__pte((pte_val(pte) & ~PTE_TABLE_BIT) | PTE_EXT_NG))
 
 #define pmd_young(pmd)		(pmd_val(pmd) & PMD_SECT_AF)
 
-- 
1.8.1.4
