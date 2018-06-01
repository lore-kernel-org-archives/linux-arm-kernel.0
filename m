From: cpandya@codeaurora.org (Chintan Pandya)
Date: Fri,  1 Jun 2018 18:09:18 +0530
Subject: [PATCH v12 5/5] arm64: Allow huge io mappings again
In-Reply-To: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
Message-ID: <1527856758-27169-6-git-send-email-cpandya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huge mappings have had stability issues due to stale
TLB entry and memory leak issues. Since, those are
addressed in this series of patches, it is now safe
to allow huge mappings.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6e7e16c..c65abc4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -934,15 +934,8 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
-	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), sect_prot);
-
-	/* Only allow permission changes for now */
-	if (!pgattr_change_is_safe(READ_ONCE(pud_val(*pudp)),
-				   pud_val(new_pud)))
-		return 0;
-
 	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pudp, new_pud);
+	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
@@ -950,15 +943,8 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
-	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), sect_prot);
-
-	/* Only allow permission changes for now */
-	if (!pgattr_change_is_safe(READ_ONCE(pmd_val(*pmdp)),
-				   pmd_val(new_pmd)))
-		return 0;
-
 	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmdp, new_pmd);
+	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
