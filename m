From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Nov 2011 16:23:49 +0000
Subject: [PATCH v9 13/15] ARM: LPAE: Add identity mapping support for the
 3-level page table format
In-Reply-To: <1321287831-24560-1-git-send-email-catalin.marinas@arm.com>
References: <1321287831-24560-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1321287831-24560-14-git-send-email-catalin.marinas@arm.com>
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

The idmap_add_pmd() function cannot be called in an atomic context. The
setup_mm_for_reboot() function is being re-implemented as part of the
kexec patches and no longer calls identity_mapping_add().

 arch/arm/mm/idmap.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2be9139..267db72 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -4,6 +4,31 @@
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
+		pmd = pmd_alloc_one(&init_mm, addr);
+		if (!pmd) {
+			pr_warning("Failed to allocate identity pmd.\n");
+			return;
+		}
+		pud_populate(&init_mm, pud, pmd);
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
@@ -15,6 +40,7 @@ static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd[1] = __pmd(addr);
 	flush_pmd_entry(pmd);
 }
+#endif	/* CONFIG_ARM_LPAE */
 
 static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 	unsigned long prot)
@@ -32,7 +58,7 @@ void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
 {
 	unsigned long prot, next;
 
-	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE;
+	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
 	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
 		prot |= PMD_BIT4;
 
@@ -46,7 +72,11 @@ void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
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
 
