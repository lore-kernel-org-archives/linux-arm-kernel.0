From: bill4carson@gmail.com (bill4carson at gmail.com)
Date: Mon, 30 Jan 2012 15:57:13 +0800
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bill Carson <bill4carson@gmail.com>

    - Add L_PTE_huge page to mark huge page
    - Modify pte_pfn for hugetlb
    - Add set_hugepte_at for hugetlb arm high levle hooks use

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/include/asm/pgtable-2level.h |    8 ++++++++
 arch/arm/include/asm/pgtable.h        |   28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 2317a71..062c93c 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -123,6 +123,11 @@
 #define L_PTE_USER		(_AT(pteval_t, 1) << 8)
 #define L_PTE_XN		(_AT(pteval_t, 1) << 9)
 #define L_PTE_SHARED		(_AT(pteval_t, 1) << 10)	/* shared(v6), coherent(xsc3) */
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+#define L_PTE_HUGEPAGE	(_AT(pteval_t, 1) << 11) /* mark hugepage */
+#define L_PTE_HPAGE_2M  (_AT(pteval_t, 1) << 12) /* only when HUGEPAGE set */
+#define L_PTE_HPAGE_16M (_AT(pteval_t, 1) << 13) /* only when HUGEPAGE set */
+#endif
 
 /*
  * These are the memory types, defined to be compatible with
@@ -178,6 +183,9 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_addr_end(addr,end) (end)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+#define set_hugepte_ext(ptep,pte,ext) cpu_set_hugepte_ext(ptep,pte,ext)
+#endif
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index f66626d..da875d8 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -187,7 +187,21 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_offset_map(pmd,addr)	(__pte_map(pmd) + pte_index(addr))
 #define pte_unmap(pte)			__pte_unmap(pte)
 
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+
+#ifdef CONFIG_HUGEPAGE_SIZE_2MB
+#define hugepte_pfn(pte)    ((pte_val(pte) & SECTION_MASK) >> PAGE_SHIFT)
+#endif
+#ifdef CONFIG_HUGEPAGE_SIZE_16MB
+#define hugepte_pfn(pte)    ((pte_val(pte) & SUPERSECTION_MASK) >> PAGE_SHIFT)
+#endif
+#define pte_is_huge(pte)	(pte_val(pte) & L_PTE_HUGEPAGE)
+#define pte_pfn(pte)	    (pte_is_huge(pte) ? \
+				hugepte_pfn(pte) : ((pte_val(pte) & PHYS_MASK) >> PAGE_SHIFT))
+#else
 #define pte_pfn(pte)		((pte_val(pte) & PHYS_MASK) >> PAGE_SHIFT)
+#endif /*!CONFIG_ARM_HUGETLB_SUPPORT*/
+
 #define pfn_pte(pfn,prot)	__pte(__pfn_to_phys(pfn) | pgprot_val(prot))
 
 #define pte_page(pte)		pfn_to_page(pte_pfn(pte))
@@ -213,6 +227,14 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 		set_pte_ext(ptep, pteval, PTE_EXT_NG);
 	}
 }
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+static inline void set_hugepte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	__sync_icache_dcache(pteval);
+	set_hugepte_ext(ptep, pteval, PTE_EXT_NG);
+}
+#endif
 
 #define pte_none(pte)		(!pte_val(pte))
 #define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
@@ -235,6 +257,12 @@ PTE_BIT_FUNC(mkclean,   &= ~L_PTE_DIRTY);
 PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
 PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
+#ifdef CONFIG_HUGEPAGE_SIZE_2MB
+PTE_BIT_FUNC(mkhuge,    |= L_PTE_HUGEPAGE | L_PTE_HPAGE_2M);
+#endif
+#ifdef CONFIG_HUGEPAGE_SIZE_16MB
+PTE_BIT_FUNC(mkhuge,    |= L_PTE_HUGEPAGE | L_PTE_HPAGE_16M);
+#endif
 
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
-- 
1.7.1
