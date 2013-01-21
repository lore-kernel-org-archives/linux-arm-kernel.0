From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 21 Jan 2013 18:44:53 +0530
Subject: [PATCH 1/4] ARM: cache-l2x0: Manage the errata at run time
Message-ID: <20130121131451.GA29855@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to manage the errata by its own by using the
l2x0 ID register. This relieves the platforms from choosing the
Errata's at compile time

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    2 +
 arch/arm/mm/cache-l2x0.c                   |   77 +++++++++++++++-------------
 2 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 3b2c40b..d5994ac 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -117,6 +117,8 @@ static inline int l2x0_of_init(u32 aux_val, u32 aux_mask)
 }
 #endif
 
+asmlinkage u32 l2x0_get_rtl_release(void);
+
 struct l2x0_regs {
 	unsigned long phy_base;
 	unsigned long aux_ctrl;
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c2f3739..49058ac 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -49,6 +49,16 @@ struct l2x0_of_data {
 
 static bool of_init = false;
 
+/*
+ * Identify ther RTL releases of l2x0 - This might help in applying
+ * the l2x0 errata's dynamically rather compile time options
+ */
+asmlinkage u32 l2x0_get_rtl_release(void)
+{
+	return readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
+			L2X0_CACHE_ID_RTL_MASK;
+}
+
 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 {
 	/* wait for cache operation by line or way to complete */
@@ -87,46 +97,41 @@ static inline void l2x0_inv_line(unsigned long addr)
 	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
 }
 
-#if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
-static inline void debug_writel(unsigned long val)
+static void debug_writel(unsigned long val)
 {
-	if (outer_cache.set_debug)
-		outer_cache.set_debug(val);
+	u32 l2x0_revision = l2x0_get_rtl_release();
+
+	if (l2x0_revision == L2X0_CACHE_ID_RTL_R3P0 ||
+		l2x0_revision == L2X0_CACHE_ID_RTL_R2P0 ||
+		l2x0_revision == L2X0_CACHE_ID_RTL_R1P0 ||
+		l2x0_revision == L2X0_CACHE_ID_RTL_R0P0)
+			if (outer_cache.set_debug)
+				outer_cache.set_debug(val);
 }
 
 static void pl310_set_debug(unsigned long val)
 {
 	writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
 }
-#else
-/* Optimised out for non-errata case */
-static inline void debug_writel(unsigned long val)
-{
-}
-
-#define pl310_set_debug	NULL
-#endif
-
-#ifdef CONFIG_PL310_ERRATA_588369
-static inline void l2x0_flush_line(unsigned long addr)
-{
-	void __iomem *base = l2x0_base;
-
-	/* Clean by PA followed by Invalidate by PA */
-	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_CLEAN_LINE_PA);
-	cache_wait(base + L2X0_INV_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
-}
-#else
 
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
-	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_CLEAN_INV_LINE_PA);
+	u32 l2x0_revision = l2x0_get_rtl_release();
+
+	if (l2x0_revision == L2X0_CACHE_ID_RTL_R0P0 ||
+		l2x0_revision == L2X0_CACHE_ID_RTL_R1P0)
+	{
+		/* Clean by PA followed by Invalidate by PA */
+		cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+		writel_relaxed(addr, base + L2X0_CLEAN_LINE_PA);
+		cache_wait(base + L2X0_INV_LINE_PA, 1);
+		writel_relaxed(addr, base + L2X0_INV_LINE_PA);
+	} else {
+		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
+		writel_relaxed(addr, base + L2X0_CLEAN_INV_LINE_PA);
+	}
 }
-#endif
 
 static void l2x0_cache_sync(void)
 {
@@ -328,6 +333,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	int ways;
 	int way_size_shift = L2X0_WAY_SIZE_SHIFT;
 	const char *type;
+	u32 l2x0_revision = l2x0_get_rtl_release();
 
 	l2x0_base = base;
 	if (cache_id_part_number_from_dt)
@@ -348,10 +354,11 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		else
 			ways = 8;
 		type = "L310";
-#ifdef CONFIG_PL310_ERRATA_753970
-		/* Unmapped register. */
-		sync_reg_offset = L2X0_DUMMY_REG;
-#endif
+
+		if (l2x0_revision == L2X0_CACHE_ID_RTL_R3P0)
+			/* Unmapped register. */
+			sync_reg_offset = L2X0_DUMMY_REG;
+
 		if ((cache_id & L2X0_CACHE_ID_RTL_MASK) <= L2X0_CACHE_ID_RTL_R3P0)
 			outer_cache.set_debug = pl310_set_debug;
 		break;
@@ -594,8 +601,7 @@ static void __init pl310_of_setup(const struct device_node *np,
 
 static void __init pl310_save(void)
 {
-	u32 l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
-		L2X0_CACHE_ID_RTL_MASK;
+	u32 l2x0_revision = l2x0_get_rtl_release();
 
 	l2x0_saved_regs.tag_latency = readl_relaxed(l2x0_base +
 		L2X0_TAG_LATENCY_CTRL);
@@ -657,8 +663,7 @@ static void pl310_resume(void)
 		writel_relaxed(l2x0_saved_regs.filter_start,
 			l2x0_base + L2X0_ADDR_FILTER_START);
 
-		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
-			L2X0_CACHE_ID_RTL_MASK;
+		l2x0_revision = l2x0_get_rtl_release();
 
 		if (l2x0_revision >= L2X0_CACHE_ID_RTL_R2P0) {
 			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
-- 
1.7.2.dirty
