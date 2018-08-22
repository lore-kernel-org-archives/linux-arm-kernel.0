From: hejianet@gmail.com (Jia He)
Date: Wed, 22 Aug 2018 11:07:17 +0800
Subject: [PATCH v11 3/3] mm: page_alloc: reduce unnecessary binary search in
 memblock_next_valid_pfn
In-Reply-To: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
Message-ID: <1534907237-2982-4-git-send-email-jia.he@hxt-semitech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement.

E.g. if pfn and pfn+1 are in the same memblock region, we can simply pfn++
instead of doing the binary search in memblock_next_valid_pfn.

Furthermore, if the pfn is in a gap of two memory region, skip to next
region directly if possible.

Attached the memblock region information in my server.
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000200000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000017ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x000000000021ffff]
[    0.000000]   node   0: [mem 0x0000000000820000-0x000000000307ffff]
[    0.000000]   node   0: [mem 0x0000000003080000-0x000000000308ffff]
[    0.000000]   node   0: [mem 0x0000000003090000-0x00000000031fffff]
[    0.000000]   node   0: [mem 0x0000000003200000-0x00000000033fffff]
[    0.000000]   node   0: [mem 0x0000000003410000-0x00000000034fffff]
[    0.000000]   node   0: [mem 0x0000000003500000-0x000000000351ffff]
[    0.000000]   node   0: [mem 0x0000000003520000-0x000000000353ffff]
[    0.000000]   node   0: [mem 0x0000000003540000-0x0000000003e3ffff]
[    0.000000]   node   0: [mem 0x0000000003e40000-0x0000000003e7ffff]
[    0.000000]   node   0: [mem 0x0000000003e80000-0x0000000003ecffff]
[    0.000000]   node   0: [mem 0x0000000003ed0000-0x0000000003ed5fff]
[    0.000000]   node   0: [mem 0x0000000003ed6000-0x0000000006eeafff]
[    0.000000]   node   0: [mem 0x0000000006eeb000-0x000000000710ffff]
[    0.000000]   node   0: [mem 0x0000000007110000-0x0000000007f0ffff]
[    0.000000]   node   0: [mem 0x0000000007f10000-0x0000000007faffff]
[    0.000000]   node   0: [mem 0x0000000007fb0000-0x000000000806ffff]
[    0.000000]   node   0: [mem 0x0000000008070000-0x00000000080affff]
[    0.000000]   node   0: [mem 0x00000000080b0000-0x000000000832ffff]
[    0.000000]   node   0: [mem 0x0000000008330000-0x000000000836ffff]
[    0.000000]   node   0: [mem 0x0000000008370000-0x000000000838ffff]
[    0.000000]   node   0: [mem 0x0000000008390000-0x00000000083a9fff]
[    0.000000]   node   0: [mem 0x00000000083aa000-0x00000000083bbfff]
[    0.000000]   node   0: [mem 0x00000000083bc000-0x00000000083fffff]
[    0.000000]   node   0: [mem 0x0000000008400000-0x000000000841ffff]
[    0.000000]   node   0: [mem 0x0000000008420000-0x000000000843ffff]
[    0.000000]   node   0: [mem 0x0000000008440000-0x000000000865ffff]
[    0.000000]   node   0: [mem 0x0000000008660000-0x000000000869ffff]
[    0.000000]   node   0: [mem 0x00000000086a0000-0x00000000086affff]
[    0.000000]   node   0: [mem 0x00000000086b0000-0x00000000086effff]
[    0.000000]   node   0: [mem 0x00000000086f0000-0x0000000008b6ffff]
[    0.000000]   node   0: [mem 0x0000000008b70000-0x0000000008bbffff]
[    0.000000]   node   0: [mem 0x0000000008bc0000-0x0000000008edffff]
[    0.000000]   node   0: [mem 0x0000000008ee0000-0x0000000008ee0fff]
[    0.000000]   node   0: [mem 0x0000000008ee1000-0x0000000008ee2fff]
[    0.000000]   node   0: [mem 0x0000000008ee3000-0x000000000decffff]
[    0.000000]   node   0: [mem 0x000000000ded0000-0x000000000defffff]
[    0.000000]   node   0: [mem 0x000000000df00000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000010800000-0x0000000017feffff]
[    0.000000]   node   0: [mem 0x000000001c000000-0x000000001c00ffff]
[    0.000000]   node   0: [mem 0x000000001c010000-0x000000001c7fffff]
[    0.000000]   node   0: [mem 0x000000001c810000-0x000000007efbffff]
[    0.000000]   node   0: [mem 0x000000007efc0000-0x000000007efdffff]
[    0.000000]   node   0: [mem 0x000000007efe0000-0x000000007efeffff]
[    0.000000]   node   0: [mem 0x000000007eff0000-0x000000007effffff]
[    0.000000]   node   0: [mem 0x000000007f000000-0x00000017ffffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000200000-0x00000017ffffffff]
[    0.000000] On node 0 totalpages: 25145296
[    0.000000]   DMA32 zone: 16376 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 1028048 pages, LIFO batch:31
[    0.000000]   Normal zone: 376832 pages used for memmap
[    0.000000]   Normal zone: 24117248 pages, LIFO batch:31

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 mm/memblock.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 077ca62..46cb6be 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1144,28 +1144,49 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
 {
 	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *regions = type->regions;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
+	unsigned long start_pfn, end_pfn, next_start_pfn;
 	phys_addr_t addr = PFN_PHYS(++pfn);
+	static int early_region_idx __initdata_memblock = -1;
 
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
1.8.3.1
