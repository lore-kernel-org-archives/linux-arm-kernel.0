From: yaojun8558363@gmail.com (Jun Yao)
Date: Wed, 22 Aug 2018 17:54:29 +0800
Subject: [RESEND PATCH v4 3/6] arm64/mm: Create the initial page table in the
 init_pg_dir.
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
Message-ID: <20180822095432.12125-4-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create the initial page table in the init_pg_dir. And before
calling kasan_early_init(), we update the init_mm.pgd by
introducing set_init_mm_pgd(). This will ensure that pgd_offset_k()
works correctly. When the final page table is created, we redirect
the init_mm.pgd to the swapper_pg_dir.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h |  2 ++
 arch/arm64/kernel/head.S         |  9 ++++++---
 arch/arm64/mm/mmu.c              | 14 ++++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

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
index 65f86271f02b..f7e544f6f3eb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -623,6 +623,19 @@ static void __init map_kernel(pgd_t *pgdp)
 	kasan_copy_shadow(pgdp);
 }
 
+/*
+ * set_init_mm_pgd() just updates init_mm.pgd. The purpose of using
+ * assembly is to prevent KASAN instrumentation, as KASAN has not
+ * been initialized when this function is called.
+ */
+void __init set_init_mm_pgd(pgd_t *pgd)
+{
+	pgd_t **addr = &(init_mm.pgd);
+
+	asm volatile("str %x0, [%1]\n"
+			: : "r" (pgd), "r" (addr) : "memory");
+}
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps and sets up the zero page.
@@ -646,6 +659,7 @@ void __init paging_init(void)
 	cpu_replace_ttbr1(__va(pgd_phys));
 	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	set_init_mm_pgd(swapper_pg_dir);
 
 	pgd_clear_fixmap();
 	memblock_free(pgd_phys, PAGE_SIZE);
-- 
2.17.1
