From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jan 2017 17:49:58 +0900
Subject: [PATCH v30 04/11] arm64: mm: allow for unmapping memory region from
 kernel mapping
In-Reply-To: <20170124084638.3770-1-takahiro.akashi@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
Message-ID: <20170124085004.3892-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of create_mapping_late() is only allowed
to modify permission attributes (read-only or read-write) against
the existing kernel mapping.

In this patch, PAGE_KERNEL_INVALID protection attribute is introduced.
We will now be able to invalidate (or unmap) some part of the existing
kernel mapping by specifying PAGE_KERNEL_INVALID to create_mapping_late().

This feature will be used in a suceeding kdump patch to protect
the memory reserved for crash dump kernel once after loaded.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/mmu.h           |  2 ++
 arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
 arch/arm64/include/asm/pgtable-prot.h  |  1 +
 arch/arm64/include/asm/pgtable.h       |  4 ++++
 arch/arm64/mm/mmu.c                    | 29 ++++++++++++++++++++---------
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 47619411f0ff..a6c1367527bc 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -36,6 +36,8 @@ extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool page_mappings_only);
+extern void create_mapping_late(phys_addr_t phys, unsigned long virt,
+				phys_addr_t size, pgprot_t prot);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 
 #endif
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd90de9..e66efec31ca9 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -119,6 +119,7 @@
 #define PUD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
 #define PUD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
 #define PUD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
+#define PUD_VALID		PUD_TYPE_SECT
 
 /*
  * Level 2 descriptor (PMD).
@@ -128,6 +129,7 @@
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 3) << 0)
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 1) << 0)
 #define PMD_TABLE_BIT		(_AT(pmdval_t, 1) << 1)
+#define PMD_VALID		PMD_TYPE_SECT
 
 /*
  * Section
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2142c7726e76..945d84cd5df7 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -54,6 +54,7 @@
 #define PAGE_KERNEL_ROX		__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
+#define PAGE_KERNEL_INVALID	__pgprot(0)
 
 #define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
 #define PAGE_HYP_EXEC		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ffbb9a520563..1904a7c07018 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -364,6 +364,8 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 #define pmd_bad(pmd)		(!(pmd_val(pmd) & PMD_TABLE_BIT))
 
+#define pmd_valid(pmd)		(!!(pmd_val(pmd) & PMD_VALID))
+
 #define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 				 PMD_TYPE_TABLE)
 #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
@@ -428,6 +430,7 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
+#define pud_valid(pud)		(!!(pud_val(pud) & PUD_VALID))
 #define pud_present(pud)	(pud_val(pud))
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
@@ -481,6 +484,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 
 #define pgd_none(pgd)		(!pgd_val(pgd))
 #define pgd_bad(pgd)		(!(pgd_val(pgd) & 2))
+#define pgd_valid(pgd)		(!!(pgd_val(pgd) & 1))
 #define pgd_present(pgd)	(pgd_val(pgd))
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 17243e43184e..9c7adcce8e4e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -133,7 +133,8 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 		 * Set the contiguous bit for the subsequent group of PTEs if
 		 * its size and alignment are appropriate.
 		 */
-		if (((addr | PFN_PHYS(pfn)) & ~CONT_PTE_MASK) == 0) {
+		if ((pgprot_val(prot) & PTE_VALID) &&
+		    (((addr | PFN_PHYS(pfn)) & ~CONT_PTE_MASK) == 0)) {
 			if (end - addr >= CONT_PTE_SIZE && !page_mappings_only)
 				__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 			else
@@ -147,7 +148,8 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 		 * After the PTE entry has been populated once, we
 		 * only allow updates to the permission attributes.
 		 */
-		BUG_ON(!pgattr_change_is_safe(pte_val(old_pte), pte_val(*pte)));
+		BUG_ON(pte_valid(old_pte) && pte_valid(*pte) &&
+		       !pgattr_change_is_safe(pte_val(old_pte), pte_val(*pte)));
 
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
@@ -190,7 +192,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 			 * Set the contiguous bit for the subsequent group of
 			 * PMDs if its size and alignment are appropriate.
 			 */
-			if (((addr | phys) & ~CONT_PMD_MASK) == 0) {
+			if ((pgprot_val(prot) | PMD_VALID) &&
+			    ((addr | phys) & ~CONT_PMD_MASK) == 0) {
 				if (end - addr >= CONT_PMD_SIZE)
 					__prot = __pgprot(pgprot_val(prot) |
 							  PTE_CONT);
@@ -203,7 +206,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 			 * After the PMD entry has been populated once, we
 			 * only allow updates to the permission attributes.
 			 */
-			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
+			BUG_ON(pmd_valid(old_pmd) && pmd_valid(*pmd) &&
+			       !pgattr_change_is_safe(pmd_val(old_pmd),
 						      pmd_val(*pmd)));
 		} else {
 			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
@@ -263,7 +267,8 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 			 * After the PUD entry has been populated once, we
 			 * only allow updates to the permission attributes.
 			 */
-			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
+			BUG_ON(pud_valid(old_pud) && pud_valid(*pud) &&
+			       !pgattr_change_is_safe(pud_val(old_pud),
 						      pud_val(*pud)));
 		} else {
 			alloc_init_pmd(pud, addr, next, phys, prot,
@@ -344,8 +349,8 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			     pgd_pgtable_alloc, page_mappings_only);
 }
 
-static void create_mapping_late(phys_addr_t phys, unsigned long virt,
-				  phys_addr_t size, pgprot_t prot)
+void create_mapping_late(phys_addr_t phys, unsigned long virt,
+			 phys_addr_t size, pgprot_t prot)
 {
 	if (virt < VMALLOC_START) {
 		pr_warn("BUG: not creating mapping for %pa@0x%016lx - outside kernel range\n",
@@ -791,14 +796,20 @@ int __init arch_ioremap_pmd_supported(void)
 int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
 {
 	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pud, __pud(phys | PUD_TYPE_SECT | pgprot_val(mk_sect_prot(prot))));
+	set_pud(pud, __pud(phys |
+			   ((pgprot_val(prot) & PUD_VALID) ?
+					PUD_TYPE_SECT : 0) |
+			   pgprot_val(mk_sect_prot(prot))));
 	return 1;
 }
 
 int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
 {
 	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmd, __pmd(phys | PMD_TYPE_SECT | pgprot_val(mk_sect_prot(prot))));
+	set_pmd(pmd, __pmd(phys |
+			   ((pgprot_val(prot) & PMD_VALID) ?
+					PMD_TYPE_SECT : 0) |
+			   pgprot_val(mk_sect_prot(prot))));
 	return 1;
 }
 
-- 
2.11.0
