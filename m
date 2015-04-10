From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 15:53:51 +0200
Subject: [PATCH v3 07/11] arm64: fixmap: allow init before linear mapping is
 set up
In-Reply-To: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1428674035-26603-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reworks early_ioremap_init() so it populates the various levels
of translation tables while taking the following into account:
- be prepared for any of the levels to have been populated already, as
  this may be the case once we move the kernel text mapping out of the
  linear mapping;
- don't rely on __va() to translate the physical address in a page table
  entry to a virtual address, since this produces linear mapping addresses;
  instead, use the fact that at any level, we know exactly which page in
  swapper_pg_dir an entry could be pointing to if it points anywhere.

This allows us to defer the initialization of the linear mapping until
after we have figured out where our RAM resides in the physical address
space.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/compiler.h |   2 +
 arch/arm64/kernel/vmlinux.lds.S   |  14 +++--
 arch/arm64/mm/mmu.c               | 117 +++++++++++++++++++++++++-------------
 3 files changed, 90 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index ee35fd0f2236..dd342af63673 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -27,4 +27,6 @@
  */
 #define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
 
+#define __pgdir		__attribute__((section(".pgdir"),aligned(PAGE_SIZE)))
+
 #endif	/* __ASM_COMPILER_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 98073332e2d0..604f285d3832 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -160,11 +160,15 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
-	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
+	.pgdir (NOLOAD) : {
+		. = ALIGN(PAGE_SIZE);
+		idmap_pg_dir = .;
+		. += IDMAP_DIR_SIZE;
+		swapper_pg_dir = .;
+		__swapper_bs_region = . + PAGE_SIZE;
+		. += SWAPPER_DIR_SIZE;
+		*(.pgdir)
+	}
 
 	_end = .;
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 60be58a160a2..c0427b5c90c7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -341,6 +341,70 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
 }
 #endif
 
+struct mem_bootstrap_region {
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
+	pud_t	pud[PTRS_PER_PUD];
+#endif
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
+	pmd_t	pmd[PTRS_PER_PMD];
+#endif
+	pte_t	pte[PTRS_PER_PTE];
+};
+
+static void __init bootstrap_mem_region(unsigned long addr,
+					struct mem_bootstrap_region *reg,
+					pmd_t **ppmd, pte_t **ppte)
+{
+	/*
+	 * Avoid using the linear phys-to-virt translation __va() so that we
+	 * can use this code before the linear mapping is set up. Note that
+	 * any populated entries at any level can only point into swapper_pg_dir
+	 * since no other translation table pages have been allocated yet.
+	 * So at each level, we either need to populate it, or it has already
+	 * been populated by a swapper_pg_dir table at the same level, in which
+	 * case we can figure out its virtual address without applying __va()
+	 * on the contents of the entry, using the following struct.
+	 */
+	extern struct mem_bootstrap_region __swapper_bs_region;
+
+	pgd_t *pgd = pgd_offset_k(addr);
+	pud_t *pud = (pud_t *)pgd;
+	pmd_t *pmd = (pmd_t *)pud;
+
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
+	if (pgd_none(*pgd)) {
+		clear_page(reg->pud);
+		pgd_populate(&init_mm, pgd, reg->pud);
+		pud = reg->pud;
+	} else {
+		pud = __swapper_bs_region.pud;
+	}
+	pud += pud_index(addr);
+#endif
+
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
+	if (pud_none(*pud)) {
+		clear_page(reg->pmd);
+		pud_populate(&init_mm, pud, reg->pmd);
+		*ppmd = reg->pmd;
+	} else {
+		*ppmd = __swapper_bs_region.pmd;
+	}
+	pmd = *ppmd + pmd_index(addr);
+#endif
+
+	if (!ppte)
+		return;
+
+	if (pmd_none(*pmd)) {
+		clear_page(reg->pte);
+		pmd_populate_kernel(&init_mm, pmd, reg->pte);
+		*ppte = reg->pte;
+	} else {
+		*ppte = __swapper_bs_region.pte;
+	}
+}
+
 static void __init map_mem(void)
 {
 	struct memblock_region *reg;
@@ -554,58 +618,35 @@ void vmemmap_free(unsigned long start, unsigned long end)
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
 
-static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
-#if CONFIG_ARM64_PGTABLE_LEVELS > 2
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
-#endif
-#if CONFIG_ARM64_PGTABLE_LEVELS > 3
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
-#endif
-
-static inline pud_t * fixmap_pud(unsigned long addr)
-{
-	pgd_t *pgd = pgd_offset_k(addr);
-
-	BUG_ON(pgd_none(*pgd) || pgd_bad(*pgd));
-
-	return pud_offset(pgd, addr);
-}
+static pmd_t *fixmap_pmd_dir __initdata = (pmd_t *)swapper_pg_dir;
+static pte_t *fixmap_pte_dir;
 
-static inline pmd_t * fixmap_pmd(unsigned long addr)
+static __always_inline pmd_t *fixmap_pmd(unsigned long addr)
 {
-	pud_t *pud = fixmap_pud(addr);
-
-	BUG_ON(pud_none(*pud) || pud_bad(*pud));
-
-	return pmd_offset(pud, addr);
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
+	return fixmap_pmd_dir + pmd_index(addr);
+#else
+	return fixmap_pmd_dir + pgd_index(addr);
+#endif
 }
 
-static inline pte_t * fixmap_pte(unsigned long addr)
+static inline pte_t *fixmap_pte(unsigned long addr)
 {
-	pmd_t *pmd = fixmap_pmd(addr);
-
-	BUG_ON(pmd_none(*pmd) || pmd_bad(*pmd));
-
-	return pte_offset_kernel(pmd, addr);
+	return fixmap_pte_dir + pte_index(addr);
 }
 
 void __init early_fixmap_init(void)
 {
-	pgd_t *pgd;
-	pud_t *pud;
+	static struct mem_bootstrap_region fixmap_bs_region __pgdir;
 	pmd_t *pmd;
-	unsigned long addr = FIXADDR_START;
 
-	pgd = pgd_offset_k(addr);
-	pgd_populate(&init_mm, pgd, bm_pud);
-	pud = pud_offset(pgd, addr);
-	pud_populate(&init_mm, pud, bm_pmd);
-	pmd = pmd_offset(pud, addr);
-	pmd_populate_kernel(&init_mm, pmd, bm_pte);
+	bootstrap_mem_region(FIXADDR_START, &fixmap_bs_region, &fixmap_pmd_dir,
+			     &fixmap_pte_dir);
+	pmd = fixmap_pmd(FIXADDR_START);
 
 	/*
 	 * The boot-ioremap range spans multiple pmds, for which
-	 * we are not preparted:
+	 * we are not prepared:
 	 */
 	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
 		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
-- 
1.8.3.2
