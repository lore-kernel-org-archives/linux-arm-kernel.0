From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 25 Jul 2013 17:26:35 +0100
Subject: [RFC 2/2] ARM: mm: Transparent huge page support for non-LPAE systems.
Message-ID: <1374769595-16043-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Much of the required code for THP has been implemented in the
earlier non-LPAE HugeTLB patch.

One more domain bit is used (to store whether or not the THP is
splitting).

Some THP helper functions are defined; and we have to re-define
pmd_page such that it distinguishes between page tables and
sections.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/Kconfig                      |  2 +-
 arch/arm/include/asm/pgtable-2level.h | 47 +++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable-3level.h |  1 +
 arch/arm/include/asm/pgtable.h        |  2 --
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe6eeae..6b53969 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1755,7 +1755,7 @@ config SYS_SUPPORTS_HUGETLBFS
 
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
        def_bool y
-       depends on ARM_LPAE
+       depends on SYS_SUPPORTS_HUGETLBFS
 
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 29ace75..a48eddc 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -217,6 +217,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define PMD_DSECT_PROT_NONE	(_AT(pmdval_t, 1) << 5)
 #define PMD_DSECT_DIRTY		(_AT(pmdval_t, 1) << 6)
 #define PMD_DSECT_AF		(_AT(pmdval_t, 1) << 7)
+#define PMD_DSECT_SPLITTING	(_AT(pmdval_t, 1) << 8)
 
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
@@ -304,6 +305,52 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	pmdret;									\
 })
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define pmd_trans_splitting(pmd)	(pmd_val(pmd) & PMD_DSECT_SPLITTING)
+#define pmd_trans_huge(pmd)		(pmd_large(pmd))
+#else
+static inline int pmd_trans_huge(pmd_t pmd);
+#endif
+
+PMD_BIT_FUNC(mksplitting, |= PMD_DSECT_SPLITTING);
+#define pmd_mkhuge(pmd)		(__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))
+
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+	/*
+	 * for a section, we need to mask off more of the pmd
+	 * before looking up the pfn.
+	 *
+	 * pmd_pfn only gets sections from the thp code.
+	 */
+	if (pmd_trans_huge(pmd))
+		return __phys_to_pfn(pmd_val(pmd) & HPAGE_MASK);
+	else
+		return __phys_to_pfn(pmd_val(pmd) & PHYS_MASK);
+}
+
+#define pfn_pmd(pfn,prot) pmd_modify(__pmd(__pfn_to_phys(pfn)),prot);
+#define mk_pmd(page,prot) pfn_pmd(page_to_pfn(page),prot);
+
+static inline int has_transparent_hugepage(void)
+{
+	return 1;
+}
+
+static inline struct page *pmd_page(pmd_t pmd)
+{
+	/*
+	 * for a section, we need to mask off more of the pmd
+	 * before looking up the page as it is a section descriptor.
+	 *
+	 * pmd_page only gets sections from the thp code.
+	 */
+	if (pmd_trans_huge(pmd))
+		return (phys_to_page(pmd_val(pmd) & HPAGE_MASK));
+
+	return phys_to_page(pmd_val(pmd) & PHYS_MASK);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 67a0e06..9c38f29 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -234,6 +234,7 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 
 /* represent a notpresent pmd by zero, this is used by pmdp_invalidate */
 #define pmd_mknotpresent(pmd)	(__pmd(0))
+#define pmd_page(pmd)           pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index cf77a59..66a1417 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -189,8 +189,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 	return __va(pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK);
 }
 
-#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
-
 #ifndef CONFIG_HIGHPTE
 #define __pte_map(pmd)		pmd_page_vaddr(*(pmd))
 #define __pte_unmap(pte)	do { } while (0)
-- 
1.8.1.4
