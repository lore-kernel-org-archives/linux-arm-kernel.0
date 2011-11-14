From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Nov 2011 16:23:39 +0000
Subject: [PATCH v9 03/15] ARM: LPAE: Move page table maintenance macros to
 pgtable-2level.h
In-Reply-To: <1321287831-24560-1-git-send-email-catalin.marinas@arm.com>
References: <1321287831-24560-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1321287831-24560-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The page table maintenance macros need to be duplicated between the
classic and the LPAE MMU so this patch moves those that are not common
to the pgtable-2level.h file.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h |   41 +++++++++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable.h        |   38 ------------------------------
 2 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 470457e..2317a71 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -140,4 +140,45 @@
 #define L_PTE_MT_DEV_CACHED	(_AT(pteval_t, 0x0b) << 2)	/* 1011 */
 #define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
 
+#ifndef __ASSEMBLY__
+
+/*
+ * The "pud_xxx()" functions here are trivial when the pmd is folded into
+ * the pud: the pud entry is never bad, always exists, and can't be set or
+ * cleared.
+ */
+#define pud_none(pud)		(0)
+#define pud_bad(pud)		(0)
+#define pud_present(pud)	(1)
+#define pud_clear(pudp)		do { } while (0)
+#define set_pud(pud,pudp)	do { } while (0)
+
+static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
+{
+	return (pmd_t *)pud;
+}
+
+#define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+
+#define copy_pmd(pmdpd,pmdps)		\
+	do {				\
+		pmdpd[0] = pmdps[0];	\
+		pmdpd[1] = pmdps[1];	\
+		flush_pmd_entry(pmdpd);	\
+	} while (0)
+
+#define pmd_clear(pmdp)			\
+	do {				\
+		pmdp[0] = __pmd(0);	\
+		pmdp[1] = __pmd(0);	\
+		clean_pmd_entry(pmdp);	\
+	} while (0)
+
+/* we don't need complex calculations here as the pmd is folded into the pgd */
+#define pmd_addr_end(addr,end) (end)
+
+#define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a1aca79..44b9247 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -164,41 +164,8 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
-/*
- * The "pud_xxx()" functions here are trivial when the pmd is folded into
- * the pud: the pud entry is never bad, always exists, and can't be set or
- * cleared.
- */
-#define pud_none(pud)		(0)
-#define pud_bad(pud)		(0)
-#define pud_present(pud)	(1)
-#define pud_clear(pudp)		do { } while (0)
-#define set_pud(pud,pudp)	do { } while (0)
-
-
-/* Find an entry in the second-level page table.. */
-static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
-{
-	return (pmd_t *)pud;
-}
-
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
-#define pmd_bad(pmd)		(pmd_val(pmd) & 2)
-
-#define copy_pmd(pmdpd,pmdps)		\
-	do {				\
-		pmdpd[0] = pmdps[0];	\
-		pmdpd[1] = pmdps[1];	\
-		flush_pmd_entry(pmdpd);	\
-	} while (0)
-
-#define pmd_clear(pmdp)			\
-	do {				\
-		pmdp[0] = __pmd(0);	\
-		pmdp[1] = __pmd(0);	\
-		clean_pmd_entry(pmdp);	\
-	} while (0)
 
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
@@ -207,10 +174,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
-/* we don't need complex calculations here as the pmd is folded into the pgd */
-#define pmd_addr_end(addr,end)	(end)
-
-
 #ifndef CONFIG_HIGHPTE
 #define __pte_map(pmd)		pmd_page_vaddr(*(pmd))
 #define __pte_unmap(pte)	do { } while (0)
@@ -232,7 +195,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_page(pte)		pfn_to_page(pte_pfn(pte))
 #define mk_pte(page,prot)	pfn_pte(page_to_pfn(page), prot)
 
-#define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 #define pte_clear(mm,addr,ptep)	set_pte_ext(ptep, __pte(0), 0)
 
 #if __LINUX_ARM_ARCH__ < 6
