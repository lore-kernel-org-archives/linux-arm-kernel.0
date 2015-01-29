From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Jan 2015 16:26:07 +0000
Subject: [PATCH] arm64: mm: mark alloc_init_p{m,u}d as __ref
In-Reply-To: <1422531063-29554-1-git-send-email-will.deacon@arm.com>
References: <1422531063-29554-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150129162606.GI8951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 11:31:03AM +0000, Will Deacon wrote:
> Both alloc_init_pmd and alloc_init_pud refer to the __init function
> early_alloc as part of a BUG_ON(alloc != early_alloc) statement.
> 
> This patch marks the functions as __ref to avoid the spurious section
> mismatch.

Actually, I think it's better to do this:

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2eeac10aa0cf..c6daaf6c6f97 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -26,6 +26,7 @@
 #include <linux/memblock.h>
 #include <linux/fs.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 #include <linux/stop_machine.h>
 
 #include <asm/cputype.h>
@@ -159,8 +160,8 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 				flush_tlb_all();
 				if (pmd_table(old_pmd)) {
 					phys_addr_t table = __pa(pte_offset_map(&old_pmd, 0));
-					BUG_ON(alloc != early_alloc);
-					memblock_free(table, PAGE_SIZE);
+					if (!WARN_ON_ONCE(slab_is_available()))
+						memblock_free(table, PAGE_SIZE);
 				}
 			}
 		} else {
@@ -220,8 +221,8 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 				flush_tlb_all();
 				if (pud_table(old_pud)) {
 					phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
-					BUG_ON(alloc != early_alloc);
-					memblock_free(table, PAGE_SIZE);
+					if (!WARN_ON_ONCE(slab_is_available()))
+						memblock_free(table, PAGE_SIZE);
 				}
 			}
 		} else {
