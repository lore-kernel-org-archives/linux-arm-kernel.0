From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 29 Jan 2013 15:44:39 +0530
Subject: [PATCH v2 2/5] ARM: cache-l2x0: Manage the errata at run time
Message-ID: <20130129101432.GA16507@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to manage the errata by its own by using the
l2x0 ID register. This relieves the platforms from choosing the
Errata's at compile time

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    1 +
 arch/arm/mm/cache-l2x0.c                   |   72 +++++++++++++--------------
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 49ac638..ab76131 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -134,6 +134,7 @@ struct l2x0_regs {
 };
 
 extern struct l2x0_regs l2x0_saved_regs;
+extern u32 l2x0_revision;
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 432fef0..4f66e64 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -38,8 +38,10 @@ static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
 /* Aurora don't have the cache ID register available, so we have to
  * pass it though the device tree */
 static u32  cache_id_part_number_from_dt;
+static u32  cache_rtl_number_from_dt;
 
 struct l2x0_regs l2x0_saved_regs;
+u32 l2x0_revision;
 
 struct l2x0_of_data {
 	void (*setup)(const struct device_node *, u32 *, u32 *);
@@ -87,7 +89,6 @@ static inline void l2x0_inv_line(unsigned long addr)
 	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
 }
 
-#if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
 static inline void debug_writel(unsigned long val)
 {
 	if (outer_cache.set_debug)
@@ -96,37 +97,31 @@ static inline void debug_writel(unsigned long val)
 
 static void pl310_set_debug(unsigned long val)
 {
-	writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
-}
-#else
-/* Optimised out for non-errata case */
-static inline void debug_writel(unsigned long val)
-{
+	/* manage ERRATA_588369 and ERRATA_727915 */
+	if (l2x0_revision == L2X0_CACHE_ID_RTL_R0P0 ||
+		l2x0_revision == L2X0_CACHE_ID_RTL_R1P0 ||
+		l2x0_revision == L2X0_CACHE_ID_RTL_R2P0 ||
+		l2x0_revision == L2X0_CACHE_ID_RTL_R3P0)
+			writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
 }
 
-#define pl310_set_debug	NULL
-#endif
-
-#ifdef CONFIG_PL310_ERRATA_588369
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
 
-	/* Clean by PA followed by Invalidate by PA */
-	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_CLEAN_LINE_PA);
-	cache_wait(base + L2X0_INV_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
-}
-#else
-
-static inline void l2x0_flush_line(unsigned long addr)
-{
-	void __iomem *base = l2x0_base;
-	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_CLEAN_INV_LINE_PA);
+	/* manage the ERRATA_588369 */
+	if (l2x0_revision == L2X0_CACHE_ID_RTL_R0P0 ||
+			l2x0_revision == L2X0_CACHE_ID_RTL_R1P0) {
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
@@ -330,11 +325,15 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask, bool smc)
 	const char *type;
 
 	l2x0_base = base;
-	if (cache_id_part_number_from_dt)
+	if (cache_id_part_number_from_dt) {
 		cache_id = cache_id_part_number_from_dt;
-	else
+		l2x0_revision = cache_rtl_number_from_dt;
+	} else {
 		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID)
 			& L2X0_CACHE_ID_PART_MASK;
+		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID)
+			& L2X0_CACHE_ID_RTL_MASK;
+	}
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
 	aux &= aux_mask;
@@ -348,10 +347,13 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask, bool smc)
 		else
 			ways = 8;
 		type = "L310";
-#ifdef CONFIG_PL310_ERRATA_753970
-		/* Unmapped register. */
-		sync_reg_offset = L2X0_DUMMY_REG;
-#endif
+
+		/* handle ERRATA_753970 */
+		if (l2x0_revision == L2X0_CACHE_ID_RTL_R3P0) {
+			/* Unmapped register. */
+			sync_reg_offset = L2X0_DUMMY_REG;
+		}
+
 		if (smc)
 			outer_cache.set_debug = pl310_set_debug;
 		else
@@ -605,8 +607,6 @@ static void __init pl310_of_setup(const struct device_node *np,
 
 static void __init pl310_save(void)
 {
-	u32 l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
-		L2X0_CACHE_ID_RTL_MASK;
 
 	l2x0_saved_regs.tag_latency = readl_relaxed(l2x0_base +
 		L2X0_TAG_LATENCY_CTRL);
@@ -655,7 +655,6 @@ static void l2x0_resume(void)
 
 static void pl310_resume(void)
 {
-	u32 l2x0_revision;
 
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* restore pl310 setup */
@@ -668,9 +667,6 @@ static void pl310_resume(void)
 		writel_relaxed(l2x0_saved_regs.filter_start,
 			l2x0_base + L2X0_ADDR_FILTER_START);
 
-		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
-			L2X0_CACHE_ID_RTL_MASK;
-
 		if (l2x0_revision >= L2X0_CACHE_ID_RTL_R2P0) {
 			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
 				l2x0_base + L2X0_PREFETCH_CTRL);
@@ -710,6 +706,8 @@ static void __init aurora_of_setup(const struct device_node *np,
 
 	of_property_read_u32(np, "cache-id-part",
 			&cache_id_part_number_from_dt);
+	of_property_read_u32(np, "cache-id-rtl",
+			&cache_rtl_number_from_dt);
 
 	/* Determine and save the write policy */
 	l2_wt_override = of_property_read_bool(np, "wt-override");
-- 
1.7.2.dirty
