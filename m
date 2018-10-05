From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri,  5 Oct 2018 10:16:40 -0600
Subject: [PATCH 3/5] arm64: mm: make use of new memblocks_present() helper
In-Reply-To: <20181005161642.2462-1-logang@deltatee.com>
References: <20181005161642.2462-1-logang@deltatee.com>
Message-ID: <20181005161642.2462-4-logang@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup the arm64_memory_present() function seeing it's very
similar to other arches.

memblocks_present() is a direct replacement of arm64_memory_present()

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 arch/arm64/mm/init.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 787e27964ab9..63fa9653f281 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -296,24 +296,6 @@ int pfn_valid(unsigned long pfn)
 EXPORT_SYMBOL(pfn_valid);
 #endif
 
-#ifndef CONFIG_SPARSEMEM
-static void __init arm64_memory_present(void)
-{
-}
-#else
-static void __init arm64_memory_present(void)
-{
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg) {
-		int nid = memblock_get_region_node(reg);
-
-		memory_present(nid, memblock_region_memory_base_pfn(reg),
-				memblock_region_memory_end_pfn(reg));
-	}
-}
-#endif
-
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
 
 /*
@@ -506,7 +488,7 @@ void __init bootmem_init(void)
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 	 * done after the fixed reservations.
 	 */
-	arm64_memory_present();
+	memblocks_present();
 
 	sparse_init();
 	zone_sizes_init(min, max);
-- 
2.19.0
