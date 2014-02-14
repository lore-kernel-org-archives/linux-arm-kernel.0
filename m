From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 14 Feb 2014 16:55:13 +0000
Subject: [RFC PATCH 2/2] arm: mm: Double logical invert for LPAE pte_write(),
 pte_dirty()
In-Reply-To: <1392396913-13570-1-git-send-email-steve.capper@linaro.org>
References: <1392396913-13570-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1392396913-13570-3-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On LPAE, L_PTE_WRITE and L_PTE_DIRTY are in the upper 32-bits.
Unfortunately, results from pte_write() and pte_dirty() are downcast
to 32-bits by core code:
  o gather_stats
  o huge_pte_dirty
  o huge_pte_write
  o make_migration_entry

This patch adds a double logical invert to pte_write() and pte_dirty()
for LPAE to ensure that the lower 32-bits are set if true.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable-2level.h |  2 ++
 arch/arm/include/asm/pgtable-3level.h | 14 ++++++++++++++
 arch/arm/include/asm/pgtable.h        |  2 --
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index ca43b84..7e8ebe7 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -162,6 +162,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define pmd_large(pmd)		(pmd_val(pmd) & 2)
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+#define pte_write(pte)		(pte_val(pte) & L_PTE_WRITE)
+#define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 8a392ef..62efcc5 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -135,6 +135,20 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * On LPAE, L_PTE_WRITE and L_PTE_DIRTY are in the upper 32-bits.
+ * Unfortunately, results from pte_write() and pte_dirty() are downcast
+ * to 32-bits by core code:
+ *  o gather_stats
+ *  o huge_pte_dirty
+ *  o huge_pte_write
+ *  o make_migration_entry
+ *
+ * Double logical invert to make sure lower 32-bits are set if true.
+ */
+#define pte_write(pte)		(!!(pte_val(pte) & L_PTE_WRITE))
+#define pte_dirty(pte)		(!!(pte_val(pte) & L_PTE_DIRTY))
+
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & 2))
 #define pud_present(pud)	(pud_val(pud))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 7a17611..e94a616 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -216,8 +216,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #define pte_none(pte)		(!pte_val(pte))
 #define pte_present(pte)	(pte_val(pte) & L_PTE_PRESENT)
-#define pte_write(pte)		(pte_val(pte) & L_PTE_WRITE)
-#define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
 #define pte_special(pte)	(0)
-- 
1.8.1.4
