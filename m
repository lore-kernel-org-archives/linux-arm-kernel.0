From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 14:20:24 +0100
Subject: [RFC PATCH 2/3] ARM: Convert L2x0 to use the IO relaxed operations
	for cache sync
In-Reply-To: <20100705130010.5157.32032.stgit@e102109-lin.cambridge.arm.com>
References: <20100705130010.5157.32032.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100705132024.5157.93765.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is in preparation for a subsequent patch which adds barriers
to the I/O accessors. Since the mandatory barriers may do an L2 cache
sync, this patch avoids a recursive call into l2x0_cache_sync() via the
write*() accessors and wmb().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-l2x0.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9819869..086d7e2 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -32,14 +32,14 @@ static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
 {
 	/* wait for the operation to complete */
-	while (readl(reg) & mask)
+	while (readl_relaxed(reg) & mask)
 		;
 }
 
 static inline void cache_sync(void)
 {
 	void __iomem *base = l2x0_base;
-	writel(0, base + L2X0_CACHE_SYNC);
+	writel_relaxed(0, base + L2X0_CACHE_SYNC);
 	cache_wait(base + L2X0_CACHE_SYNC, 1);
 }
 
