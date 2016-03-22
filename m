From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 22 Mar 2016 10:11:45 +0000
Subject: [PATCH] arm64: consistently use p?d_set_huge
Message-ID: <1458641505-21499-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 324420bf91f60582 ("arm64: add support for ioremap() block
mappings") added new p?d_set_huge functions which do the hard work to
generate and set a correct block entry.

These differ from open-coded huge page creation in the early page table
code by explicitly setting the P?D_TYPE_SECT bits (which are implicitly
retained by mv_sect_prot() for any valid prot), but are otherwise
identical (and cannot fail on arm64).

For simplicity and consistency, make use of these in the initial page
table creation code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d2d8b8c..f3e5c74 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -211,8 +211,7 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
 		      block_mappings_allowed(pgtable_alloc)) {
 			pmd_t old_pmd =*pmd;
-			set_pmd(pmd, __pmd(phys |
-					   pgprot_val(mk_sect_prot(prot))));
+			pmd_set_huge(pmd, phys, prot);
 			/*
 			 * Check for previous table entries created during
 			 * boot (__create_page_tables) and flush them.
@@ -272,8 +271,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		if (use_1G_block(addr, next, phys) &&
 		    block_mappings_allowed(pgtable_alloc)) {
 			pud_t old_pud = *pud;
-			set_pud(pud, __pud(phys |
-					   pgprot_val(mk_sect_prot(prot))));
+			pud_set_huge(pud, phys, prot);
 
 			/*
 			 * If we have an old value for a pud, it will
-- 
1.9.1
