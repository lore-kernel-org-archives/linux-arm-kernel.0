From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Jul 2014 20:09:44 +0100
Subject: [PATCH v7 03/11] arm64: Do not initialise the fixmap page tables in
 head.S
In-Reply-To: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
References: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1405537792-23666-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early_ioremap_init() function already handles fixmap pte
initialisation, so upgrade this to cover all of pud/pmd/pte and remove
one page from swapper_pg_dir.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/page.h |  8 ++++----
 arch/arm64/kernel/head.S      |  7 -------
 arch/arm64/mm/ioremap.c       | 26 ++++++++++++++++++--------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index a6331e6a92b5..d3515bce4077 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -33,11 +33,11 @@
 
 /*
  * The idmap and swapper page tables need some space reserved in the kernel
- * image. The idmap only requires a pgd and a next level table to (section) map
- * the kernel, while the swapper also maps the FDT and requires an additional
- * table to map an early UART. See __create_page_tables for more information.
+ * image. Both require a pgd and a next level table to (section) map the
+ * kernel. The the swapper also maaps the FDT (see __create_page_tables for
+ * more information).
  */
-#define SWAPPER_DIR_SIZE	(3 * PAGE_SIZE)
+#define SWAPPER_DIR_SIZE	(2 * PAGE_SIZE)
 #define IDMAP_DIR_SIZE		(2 * PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 69dafe9621fd..fa3b7fb8a77a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -583,13 +583,6 @@ __create_page_tables:
 	create_block_map x0, x7, x3, x5, x6
 1:
 	/*
-	 * Create the pgd entry for the fixed mappings.
-	 */
-	ldr	x5, =FIXADDR_TOP		// Fixed mapping virtual address
-	add	x0, x26, #2 * PAGE_SIZE		// section table address
-	create_pgd_entry x26, x0, x5, x6, x7
-
-	/*
 	 * Since the page tables have been populated with non-cacheable
 	 * accesses (MMU disabled), invalidate the idmap and swapper page
 	 * tables again to remove any speculatively loaded cache lines.
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 7ec328392ae0..69000efa015e 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -103,19 +103,25 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
 }
 EXPORT_SYMBOL(ioremap_cache);
 
-#ifndef CONFIG_ARM64_64K_PAGES
 static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
+#ifndef CONFIG_ARM64_64K_PAGES
+static pte_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
 
-static inline pmd_t * __init early_ioremap_pmd(unsigned long addr)
+static inline pud_t * __init early_ioremap_pud(unsigned long addr)
 {
 	pgd_t *pgd;
-	pud_t *pud;
 
 	pgd = pgd_offset_k(addr);
 	BUG_ON(pgd_none(*pgd) || pgd_bad(*pgd));
 
-	pud = pud_offset(pgd, addr);
+	return pud_offset(pgd, addr);
+}
+
+static inline pmd_t * __init early_ioremap_pmd(unsigned long addr)
+{
+	pud_t *pud = early_ioremap_pud(addr);
+
 	BUG_ON(pud_none(*pud) || pud_bad(*pud));
 
 	return pmd_offset(pud, addr);
@@ -132,13 +138,17 @@ static inline pte_t * __init early_ioremap_pte(unsigned long addr)
 
 void __init early_ioremap_init(void)
 {
+	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
+	unsigned long addr = fix_to_virt(FIX_BTMAP_BEGIN);
 
-	pmd = early_ioremap_pmd(fix_to_virt(FIX_BTMAP_BEGIN));
-#ifndef CONFIG_ARM64_64K_PAGES
-	/* need to populate pmd for 4k pagesize only */
+	pgd = pgd_offset_k(addr);
+	pud = pud_offset(pgd, addr);
+	pud_populate(&init_mm, pud, bm_pmd);
+	pmd = pmd_offset(pud, addr);
 	pmd_populate_kernel(&init_mm, pmd, bm_pte);
-#endif
+
 	/*
 	 * The boot-ioremap range spans multiple pmds, for which
 	 * we are not prepared:
