From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Nov 2010 17:40:10 +0000
Subject: [PATCH v3 01/20] ARM: LPAE: Use PMD_(SHIFT|SIZE|MASK) instead of
	PGDIR_*
In-Reply-To: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1289842829-3027-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PGDIR_SHIFT and PMD_SHIFT for the classic 2-level page table format have
the same value (21). This patch converts the PGDIR_* uses in the kernel
to the PMD_* equivalent.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/module.c  |    2 +-
 arch/arm/kernel/smp.c     |    4 ++--
 arch/arm/mm/dma-mapping.c |    6 +++---
 arch/arm/mm/mmu.c         |   16 ++++++++--------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index d9bd786..6b30f01 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -32,7 +32,7 @@
  * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
  */
 #undef MODULES_VADDR
-#define MODULES_VADDR	(((unsigned long)_etext + ~PGDIR_MASK) & PGDIR_MASK)
+#define MODULES_VADDR	(((unsigned long)_etext + ~PMD_MASK) & PMD_MASK)
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8c19595..40b386c 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -78,7 +78,7 @@ static inline void identity_mapping_add(pgd_t *pgd, unsigned long start,
 	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
 		prot |= PMD_BIT4;
 
-	for (addr = start & PGDIR_MASK; addr < end;) {
+	for (addr = start & PMD_MASK; addr < end;) {
 		pmd = pmd_offset(pgd + pgd_index(addr), addr);
 		pmd[0] = __pmd(addr | prot);
 		addr += SECTION_SIZE;
@@ -95,7 +95,7 @@ static inline void identity_mapping_del(pgd_t *pgd, unsigned long start,
 	unsigned long addr;
 	pmd_t *pmd;
 
-	for (addr = start & PGDIR_MASK; addr < end; addr += PGDIR_SIZE) {
+	for (addr = start & PMD_MASK; addr < end; addr += PMD_SIZE) {
 		pmd = pmd_offset(pgd + pgd_index(addr), addr);
 		pmd[0] = __pmd(0);
 		pmd[1] = __pmd(0);
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e4dd064..2aab1b4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -120,8 +120,8 @@ static void __dma_free_buffer(struct page *page, size_t size)
 #endif
 
 #define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
-#define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> PGDIR_SHIFT)
-#define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)
+#define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> PMD_SHIFT)
+#define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PMD_SHIFT)
 
 /*
  * These are the page tables (2MB each) covering uncached, DMA consistent allocations
@@ -171,7 +171,7 @@ static int __init consistent_init(void)
 		}
 
 		consistent_pte[i++] = pte;
-		base += (1 << PGDIR_SHIFT);
+		base += (1 << PMD_SHIFT);
 	} while (base < CONSISTENT_END);
 
 	return ret;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 79c01f5..5e3adca 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -858,14 +858,14 @@ static inline void prepare_page_table(void)
 	/*
 	 * Clear out all the mappings below the kernel image.
 	 */
-	for (addr = 0; addr < MODULES_VADDR; addr += PGDIR_SIZE)
+	for (addr = 0; addr < MODULES_VADDR; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
 #ifdef CONFIG_XIP_KERNEL
 	/* The XIP kernel is mapped in the module area -- skip over it */
-	addr = ((unsigned long)_etext + PGDIR_SIZE - 1) & PGDIR_MASK;
+	addr = ((unsigned long)_etext + PMD_SIZE - 1) & PMD_MASK;
 #endif
-	for ( ; addr < PAGE_OFFSET; addr += PGDIR_SIZE)
+	for ( ; addr < PAGE_OFFSET; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
 	/*
@@ -880,7 +880,7 @@ static inline void prepare_page_table(void)
 	 * memory bank, up to the end of the vmalloc region.
 	 */
 	for (addr = __phys_to_virt(end);
-	     addr < VMALLOC_END; addr += PGDIR_SIZE)
+	     addr < VMALLOC_END; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 }
 
@@ -921,7 +921,7 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 */
 	vectors_page = early_alloc(PAGE_SIZE);
 
-	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
+	for (addr = VMALLOC_END; addr; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
 	/*
@@ -1068,12 +1068,12 @@ void setup_mm_for_reboot(char mode)
 		base_pmdval |= PMD_BIT4;
 
 	for (i = 0; i < FIRST_USER_PGD_NR + USER_PTRS_PER_PGD; i++, pgd++) {
-		unsigned long pmdval = (i << PGDIR_SHIFT) | base_pmdval;
+		unsigned long pmdval = (i << PMD_SHIFT) | base_pmdval;
 		pmd_t *pmd;
 
-		pmd = pmd_off(pgd, i << PGDIR_SHIFT);
+		pmd = pmd_off(pgd, i << PMD_SHIFT);
 		pmd[0] = __pmd(pmdval);
-		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
+		pmd[1] = __pmd(pmdval + (1 << (PMD_SHIFT - 1)));
 		flush_pmd_entry(pmd);
 	}
 
