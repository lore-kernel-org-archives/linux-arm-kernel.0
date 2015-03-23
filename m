From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Mar 2015 16:36:54 +0100
Subject: [PATCH 2/4] arm64: fixmap: move translation tables to dedicated region
In-Reply-To: <1427125016-3873-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427125016-3873-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427125016-3873-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the fixmap translation tables to a dedicated region
in the linker map. This is needed for a split kernel text from
the linear mapping, to ensure that the contents of the tables
rely on a single translation regime.

Also make the population of the translation levels conditional,
so that the kernel text can share some levels of translation if
needed.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/linkage.h |  2 ++
 arch/arm64/kernel/vmlinux.lds.S  | 15 ++++++++++-----
 arch/arm64/mm/mmu.c              | 15 +++++++++------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index 636c1bced7d4..dc9354de6f52 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -4,4 +4,6 @@
 #define __ALIGN		.align 4
 #define __ALIGN_STR	".align 4"
 
+#define __pgdir		__attribute__((__section__(".pgdir")))
+
 #endif
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 434ef407ef0f..d3885043f0b7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -149,11 +149,16 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
-	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
+	.pgdir : {
+		. = ALIGN(PAGE_SIZE);
+		__pgdir_start = .;
+		idmap_pg_dir = .;
+		. += IDMAP_DIR_SIZE;
+		*(.pgdir)
+		swapper_pg_dir = .;
+		. += SWAPPER_DIR_SIZE;
+		__pgdir_stop = .;
+	}
 
 	_end = .;
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 43496748e3d9..bb3ce41130f3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -549,12 +549,12 @@ void vmemmap_free(unsigned long start, unsigned long end)
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
 
-static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
+static pte_t bm_pte[PTRS_PER_PTE] __pgdir;
 #if CONFIG_ARM64_PGTABLE_LEVELS > 2
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __pgdir;
 #endif
 #if CONFIG_ARM64_PGTABLE_LEVELS > 3
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
+static pud_t bm_pud[PTRS_PER_PUD] __pgdir;
 #endif
 
 static inline pud_t * fixmap_pud(unsigned long addr)
@@ -592,11 +592,14 @@ void __init early_fixmap_init(void)
 	unsigned long addr = FIXADDR_START;
 
 	pgd = pgd_offset_k(addr);
-	pgd_populate(&init_mm, pgd, bm_pud);
+	if (pgd_none(*pgd))
+		pgd_populate(&init_mm, pgd, bm_pud);
 	pud = pud_offset(pgd, addr);
-	pud_populate(&init_mm, pud, bm_pmd);
+	if (pud_none(*pud))
+		pud_populate(&init_mm, pud, bm_pmd);
 	pmd = pmd_offset(pud, addr);
-	pmd_populate_kernel(&init_mm, pmd, bm_pte);
+	if (pmd_none(*pmd))
+		pmd_populate_kernel(&init_mm, pmd, bm_pte);
 
 	/*
 	 * The boot-ioremap range spans multiple pmds, for which
-- 
1.8.3.2
