From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  3 Jan 2017 14:27:26 +0000
Subject: [PATCH] arm64: mm: fix show_pte KERN_CONT fallout
Message-ID: <1483453646-13617-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent changes made KERN_CONT mandatory for continued lines. In the
absence of KERN_CONT, a newline may be implicit inserted by the core
printk code.

In show_pte, we (erroneously) use printk without KERN_CONT for continued
prints, resulting in output being split across a number of lines, and
not matching the intended output, e.g.

[ff000000000000] *pgd=00000009f511b003
, *pud=00000009f4a80003
, *pmd=0000000000000000

Fix this by using pr_cont() for all the continuations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/fault.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a78a5c4..156169c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -88,21 +88,21 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 			break;
 
 		pud = pud_offset(pgd, addr);
-		printk(", *pud=%016llx", pud_val(*pud));
+		pr_cont(", *pud=%016llx", pud_val(*pud));
 		if (pud_none(*pud) || pud_bad(*pud))
 			break;
 
 		pmd = pmd_offset(pud, addr);
-		printk(", *pmd=%016llx", pmd_val(*pmd));
+		pr_cont(", *pmd=%016llx", pmd_val(*pmd));
 		if (pmd_none(*pmd) || pmd_bad(*pmd))
 			break;
 
 		pte = pte_offset_map(pmd, addr);
-		printk(", *pte=%016llx", pte_val(*pte));
+		pr_cont(", *pte=%016llx", pte_val(*pte));
 		pte_unmap(pte);
 	} while(0);
 
-	printk("\n");
+	pr_cont("\n");
 }
 
 #ifdef CONFIG_ARM64_HW_AFDBM
-- 
1.9.1
