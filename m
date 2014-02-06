From: steve.capper@linaro.org (Steve Capper)
Date: Thu,  6 Feb 2014 14:16:10 +0000
Subject: [PATCH 2/3] arm64: mm: Route pmd thp functions through pte equivalents
In-Reply-To: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1391696171-8922-3-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than have separate hugetlb and transparent huge page pmd
manipulation functions, re-wire our thp functions to simply call the
pte equivalents.

This allows THP to take advantage of the new PTE_WRITE logic introduced
in:
  c2c93e5 arm64: mm: Introduce PTE_WRITE

To represent splitting THPs we use the PTE_SPECIAL bit as this is not
used for pmds.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 67 +++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a3fb1e4..a5d5832 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -228,59 +228,65 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 #define __HAVE_ARCH_PTE_SPECIAL
 
 /*
- * Software PMD bits for THP
- */
-
-#define PMD_SECT_DIRTY		(_AT(pmdval_t, 1) << 55)
-#define PMD_SECT_SPLITTING	(_AT(pmdval_t, 1) << 57)
-
-/*
  * THP definitions.
  */
-#define pmd_young(pmd)		(pmd_val(pmd) & PMD_SECT_AF)
-
 #define __HAVE_ARCH_PMD_WRITE
-#define pmd_write(pmd)		(!(pmd_val(pmd) & PMD_SECT_RDONLY))
+static inline long pmd_write(pmd_t pmd)
+{
+	pte_t pte = __pte(pmd_val(pmd));
+	return pte_write(pte);
+}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
-#define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
+
+static inline long pmd_trans_splitting(pmd_t pmd)
+{
+	pte_t pte = __pte(pmd_val(pmd));
+	return pte_special(pte);
+}
 #endif
 
+static inline long pmd_young(pmd_t pmd)
+{
+	pte_t pte = __pte(pmd_val(pmd));
+	return pte_young(pte);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
-	pmd_val(pmd) |= PMD_SECT_RDONLY;
-	return pmd;
+	pte_t pte = pte_wrprotect(__pte(pmd_val(pmd)));
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~PMD_SECT_AF;
-	return pmd;
+	pte_t pte = pte_mkold(__pte(pmd_val(pmd)));
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mksplitting(pmd_t pmd)
 {
-	pmd_val(pmd) |= PMD_SECT_SPLITTING;
-	return pmd;
+	pte_t pte = pte_mkspecial(__pte(pmd_val(pmd)));
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mkwrite(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~PMD_SECT_RDONLY;
-	return pmd;
+	pte_t pte = pte_mkwrite(__pte(pmd_val(pmd)));
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	pmd_val(pmd) |= PMD_SECT_DIRTY;
-	return pmd;
+	pte_t pte = pte_mkdirty(__pte(pmd_val(pmd)));
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mkyoung(pmd_t pmd)
 {
-	pmd_val(pmd) |= PMD_SECT_AF;
-	return pmd;
+	pte_t pte = pte_mkyoung(__pte(pmd_val(pmd)));
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
@@ -297,15 +303,6 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 
 #define pmd_page(pmd)           pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
-static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
-{
-	const pmdval_t mask = PMD_SECT_USER | PMD_SECT_PXN | PMD_SECT_UXN |
-			      PMD_SECT_RDONLY | PMD_SECT_PROT_NONE |
-			      PMD_SECT_VALID;
-	pmd_val(pmd) = (pmd_val(pmd) & ~mask) | (pgprot_val(newprot) & mask);
-	return pmd;
-}
-
 #define set_pmd_at(mm, addr, pmdp, pmd)	set_pmd(pmdp, pmd)
 
 static inline int has_transparent_hugepage(void)
@@ -414,6 +411,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	return pte;
 }
 
+static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+	pte_t pte = pte_modify(__pte(pmd_val(pmd)), newprot);
+	return __pmd(pte_val(pte));
+}
+
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 
-- 
1.8.1.4
