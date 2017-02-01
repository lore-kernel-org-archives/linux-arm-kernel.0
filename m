From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  1 Feb 2017 21:46:23 +0900
Subject: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
In-Reply-To: <20170201124218.5823-1-takahiro.akashi@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
Message-ID: <20170201124630.6016-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new function, remove_pgd_mapping(), is added.
It allows us to unmap a specific portion of kernel mapping later as far as
the mapping is made using create_pgd_mapping() and unless we try to free
a sub-set of memory range within a section mapping.

This function will be used in a later kdump patch to implement
the protection against corrupting crash dump kernel memory which is to be
set aside.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/mmu.h |   2 +
 arch/arm64/mm/mmu.c          | 130 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 47619411f0ff..04eb240736d8 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -36,6 +36,8 @@ extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool page_mappings_only);
+extern void remove_pgd_mapping(struct mm_struct *mm, unsigned long virt,
+			       phys_addr_t size);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 17243e43184e..9d3cea1db3b4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -334,12 +334,10 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, false);
 }
 
-void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
-			       unsigned long virt, phys_addr_t size,
-			       pgprot_t prot, bool page_mappings_only)
+void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
+			unsigned long virt, phys_addr_t size,
+			pgprot_t prot, bool page_mappings_only)
 {
-	BUG_ON(mm == &init_mm);
-
 	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
 			     pgd_pgtable_alloc, page_mappings_only);
 }
@@ -357,6 +355,128 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 			     NULL, debug_pagealloc_enabled());
 }
 
+static bool pgtable_is_cleared(void *pgtable)
+{
+	unsigned long *desc, *end;
+
+	for (desc = pgtable, end = (unsigned long *)(pgtable + PAGE_SIZE);
+	     desc < end; desc++)
+		if (*desc)
+			return false;
+
+	return true;
+}
+
+static void clear_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end)
+{
+	pte_t *pte;
+
+	if (WARN_ON(pmd_bad(*pmd)))
+		return;
+
+	pte = pte_set_fixmap_offset(pmd, addr);
+
+	do {
+		pte_clear(NULL, NULL, pte);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+	pte_clear_fixmap();
+}
+
+static void clear_pmd_range(pud_t *pud, unsigned long addr, unsigned long end)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	if (WARN_ON(pud_bad(*pud)))
+		return;
+
+	pmd = pmd_set_fixmap_offset(pud, addr);
+
+	do {
+		next = pmd_addr_end(addr, end);
+
+		if (pmd_table(*pmd)) {
+			clear_pte_range(pmd, addr, next);
+			if (((next - addr) == PMD_SIZE) ||
+			    pgtable_is_cleared(__va(pmd_page_paddr(*pmd)))) {
+				__free_page(pmd_page(*pmd));
+				pmd_clear(pmd);
+			}
+		} else {
+			if (WARN_ON((next - addr) != PMD_SIZE))
+				return;
+			pmd_clear(pmd);
+		}
+	} while (pmd++, addr = next, addr != end);
+
+	pmd_clear_fixmap();
+}
+
+static void clear_pud_range(pgd_t *pgd, unsigned long addr, unsigned long end)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	if (WARN_ON(pgd_bad(*pgd)))
+		return;
+
+	pud = pud_set_fixmap_offset(pgd, addr);
+
+	do {
+		next = pud_addr_end(addr, end);
+
+		if (pud_table(*pud)) {
+			clear_pmd_range(pud, addr, next);
+#if CONFIG_PGTABLE_LEVELS > 2
+			if (((next - addr) == PUD_SIZE) ||
+			    pgtable_is_cleared(__va(pud_page_paddr(*pud)))) {
+				__free_page(pud_page(*pud));
+				pud_clear(pud);
+			}
+#endif
+		} else {
+#if CONFIG_PGTABLE_LEVELS > 2
+			if (WARN_ON((next - addr) != PUD_SIZE))
+				return;
+			pud_clear(pud);
+#endif
+		}
+	} while (pud++, addr = next, addr != end);
+
+	pud_clear_fixmap();
+}
+
+static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long virt,
+				 phys_addr_t size)
+{
+	unsigned long addr, length, end, next;
+	pgd_t *pgd = pgd_offset_raw(pgdir, virt);
+
+	addr = virt & PAGE_MASK;
+	length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
+
+	end = addr + length;
+	do {
+		next = pgd_addr_end(addr, end);
+		clear_pud_range(pgd, addr, next);
+
+#if CONFIG_PGTABLE_LEVELS > 3
+		if (((next - addr) == PGD_SIZE) ||
+		    pgtable_is_cleared(__va(pgd_page_paddr(*pgd)))) {
+			__free_page(pgd_page(*pgd));
+			pgd_clear(pgd);
+		}
+#endif
+	} while (pgd++, addr = next, addr != end);
+}
+
+void remove_pgd_mapping(struct mm_struct *mm, unsigned long virt,
+			phys_addr_t size)
+{
+	__remove_pgd_mapping(mm->pgd, virt, size);
+}
+
 static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
 {
 	unsigned long kernel_start = __pa(_text);
-- 
2.11.0
