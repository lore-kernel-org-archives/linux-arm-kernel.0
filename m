From: r.sricharan@ti.com (R Sricharan)
Date: Mon, 6 Aug 2012 16:03:50 +0530
Subject: [RFC PATCH] ARM: LPAE: Fix alloc_init_section to flush all the pmd
 entries.
Message-ID: <1344249230-29835-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flush_pmd_entry flushes one cache line by MVA. This is
called by alloc_init_section to flush the mapped pmd
entries. But this is called outside the loop and when
LPAE is enabled the number of pmd entries to be
flushed can be across multiple cache lines. So call
this inside the loop so that all the mapped entries are
flushed.

This is going to result in additional cache line
flushes. There might be other better way to handle
this.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/mmu.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 0ed8808..02af3fe 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -619,7 +619,6 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 	 * up one logical pointer to an L2 table.
 	 */
 	if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) == 0) {
-		pmd_t *p = pmd;
 
 #ifndef CONFIG_ARM_LPAE
 		if (addr & SECTION_SIZE)
@@ -629,9 +628,8 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 		do {
 			*pmd = __pmd(phys | type->prot_sect);
 			phys += SECTION_SIZE;
+			flush_pmd_entry(pmd);
 		} while (pmd++, addr += SECTION_SIZE, addr != end);
-
-		flush_pmd_entry(p);
 	} else {
 		/*
 		 * No need to loop; pte's aren't interested in the
-- 
1.7.9.5
