From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 13 Dec 2013 19:05:46 +0000
Subject: [RFC PATCH 6/6] arm: mm: Add Transparent HugePage support for non-LPAE
In-Reply-To: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
References: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1386961546-10061-7-git-send-email-steve.capper@linaro.org>
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
 arch/arm/include/asm/pgtable-2level.h | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable-3level.h |  1 +
 arch/arm/include/asm/pgtable.h        |  2 --
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2eeee73..f17f5c92 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1788,7 +1788,7 @@ config SYS_SUPPORTS_HUGETLBFS
 
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
        def_bool y
-       depends on ARM_LPAE
+       depends on SYS_SUPPORTS_HUGETLBFS
 
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 95ed36e..f7c2599 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -211,6 +211,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
  */
 #define PMD_DSECT_DIRTY		(_AT(pmdval_t, 1) << 5)
 #define PMD_DSECT_AF		(_AT(pmdval_t, 1) << 6)
+#define PMD_DSECT_SPLITTING	(_AT(pmdval_t, 1) << 7)
 
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
@@ -234,12 +235,25 @@ extern pgprot_t get_huge_pgprot(pgprot_t newprot);
 
 #define pfn_pmd(pfn,prot) __pmd(__pfn_to_phys(pfn) | pgprot_val(prot));
 #define mk_pmd(page,prot) pfn_pmd(page_to_pfn(page),get_huge_pgprot(prot));
+#define pmd_mkhuge(pmd)	(pmd)
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define pmd_trans_splitting(pmd)       (pmd_val(pmd) & PMD_DSECT_SPLITTING)
+#define pmd_trans_huge(pmd)            (pmd_large(pmd))
+#else
+static inline int pmd_trans_huge(pmd_t pmd);
+#endif
+
+#define pmd_mknotpresent(pmd)  (__pmd(0))
 
 PMD_BIT_FUNC(mkdirty, |= PMD_DSECT_DIRTY);
 PMD_BIT_FUNC(mkwrite, |= PMD_SECT_AP_WRITE);
 PMD_BIT_FUNC(wrprotect,	&= ~PMD_SECT_AP_WRITE);
 PMD_BIT_FUNC(mknexec,	|= PMD_SECT_XN);
 PMD_BIT_FUNC(rmprotnone, |= PMD_TYPE_SECT);
+PMD_BIT_FUNC(mkold, &= ~PMD_DSECT_AF);
+PMD_BIT_FUNC(mksplitting, |= PMD_DSECT_SPLITTING);
+PMD_BIT_FUNC(mkyoung, |= PMD_DSECT_AF);
 
 #define pmd_young(pmd)			(pmd_val(pmd) & PMD_DSECT_AF)
 #define pmd_write(pmd)			(pmd_val(pmd) & PMD_SECT_AP_WRITE)
@@ -281,6 +295,26 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return pmd;
 }
 
+static inline int has_transparent_hugepage(void)
+{
+	return 1;
+}
+
+
+static inline struct page *pmd_page(pmd_t pmd)
+{
+	/*
+	* for a section, we need to mask off more of the pmd
+	* before looking up the page as it is a section descriptor.
+	*
+	* pmd_page only gets sections from the thp code.
+	*/
+	if (pmd_trans_huge(pmd))
+		return (phys_to_page(pmd_val(pmd) & HPAGE_MASK));
+
+	return phys_to_page(pmd_val(pmd) & PHYS_MASK);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 520a875..4a3a256 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -215,6 +215,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
+#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9bd4046..361ca7c 100644
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
