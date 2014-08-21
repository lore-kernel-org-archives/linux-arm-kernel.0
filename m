From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 20 Aug 2014 18:20:37 -0700
Subject: [PATCHv3 5/7] arm64: Factor out fixmap initialiation from ioremap
In-Reply-To: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1408584039-12735-6-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fixmap API was originally added for arm64 for
early_ioremap purposes. It can be used for other purposes too
so move the initialization from ioremap to somewhere more
generic. This makes it obvious where the fixmap is being set
up and allows for a cleaner implementation of __set_fixmap.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/include/asm/fixmap.h |  7 +--
 arch/arm64/kernel/setup.c       |  3 +-
 arch/arm64/mm/ioremap.c         | 93 ++--------------------------------------
 arch/arm64/mm/mmu.c             | 94 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 94 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 5f7bfe6..db26a2f2 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -56,10 +56,11 @@ enum fixed_addresses {
 
 #define FIXMAP_PAGE_IO     __pgprot(PROT_DEVICE_nGnRE)
 
-extern void __early_set_fixmap(enum fixed_addresses idx,
-			       phys_addr_t phys, pgprot_t flags);
+void __init early_fixmap_init(void);
 
-#define __set_fixmap __early_set_fixmap
+#define __early_set_fixmap __set_fixmap
+
+extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
 
 #include <asm-generic/fixmap.h>
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f6f0ccf..9244e20 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -378,7 +378,8 @@ void __init setup_arch(char **cmdline_p)
 
 	*cmdline_p = boot_command_line;
 
-	early_ioremap_init();
+	early_fixmap_init();
+	early_ioremap_setup();
 
 	parse_early_param();
 
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index fa324bd..cbb99c8 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -103,97 +103,10 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
 }
 EXPORT_SYMBOL(ioremap_cache);
 
-static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
-#if CONFIG_ARM64_PGTABLE_LEVELS > 2
-static pte_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
-#endif
-#if CONFIG_ARM64_PGTABLE_LEVELS > 3
-static pte_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
-#endif
-
-static inline pud_t * __init early_ioremap_pud(unsigned long addr)
-{
-	pgd_t *pgd;
-
-	pgd = pgd_offset_k(addr);
-	BUG_ON(pgd_none(*pgd) || pgd_bad(*pgd));
-
-	return pud_offset(pgd, addr);
-}
-
-static inline pmd_t * __init early_ioremap_pmd(unsigned long addr)
-{
-	pud_t *pud = early_ioremap_pud(addr);
-
-	BUG_ON(pud_none(*pud) || pud_bad(*pud));
-
-	return pmd_offset(pud, addr);
-}
-
-static inline pte_t * __init early_ioremap_pte(unsigned long addr)
-{
-	pmd_t *pmd = early_ioremap_pmd(addr);
-
-	BUG_ON(pmd_none(*pmd) || pmd_bad(*pmd));
-
-	return pte_offset_kernel(pmd, addr);
-}
-
+/*
+ * Must be called after early_fixmap_init
+ */
 void __init early_ioremap_init(void)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	unsigned long addr = fix_to_virt(FIX_BTMAP_BEGIN);
-
-	pgd = pgd_offset_k(addr);
-	pgd_populate(&init_mm, pgd, bm_pud);
-	pud = pud_offset(pgd, addr);
-	pud_populate(&init_mm, pud, bm_pmd);
-	pmd = pmd_offset(pud, addr);
-	pmd_populate_kernel(&init_mm, pmd, bm_pte);
-
-	/*
-	 * The boot-ioremap range spans multiple pmds, for which
-	 * we are not prepared:
-	 */
-	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
-		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
-
-	if (pmd != early_ioremap_pmd(fix_to_virt(FIX_BTMAP_END))) {
-		WARN_ON(1);
-		pr_warn("pmd %p != %p\n",
-			pmd, early_ioremap_pmd(fix_to_virt(FIX_BTMAP_END)));
-		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
-			fix_to_virt(FIX_BTMAP_BEGIN));
-		pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",
-			fix_to_virt(FIX_BTMAP_END));
-
-		pr_warn("FIX_BTMAP_END:       %d\n", FIX_BTMAP_END);
-		pr_warn("FIX_BTMAP_BEGIN:     %d\n",
-			FIX_BTMAP_BEGIN);
-	}
-
 	early_ioremap_setup();
 }
-
-void __init __early_set_fixmap(enum fixed_addresses idx,
-			       phys_addr_t phys, pgprot_t flags)
-{
-	unsigned long addr = __fix_to_virt(idx);
-	pte_t *pte;
-
-	if (idx >= __end_of_fixed_addresses) {
-		BUG();
-		return;
-	}
-
-	pte = early_ioremap_pte(addr);
-
-	if (pgprot_val(flags))
-		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
-	else {
-		pte_clear(&init_mm, addr, pte);
-		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
-	}
-}
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c555672..bd549a3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 
 #include <asm/cputype.h>
+#include <asm/fixmap.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/sizes.h>
@@ -459,3 +460,96 @@ void vmemmap_free(unsigned long start, unsigned long end)
 {
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
+
+static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
+#if CONFIG_ARM64_PGTABLE_LEVELS > 2
+static pte_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
+#endif
+#if CONFIG_ARM64_PGTABLE_LEVELS > 3
+static pte_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
+#endif
+
+static inline pud_t * fixmap_pud(unsigned long addr)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+
+	BUG_ON(pgd_none(*pgd) || pgd_bad(*pgd));
+
+	return pud_offset(pgd, addr);
+}
+
+static inline pmd_t * fixmap_pmd(unsigned long addr)
+{
+	pud_t *pud = fixmap_pud(addr);
+
+	BUG_ON(pud_none(*pud) || pud_bad(*pud));
+
+	return pmd_offset(pud, addr);
+}
+
+static inline pte_t * fixmap_pte(unsigned long addr)
+{
+	pmd_t *pmd = fixmap_pmd(addr);
+
+	BUG_ON(pmd_none(*pmd) || pmd_bad(*pmd));
+
+	return pte_offset_kernel(pmd, addr);
+}
+
+void __init early_fixmap_init(void)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	unsigned long addr = FIXADDR_START;
+
+	pgd = pgd_offset_k(addr);
+	pgd_populate(&init_mm, pgd, bm_pud);
+	pud = pud_offset(pgd, addr);
+	pud_populate(&init_mm, pud, bm_pmd);
+	pmd = pmd_offset(pud, addr);
+	pmd_populate_kernel(&init_mm, pmd, bm_pte);
+
+	/*
+	 * The boot-ioremap range spans multiple pmds, for which
+	 * we are not preparted:
+	 */
+	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
+		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
+
+	if ((pmd != fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)))
+	     || pmd != fixmap_pmd(fix_to_virt(FIX_BTMAP_END))) {
+		WARN_ON(1);
+		pr_warn("pmd %p != %p, %p\n",
+			pmd, fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)),
+			fixmap_pmd(fix_to_virt(FIX_BTMAP_END)));
+		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
+			fix_to_virt(FIX_BTMAP_BEGIN));
+		pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",
+			fix_to_virt(FIX_BTMAP_END));
+
+		pr_warn("FIX_BTMAP_END:       %d\n", FIX_BTMAP_END);
+		pr_warn("FIX_BTMAP_BEGIN:     %d\n", FIX_BTMAP_BEGIN);
+	}
+}
+
+void __set_fixmap(enum fixed_addresses idx,
+			       phys_addr_t phys, pgprot_t flags)
+{
+	unsigned long addr = __fix_to_virt(idx);
+	pte_t *pte;
+
+	if (idx >= __end_of_fixed_addresses) {
+		BUG();
+		return;
+	}
+
+	pte = fixmap_pte(addr);
+
+	if (pgprot_val(flags)) {
+		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
+	} else {
+		pte_clear(&init_mm, addr, pte);
+		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
+	}
+}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
