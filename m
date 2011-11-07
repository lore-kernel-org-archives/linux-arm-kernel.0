From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon,  7 Nov 2011 16:16:44 +0000
Subject: [PATCH v8 02/16] ARM: pgtable: Fix compiler warning in ioremap.c
 introduced by nopud
In-Reply-To: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1320682618-1182-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the arch/arm code conversion to pgtable-nopud.h, the section and
supersection (un|re)map code triggers compiler warnings on UP systems.
This is caused by pmd_offset() being given a pgd_t argument rather than
a pud_t one. This patch makes the necessary conversion with the
assumption that the pud is folded into the pgd. The page table setting
code only loops over the pmd which is enough with the classic page
tables. This code is not compiled when LPAE is enabled.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/ioremap.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index bdb248c..c3fa40d 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -79,13 +79,16 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
 {
 	unsigned long addr = virt, end = virt + (size & ~(SZ_1M - 1));
 	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmdp;
 
 	flush_cache_vunmap(addr, end);
 	pgd = pgd_offset_k(addr);
+	pud = pud_offset(pgd, addr);
+	pmdp = pmd_offset(pud, addr);
 	do {
-		pmd_t pmd, *pmdp = pmd_offset(pgd, addr);
+		pmd_t pmd = *pmdp;
 
-		pmd = *pmdp;
 		if (!pmd_none(pmd)) {
 			/*
 			 * Clear the PMD from the page table, and
@@ -104,8 +107,8 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
 				pte_free_kernel(&init_mm, pmd_page_vaddr(pmd));
 		}
 
-		addr += PGDIR_SIZE;
-		pgd++;
+		addr += PMD_SIZE;
+		pmdp += 2;
 	} while (addr < end);
 
 	/*
@@ -124,6 +127,8 @@ remap_area_sections(unsigned long virt, unsigned long pfn,
 {
 	unsigned long addr = virt, end = virt + size;
 	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
 
 	/*
 	 * Remove and free any PTE-based mapping, and
@@ -132,17 +137,17 @@ remap_area_sections(unsigned long virt, unsigned long pfn,
 	unmap_area_sections(virt, size);
 
 	pgd = pgd_offset_k(addr);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
 	do {
-		pmd_t *pmd = pmd_offset(pgd, addr);
-
 		pmd[0] = __pmd(__pfn_to_phys(pfn) | type->prot_sect);
 		pfn += SZ_1M >> PAGE_SHIFT;
 		pmd[1] = __pmd(__pfn_to_phys(pfn) | type->prot_sect);
 		pfn += SZ_1M >> PAGE_SHIFT;
 		flush_pmd_entry(pmd);
 
-		addr += PGDIR_SIZE;
-		pgd++;
+		addr += PMD_SIZE;
+		pmd += 2;
 	} while (addr < end);
 
 	return 0;
@@ -154,6 +159,8 @@ remap_area_supersections(unsigned long virt, unsigned long pfn,
 {
 	unsigned long addr = virt, end = virt + size;
 	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
 
 	/*
 	 * Remove and free any PTE-based mapping, and
@@ -162,6 +169,8 @@ remap_area_supersections(unsigned long virt, unsigned long pfn,
 	unmap_area_sections(virt, size);
 
 	pgd = pgd_offset_k(virt);
+	pud = pud_offset(pgd, addr);
+	pmd = pmd_offset(pud, addr);
 	do {
 		unsigned long super_pmd_val, i;
 
@@ -170,14 +179,12 @@ remap_area_supersections(unsigned long virt, unsigned long pfn,
 		super_pmd_val |= ((pfn >> (32 - PAGE_SHIFT)) & 0xf) << 20;
 
 		for (i = 0; i < 8; i++) {
-			pmd_t *pmd = pmd_offset(pgd, addr);
-
 			pmd[0] = __pmd(super_pmd_val);
 			pmd[1] = __pmd(super_pmd_val);
 			flush_pmd_entry(pmd);
 
-			addr += PGDIR_SIZE;
-			pgd++;
+			addr += PMD_SIZE;
+			pmd += 2;
 		}
 
 		pfn += SUPERSECTION_SIZE >> PAGE_SHIFT;
