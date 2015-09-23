From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 22 Sep 2015 17:37:39 -0700
Subject: [PATCH v2 3/7] arm64: split off early mapping code from
 early_fixmap_init()
In-Reply-To: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442968663-31843-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This splits off and generalises the population of the statically
allocated fixmap page tables so that we may reuse it later for
the linear mapping once we move the kernel text mapping out of it.

This also involves taking into account that table entries at any of
the levels we are populating may have been populated already, since
the fixmap mapping might not be disjoint up to the pgd level anymore
from other early mappings.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/compiler.h |  2 +
 arch/arm64/kernel/vmlinux.lds.S   | 12 ++--
 arch/arm64/mm/mmu.c               | 60 ++++++++++++++------
 3 files changed, 51 insertions(+), 23 deletions(-)

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
index 98073332e2d0..ceec4def354b 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -160,11 +160,13 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
-	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
+	.pgdir (NOLOAD) : ALIGN(PAGE_SIZE) {
+		idmap_pg_dir = .;
+		. += IDMAP_DIR_SIZE;
+		swapper_pg_dir = .;
+		. += SWAPPER_DIR_SIZE;
+		*(.pgdir)
+	}
 
 	_end = .;
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9211b8527f25..5af804334697 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -342,6 +342,44 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
 }
 #endif
 
+struct bootstrap_pgtables {
+	pte_t	pte[PTRS_PER_PTE];
+	pmd_t	pmd[PTRS_PER_PMD > 1 ? PTRS_PER_PMD : 0];
+	pud_t	pud[PTRS_PER_PUD > 1 ? PTRS_PER_PUD : 0];
+};
+
+static void __init bootstrap_early_mapping(unsigned long addr,
+					   struct bootstrap_pgtables *reg,
+					   bool pte_level)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd)) {
+		clear_page(reg->pud);
+		memblock_reserve(__pa(reg->pud), PAGE_SIZE);
+		pgd_populate(&init_mm, pgd, reg->pud);
+	}
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud)) {
+		clear_page(reg->pmd);
+		memblock_reserve(__pa(reg->pmd), PAGE_SIZE);
+		pud_populate(&init_mm, pud, reg->pmd);
+	}
+
+	if (!pte_level)
+		return;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd)) {
+		clear_page(reg->pte);
+		memblock_reserve(__pa(reg->pte), PAGE_SIZE);
+		pmd_populate_kernel(&init_mm, pmd, reg->pte);
+	}
+}
+
 static void __init map_mem(void)
 {
 	struct memblock_region *reg;
@@ -544,14 +582,6 @@ void vmemmap_free(unsigned long start, unsigned long end)
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
 
-static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
-#if CONFIG_PGTABLE_LEVELS > 2
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
-#endif
-#if CONFIG_PGTABLE_LEVELS > 3
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
-#endif
-
 static inline pud_t * fixmap_pud(unsigned long addr)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
@@ -581,21 +611,15 @@ static inline pte_t * fixmap_pte(unsigned long addr)
 
 void __init early_fixmap_init(void)
 {
-	pgd_t *pgd;
-	pud_t *pud;
+	static struct bootstrap_pgtables fixmap_bs_pgtables __pgdir;
 	pmd_t *pmd;
-	unsigned long addr = FIXADDR_START;
 
-	pgd = pgd_offset_k(addr);
-	pgd_populate(&init_mm, pgd, bm_pud);
-	pud = pud_offset(pgd, addr);
-	pud_populate(&init_mm, pud, bm_pmd);
-	pmd = pmd_offset(pud, addr);
-	pmd_populate_kernel(&init_mm, pmd, bm_pte);
+	bootstrap_early_mapping(FIXADDR_START, &fixmap_bs_pgtables, true);
+	pmd = fixmap_pmd(FIXADDR_START);
 
 	/*
 	 * The boot-ioremap range spans multiple pmds, for which
-	 * we are not preparted:
+	 * we are not prepared:
 	 */
 	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
 		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
-- 
1.9.1
