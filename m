From: yaojun8558363@gmail.com (Jun Yao)
Date: Mon,  2 Jul 2018 19:16:59 +0800
Subject: [PATCH v3 5/5] arm64/mm: Move {idmap_pg_dir,
 swapper_pg_dir} to .rodata section
In-Reply-To: <20180702111659.25570-1-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
Message-ID: <20180702111659.25570-6-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move {idmap_pg_dir, swapper_pg_dir} to .rodata section and
populate swapper_pg_dir by fixmap.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgalloc.h | 48 ++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h | 15 +++++-----
 arch/arm64/kernel/vmlinux.lds.S  | 22 +++++++++------
 3 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2e05bcd944c8..a0ce7d0f81c5 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -29,6 +29,23 @@
 #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
+static inline int in_swapper_dir(void *addr)
+{
+	if ((unsigned long)addr >= (unsigned long)swapper_pg_dir &&
+		(unsigned long)addr < (unsigned long)swapper_pg_end) {
+		return 1;
+	}
+	return 0;
+}
+
+static inline void *swapper_mirror_addr(void *start, void *addr)
+{
+	unsigned long offset;
+
+	offset = (unsigned long)addr - (unsigned long)swapper_pg_dir;
+	return start + offset;
+}
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -49,6 +66,17 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
 {
+#ifdef __PAGETABLE_PUD_FOLDED
+	if ((mm == &init_mm) && in_swapper_dir(pudp)) {
+		pud_t *pud;
+
+		pud = pud_set_fixmap(__pa_symbol(swapper_pg_dir));
+		pud = (pud_t *)swapper_mirror_addr(pud, pudp);
+		__pud_populate(pud, __pa(pmdp), PMD_TYPE_TABLE);
+		pud_clear_fixmap();
+		return;
+	}
+#endif
 	__pud_populate(pudp, __pa(pmdp), PMD_TYPE_TABLE);
 }
 #else
@@ -78,6 +106,15 @@ static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, pud_t *pudp)
 {
+	if ((mm == &init_mm) && in_swapper_dir(pgdp)) {
+		pgd_t *pgd;
+
+		pgd = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
+		pgd = (pgd_t *)swapper_mirror_addr(pgd, pgdp);
+		__pgd_populate(pgd, __pa(pudp), PUD_TYPE_TABLE);
+		pgd_clear_fixmap();
+		return;
+	}
 	__pgd_populate(pgdp, __pa(pudp), PUD_TYPE_TABLE);
 }
 #else
@@ -139,6 +176,17 @@ static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 {
+#ifdef __PAGETABLE_PMD_FOLDED
+	if (in_swapper_dir(pmdp)) {
+		pmd_t *pmd;
+
+		pmd = pmd_set_fixmap(__pa_symbol(swapper_pg_dir));
+		pmd = (pmd_t *)swapper_mirror_addr(pmd, pmdp);
+		__pmd_populate(pmd, __pa(ptep), PMD_TYPE_TABLE);
+		pmd_clear_fixmap();
+		return;
+	}
+#endif
 	/*
 	 * The pmd must be loaded with the physical address of the PTE table
 	 */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3b408f21fe2e..b479d1b997c2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -475,6 +475,9 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
  */
 #define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
 
+#define pmd_set_fixmap(addr)		((pmd_t *)set_fixmap_offset(FIX_PMD, addr))
+#define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 #define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
@@ -506,11 +509,11 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 #define pmd_offset_phys(dir, addr)	(pud_page_paddr(READ_ONCE(*(dir))) + pmd_index(addr) * sizeof(pmd_t))
 #define pmd_offset(dir, addr)		((pmd_t *)__va(pmd_offset_phys((dir), (addr))))
 
-#define pmd_set_fixmap(addr)		((pmd_t *)set_fixmap_offset(FIX_PMD, addr))
 #define pmd_set_fixmap_offset(pud, addr)	pmd_set_fixmap(pmd_offset_phys(pud, addr))
-#define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
 
 #define pud_page(pud)		pfn_to_page(__phys_to_pfn(__pud_to_phys(pud)))
+#define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
+#define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
 
 /* use ONLY for statically allocated translation tables */
 #define pmd_offset_kimg(dir,addr)	((pmd_t *)__phys_to_kimg(pmd_offset_phys((dir), (addr))))
@@ -518,11 +521,11 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 #else
 
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
+#define pud_set_fixmap(addr)		NULL
+#define pud_clear_fixmap()
 
 /* Match pmd_offset folding in <asm/generic/pgtable-nopmd.h> */
-#define pmd_set_fixmap(addr)		NULL
 #define pmd_set_fixmap_offset(pudp, addr)	((pmd_t *)pudp)
-#define pmd_clear_fixmap()
 
 #define pmd_offset_kimg(dir,addr)	((pmd_t *)dir)
 
@@ -558,9 +561,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pud_offset_phys(dir, addr)	(pgd_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
 #define pud_offset(dir, addr)		((pud_t *)__va(pud_offset_phys((dir), (addr))))
 
-#define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
 #define pud_set_fixmap_offset(pgd, addr)	pud_set_fixmap(pud_offset_phys(pgd, addr))
-#define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
 
 #define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
 
@@ -572,9 +573,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0;})
 
 /* Match pud_offset folding in <asm/generic/pgtable-nopud.h> */
-#define pud_set_fixmap(addr)		NULL
 #define pud_set_fixmap_offset(pgdp, addr)	((pud_t *)pgdp)
-#define pud_clear_fixmap()
 
 #define pud_offset_kimg(dir,addr)	((pud_t *)dir)
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index d69e11ad92e3..beff018bf0f9 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -223,21 +223,25 @@ SECTIONS
 	BSS_SECTION(0, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
+
+	.rodata : {
+		. = ALIGN(PAGE_SIZE);
+		idmap_pg_dir = .;
+		. += IDMAP_DIR_SIZE;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
+		tramp_pg_dir = .;
+		. += PAGE_SIZE;
 #endif
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	reserved_ttbr0 = .;
-	. += RESERVED_TTBR0_SIZE;
+		reserved_ttbr0 = .;
+		. += RESERVED_TTBR0_SIZE;
 #endif
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
-	swapper_pg_end = .;
+		swapper_pg_dir = .;
+		. += PAGE_SIZE;
+		swapper_pg_end = .;
+	}
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
-- 
2.17.1
