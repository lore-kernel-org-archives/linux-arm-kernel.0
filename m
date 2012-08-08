From: chris_brand@broadcom.com (chris_brand at broadcom.com)
Date: Wed, 8 Aug 2012 14:04:30 -0700
Subject: [PATCH] ARM: mm: MMU mapping of CMA regions
Message-ID: <1344459870-12790-1-git-send-email-chris_brand@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brand <cbrand@broadcom.com>

Fix dma_contiguous_remap() so that it continues through all the
regions, even after encountering one that is outside lowmem.
Without this change, if you have two CMA regions, the first outside
lowmem and the second inside lowmem, neither will get
set up in the MMU. Data written to the second region then doesn't get
automatically flushed from the cache into memory.

Signed-off-by: Chris Brand <cbrand@broadcom.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 655878b..4a4f3f9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -388,7 +388,7 @@ void __init dma_contiguous_remap(void)
 		if (end > arm_lowmem_limit)
 			end = arm_lowmem_limit;
 		if (start >= end)
-			return;
+			continue;
 
 		map.pfn = __phys_to_pfn(start);
 		map.virtual = __phys_to_virt(start);
-- 
1.7.5.4
