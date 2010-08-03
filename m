From: gking@nvidia.com (Gary King)
Date: Mon,  2 Aug 2010 19:42:46 -0700
Subject: [PATCH 1/4] [ARM] mmu: add option to map lowmem with page mappings
In-Reply-To: <1280803369-13362-1-git-send-email-gking@nvidia.com>
References: <1280803369-13362-1-git-send-email-gking@nvidia.com>
Message-ID: <1280803369-13362-2-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a kernel configuration to map the kernel's lowmem pages using PTE
mappings, rather than the default behavior of 1MiB section mappings.
on ARMv7 processors, to support allocating pages with DMA-coherent
cache attributes, the cache attributes specified in the kernel's
mapping must match cache attributes specified for other mappings;
to ensure that this is the case, the kernel's attributes must be
specified on a per-page basis.

to avoid problems caused by the init_mm page table allocations exceeding
the available initial memory, when this config is enabled lowmem is
initially mapped using sections (matches current behavior), then remapped
using pages after bootmem is initialized

Signed-off-by: Gary King <gking@nvidia.com>
---
 arch/arm/mm/Kconfig |    9 +++++++
 arch/arm/mm/mmu.c   |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 101105e..176e815 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -837,3 +837,12 @@ config ARCH_HAS_BARRIERS
 	help
 	  This option allows the use of custom mandatory barriers
 	  included via the mach/barriers.h file.
+
+config ARCH_LOWMEM_IN_PTES
+	bool
+	help
+	  This option will map the kernel direct-mapped lowmem region
+	  using page table mappings rather than section mappings.
+
+config ARCH_USES_PG_UNCACHED
+	bool
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 2858941..5818e83 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -247,7 +247,10 @@ static struct mem_type mem_types[] = {
 		.domain    = DOMAIN_USER,
 	},
 	[MT_MEMORY] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_EXEC,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
+		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_ROM] = {
@@ -463,6 +466,7 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_MEMORY].prot_sect |= ecc_mask | cp->pmd;
+	mem_types[MT_MEMORY].prot_pte |= pgprot_kernel;
 	mem_types[MT_ROM].prot_sect |= cp->pmd;
 
 	switch (cp->pmd) {
@@ -506,6 +510,30 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
 
+#ifdef CONFIG_ARCH_LOWMEM_IN_PTES
+static void __init realloc_init_pte(pmd_t *pmd, unsigned long addr,
+				    unsigned long end, unsigned long pfn,
+				    const struct mem_type *type)
+{
+	pte_t *pte, *ptep;
+
+	if ((pmd_val(*pmd) & PMD_TYPE_MASK) != PMD_TYPE_SECT)
+		return;
+
+	pte = alloc_bootmem_low_pages(2 * PTRS_PER_PTE * sizeof(pte_t));
+	if (WARN_ON(!pte))
+		return;
+
+	ptep = pte + PTRS_PER_PTE + __pte_index(addr);
+	do {
+		set_pte_ext(ptep, pfn_pte(pfn, __pgprot(type->prot_pte)), 0);
+		pfn++;
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
+
+	__pmd_populate(pmd, __pa(pte) | type->prot_l1);
+}
+#endif
+
 static void __init alloc_init_section(pgd_t *pgd, unsigned long addr,
 				      unsigned long end, unsigned long phys,
 				      const struct mem_type *type)
@@ -1045,6 +1073,40 @@ static void __init map_lowmem(void)
 	}
 }
 
+static void __init remap_lowmem(void)
+{
+#ifdef CONFIG_ARCH_LOWMEM_IN_PTES
+	struct meminfo *mi = &meminfo;
+	const struct mem_type *type = &mem_types[MT_MEMORY];
+	int i;
+
+	for (i = 0; i < mi->nr_banks; i++) {
+		pgd_t *pgd;
+		unsigned long phys, addr, end;
+		struct membank *bank = &mi->bank[i];
+
+		if (bank->highmem)
+			continue;
+
+		phys = __pfn_to_phys(bank_pfn_start(bank));
+		addr = __phys_to_virt(bank_phys_start(bank));
+		end = addr + bank_phys_size(bank);
+
+		pgd = pgd_offset_k(addr);
+		do {
+			unsigned long next = pgd_addr_end(addr, end);
+			pmd_t *pmd = pmd_offset(pgd, addr);
+
+			realloc_init_pte(pmd, addr, next,
+					 __phys_to_pfn(phys), type);
+
+			phys += next - addr;
+			addr = next;
+		} while (pgd++, addr != end);
+	}
+#endif
+}
+
 static int __init meminfo_cmp(const void *_a, const void *_b)
 {
 	const struct membank *a = _a, *b = _b;
@@ -1067,6 +1129,7 @@ void __init paging_init(struct machine_desc *mdesc)
 	prepare_page_table();
 	map_lowmem();
 	bootmem_init();
+	remap_lowmem();
 	devicemaps_init(mdesc);
 	kmap_init();
 
-- 
1.7.0.4
