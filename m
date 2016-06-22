From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Jun 2016 12:13:45 +0100
Subject: [PATCH] arm64: mm: simplify memblock numa node extraction
Message-ID: <1466594025-27682-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently open-code extracting the NUMA node of a memblock region,
which requires an ifdef to cater for !CONFIG_NUMA builds where the
memblock_region::nid field does not exist.

The generic memblock_get_region_node helper is intended to cater for
this. For CONFIG_HAVE_MEMBLOCK_NODE_MAP, builds this returns reg->nid,
and for for !CONFIG_HAVE_MEMBLOCK_NODE_MAP builds this is a static
inline that returns 0. Note that for arm64,
CONFIG_HAVE_MEMBLOCK_NODE_MAP is selected iff CONFIG_NUMA is.

This patch makes use of memblock_get_region_node to simplify the arm64
code. At the same time, we can move the nid variable definition into the
loop, as this is the only place it is used.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d45f862..0652d60 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -160,12 +160,10 @@ static void __init arm64_memory_present(void)
 static void __init arm64_memory_present(void)
 {
 	struct memblock_region *reg;
-	int nid = 0;
 
 	for_each_memblock(memory, reg) {
-#ifdef CONFIG_NUMA
-		nid = reg->nid;
-#endif
+		int nid = memblock_get_region_node(reg);
+
 		memory_present(nid, memblock_region_memory_base_pfn(reg),
 				memblock_region_memory_end_pfn(reg));
 	}
-- 
1.9.1
