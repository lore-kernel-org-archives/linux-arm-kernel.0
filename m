From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:17:29 +0000
Subject: [PATCH 36/75] ARM: l2c: remove obsolete l2x0 ops for non-OF init
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYXB-0007FI-Pl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

non-OF initialisation has never been used with any cache controller
which isn't an ARM cache controller, so we can safely get rid of the
old (and buggy) l2x0_*-based operations structure.

This is also the last reference to:
- l2x0_clean_line()
- l2x0_inv_line()
- l2x0_flush_line()
- l2x0_flush_all()
- l2x0_clean_all()
- l2x0_inv_all()
- l2x0_inv_range()
- l2x0_clean_range()
- l2x0_flush_range()
- l2x0_enable()
- l2x0_resume()
so kill those functions too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 206 -----------------------------------------------
 1 file changed, 206 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b059b8d885dc..fc7ce31d9b52 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -134,20 +134,6 @@ static inline void cache_sync(void)
 	cache_wait(base + L2X0_CACHE_SYNC, 1);
 }
 
-static inline void l2x0_clean_line(unsigned long addr)
-{
-	void __iomem *base = l2x0_base;
-	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_CLEAN_LINE_PA);
-}
-
-static inline void l2x0_inv_line(unsigned long addr)
-{
-	void __iomem *base = l2x0_base;
-	cache_wait(base + L2X0_INV_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
-}
-
 #if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
 static inline void debug_writel(unsigned long val)
 {
@@ -161,27 +147,6 @@ static inline void debug_writel(unsigned long val)
 }
 #endif
 
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
-
-static inline void l2x0_flush_line(unsigned long addr)
-{
-	void __iomem *base = l2x0_base;
-	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-	writel_relaxed(addr, base + L2X0_CLEAN_INV_LINE_PA);
-}
-#endif
-
 static void l2x0_cache_sync(void)
 {
 	unsigned long flags;
@@ -209,131 +174,6 @@ static void l2x0_flush_all(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2x0_clean_all(void)
-{
-	unsigned long flags;
-
-	/* clean all ways */
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	__l2c_op_way(l2x0_base + L2X0_CLEAN_WAY);
-	cache_sync();
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
-static void l2x0_inv_all(void)
-{
-	unsigned long flags;
-
-	/* invalidate all ways */
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	/* Invalidating when L2 is enabled is a nono */
-	BUG_ON(readl(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN);
-	__l2c_op_way(l2x0_base + L2X0_INV_WAY);
-	cache_sync();
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
-static void l2x0_inv_range(unsigned long start, unsigned long end)
-{
-	void __iomem *base = l2x0_base;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	if (start & (CACHE_LINE_SIZE - 1)) {
-		start &= ~(CACHE_LINE_SIZE - 1);
-		debug_writel(0x03);
-		l2x0_flush_line(start);
-		debug_writel(0x00);
-		start += CACHE_LINE_SIZE;
-	}
-
-	if (end & (CACHE_LINE_SIZE - 1)) {
-		end &= ~(CACHE_LINE_SIZE - 1);
-		debug_writel(0x03);
-		l2x0_flush_line(end);
-		debug_writel(0x00);
-	}
-
-	while (start < end) {
-		unsigned long blk_end = start + min(end - start, 4096UL);
-
-		while (start < blk_end) {
-			l2x0_inv_line(start);
-			start += CACHE_LINE_SIZE;
-		}
-
-		if (blk_end < end) {
-			raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-			raw_spin_lock_irqsave(&l2x0_lock, flags);
-		}
-	}
-	cache_wait(base + L2X0_INV_LINE_PA, 1);
-	cache_sync();
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
-static void l2x0_clean_range(unsigned long start, unsigned long end)
-{
-	void __iomem *base = l2x0_base;
-	unsigned long flags;
-
-	if ((end - start) >= l2x0_size) {
-		l2x0_clean_all();
-		return;
-	}
-
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	start &= ~(CACHE_LINE_SIZE - 1);
-	while (start < end) {
-		unsigned long blk_end = start + min(end - start, 4096UL);
-
-		while (start < blk_end) {
-			l2x0_clean_line(start);
-			start += CACHE_LINE_SIZE;
-		}
-
-		if (blk_end < end) {
-			raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-			raw_spin_lock_irqsave(&l2x0_lock, flags);
-		}
-	}
-	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
-	cache_sync();
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
-static void l2x0_flush_range(unsigned long start, unsigned long end)
-{
-	void __iomem *base = l2x0_base;
-	unsigned long flags;
-
-	if ((end - start) >= l2x0_size) {
-		l2x0_flush_all();
-		return;
-	}
-
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	start &= ~(CACHE_LINE_SIZE - 1);
-	while (start < end) {
-		unsigned long blk_end = start + min(end - start, 4096UL);
-
-		debug_writel(0x03);
-		while (start < blk_end) {
-			l2x0_flush_line(start);
-			start += CACHE_LINE_SIZE;
-		}
-		debug_writel(0x00);
-
-		if (blk_end < end) {
-			raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-			raw_spin_lock_irqsave(&l2x0_lock, flags);
-		}
-	}
-	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-	cache_sync();
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
 static void l2x0_disable(void)
 {
 	unsigned long flags;
@@ -345,49 +185,6 @@ static void l2x0_disable(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2x0_enable(void __iomem *base, u32 aux, unsigned num_lock)
-{
-	unsigned id;
-
-	id = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
-	if (id == L2X0_CACHE_ID_PART_L310)
-		num_lock = 8;
-	else
-		num_lock = 1;
-
-	/* l2x0 controller is disabled */
-	writel_relaxed(aux, base + L2X0_AUX_CTRL);
-
-	/* Make sure that I&D is not locked down when starting */
-	l2c_unlock(base, num_lock);
-
-	l2x0_inv_all();
-
-	/* enable L2X0 */
-	writel_relaxed(L2X0_CTRL_EN, base + L2X0_CTRL);
-}
-
-static void l2x0_resume(void)
-{
-	void __iomem *base = l2x0_base;
-
-	if (!(readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN))
-		l2x0_enable(base, l2x0_saved_regs.aux_ctrl, 0);
-}
-
-static const struct l2c_init_data l2x0_init_fns __initconst = {
-	.enable = l2x0_enable,
-	.outer_cache = {
-		.inv_range = l2x0_inv_range,
-		.clean_range = l2x0_clean_range,
-		.flush_range = l2x0_flush_range,
-		.flush_all = l2x0_flush_all,
-		.disable = l2x0_disable,
-		.sync = l2x0_cache_sync,
-		.resume = l2x0_resume,
-	},
-};
-
 /*
  * L2C-210 specific code.
  *
@@ -966,9 +763,6 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	default:
-		data = &l2x0_init_fns;
-		break;
-
 	case L2X0_CACHE_ID_PART_L210:
 		data = &l2c210_data;
 		break;
-- 
1.8.3.1
