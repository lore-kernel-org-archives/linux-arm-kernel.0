From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun,  8 May 2011 13:51:33 +0100
Subject: [PATCH v5 14/19] ARM: LPAE: Add identity mapping support for the
	3-level page table format
In-Reply-To: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1304859098-10760-15-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With LPAE, the pgd is a separate page table with entries pointing to the
pmd. The identity_mapping_add() function needs to ensure that the pgd is
populated before populating the pmd level. The do..while blocks now loop
over the pmd in order to have the same implementation for the two page
table formats. The pmd_addr_end() definition has been removed and the
generic one used instead. The pmd clean-up is done in the pgd_free()
function.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable.h |    4 ----
 arch/arm/mm/idmap.c            |   36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 1db9ad6..9645e52 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -263,10 +263,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
-/* we don't need complex calculations here as the pmd is folded into the pgd */
-#define pmd_addr_end(addr,end)	(end)
-
-
 #ifndef CONFIG_HIGHPTE
 #define __pte_map(pmd)		pmd_page_vaddr(*(pmd))
 #define __pte_unmap(pte)	do { } while (0)
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2be9139..24e0655 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -1,9 +1,36 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 
 #include <asm/cputype.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
+#ifdef CONFIG_ARM_LPAE
+static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
+	unsigned long prot)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	if (pud_none_or_clear_bad(pud) || (pud_val(*pud) & L_PGD_SWAPPER)) {
+		pmd = pmd_alloc_one(NULL, addr);
+		if (!pmd) {
+			pr_warning("Failed to allocate identity pmd.\n");
+			return;
+		}
+		pud_populate(NULL, pud, pmd);
+		pmd += pmd_index(addr);
+	} else
+		pmd = pmd_offset(pud, addr);
+
+	do {
+		next = pmd_addr_end(addr, end);
+		*pmd = __pmd((addr & PMD_MASK) | prot);
+		flush_pmd_entry(pmd);
+	} while (pmd++, addr = next, addr != end);
+}
+#else	/* !CONFIG_ARM_LPAE */
 static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	unsigned long prot)
 {
@@ -15,6 +42,7 @@ static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd[1] = __pmd(addr);
 	flush_pmd_entry(pmd);
 }
+#endif	/* CONFIG_ARM_LPAE */
 
 static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 	unsigned long prot)
@@ -32,7 +60,7 @@ void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
 {
 	unsigned long prot, next;
 
-	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE;
+	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
 	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
 		prot |= PMD_BIT4;
 
@@ -46,7 +74,11 @@ void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
 #ifdef CONFIG_SMP
 static void idmap_del_pmd(pud_t *pud, unsigned long addr, unsigned long end)
 {
-	pmd_t *pmd = pmd_offset(pud, addr);
+	pmd_t *pmd;
+
+	if (pud_none_or_clear_bad(pud))
+		return;
+	pmd = pmd_offset(pud, addr);
 	pmd_clear(pmd);
 }
 
