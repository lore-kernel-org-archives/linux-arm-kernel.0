From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:26 +0100
Subject: [RFC PATCH 13/17] ARM: mm: L2x0 save/restore support
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-14-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the system hits deep low power states the L2 cache controller
can lose its internal logic values and possibly its TAG/DATA RAM content.

This patch adds save/restore hooks to the L2x0 subsystem to save/restore
L2x0 registers and clean/invalidate/disable the cache controller as
needed.

The cache controller has to go to power down disabled even if its
RAM(s) are retained to prevent it from sending AXI transactions on the
bus when the cluster is shut-down which might leave the system in a
limbo state.

Hence the save function cleans (completely or partially) L2 and disable
it in one single function to avoid playing with cacheable stack and
flush data to L3.

The current code saving context for retention mode is still a hack and must be
improved.

Fully tested on dual-core A9 cluster.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/outercache.h |   22 +++++++++++++
 arch/arm/mm/cache-l2x0.c          |   63 +++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index d838743..0437c21 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -34,6 +34,8 @@ struct outer_cache_fns {
 	void (*sync)(void);
 #endif
 	void (*set_debug)(unsigned long);
+	void (*save_context)(void *, bool, unsigned long);
+	void (*restore_context)(void *, bool);
 };
 
 #ifdef CONFIG_OUTER_CACHE
@@ -74,6 +76,19 @@ static inline void outer_disable(void)
 		outer_cache.disable();
 }
 
+static inline void outer_save_context(void *data, bool dormant,
+					phys_addr_t end)
+{
+	if (outer_cache.save_context)
+		outer_cache.save_context(data, dormant, end);
+}
+
+static inline void outer_restore_context(void *data, bool dormant)
+{
+	if (outer_cache.restore_context)
+		outer_cache.restore_context(data, dormant);
+}
+
 #else
 
 static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
@@ -86,6 +101,13 @@ static inline void outer_flush_all(void) { }
 static inline void outer_inv_all(void) { }
 static inline void outer_disable(void) { }
 
+static inline void outer_save_context(void *data, bool dormant,
+					phys_addr_t end)
+{ }
+
+static inline void outer_restore_context(void *data, bool dormant)
+{ }
+
 #endif
 
 #ifdef CONFIG_OUTER_CACHE_SYNC
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ef59099..331fe9b 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -270,6 +270,67 @@ static void l2x0_disable(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2x0_save_context(void *data, bool dormant, unsigned long end)
+{
+	u32 *l2x0_regs = (u32 *) data;
+	*l2x0_regs =  readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+	l2x0_regs++;
+	*l2x0_regs =  readl_relaxed(l2x0_base + L2X0_TAG_LATENCY_CTRL);
+	l2x0_regs++;
+	*l2x0_regs =  readl_relaxed(l2x0_base + L2X0_DATA_LATENCY_CTRL);
+
+	if (!dormant) {
+		/* clean entire L2 before disabling it*/
+		writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
+		cache_wait_way(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
+	} else {
+		/*
+		 * This is an ugly hack, which is there to clean
+		 * the stack from L2 before disabling it
+		 * The only alternative consists in using a non-cacheable stack
+		 * but it is poor in terms of performance since it is only
+		 * needed for cluster shutdown and L2 retention
+		 * On L2 off mode the cache is cleaned anyway
+		 */
+		register unsigned long start asm("sp");
+		start &= ~(CACHE_LINE_SIZE - 1);
+		while (start < end) {
+			cache_wait(l2x0_base + L2X0_CLEAN_LINE_PA, 1);
+			writel_relaxed(__pa(start), l2x0_base +
+					L2X0_CLEAN_LINE_PA);
+			start += CACHE_LINE_SIZE;
+		}
+	}
+	/*
+	 * disable the cache implicitly syncs
+	 */
+	writel_relaxed(0, l2x0_base + L2X0_CTRL);
+}
+
+static void l2x0_restore_context(void *data, bool dormant)
+{
+	u32 *l2x0_regs = (u32 *) data;
+
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+
+		writel_relaxed(*l2x0_regs, l2x0_base + L2X0_AUX_CTRL);
+		l2x0_regs++;
+		writel_relaxed(*l2x0_regs, l2x0_base + L2X0_TAG_LATENCY_CTRL);
+		l2x0_regs++;
+		writel_relaxed(*l2x0_regs, l2x0_base + L2X0_DATA_LATENCY_CTRL);
+		/*
+		 * If L2 is retained do not invalidate
+		 */
+		if (!dormant) {
+			writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
+			cache_wait_way(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
+			cache_sync();
+		}
+
+		writel_relaxed(1, l2x0_base + L2X0_CTRL);
+	}
+}
+
 void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 {
 	__u32 aux;
@@ -339,6 +400,8 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.inv_all = l2x0_inv_all;
 	outer_cache.disable = l2x0_disable;
 	outer_cache.set_debug = l2x0_set_debug;
+	outer_cache.save_context = l2x0_save_context;
+	outer_cache.restore_context = l2x0_restore_context;
 
 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
-- 
1.7.4.4
