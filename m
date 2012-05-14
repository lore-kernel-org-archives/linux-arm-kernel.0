From: vitalya@ti.com (Vitaly Andrianov)
Date: Mon, 14 May 2012 13:49:56 -0400
Subject: [PATCH] ARM: dma-mapping: use PMD size for section unmap
Message-ID: <1337017796-27267-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_contiguous_remap() function clears existing section maps using
the wrong size (PGDIR_SIZE instead of PMD_SIZE).  This is a bug which
does not affect non-LPAE systems, where PGDIR_SIZE and PMD_SIZE are the same.
On LPAE systems, however, this bug causes the kernel to hang at this point.

This fix has been tested on both LPAE and non-LPAE kernel builds.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 446dc1b..d220d4f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -414,7 +414,7 @@ void __init dma_contiguous_remap(void)
 		 * Clear previous low-memory mapping
 		 */
 		for (addr = __phys_to_virt(start); addr < __phys_to_virt(end);
-		     addr += PGDIR_SIZE)
+		     addr += PMD_SIZE)
 			pmd_clear(pmd_off_k(addr));
 
 		iotable_init(&map, 1);
-- 
1.7.5.4
