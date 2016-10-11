From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Oct 2016 13:39:48 +0100
Subject: [PATCH v2 2/3] arm64: mm: replace 'block_mappings_allowed' with
 'page_mappings_only'
In-Reply-To: <1476189589-1443-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476189589-1443-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1476189589-1443-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of adding support for contiguous PTE and PMD mappings,
let's replace 'block_mappings_allowed' with 'page_mappings_only', which
will be a more accurate description of the nature of the setting once we
add such contiguous mappings into the mix.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/mmu.h |  2 +-
 arch/arm64/kernel/efi.c      |  8 ++---
 arch/arm64/mm/mmu.c          | 32 ++++++++++----------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 8d9fce037b2f..a81454ad5455 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -34,7 +34,7 @@ extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
-			       pgprot_t prot, bool allow_block_mappings);
+			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 
 #endif
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index ba9bee389fd5..5d17f377d905 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -62,8 +62,8 @@ struct screen_info screen_info __section(.data);
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
 	pteval_t prot_val = create_mapping_protection(md);
-	bool allow_block_mappings = (md->type != EFI_RUNTIME_SERVICES_CODE &&
-				     md->type != EFI_RUNTIME_SERVICES_DATA);
+	bool page_mappings_only = (md->type == EFI_RUNTIME_SERVICES_CODE ||
+				   md->type == EFI_RUNTIME_SERVICES_DATA);
 
 	if (!PAGE_ALIGNED(md->phys_addr) ||
 	    !PAGE_ALIGNED(md->num_pages << EFI_PAGE_SHIFT)) {
@@ -76,12 +76,12 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 		 * from the MMU routines. So avoid block mappings altogether in
 		 * that case.
 		 */
-		allow_block_mappings = false;
+		page_mappings_only = true;
 	}
 
 	create_pgd_mapping(mm, md->phys_addr, md->virt_addr,
 			   md->num_pages << EFI_PAGE_SHIFT,
-			   __pgprot(prot_val | PTE_NG), allow_block_mappings);
+			   __pgprot(prot_val | PTE_NG), page_mappings_only);
 	return 0;
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1cbadd20e741..ee3cda6c41a7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -139,7 +139,7 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
 				  phys_addr_t (*pgtable_alloc)(void),
-				  bool allow_block_mappings)
+				  bool page_mappings_only)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -166,7 +166,7 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
-		      allow_block_mappings) {
+		      !page_mappings_only) {
 			pmd_set_huge(pmd, phys, prot);
 
 			/*
@@ -204,7 +204,7 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
 				  phys_addr_t (*pgtable_alloc)(void),
-				  bool allow_block_mappings)
+				  bool page_mappings_only)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -226,7 +226,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
-		if (use_1G_block(addr, next, phys) && allow_block_mappings) {
+		if (use_1G_block(addr, next, phys) && !page_mappings_only) {
 			pud_set_huge(pud, phys, prot);
 
 			/*
@@ -238,7 +238,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 				~modifiable_attr_mask) != 0);
 		} else {
 			alloc_init_pmd(pud, addr, next, phys, prot,
-				       pgtable_alloc, allow_block_mappings);
+				       pgtable_alloc, page_mappings_only);
 
 			BUG_ON(!pud_none(old_pud) &&
 			       pud_val(old_pud) != pud_val(*pud));
@@ -253,7 +253,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 unsigned long virt, phys_addr_t size,
 				 pgprot_t prot,
 				 phys_addr_t (*pgtable_alloc)(void),
-				 bool allow_block_mappings)
+				 bool page_mappings_only)
 {
 	unsigned long addr, length, end, next;
 	pgd_t *pgd = pgd_offset_raw(pgdir, virt);
@@ -273,7 +273,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	do {
 		next = pgd_addr_end(addr, end);
 		alloc_init_pud(pgd, addr, next, phys, prot, pgtable_alloc,
-			       allow_block_mappings);
+			       page_mappings_only);
 		phys += next - addr;
 	} while (pgd++, addr = next, addr != end);
 }
@@ -302,17 +302,17 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, true);
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, false);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
-			       pgprot_t prot, bool allow_block_mappings)
+			       pgprot_t prot, bool page_mappings_only)
 {
 	BUG_ON(mm == &init_mm);
 
 	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
-			     pgd_pgtable_alloc, allow_block_mappings);
+			     pgd_pgtable_alloc, page_mappings_only);
 }
 
 static void create_mapping_late(phys_addr_t phys, unsigned long virt,
@@ -325,7 +325,7 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 	}
 
 	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
-			     NULL, !debug_pagealloc_enabled());
+			     NULL, debug_pagealloc_enabled());
 }
 
 static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
@@ -343,7 +343,7 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
 				     end - start, PAGE_KERNEL,
 				     early_pgtable_alloc,
-				     !debug_pagealloc_enabled());
+				     debug_pagealloc_enabled());
 		return;
 	}
 
@@ -356,13 +356,13 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 				     __phys_to_virt(start),
 				     kernel_start - start, PAGE_KERNEL,
 				     early_pgtable_alloc,
-				     !debug_pagealloc_enabled());
+				     debug_pagealloc_enabled());
 	if (kernel_end < end)
 		__create_pgd_mapping(pgd, kernel_end,
 				     __phys_to_virt(kernel_end),
 				     end - kernel_end, PAGE_KERNEL,
 				     early_pgtable_alloc,
-				     !debug_pagealloc_enabled());
+				     debug_pagealloc_enabled());
 
 	/*
 	 * Map the linear alias of the [_text, __init_begin) interval as
@@ -372,7 +372,7 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 	 */
 	__create_pgd_mapping(pgd, kernel_start, __phys_to_virt(kernel_start),
 			     kernel_end - kernel_start, PAGE_KERNEL_RO,
-			     early_pgtable_alloc, !debug_pagealloc_enabled());
+			     early_pgtable_alloc, debug_pagealloc_enabled());
 }
 
 static void __init map_mem(pgd_t *pgd)
@@ -422,7 +422,7 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
 	BUG_ON(!PAGE_ALIGNED(size));
 
 	__create_pgd_mapping(pgd, pa_start, (unsigned long)va_start, size, prot,
-			     early_pgtable_alloc, !debug_pagealloc_enabled());
+			     early_pgtable_alloc, debug_pagealloc_enabled());
 
 	vma->addr	= va_start;
 	vma->phys_addr	= pa_start;
-- 
2.7.4
