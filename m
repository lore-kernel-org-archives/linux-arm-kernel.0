From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 23 May 2013 16:31:17 +0100
Subject: [PATCH v2 1/4] ARM: mm: correct pte_same behaviour for LPAE.
In-Reply-To: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
References: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1369323080-9673-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 3 levels of paging the PTE_EXT_NG bit will be set for user
address ptes that are written to a page table but not for ptes
created with mk_pte.

This can cause some comparison tests made by pte_same to fail
spuriously and lead to other problems.

To correct this behaviour, we mask off PTE_EXT_NG for any pte that
is present before running the comparison.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pgtable-3level.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 86b8fe3..70f041c 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -166,6 +166,23 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 		clean_pmd_entry(pmdp);	\
 	} while (0)
 
+/*
+ * For 3 levels of paging the PTE_EXT_NG bit will be set for user address ptes
+ * that are written to a page table but not for ptes created with mk_pte.
+ *
+ * In hugetlb_no_page, a new huge pte (new_pte) is generated and passed to
+ * hugetlb_cow, where it is compared with an entry in a page table.
+ * This comparison test fails erroneously leading ultimately to a memory leak.
+ *
+ * To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
+ * present before running the comparison.
+ */
+#define __HAVE_ARCH_PTE_SAME
+#define pte_same(pte_a,pte_b)	((pte_present(pte_a) ? pte_val(pte_a) & ~PTE_EXT_NG	\
+					: pte_val(pte_a))				\
+				== (pte_present(pte_b) ? pte_val(pte_b) & ~PTE_EXT_NG	\
+					: pte_val(pte_b)))
+
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,__pte(pte_val(pte)|(ext)))
 
 #endif /* __ASSEMBLY__ */
-- 
1.8.1.4
