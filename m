From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 14 May 2012 13:26:13 -0700
Subject: [PATCH] arm: Don't try to print pud/pmd information unless present
Message-ID: <1337027173-22620-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently in show_pte, there are unconditional checks for
pud_none/pud_bad/pmd_none/pmd_bad. If pud/pmd are not used,
this may incorrectly try to interpret entries as pud/pmd
entries which may print bogus information (e.g. marking a
pgd as bad when the entry is valid). Only check for pud/pmd
information if pud/pmd is actually used.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/fault.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index d7561bb..f69dee0 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -103,27 +103,29 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 		}
 
 		pud = pud_offset(pgd, addr);
-		if (PTRS_PER_PUD != 1)
+		if (PTRS_PER_PUD != 1) {
 			printk(", *pud=%08lx", pud_val(*pud));
 
-		if (pud_none(*pud))
-			break;
+			if (pud_none(*pud))
+				break;
 
-		if (pud_bad(*pud)) {
-			printk("(bad)");
-			break;
+			if (pud_bad(*pud)) {
+				printk("(bad)");
+				break;
+			}
 		}
 
 		pmd = pmd_offset(pud, addr);
-		if (PTRS_PER_PMD != 1)
+		if (PTRS_PER_PMD != 1) {
 			printk(", *pmd=%08llx", (long long)pmd_val(*pmd));
 
-		if (pmd_none(*pmd))
-			break;
+			if (pmd_none(*pmd))
+				break;
 
-		if (pmd_bad(*pmd)) {
-			printk("(bad)");
-			break;
+			if (pmd_bad(*pmd)) {
+				printk("(bad)");
+				break;
+			}
 		}
 
 		/* We must not map this if we have highmem enabled */
-- 
1.7.8.3
