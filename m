From: puck.chen@hisilicon.com (Chen Feng)
Date: Tue, 5 Apr 2016 16:22:52 +0800
Subject: [PATCH 2/2] arm64: mm: make pfn always valid with flat memory
In-Reply-To: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
References: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <1459844572-53069-2-git-send-email-puck.chen@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the pfn always valid when using flat memory.
If the reserved memory is not align to memblock-size,
there will be holes in zone.

This patch makes the memory in buddy always in the
array of mem-map.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Fu Jun <oliver.fu@hisilicon.com>
---
 arch/arm64/mm/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ea989d8..0e1d5b7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -306,7 +306,8 @@ static void __init free_unused_memmap(void)
 	struct memblock_region *reg;
 
 	for_each_memblock(memory, reg) {
-		start = __phys_to_pfn(reg->base);
+		start = round_down(__phys_to_pfn(reg->base),
+				   MAX_ORDER_NR_PAGES);
 
 #ifdef CONFIG_SPARSEMEM
 		/*
@@ -327,8 +328,8 @@ static void __init free_unused_memmap(void)
 		 * memmap entries are valid from the bank end aligned to
 		 * MAX_ORDER_NR_PAGES.
 		 */
-		prev_end = ALIGN(__phys_to_pfn(reg->base + reg->size),
-				 MAX_ORDER_NR_PAGES);
+		prev_end = round_up(__phys_to_pfn(reg->base + reg->size),
+				    MAX_ORDER_NR_PAGES);
 	}
 
 #ifdef CONFIG_SPARSEMEM
-- 
1.9.1
