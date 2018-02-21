From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Feb 2018 12:59:27 +0000
Subject: [PATCH] arm64: Enforce BBM for huge IO/VMAP mappings
Message-ID: <1519217967-2545-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ioremap_page_range doesn't honour break-before-make and attempts to put
down huge mappings (using p*d_set_huge) over the top of pre-existing
table entries. This leads to us leaking page table memory and also gives
rise to TLB conflicts and spurious aborts, which have been seen in
practice on Cortex-A75.

Until this has been resolved, refuse to put block mappings when the
existing entry is found to be present.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: Hanjun Guo <hanjun.guo@linaro.org>
Reported-by: Lei Li <lious.lilei@hisilicon.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3161b853f29e..84a019f55022 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -933,6 +933,11 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+
+	/* ioremap_page_range doesn't honour BBM */
+	if (pud_present(READ_ONCE(*pudp)))
+		return 0;
+
 	BUG_ON(phys & ~PUD_MASK);
 	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
@@ -942,6 +947,11 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+
+	/* ioremap_page_range doesn't honour BBM */
+	if (pmd_present(READ_ONCE(*pmdp)))
+		return 0;
+
 	BUG_ON(phys & ~PMD_MASK);
 	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
-- 
2.1.4
