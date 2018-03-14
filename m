From: toshi.kani@hpe.com (Toshi Kani)
Date: Wed, 14 Mar 2018 12:01:55 -0600
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <20180314180155.19492-1-toshi.kani@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
Message-ID: <20180314180155.19492-3-toshi.kani@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
clear a given pud/pmd entry and free up lower level page table(s).
Address range associated with the pud/pmd entry must have been purged
by INVLPG.

fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
---
 arch/x86/mm/pgtable.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 1eed7ed518e6..34cda7e0551b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -712,7 +712,22 @@ int pmd_clear_huge(pmd_t *pmd)
  */
 int pud_free_pmd_page(pud_t *pud)
 {
-	return pud_none(*pud);
+	pmd_t *pmd;
+	int i;
+
+	if (pud_none(*pud))
+		return 1;
+
+	pmd = (pmd_t *)pud_page_vaddr(*pud);
+
+	for (i = 0; i < PTRS_PER_PMD; i++)
+		if (!pmd_free_pte_page(&pmd[i]))
+			return 0;
+
+	pud_clear(pud);
+	free_page((unsigned long)pmd);
+
+	return 1;
 }
 
 /**
@@ -724,6 +739,15 @@ int pud_free_pmd_page(pud_t *pud)
  */
 int pmd_free_pte_page(pmd_t *pmd)
 {
-	return pmd_none(*pmd);
+	pte_t *pte;
+
+	if (pmd_none(*pmd))
+		return 1;
+
+	pte = (pte_t *)pmd_page_vaddr(*pmd);
+	pmd_clear(pmd);
+	free_page((unsigned long)pte);
+
+	return 1;
 }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
