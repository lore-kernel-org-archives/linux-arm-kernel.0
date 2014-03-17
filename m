From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:40 +0000
Subject: [PATCH 37/44] ARM: l2c: provide generic hook to intercept writes to
 secure registers
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLEO-0002eM-B2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Linux is running in the non-secure world, any write to a secure
L2C register will generate an abort.  Platforms normally have to call
firmware to work around this.  Provide a hook for them to intercept
any L2C secure register write.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/outercache.h |  5 ++++-
 arch/arm/mm/cache-l2x0.c          | 34 ++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 1ee2cf23fae1..69f57a5c0dd3 100644
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
index 44b8fd6ae2f6..f9fe70792bc9 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -59,13 +59,28 @@ static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
 }
 
 /*
+ * By default, we write directly to secure registers.  Platforms must
+ * override this if they are running non-secure.
+ */
+static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned reg)
+{
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
@@ -96,7 +111,7 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 
 	l2c_unlock(base, num_lock);
 
-	writel_relaxed(aux, base + L2X0_AUX_CTRL);
+	l2c_write_sec(aux, base, L2X0_AUX_CTRL);
 
 	local_irq_save(flags);
 	__l2c_op_way(base + L2X0_INV_WAY);
@@ -104,7 +119,7 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 	l2c_wait_mask(base + sync_reg_offset, 1);
 	local_irq_restore(flags);
 
-	writel_relaxed(L2X0_CTRL_EN, base + L2X0_CTRL);
+	l2c_write_sec(L2X0_CTRL_EN, base, L2X0_CTRL);
 }
 
 #ifdef CONFIG_CACHE_PL310
@@ -141,7 +156,7 @@ static inline void l2x0_inv_line(unsigned long addr)
 #if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
 static inline void debug_writel(unsigned long val)
 {
-	if (outer_cache.set_debug)
+	if (outer_cache.set_debug || outer_cache.write_sec)
 		l2c_set_debug(l2x0_base, val);
 }
 #else
@@ -330,7 +345,7 @@ static void l2x0_disable(void)
 
 	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	__l2x0_flush_all();
-	writel_relaxed(0, l2x0_base + L2X0_CTRL);
+	l2c_write_sec(0, l2x0_base, L2X0_CTRL);
 	dsb(st);
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
@@ -349,12 +364,12 @@ static void l2x0_enable(void __iomem *base, u32 aux)
 	l2c_unlock(base, num_lock);
 
 	/* l2x0 controller is disabled */
-	writel_relaxed(aux, base + L2X0_AUX_CTRL);
+	l2c_write_sec(aux, base, L2X0_AUX_CTRL);
 
 	l2x0_inv_all();
 
 	/* enable L2X0 */
-	writel_relaxed(L2X0_CTRL_EN, base + L2X0_CTRL);
+	l2c_write_sec(L2X0_CTRL_EN, base, L2X0_CTRL);
 }
 
 static void l2x0_resume(void)
@@ -445,7 +460,7 @@ static void l2c210_disable(void)
 	void __iomem *base = l2x0_base;
 
 	outer_flush_all();
-	writel_relaxed(0, base + L2X0_CTRL);
+	l2c_write_sec(0, base, L2X0_CTRL);
 	dsb(st);
 }
 
@@ -930,8 +945,11 @@ static void __init __l2c_init(const struct l2c_init_data *data,
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
