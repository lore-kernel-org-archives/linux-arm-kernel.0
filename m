From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:48 +0000
Subject: [RFC PATCH 13/20] arm64: mm: avoid redundant __pa(__va(x))
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-14-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we "upgrade" to a section mapping, we free any table we made
redundant by giving it back to memblock. To get the PA, we acquire the
physical address and convert this to a VA, then subsequently convert
this back to a PA.

This works currently, but will not work if the tables are not accessed
via linear map VAs (e.g. is we use fixmap slots).

This patch uses {pmd,pud}_page_paddr to acquire the PA. This avoids the
__pa(__va()) round trip, saving some work and avoiding reliance on the
linear mapping.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0c16c25..5ed1623 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -167,7 +167,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 			if (!pmd_none(old_pmd)) {
 				flush_tlb_all();
 				if (pmd_table(old_pmd)) {
-					phys_addr_t table = __pa(pte_offset_map(&old_pmd, 0));
+					phys_addr_t table = pmd_page_paddr(old_pmd);
 					if (!WARN_ON_ONCE(slab_is_available()))
 						memblock_free(table, PAGE_SIZE);
 				}
@@ -228,7 +228,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 			if (!pud_none(old_pud)) {
 				flush_tlb_all();
 				if (pud_table(old_pud)) {
-					phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
+					phys_addr_t table = pud_page_paddr(old_pud);
 					if (!WARN_ON_ONCE(slab_is_available()))
 						memblock_free(table, PAGE_SIZE);
 				}
-- 
1.9.1
