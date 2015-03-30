From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 30 Mar 2015 22:41:01 +0100
Subject: [PATCH] ARM: switch to use the generic show_mem() implementation
Message-ID: <E1YchQb-0005DP-MZ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch ARM to use the generic show_mem() implementation, which displays
the statistics from the mm zone rather than walking the page arrays.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Any objections to merging this?

 arch/arm/mm/init.c | 49 -------------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1609b022a72f..ae369c1066e6 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -86,55 +86,6 @@ static int __init parse_tag_initrd2(const struct tag *tag)
 
 __tagtable(ATAG_INITRD2, parse_tag_initrd2);
 
-/*
- * This keeps memory configuration data used by a couple memory
- * initialization functions, as well as show_mem() for the skipping
- * of holes in the memory map.  It is populated by arm_add_memory().
- */
-void show_mem(unsigned int filter)
-{
-	int free = 0, total = 0, reserved = 0;
-	int shared = 0, cached = 0, slab = 0;
-	struct memblock_region *reg;
-
-	printk("Mem-info:\n");
-	show_free_areas(filter);
-
-	for_each_memblock (memory, reg) {
-		unsigned int pfn1, pfn2;
-		struct page *page, *end;
-
-		pfn1 = memblock_region_memory_base_pfn(reg);
-		pfn2 = memblock_region_memory_end_pfn(reg);
-
-		page = pfn_to_page(pfn1);
-		end  = pfn_to_page(pfn2 - 1) + 1;
-
-		do {
-			total++;
-			if (PageReserved(page))
-				reserved++;
-			else if (PageSwapCache(page))
-				cached++;
-			else if (PageSlab(page))
-				slab++;
-			else if (!page_count(page))
-				free++;
-			else
-				shared += page_count(page) - 1;
-			pfn1++;
-			page = pfn_to_page(pfn1);
-		} while (pfn1 < pfn2);
-	}
-
-	printk("%d pages of RAM\n", total);
-	printk("%d free pages\n", free);
-	printk("%d reserved pages\n", reserved);
-	printk("%d slab pages\n", slab);
-	printk("%d pages shared\n", shared);
-	printk("%d pages swap cached\n", cached);
-}
-
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
 			       unsigned long *max_high)
 {
-- 
1.8.3.1
