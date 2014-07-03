From: steve.capper@linaro.org (Steve Capper)
Date: Thu,  3 Jul 2014 13:06:12 +0100
Subject: [PATCH V6 1/2] arm: mm: Introduce {pte, pmd}_isset and {pte,
 pmd}_isclear
In-Reply-To: <1404389173-4246-1-git-send-email-steve.capper@linaro.org>
References: <1404389173-4246-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1404389173-4246-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Long descriptors on ARM are 64 bits, and some pte functions such as
pte_dirty return a bitwise-and of a flag with the pte value. If the
flag to be tested resides in the upper 32 bits of the pte, then we run
into the danger of the result being dropped if downcast.

For example:
	gather_stats(page, md, pte_dirty(*pte), 1);
where pte_dirty(*pte) is downcast to an int.

This patch introduces a new macro pte_isset which performs the bitwise
and, then performs a double logical invert (where needed) to ensure
predictable downcasting. The logical inverse pte_isclear is also
introduced.

Equivalent pmd functions for Transparent HugePages have also been
added.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable-3level.h | 12 ++++++++----
 arch/arm/include/asm/pgtable.h        | 18 +++++++++++-------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 85c60ad..34f371c 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -207,17 +207,21 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pte_huge(pte)		(pte_val(pte) && !(pte_val(pte) & PTE_TABLE_BIT))
 #define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
 
-#define pmd_young(pmd)		(pmd_val(pmd) & PMD_SECT_AF)
+#define pmd_isset(pmd, val)	((u32)(val) == (val) ? pmd_val(pmd) & (val) \
+						: !!(pmd_val(pmd) & (val)))
+#define pmd_isclear(pmd, val)	(!(pmd_val(pmd) & (val)))
+
+#define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
 
 #define __HAVE_ARCH_PMD_WRITE
-#define pmd_write(pmd)		(!(pmd_val(pmd) & PMD_SECT_RDONLY))
+#define pmd_write(pmd)		(pmd_isclear((pmd), PMD_SECT_RDONLY))
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
-#define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
+#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !pmd_table(pmd))
+#define pmd_trans_splitting(pmd) (pmd_isset((pmd), PMD_SECT_SPLITTING))
 #endif
 
 #define PMD_BIT_FUNC(fn,op) \
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 5478e5d..01baef0 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -214,18 +214,22 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #define pte_clear(mm,addr,ptep)	set_pte_ext(ptep, __pte(0), 0)
 
+#define pte_isset(pte, val)	((u32)(val) == (val) ? pte_val(pte) & (val) \
+						: !!(pte_val(pte) & (val)))
+#define pte_isclear(pte, val)	(!(pte_val(pte) & (val)))
+
 #define pte_none(pte)		(!pte_val(pte))
-#define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
-#define pte_valid(pte)		(pte_val(pte) & L_PTE_VALID)
+#define pte_present(pte)	(pte_isset((pte), L_PTE_PRESENT))
+#define pte_valid(pte)		(pte_isset((pte), L_PTE_VALID))
 #define pte_accessible(mm, pte)	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
-#define pte_write(pte)		(!(pte_val(pte) & L_PTE_RDONLY))
-#define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
-#define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
-#define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
+#define pte_write(pte)		(pte_isclear((pte), L_PTE_RDONLY))
+#define pte_dirty(pte)		(pte_isset((pte), L_PTE_DIRTY))
+#define pte_young(pte)		(pte_isset((pte), L_PTE_YOUNG))
+#define pte_exec(pte)		(pte_isclear((pte), L_PTE_XN))
 #define pte_special(pte)	(0)
 
 #define pte_valid_user(pte)	\
-	(pte_valid(pte) && (pte_val(pte) & L_PTE_USER) && pte_young(pte))
+	(pte_valid(pte) && pte_isset((pte), L_PTE_USER) && pte_young(pte))
 
 #if __LINUX_ARM_ARCH__ < 6
 static inline void __sync_icache_dcache(pte_t pteval)
-- 
1.9.3
