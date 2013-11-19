From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 19 Nov 2013 17:35:29 +0000
Subject: [PATCH 3/3] Revert "ARM: mm: correct pte_same behaviour for LPAE."
In-Reply-To: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
References: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1384882529-28104-4-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit dde1b65110353517816bcbc58539463396202244.

We no longer need to override pte_same for LPAE, as we set the NG bit
on huge pte creation.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable-3level.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index d1318e1..7f3fa99 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -179,23 +179,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 		clean_pmd_entry(pmdp);	\
 	} while (0)
 
-/*
- * For 3 levels of paging the PTE_EXT_NG bit will be set for user address ptes
- * that are written to a page table but not for ptes created with mk_pte.
- *
- * In hugetlb_no_page, a new huge pte (new_pte) is generated and passed to
- * hugetlb_cow, where it is compared with an entry in a page table.
- * This comparison test fails erroneously leading ultimately to a memory leak.
- *
- * To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
- * present before running the comparison.
- */
-#define __HAVE_ARCH_PTE_SAME
-#define pte_same(pte_a,pte_b)	((pte_present(pte_a) ? pte_val(pte_a) & ~PTE_EXT_NG	\
-					: pte_val(pte_a))				\
-				== (pte_present(pte_b) ? pte_val(pte_b) & ~PTE_EXT_NG	\
-					: pte_val(pte_b)))
-
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,__pte(pte_val(pte)|(ext)))
 
 #define pte_huge(pte)		(pte_val(pte) && !(pte_val(pte) & PTE_TABLE_BIT))
-- 
1.8.1.4
