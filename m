From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:34:26 +0100
Subject: [PATCH 041/222] ARM: l2c: provide generic hook to intercept writes to
 secure registers
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeOg-0007Fu-E7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Linux is running in the non-secure world, any write to a secure
L2C register will generate an abort.  Platforms normally have to call
firmware to work around this.  Provide a hook for them to intercept
any L2C secure register write.

l2c_write_sec() avoids writes to secure registers which are already set
to the appropriate value, thus avoiding the overhead of needlessly
calling into the secure monitor.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/outercache.h |  5 ++++-
 arch/arm/mm/cache-l2x0.c          | 42 ++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index e9a0797fe188..5066fa2f73ab 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -33,8 +33,11 @@ struct outer_cache_fns {
 #ifdef CONFIG_OUTER_CACHE_SYNC
 	void (*sync)(void);
 #endif
-	void (*set_debug)(unsigned long);
 	void (*resume)(void);
+
+	/* This is an ARM L2C thing */
+	void (*set_debug)(unsigned long);
+	void (*write_sec)(unsigned long, unsigned);
 };
 
 extern struct outer_cache_fns outer_cache;
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b4d373ab1a5c..369a9d01d94f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -60,13 +60,30 @@ static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
 }
 
 /*
+ * By default, we write directly to secure registers.  Platforms must
+ * override this if they are running non-secure.
+ */
+static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned reg)
+{
+	if (val == readl_relaxed(base + reg))
+		return;
+	if (outer_cache.write_sec)
+		outer_cache.write_sec(val, reg);
+	else
+		writel_relaxed(val, base + reg);
+}
+
+/*
  * This should only be called when we have a requirement that the
  * register be written due to a work-around, as platforms running
  * in non-secure mode may not be able to access this register.
  */
 static inline void l2c_set_debug(void __iomem *base, unsigned long val)
 {
-	outer_cache.set_debug(val);
+	if (outer_cache.set_debug)
+		outer_cache.set_debug(val);
+	else
+		l2c_write_sec(val, base, L2X0_DEBUG_CTRL);
 }
 
 static void __l2c_op_way(void __iomem *reg)
@@ -95,9 +112,7 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 {
 	unsigned long flags;
 
-	/* Only write the aux register if it needs changing */
-	if (readl_relaxed(base + L2X0_AUX_CTRL) != aux)
-		writel_relaxed(aux, base + L2X0_AUX_CTRL);
+	l2c_write_sec(aux, base, L2X0_AUX_CTRL);
 
 	l2c_unlock(base, num_lock);
 
@@ -107,7 +122,7 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 	l2c_wait_mask(base + sync_reg_offset, 1);
 	local_irq_restore(flags);
 
-	writel_relaxed(L2X0_CTRL_EN, base + L2X0_CTRL);
+	l2c_write_sec(L2X0_CTRL_EN, base, L2X0_CTRL);
 }
 
 static void l2c_disable(void)
@@ -115,7 +130,7 @@ static void l2c_disable(void)
 	void __iomem *base = l2x0_base;
 
 	outer_cache.flush_all();
-	writel_relaxed(0, base + L2X0_CTRL);
+	l2c_write_sec(0, base, L2X0_CTRL);
 	dsb(st);
 }
 
@@ -139,7 +154,7 @@ static inline void cache_sync(void)
 #if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
 static inline void debug_writel(unsigned long val)
 {
-	if (outer_cache.set_debug)
+	if (outer_cache.set_debug || outer_cache.write_sec)
 		l2c_set_debug(l2x0_base, val);
 }
 #else
@@ -182,7 +197,7 @@ static void l2x0_disable(void)
 
 	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	__l2x0_flush_all();
-	writel_relaxed(0, l2x0_base + L2X0_CTRL);
+	l2c_write_sec(0, l2x0_base, L2X0_CTRL);
 	dsb(st);
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
@@ -599,11 +614,11 @@ static void l2c310_resume(void)
 				L2X0_CACHE_ID_RTL_MASK;
 
 		if (revision >= L310_CACHE_ID_RTL_R2P0)
-			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
-				       base + L2X0_PREFETCH_CTRL);
+			l2c_write_sec(l2x0_saved_regs.prefetch_ctrl, base,
+				      L2X0_PREFETCH_CTRL);
 		if (revision >= L310_CACHE_ID_RTL_R3P0)
-			writel_relaxed(l2x0_saved_regs.pwr_ctrl,
-				       base + L2X0_POWER_CTRL);
+			l2c_write_sec(l2x0_saved_regs.pwr_ctrl, base,
+				      L2X0_POWER_CTRL);
 
 		l2c_enable(base, l2x0_saved_regs.aux_ctrl, 8);
 	}
@@ -732,8 +747,11 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	l2x0_size = ways * (data->way_size_0 << way_size_bits);
 
 	fns = data->outer_cache;
+	fns.write_sec = outer_cache.write_sec;
 	if (data->fixup)
 		data->fixup(l2x0_base, cache_id, &fns);
+	if (fns.write_sec)
+		fns.set_debug = NULL;
 
 	/*
 	 * Check if l2x0 controller is already enabled.  If we are booting
-- 
1.8.3.1
