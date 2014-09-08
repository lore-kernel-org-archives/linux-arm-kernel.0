From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 22:42:23 +0200
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <2958731.nsOomQFma0@wuerfel>
References: <2852268.nkG1OoBDfE@wuerfel>
 <20140908153946.GB12361@n2100.arm.linux.org.uk> <2958731.nsOomQFma0@wuerfel>
Message-ID: <3459745.mC0zoLRDxy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aurora cache controller is the only remaining user of a couple
of functions in this file and are completely unused when that is
disabled, leading to build warnings:

arch/arm/mm/cache-l2x0.c:167:13: warning: 'l2x0_cache_sync' defined but not used [-Wunused-function]
arch/arm/mm/cache-l2x0.c:184:13: warning: 'l2x0_flush_all' defined but not used [-Wunused-function]
arch/arm/mm/cache-l2x0.c:194:13: warning: 'l2x0_disable' defined but not used [-Wunused-function]

With the knowledge that the code is now aurora-specific, we can
simplify it noticeably:

- The pl310 errata workarounds are not needed on aurora and can be removed
- The cache_wait() macro is never needed since this is not an l210/l220
- aurora_pa_range can keep the spinlock while syncing the cache
- We can load the l2x0_base into a local variable across operations

There should be no functional change in this patch, but readability
and the generated object code improves, along with avoiding the
warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
 arch/arm/mm/cache-l2x0.c | 115 ++++++++++++++++++++++++++-----------------------------------------------
 1 file changed, 41 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5f2c988a06ac..0964e83e0238 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -135,73 +135,6 @@ static void l2c_disable(void)
 	dsb(st);
 }
 
-#ifdef CONFIG_CACHE_PL310
-static inline void cache_wait(void __iomem *reg, unsigned long mask)
-{
-	/* cache operations by line are atomic on PL310 */
-}
-#else
-#define cache_wait	l2c_wait_mask
-#endif
-
-static inline void cache_sync(void)
-{
-	void __iomem *base = l2x0_base;
-
-	writel_relaxed(0, base + sync_reg_offset);
-	cache_wait(base + L2X0_CACHE_SYNC, 1);
-}
-
-#if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
-static inline void debug_writel(unsigned long val)
-{
-	l2c_set_debug(l2x0_base, val);
-}
-#else
-/* Optimised out for non-errata case */
-static inline void debug_writel(unsigned long val)
-{
-}
-#endif
-
-static void l2x0_cache_sync(void)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	cache_sync();
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
-static void __l2x0_flush_all(void)
-{
-	debug_writel(0x03);
-	__l2c_op_way(l2x0_base + L2X0_CLEAN_INV_WAY);
-	cache_sync();
-	debug_writel(0x00);
-}
-
-static void l2x0_flush_all(void)
-{
-	unsigned long flags;
-
-	/* clean all ways */
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	__l2x0_flush_all();
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
-static void l2x0_disable(void)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	__l2x0_flush_all();
-	l2c_write_sec(0, l2x0_base, L2X0_CTRL);
-	dsb(st);
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
 static void l2c_save(void __iomem *base)
 {
 	l2x0_saved_regs.aux_ctrl = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
@@ -1126,14 +1059,14 @@ static unsigned long calc_range_end(unsigned long start, unsigned long end)
 static void aurora_pa_range(unsigned long start, unsigned long end,
 			unsigned long offset)
 {
+	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	writel_relaxed(start, l2x0_base + AURORA_RANGE_BASE_ADDR_REG);
-	writel_relaxed(end, l2x0_base + offset);
+	writel_relaxed(start, base + AURORA_RANGE_BASE_ADDR_REG);
+	writel_relaxed(end, base + offset);
+	writel_relaxed(0, base + AURORA_SYNC_REG);
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-
-	cache_sync();
 }
 
 static void aurora_inv_range(unsigned long start, unsigned long end)
@@ -1193,6 +1126,40 @@ static void aurora_flush_range(unsigned long start, unsigned long end)
 	}
 }
 
+static void aurora_flush_all(void)
+{
+	void __iomem *base = l2x0_base;
+	unsigned long flags;
+
+	/* clean all ways */
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	__l2c_op_way(base + L2X0_CLEAN_INV_WAY);
+	writel_relaxed(0, base + AURORA_SYNC_REG);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
+static void aurora_cache_sync(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	writel_relaxed(0, l2x0_base + AURORA_SYNC_REG);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
+static void aurora_disable(void)
+{
+	void __iomem *base = l2x0_base;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	__l2c_op_way(base + L2X0_CLEAN_INV_WAY);
+	writel_relaxed(0, base + AURORA_SYNC_REG);
+	l2c_write_sec(0, base, L2X0_CTRL);
+	dsb(st);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
 static void aurora_save(void __iomem *base)
 {
 	l2x0_saved_regs.ctrl = readl_relaxed(base + L2X0_CTRL);
@@ -1267,9 +1234,9 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 		.inv_range   = aurora_inv_range,
 		.clean_range = aurora_clean_range,
 		.flush_range = aurora_flush_range,
-		.flush_all   = l2x0_flush_all,
-		.disable     = l2x0_disable,
-		.sync        = l2x0_cache_sync,
+		.flush_all   = aurora_flush_all,
+		.disable     = aurora_disable,
+		.sync        = aurora_cache_sync,
 		.resume      = aurora_resume,
 	},
 };
