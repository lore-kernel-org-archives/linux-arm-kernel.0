From: cpandya@codeaurora.org (Chintan Pandya)
Date: Wed,  6 Jun 2018 12:31:21 +0530
Subject: [PATCH v13 3/3] arm64: Implement page table free interfaces
In-Reply-To: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
Message-ID: <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 requires break-before-make. Originally, before
setting up new pmd/pud entry for huge mapping, in few
cases, the modifying pmd/pud entry was still valid
and pointing to next level page table as we only
clear off leaf PTE in unmap leg.

 a) This was resulting into stale entry in TLBs (as few
    TLBs also cache intermediate mapping for performance
    reasons)
 b) Also, modifying pmd/pud was the only reference to
    next level page table and it was getting lost without
    freeing it. So, page leaks were happening.

Implement pud_free_pmd_page() and pmd_free_pte_page() to
enforce BBM and also free the leaking page tables.

Implementation requires,
 1) Clearing off the current pud/pmd entry
 2) Invalidation of TLB
 3) Freeing of the un-used next level page tables

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8ae5d7a..65f8627 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/tlbflush.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -977,12 +978,51 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pud_free_pmd_page(pud_t *pud, unsigned long addr)
+int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
-	return pud_none(*pud);
+	pte_t *table;
+	pmd_t pmd;
+
+	pmd = READ_ONCE(*pmdp);
+
+	/* No-op for empty entry and WARN_ON for valid entry */
+	if (!pmd_present(pmd) || !pmd_table(pmd)) {
+		VM_WARN_ON(!pmd_table(pmd));
+		return 1;
+	}
+
+	table = pte_offset_kernel(pmdp, addr);
+	pmd_clear(pmdp);
+	__flush_tlb_kernel_pgtable(addr);
+	pte_free_kernel(NULL, table);
+	return 1;
 }
 
-int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
+int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 {
-	return pmd_none(*pmd);
+	pmd_t *table;
+	pmd_t *pmdp;
+	pud_t pud;
+	unsigned long next, end;
+
+	pud = READ_ONCE(*pudp);
+
+	/* No-op for empty entry and WARN_ON for valid entry */
+	if (!pud_present(pud) || !pud_table(pud)) {
+		VM_WARN_ON(!pud_table(pud));
+		return 1;
+	}
+
+	table = pmd_offset(pudp, addr);
+	pmdp = table;
+	next = addr;
+	end = addr + PUD_SIZE;
+	do {
+		pmd_free_pte_page(pmdp, next);
+	} while (pmdp++, next += PMD_SIZE, next != end);
+
+	pud_clear(pudp);
+	__flush_tlb_kernel_pgtable(addr);
+	pmd_free(NULL, table);
+	return 1;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
