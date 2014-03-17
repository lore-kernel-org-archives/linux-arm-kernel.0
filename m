From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:59 +0000
Subject: [PATCH 29/44] ARM: l2c: add L2C-220 specific handlers
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLDj-0002dp-ES@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2C-220 is different from the L2C-210 and L2C-310 in that every
operation is a background operation: this means we have to use
spinlocks to protect all operations, and we have to wait for every
operation to complete.

Should a second operation be attempted while a previous operation
is in progress, the response will be an imprecise abort.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 166 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 156 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 568d76016040..29d12ae05c39 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -493,6 +493,148 @@ static const struct l2c_init_data l2c210_data __initconst = {
 };
 
 /*
+ * L2C-220 specific code.
+ *
+ * All operations are background operations: they have to be waited for.
+ * Conflicting requests generate a slave error (which will cause an
+ * imprecise abort.)  Never uses sync_reg_offset, so we hard-code the
+ * sync register here.
+ *
+ * However, we can re-use the l2c210_disable, l2c210_enable and
+ * l2c210_resume calls.
+ */
+static inline void __l2c220_cache_sync(void __iomem *base)
+{
+	writel_relaxed(0, base + L2X0_CACHE_SYNC);
+	l2c_wait_mask(base + L2X0_CACHE_SYNC, 1);
+}
+
+static void l2c220_op_way(void __iomem *base, unsigned reg)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	__l2c_op_way(base + reg);
+	__l2c220_cache_sync(base);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
+static unsigned long l2c220_op_pa_range(void __iomem *reg, unsigned long start,
+	unsigned long end, unsigned long flags)
+{
+	raw_spinlock_t *lock = &l2x0_lock;
+
+	while (start < end) {
+		unsigned long blk_end = start + min(end - start, 4096UL);
+
+		while (start < blk_end) {
+			l2c_wait_mask(reg, 1);
+			writel_relaxed(start, reg);
+			start += CACHE_LINE_SIZE;
+		}
+
+		if (blk_end < end) {
+			raw_spin_unlock_irqrestore(lock, flags);
+			raw_spin_lock_irqsave(lock, flags);
+		}
+	}
+
+	return flags;
+}
+
+static void l2c220_inv_range(unsigned long start, unsigned long end)
+{
+	void __iomem *base = l2x0_base;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	if ((start | end) & (CACHE_LINE_SIZE - 1)) {
+		if (start & (CACHE_LINE_SIZE - 1)) {
+			start &= ~(CACHE_LINE_SIZE - 1);
+			writel_relaxed(start, base + L2X0_CLEAN_INV_LINE_PA);
+			start += CACHE_LINE_SIZE;
+		}
+
+		if (end & (CACHE_LINE_SIZE - 1)) {
+			end &= ~(CACHE_LINE_SIZE - 1);
+			l2c_wait_mask(base + L2X0_CLEAN_INV_LINE_PA, 1);
+			writel_relaxed(end, base + L2X0_CLEAN_INV_LINE_PA);
+		}
+	}
+
+	flags = l2c220_op_pa_range(base + L2X0_INV_LINE_PA,
+				   start, end, flags);
+	l2c_wait_mask(base + L2X0_INV_LINE_PA, 1);
+	__l2c220_cache_sync(base);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
+static void l2c220_clean_range(unsigned long start, unsigned long end)
+{
+	void __iomem *base = l2x0_base;
+	unsigned long flags;
+
+	start &= ~(CACHE_LINE_SIZE - 1);
+	if ((end - start) >= l2x0_size) {
+		l2c220_op_way(base, L2X0_CLEAN_WAY);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	flags = l2c220_op_pa_range(base + L2X0_CLEAN_LINE_PA,
+				   start, end, flags);
+	l2c_wait_mask(base + L2X0_CLEAN_INV_LINE_PA, 1);
+	__l2c220_cache_sync(base);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
+static void l2c220_flush_range(unsigned long start, unsigned long end)
+{
+	void __iomem *base = l2x0_base;
+	unsigned long flags;
+
+	start &= ~(CACHE_LINE_SIZE - 1);
+	if ((end - start) >= l2x0_size) {
+		l2c220_op_way(base, L2X0_CLEAN_INV_WAY);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	flags = l2c220_op_pa_range(base + L2X0_CLEAN_INV_LINE_PA,
+				   start, end, flags);
+	l2c_wait_mask(base + L2X0_CLEAN_INV_LINE_PA, 1);
+	__l2c220_cache_sync(base);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
+static void l2c220_flush_all(void)
+{
+	l2c220_op_way(l2x0_base, L2X0_CLEAN_INV_WAY);
+}
+
+static void l2c220_sync(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	__l2c220_cache_sync(l2x0_base);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
+static const struct l2c_init_data l2c220_data = {
+	.enable = l2c210_enable,
+	.outer_cache = {
+		.inv_range = l2c220_inv_range,
+		.clean_range = l2c220_clean_range,
+		.flush_range = l2c220_flush_range,
+		.flush_all = l2c220_flush_all,
+		.disable = l2c210_disable,
+		.sync = l2c220_sync,
+		.resume = l2c210_resume,
+	},
+};
+
+/*
  * L2C-310 specific code.
  *
  * Very similar to L2C-210, the PA, set/way and sync operations are atomic,
@@ -839,6 +981,10 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		data = &l2c210_data;
 		break;
 
+	case L2X0_CACHE_ID_PART_L220:
+		data = &l2c220_data;
+		break;
+
 	case L2X0_CACHE_ID_PART_L310:
 		data = &l2c310_init_fns;
 		break;
@@ -902,17 +1048,17 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 	},
 };
 
-static const struct l2c_init_data of_l2x0_data __initconst = {
+static const struct l2c_init_data of_l2c220_data __initconst = {
 	.of_parse = l2x0_of_parse,
-	.enable = l2x0_enable,
+	.enable = l2c210_enable,
 	.outer_cache = {
-		.inv_range   = l2x0_inv_range,
-		.clean_range = l2x0_clean_range,
-		.flush_range = l2x0_flush_range,
-		.flush_all   = l2x0_flush_all,
-		.disable     = l2x0_disable,
-		.sync        = l2x0_cache_sync,
-		.resume      = l2x0_resume,
+		.inv_range   = l2c220_inv_range,
+		.clean_range = l2c220_clean_range,
+		.flush_range = l2c220_flush_range,
+		.flush_all   = l2c220_flush_all,
+		.disable     = l2c210_disable,
+		.sync        = l2c220_sync,
+		.resume      = l2c210_resume,
 	},
 };
 
@@ -1348,7 +1494,7 @@ static const struct l2c_init_data of_tauros3_data __initconst = {
 #define L2C_ID(name, fns) { .compatible = name, .data = (void *)&fns }
 static const struct of_device_id l2x0_ids[] __initconst = {
 	L2C_ID("arm,l210-cache", of_l2c210_data),
-	L2C_ID("arm,l220-cache", of_l2x0_data),
+	L2C_ID("arm,l220-cache", of_l2c220_data),
 	L2C_ID("arm,pl310-cache", of_l2c310_data),
 	L2C_ID("brcm,bcm11351-a2-pl310-cache", of_bcm_l2x0_data),
 	L2C_ID("marvell,aurora-outer-cache", of_aurora_with_outer_data),
-- 
1.8.3.1
