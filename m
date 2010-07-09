From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 12:08:08 +0100
Subject: [PATCH v2 2/3] ARM: Convert L2x0 to use the IO relaxed operations
	for cache sync
In-Reply-To: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100709110808.11333.47652.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is in preparation for a subsequent patch which adds barriers
to the I/O accessors. Since the mandatory barriers may do an L2 cache
sync, this patch avoids a recursive call into l2x0_cache_sync() via the
write*() accessors and wmb().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-l2x0.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9819869..532c35c 100644
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
 
@@ -47,14 +47,14 @@ static inline void l2x0_clean_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
 	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
-	writel(addr, base + L2X0_CLEAN_LINE_PA);
+	writel_relaxed(addr, base + L2X0_CLEAN_LINE_PA);
 }
 
 static inline void l2x0_inv_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
 	cache_wait(base + L2X0_INV_LINE_PA, 1);
-	writel(addr, base + L2X0_INV_LINE_PA);
+	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
 }
 
 #ifdef CONFIG_PL310_ERRATA_588369
@@ -75,9 +75,9 @@ static inline void l2x0_flush_line(unsigned long addr)
 
 	/* Clean by PA followed by Invalidate by PA */
 	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
-	writel(addr, base + L2X0_CLEAN_LINE_PA);
+	writel_relaxed(addr, base + L2X0_CLEAN_LINE_PA);
 	cache_wait(base + L2X0_INV_LINE_PA, 1);
-	writel(addr, base + L2X0_INV_LINE_PA);
+	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
 }
 #else
 
@@ -90,7 +90,7 @@ static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
 	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-	writel(addr, base + L2X0_CLEAN_INV_LINE_PA);
+	writel_relaxed(addr, base + L2X0_CLEAN_INV_LINE_PA);
 }
 #endif
 
@@ -109,7 +109,7 @@ static inline void l2x0_inv_all(void)
 
 	/* invalidate all ways */
 	spin_lock_irqsave(&l2x0_lock, flags);
-	writel(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
+	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
 	cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
 	cache_sync();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
@@ -215,8 +215,8 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 
 	l2x0_base = base;
 
-	cache_id = readl(l2x0_base + L2X0_CACHE_ID);
-	aux = readl(l2x0_base + L2X0_AUX_CTRL);
+	cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
+	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
 	/* Determine the number of ways */
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
@@ -245,17 +245,17 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	 * If you are booting from non-secure mode
 	 * accessing the below registers will fault.
 	 */
-	if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
 
 		/* l2x0 controller is disabled */
 		aux &= aux_mask;
 		aux |= aux_val;
-		writel(aux, l2x0_base + L2X0_AUX_CTRL);
+		writel_relaxed(aux, l2x0_base + L2X0_AUX_CTRL);
 
 		l2x0_inv_all();
 
 		/* enable L2X0 */
-		writel(1, l2x0_base + L2X0_CTRL);
+		writel_relaxed(1, l2x0_base + L2X0_CTRL);
 	}
 
 	outer_cache.inv_range = l2x0_inv_range;
