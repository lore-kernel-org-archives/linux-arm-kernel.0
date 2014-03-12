From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Mar 2014 13:40:18 +0000
Subject: [RFC PATCH V3 1/6] arm: mm: Introduce special ptes for LPAE
In-Reply-To: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1394631623-17883-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need a mechanism to tag ptes as being special, this indicates that
no attempt should be made to access the underlying struct page *
associated with the pte. This is used by the fast_gup as it has no means
to access VMAs (that also contain this information) locklessly.

The L_PTE_SPECIAL bit is already allocated for LPAE, this patch modifies
pte_special and pte_mkspecial to make use of it, and defines
__HAVE_ARCH_PTE_SPECIAL.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable-2level.h | 2 ++
 arch/arm/include/asm/pgtable-3level.h | 8 ++++++++
 arch/arm/include/asm/pgtable.h        | 3 ---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index dfff709..26d1742 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -181,6 +181,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_addr_end(addr,end) (end)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
+#define pte_special(pte)	(0)
+static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 /*
  * We don't have huge page support for short descriptors, for the moment
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 85c60ad..b286ba9 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -207,6 +207,14 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pte_huge(pte)		(pte_val(pte) && !(pte_val(pte) & PTE_TABLE_BIT))
 #define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
 
+#define pte_special(pte)	(!!(pte_val(pte) & L_PTE_SPECIAL))
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	pte_val(pte) |= L_PTE_SPECIAL;
+	return pte;
+}
+#define	__HAVE_ARCH_PTE_SPECIAL
+
 #define pmd_young(pmd)		(pmd_val(pmd) & PMD_SECT_AF)
 
 #define __HAVE_ARCH_PMD_WRITE
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 5478e5d..664d243 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -222,7 +222,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
-#define pte_special(pte)	(0)
 
 #define pte_valid_user(pte)	\
 	(pte_valid(pte) && (pte_val(pte) & L_PTE_USER) && pte_young(pte))
@@ -260,8 +259,6 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 PTE_BIT_FUNC(mkexec,   &= ~L_PTE_XN);
 PTE_BIT_FUNC(mknexec,   |= L_PTE_XN);
 
-static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER |
-- 
1.8.1.4
