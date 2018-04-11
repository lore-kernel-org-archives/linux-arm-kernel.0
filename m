From: hejianet@gmail.com (Jia He)
Date: Wed, 11 Apr 2018 00:21:54 -0700
Subject: [PATCH v8 3/6] arm: arm64: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
In-Reply-To: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
References: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
Message-ID: <1523431317-30612-4-git-send-email-hejianet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. if pfn and pfn+1 are in the same
memblock region, we can simply pfn++ instead of doing the binary search
in memblock_next_valid_pfn. Furthermore, if the pfn is in a *gap* of two
memory region, skip to next region directly if possible.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/early_pfn.h | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/early_pfn.h b/include/linux/early_pfn.h
index 1b001c7..f9e40c3 100644
--- a/include/linux/early_pfn.h
+++ b/include/linux/early_pfn.h
@@ -3,31 +3,52 @@
 #ifndef __EARLY_PFN_H
 #define __EARLY_PFN_H
 #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
+static int early_region_idx __init_memblock = -1;
 ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
 {
 	struct memblock_type *type = &memblock.memory;
-	unsigned int right = type->cnt;
-	unsigned int mid, left = 0;
+	struct memblock_region *regions = type->regions;
+	uint right = type->cnt;
+	uint mid, left = 0;
+	ulong start_pfn, end_pfn, next_start_pfn;
 	phys_addr_t addr = PFN_PHYS(++pfn);
 
+	/* fast path, return pfn+1 if next pfn is in the same region */
+	if (early_region_idx != -1) {
+		start_pfn = PFN_DOWN(regions[early_region_idx].base);
+		end_pfn = PFN_DOWN(regions[early_region_idx].base +
+				regions[early_region_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return pfn;
+
+		early_region_idx++;
+		next_start_pfn = PFN_DOWN(regions[early_region_idx].base);
+
+		if (pfn >= end_pfn && pfn <= next_start_pfn)
+			return next_start_pfn;
+	}
+
+	/* slow path, do the binary searching */
 	do {
 		mid = (right + left) / 2;
 
-		if (addr < type->regions[mid].base)
+		if (addr < regions[mid].base)
 			right = mid;
-		else if (addr >= (type->regions[mid].base +
-				  type->regions[mid].size))
+		else if (addr >= (regions[mid].base + regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn is valid */
+			early_region_idx = mid;
 			return pfn;
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
 		return -1UL;
-	else
-		return PHYS_PFN(type->regions[right].base);
+
+	early_region_idx = right;
+
+	return PHYS_PFN(regions[early_region_idx].base);
 }
 EXPORT_SYMBOL(memblock_next_valid_pfn);
 #endif /*CONFIG_HAVE_MEMBLOCK_PFN_VALID*/
-- 
2.7.4
