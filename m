From: james.morse@arm.com (James Morse)
Date: Fri,  2 Dec 2016 14:49:08 +0000
Subject: [PATCH 1/2] arm64: mm: Mark nomap regions with the PG_reserved flag
In-Reply-To: <20161202144909.18405-1-james.morse@arm.com>
References: <20161202144909.18405-1-james.morse@arm.com>
Message-ID: <20161202144909.18405-2-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux/page-flags.h has a flag for describing special pages:
> PG_reserved is set for special pages, which can never be swapped out.
> Some of them might not even exist (eg empty_bad_page)...

memblock nomap pages fall in the 'might not even exist' category,
set this bit on all the struct pages in the nomap regions.

This gives pfn walkers the necessary hint that the page might not
be accessible, allowing pfn_valid()s meaning to change slightly.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/mm/init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 166911f4a2e6..5da9ff7d20f5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -31,6 +31,7 @@
 #include <linux/memblock.h>
 #include <linux/sort.h>
 #include <linux/of_fdt.h>
+#include <linux/page-flags.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
 #include <linux/efi.h>
@@ -401,6 +402,8 @@ static void __init free_unused_memmap(void)
  */
 void __init mem_init(void)
 {
+	struct memblock_region *region;
+
 	if (swiotlb_force || max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
 		swiotlb_init(1);
 
@@ -479,6 +482,17 @@ void __init mem_init(void)
 		 */
 		sysctl_overcommit_memory = OVERCOMMIT_ALWAYS;
 	}
+
+	/* Mark struct pages for the memblock:nomap regions as reserved */
+	for_each_memblock(memory, region) {
+		u64 pfn;
+		u64 start_pfn = memblock_region_memory_base_pfn(region);
+		u64 end_pfn = memblock_region_memory_end_pfn(region);
+
+		if (memblock_is_nomap(region))
+			for (pfn = start_pfn; pfn < end_pfn; pfn++)
+				SetPageReserved(pfn_to_page(pfn));
+	}
 }
 
 void free_initmem(void)
-- 
2.10.1
