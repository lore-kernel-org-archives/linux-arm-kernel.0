From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 12 Oct 2016 12:23:44 +0100
Subject: [PATCH v3 4/5] arm64: mm: support additional contiguous kernel
 mapping region sizes
In-Reply-To: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1476271425-19401-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the basic support for kernel mappings using contiguous regions
by adding support for contiguous PUDs (4k granule only), either as a
discrete level or folded into the PGDs. In the same way, handle folded
PMDs so that contiguous PMDs (for 16k and 64k granule kernels) will
work as expected for 2 levels of translation as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h |  6 +++
 arch/arm64/mm/mmu.c                    | 40 +++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd90de9..4192072af932 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -93,12 +93,15 @@
 #ifdef CONFIG_ARM64_64K_PAGES
 #define CONT_PTE_SHIFT		5
 #define CONT_PMD_SHIFT		5
+#define CONT_PUD_SHIFT		0
 #elif defined(CONFIG_ARM64_16K_PAGES)
 #define CONT_PTE_SHIFT		7
 #define CONT_PMD_SHIFT		5
+#define CONT_PUD_SHIFT		0
 #else
 #define CONT_PTE_SHIFT		4
 #define CONT_PMD_SHIFT		4
+#define CONT_PUD_SHIFT		4
 #endif
 
 #define CONT_PTES		(1 << CONT_PTE_SHIFT)
@@ -107,6 +110,9 @@
 #define CONT_PMDS		(1 << CONT_PMD_SHIFT)
 #define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
 #define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
+#define CONT_PUDS		(1 << CONT_PUD_SHIFT)
+#define CONT_PUD_SIZE		(CONT_PUDS * PUD_SIZE)
+#define CONT_PUD_MASK		(~(CONT_PUD_SIZE - 1))
 /* the the numerical offset of the PTE within a range of CONT_PTES */
 #define CONT_RANGE_OFFSET(addr) (((addr)>>PAGE_SHIFT)&(CONT_PTES-1))
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 40be4979102d..0e0eca45b54a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -233,6 +233,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 				  phys_addr_t (*pgtable_alloc)(void),
 				  bool page_mappings_only)
 {
+	pgprot_t __prot = prot;
 	pud_t *pud;
 	unsigned long next;
 
@@ -254,7 +255,19 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
 		if (use_1G_block(addr, next, phys) && !page_mappings_only) {
-			pud_set_huge(pud, phys, prot);
+			/*
+			 * Set the contiguous bit for the subsequent group of
+			 * PUDs if its size and alignment are appropriate.
+			 */
+			if (((addr | phys) & ~CONT_PUD_MASK) == 0) {
+				if (end - addr >= CONT_PUD_SIZE)
+					__prot = __pgprot(pgprot_val(prot) |
+							  PTE_CONT);
+				else
+					__prot = prot;
+			}
+
+			pud_set_huge(pud, phys, __prot);
 
 			/*
 			 * After the PUD entry has been populated once, we
@@ -284,6 +297,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 {
 	unsigned long addr, length, end, next;
 	pgd_t *pgd = pgd_offset_raw(pgdir, virt);
+	pgprot_t __prot = prot;
 
 	/*
 	 * If the virtual and physical address don't have the same offset
@@ -299,7 +313,29 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	end = addr + length;
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_pud(pgd, addr, next, phys, prot, pgtable_alloc,
+
+		/*
+		 * If any intermediate levels are folded into the PGDs, we
+		 * need to deal with the contiguous attributes here, since
+		 * the contiguity can only be observed at this level.
+		 */
+		if (PGDIR_SHIFT == PMD_SHIFT && !page_mappings_only &&
+		    ((addr | phys) & ~CONT_PMD_MASK) == 0) {
+			if (end - addr >= CONT_PMD_SIZE)
+				__prot = __pgprot(pgprot_val(prot) |
+						  PTE_CONT);
+			else
+				__prot = prot;
+		} else if (PGDIR_SHIFT == PUD_SHIFT && CONT_PUD_SHIFT > 0 &&
+			   !page_mappings_only &&
+			   ((addr | phys) & ~CONT_PUD_MASK) == 0) {
+			if (end - addr >= CONT_PUD_SIZE)
+				__prot = __pgprot(pgprot_val(prot) |
+						  PTE_CONT);
+			else
+				__prot = prot;
+		}
+		alloc_init_pud(pgd, addr, next, phys, __prot, pgtable_alloc,
 			       page_mappings_only);
 		phys += next - addr;
 	} while (pgd++, addr = next, addr != end);
-- 
2.7.4
