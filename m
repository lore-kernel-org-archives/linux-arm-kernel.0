From: janboe.ye@gmail.com (janboe)
Date: Mon, 12 Oct 2009 23:21:29 +0800
Subject: [PATCH] check pmd type before modifying pte
Message-ID: <1255360889-29507-1-git-send-email-janboe.ye@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch could give a warning before modifing pte when pmd type is
not correct.

Signed-off-by: janboe <janboe.ye@gmail.com>
---
 arch/arm/mm/mmu.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4426ee6..ac8f27b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -487,6 +487,11 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 		__pmd_populate(pmd, __pa(pte) | type->prot_l1);
 	}
 
+	if (pmd_bad(*pmd))
+		printk(KERN_WARNING "BUG: mapping for 0x%8lx at 0x%08lx "
+		       "pmd is not correct\n",
+		       __pfn_to_phys(pfn), addr);
+
 	pte = pte_offset_kernel(pmd, addr);
 	do {
 		set_pte_ext(pte, pfn_pte(pfn, __pgprot(type->prot_pte)), 0);
-- 
1.6.3.3
