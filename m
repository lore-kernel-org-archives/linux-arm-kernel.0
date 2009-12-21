From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 21 Dec 2009 01:00:22 +0000
Subject: [PATCH] armv6: invalidate cache on DMA_FROM_DEVICE/DMA_BIDIRECTIONAL
Message-ID: <1261357222-18470-1-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARMv6 cores will use speculative prefetching. This can be a problem
when devices DMA to memory and the core prefetches data before the
device has written it. This can result in stale data being stored in
the cache. The DMA API will request the invalidation but this is
currently a no-op on v6. Use the same dma_unmap_area implementation as
for v7.

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-v6.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index a11934e..a4da9d2 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -284,6 +284,9 @@ ENDPROC(v6_dma_map_area)
  *	- dir	- DMA direction
  */
 ENTRY(v6_dma_unmap_area)
+	add	r1, r1, r0
+	teq	r2, #DMA_TO_DEVICE
+	bne	v6_dma_inv_range
 	mov	pc, lr
 ENDPROC(v6_dma_unmap_area)
 
-- 
1.6.5.4
