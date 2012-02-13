From: bill4carson@gmail.com (Bill Carson)
Date: Mon, 13 Feb 2012 17:44:23 +0800
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1329126268-11032-3-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/include/asm/pgtable-2level.h |    3 +++
 arch/arm/include/asm/pgtable.h        |    9 +++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 2317a71..031c50e 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -178,6 +178,9 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_addr_end(addr,end) (end)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+#define set_hugepte_ext(ptep,pte,ext) cpu_set_hugepte_ext(ptep,pte,ext)
+#endif
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index f66626d..a119ac6 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -213,6 +213,14 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
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
@@ -236,6 +244,7 @@ PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
 PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 
+static inline pte_t pte_mkhuge(pte_t pte) { return pte; }
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-- 
1.7.1
