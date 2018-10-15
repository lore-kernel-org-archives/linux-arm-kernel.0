From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 15 Oct 2018 11:56:59 -0600
Subject: [PATCH v2 3/6] ARM: mm: make use of new memblocks_present() helper
In-Reply-To: <20181015175702.9036-1-logang@deltatee.com>
References: <20181015175702.9036-1-logang@deltatee.com>
Message-ID: <20181015175702.9036-4-logang@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup the arm_memory_present() function seeing it's very
similar to other arches.

The new memblocks_present() helper checks for node ids which the
arm version did not. However, this is equivalent seeing
HAVE_MEMBLOCK_NODE_MAP should be false in this arch and therefore
memblock_get_region_node() should return 0.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Philip Derrin <philip@cog.systems>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/init.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0cc8e04295a4..e2710dd7446f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -201,21 +201,6 @@ int pfn_valid(unsigned long pfn)
 EXPORT_SYMBOL(pfn_valid);
 #endif
 
-#ifndef CONFIG_SPARSEMEM
-static void __init arm_memory_present(void)
-{
-}
-#else
-static void __init arm_memory_present(void)
-{
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg)
-		memory_present(0, memblock_region_memory_base_pfn(reg),
-			       memblock_region_memory_end_pfn(reg));
-}
-#endif
-
 static bool arm_memblock_steal_permitted = true;
 
 phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
@@ -317,7 +302,7 @@ void __init bootmem_init(void)
 	 * Sparsemem tries to allocate bootmem in memory_present(),
 	 * so must be done after the fixed reservations
 	 */
-	arm_memory_present();
+	memblocks_present();
 
 	/*
 	 * sparse_init() needs the bootmem allocator up and running.
-- 
2.19.0
