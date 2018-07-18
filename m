From: yaojun8558363@gmail.com (Jun Yao)
Date: Wed, 18 Jul 2018 18:17:24 +0800
Subject: [RESEND PATCH v4 3/6] arm64/mm: Create initial page tables in
In-Reply-To: <20180718101727.10787-1-yaojun8558363@gmail.com>
References: <20180718101727.10787-1-yaojun8558363@gmail.com>
Message-ID: <20180718101727.10787-4-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create initial page tables in init_pg_dir and then create final
page tables in swapper_pg_dir directly.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h |  2 ++
 arch/arm64/kernel/head.S         |  9 ++++++---
 arch/arm64/mm/mmu.c              | 27 ++++++++-------------------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1bdeca8918a6..46ef21ebfe47 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -712,6 +712,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+extern pgd_t init_pg_dir[PTRS_PER_PGD];
+extern pgd_t init_pg_end[];
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c3e4b1886cde..ede2e964592b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -376,7 +376,7 @@ __create_page_tables:
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
-	adrp	x0, swapper_pg_dir
+	adrp	x0, init_pg_dir
 	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
 	mov	x4, PTRS_PER_PGD
@@ -402,7 +402,6 @@ __create_page_tables:
 	adrp	x1, init_pg_end
 	sub	x1, x1, x0
 	bl	__inval_dcache_area
-
 	ret	x28
 ENDPROC(__create_page_tables)
 	.ltorg
@@ -439,6 +438,9 @@ __primary_switched:
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+	adrp	x0, init_pg_dir
+	bl	set_init_mm_pgd
+
 #ifdef CONFIG_KASAN
 	bl	kasan_early_init
 #endif
@@ -833,8 +835,9 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
-	adrp	x1, swapper_pg_dir
+	adrp	x1, init_pg_dir
 	bl	__enable_mmu
+
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
 #ifdef CONFIG_RANDOMIZE_BASE
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 65f86271f02b..088a591e4ea4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -629,26 +629,10 @@ static void __init map_kernel(pgd_t *pgdp)
  */
 void __init paging_init(void)
 {
-	phys_addr_t pgd_phys = early_pgtable_alloc();
-	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
-
-	map_kernel(pgdp);
-	map_mem(pgdp);
-
-	/*
-	 * We want to reuse the original swapper_pg_dir so we don't have to
-	 * communicate the new address to non-coherent secondaries in
-	 * secondary_entry, and so cpu_switch_mm can generate the address with
-	 * adrp+add rather than a load from some global variable.
-	 *
-	 * To do this we need to go via a temporary pgd.
-	 */
-	cpu_replace_ttbr1(__va(pgd_phys));
-	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
+	map_kernel(swapper_pg_dir);
+	map_mem(swapper_pg_dir);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
-
-	pgd_clear_fixmap();
-	memblock_free(pgd_phys, PAGE_SIZE);
+	init_mm.pgd = swapper_pg_dir;
 
 	/*
 	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
@@ -659,6 +643,11 @@ void __init paging_init(void)
 		      - PAGE_SIZE);
 }
 
+void __init set_init_mm_pgd(pgd_t *pgd)
+{
+	init_mm.pgd = pgd;
+}
+
 /*
  * Check whether a kernel address is valid (derived from arch/x86/).
  */
-- 
2.17.1
