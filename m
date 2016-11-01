From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 1 Nov 2016 17:55:44 +0100
Subject: [PATCH] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <1475747527-32387-1-git-send-email-rrichter@cavium.com>
References: <1475747527-32387-1-git-send-email-rrichter@cavium.com>
Message-ID: <20161101165544.GP22012@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.10.16 11:52:07, Robert Richter wrote:
> There is a memory setup problem on ThunderX systems with certain
> memory configurations. The symptom is
> 
>  kernel BUG at mm/page_alloc.c:1848!
> 
> This happens for some configs with 64k page size enabled. The bug
> triggers for page zones with some pages in the zone not assigned to
> this particular zone. In my case some pages that are marked as nomap
> were not reassigned to the new zone of node 1, so those are still
> assigned to node 0.
> 
> The reason for the mis-configuration is a change in pfn_valid() which
> reports pages marked nomap as invalid:
> 
>  68709f45385a arm64: only consider memblocks with NOMAP cleared for linear mapping
> 
> This causes pages marked as nomap being no long reassigned to the new
> zone in memmap_init_zone() by calling __init_single_pfn().
> 
> Fixing this by restoring the old behavior of pfn_valid() to use
> memblock_is_memory(). Also changing users of pfn_valid() in arm64 code
> to use memblock_is_map_memory() where necessary. This only affects
> code in ioremap.c. The code in mmu.c still can use the new version of
> pfn_valid().

Below a reproducer for non-numa systems. Note that invalidating the
node id just simulates a different node in reality.

The patch injects a (pageblock_order) unaligned NOMAP mem range at the
end of a memory block and then tries to free that area. This causes a
BUG_ON() (log attached).

-Robert



>From 20d853e300c99be5420c7ee3f072c318804cac1b Mon Sep 17 00:00:00 2001
From: root <root@10.18.240.201>
Date: Tue, 1 Nov 2016 15:04:43 +0000
Subject: [PATCH] mm-fault-reproducer

Signed-off-by: root <root@10.18.240.201>
---
 arch/arm64/mm/init.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c      |  4 ++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 21c489bdeb4e..feaa7ab97551 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -36,6 +36,7 @@
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
+#include <linux/page-isolation.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -301,6 +302,80 @@ void __init arm64_memblock_init(void)
 	memblock_allow_resize();
 }
 
+static struct page *inject_pageblock;
+
+static void __init inject_nomap_create(void)
+{
+	phys_addr_t start, end;
+	unsigned long start_pfn, end_pfn;
+	u64 i;
+	int ret = -ENOMEM;
+
+	pr_info("%s: PAGES_PER_SECTION=%08lx pageblock_nr_pages=%08lx PAGE_SIZE=%08lx\n",
+		__func__, PAGES_PER_SECTION, pageblock_nr_pages, PAGE_SIZE);
+
+	/*
+	 * find a mem range with a complet pageblock in it
+	 */
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
+		start_pfn = PFN_DOWN(start);
+		end_pfn = PFN_UP(end);
+		if  (end_pfn - (start_pfn & ~(pageblock_nr_pages-1)) > 2 * pageblock_nr_pages)
+			break;
+	}
+
+	if (i == ULLONG_MAX)
+		goto fail;
+
+	start = PFN_PHYS(start_pfn);
+	end = PFN_PHYS(end_pfn) - 1;
+
+	pr_info("%s: Injecting into range: [%pa-%pa]\n", __func__, &start, &end);
+
+	/* mark the upper 5 pages nomap of a complete pageblock */
+	start_pfn = end_pfn & ~(pageblock_nr_pages-1);
+	start_pfn -= 5;			/* unalign by 5 pages */
+
+	start = PFN_PHYS(start_pfn);
+	end = PFN_PHYS(end_pfn) - 1;
+
+	ret = memblock_mark_nomap(start, end - start + 1);
+	if (ret)
+		goto fail;
+
+	inject_pageblock = pfn_to_page(start_pfn & ~(pageblock_nr_pages-1));
+
+	pr_info("%s: Injected nomap range at: [%pa-%pa] zones: %p %p\n", __func__,
+		&start, &end, page_zone(inject_pageblock),
+		page_zone(inject_pageblock + pageblock_nr_pages - 1));
+
+	return;
+fail:
+	pr_err("%s: Could not inject_unaligned_range: %d\n", __func__, ret);
+}
+
+static void __init inject_nomap_move(void)
+{
+	phys_addr_t start, end;
+	int ret;
+
+	if (!inject_pageblock)
+		return;
+
+	start = PFN_PHYS(page_to_pfn(inject_pageblock));
+	end = PFN_PHYS(page_to_pfn(inject_pageblock) + pageblock_nr_pages) - 1;
+
+	pr_info("%s: Moving [%pa-%pa] zones: %p %p\n", __func__,
+		&start, &end, page_zone(inject_pageblock),
+		page_zone(inject_pageblock + pageblock_nr_pages - 1));
+
+	ret = move_freepages_block(page_zone(inject_pageblock),
+				inject_pageblock,
+				gfpflags_to_migratetype(GFP_KERNEL));
+
+	pr_info("%s: Moved %d pages\n", __func__, ret);
+}
+
 void __init bootmem_init(void)
 {
 	unsigned long min, max;
@@ -320,6 +395,7 @@ void __init bootmem_init(void)
 	arm64_memory_present();
 
 	sparse_init();
+	inject_nomap_create();
 	zone_sizes_init(min, max);
 
 	high_memory = __va((max << PAGE_SHIFT) - 1) + 1;
@@ -479,6 +555,8 @@ void __init mem_init(void)
 		 */
 		sysctl_overcommit_memory = OVERCOMMIT_ALWAYS;
 	}
+
+	inject_nomap_move();
 }
 
 void free_initmem(void)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2b3bf6767d54..19d74637e242 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5077,8 +5077,10 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context != MEMMAP_EARLY)
 			goto not_early;
 
-		if (!early_pfn_valid(pfn))
+		if (!early_pfn_valid(pfn)) {
+			set_page_node(pfn_to_page(pfn), NUMA_NO_NODE);
 			continue;
+		}
 		if (!early_pfn_in_nid(pfn, nid))
 			continue;
 		if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
-- 
2.9.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: typescript-crb2s-test21-201611010941-trigger-mm-fault.xz
Type: application/x-xz
Size: 10420 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161101/7eae9153/attachment-0001.xz>
