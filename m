From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:38 +0000
Subject: [PATCH 25/44] ARM: l2c: add L2C-210 specific handlers
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLDO-0002dY-W6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add L2C-210 specific cache operation handlers.  These are tailored to
the requirements of the L2C-210 cache controller, which doesn't
require any workarounds.  We avoid using the way operations during
normal operation, which means we can avoid locking: the only time
we use the way operations are during initialisation, and when
disabling the cache.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 4e12fad497b2..4930f63d5f4a 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -377,6 +377,122 @@ static const struct l2c_init_data l2x0_init_fns __initconst = {
 };
 
 /*
+ * L2C-210 specific code.
+ *
+ * The L2C-2x0 PA, set/way and sync operations are atomic, but we must
+ * ensure that no background operation is running.  The way operations
+ * are all background tasks.
+ *
+ * While a background operation is in progress, any new operation is
+ * ignored (unspecified whether this causes an error.)  Thankfully, not
+ * used on SMP.
+ *
+ * Never has a different sync register other than L2X0_CACHE_SYNC, but
+ * we use sync_reg_offset here so we can share some of this with L2C-310.
+ */
+static void __l2c210_cache_sync(void __iomem *base)
+{
+	writel_relaxed(0, base + sync_reg_offset);
+}
+
+static void __l2c210_op_pa_range(void __iomem *reg, unsigned long start,
+	unsigned long end)
+{
+	while (start < end) {
+		writel_relaxed(start, reg);
+		start += CACHE_LINE_SIZE;
+	}
+}
+
+static void l2c210_inv_range(unsigned long start, unsigned long end)
+{
+	void __iomem *base = l2x0_base;
+
+	if (start & (CACHE_LINE_SIZE - 1)) {
+		start &= ~(CACHE_LINE_SIZE - 1);
+		writel_relaxed(start, base + L2X0_CLEAN_INV_LINE_PA);
+		start += CACHE_LINE_SIZE;
+	}
+
+	if (end & (CACHE_LINE_SIZE - 1)) {
+		end &= ~(CACHE_LINE_SIZE - 1);
+		writel_relaxed(end, base + L2X0_CLEAN_INV_LINE_PA);
+	}
+
+	__l2c210_op_pa_range(base + L2X0_INV_LINE_PA, start, end);
+	__l2c210_cache_sync(base);
+}
+
+static void l2c210_clean_range(unsigned long start, unsigned long end)
+{
+	void __iomem *base = l2x0_base;
+
+	start &= ~(CACHE_LINE_SIZE - 1);
+	__l2c210_op_pa_range(base + L2X0_CLEAN_LINE_PA, start, end);
+	__l2c210_cache_sync(base);
+}
+
+static void l2c210_flush_range(unsigned long start, unsigned long end)
+{
+	void __iomem *base = l2x0_base;
+
+	start &= ~(CACHE_LINE_SIZE - 1);
+	__l2c210_op_pa_range(base + L2X0_CLEAN_INV_LINE_PA, start, end);
+	__l2c210_cache_sync(base);
+}
+
+static void l2c210_flush_all(void)
+{
+	void __iomem *base = l2x0_base;
+
+	BUG_ON(!irqs_disabled());
+
+	__l2c_op_way(base + L2X0_CLEAN_INV_WAY);
+	__l2c210_cache_sync(base);
+}
+
+static void l2c210_disable(void)
+{
+	void __iomem *base = l2x0_base;
+
+	outer_flush_all();
+	writel_relaxed(0, base + L2X0_CTRL);
+	dsb(st);
+}
+
+static void l2c210_sync(void)
+{
+	__l2c210_cache_sync(l2x0_base);
+}
+
+static void l2c210_enable(void __iomem *base, u32 aux)
+{
+	/* Only one lock register on L2C-210 */
+	l2c_enable(base, aux, 1);
+}
+
+static void l2c210_resume(void)
+{
+	void __iomem *base = l2x0_base;
+
+	if (!(readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN))
+		l2c210_enable(base, l2x0_saved_regs.aux_ctrl);
+}
+
+static const struct l2c_init_data l2c210_data __initconst = {
+	.enable = l2c210_enable,
+	.outer_cache = {
+		.inv_range = l2c210_inv_range,
+		.clean_range = l2c210_clean_range,
+		.flush_range = l2c210_flush_range,
+		.flush_all = l2c210_flush_all,
+		.disable = l2c210_disable,
+		.sync = l2c210_sync,
+		.resume = l2c210_resume,
+	},
+};
+
+/*
  * L2C-310 specific code.
  *
  * Errata:
@@ -616,6 +732,10 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		data = &l2x0_init_fns;
 		break;
 
+	case L2X0_CACHE_ID_PART_L210:
+		data = &l2c210_data;
+		break;
+
 	case L2X0_CACHE_ID_PART_L310:
 		data = &l2c310_init_fns;
 		break;
@@ -665,6 +785,20 @@ static void __init l2x0_of_parse(const struct device_node *np,
 	*aux_mask &= ~mask;
 }
 
+static const struct l2c_init_data of_l2c210_data __initconst = {
+	.of_parse = l2x0_of_parse,
+	.enable = l2c210_enable,
+	.outer_cache = {
+		.inv_range   = l2c210_inv_range,
+		.clean_range = l2c210_clean_range,
+		.flush_range = l2c210_flush_range,
+		.flush_all   = l2c210_flush_all,
+		.disable     = l2c210_disable,
+		.sync        = l2c210_sync,
+		.resume      = l2c210_resume,
+	},
+};
+
 static const struct l2c_init_data of_l2x0_data __initconst = {
 	.of_parse = l2x0_of_parse,
 	.enable = l2x0_enable,
@@ -1109,7 +1243,7 @@ static const struct l2c_init_data of_tauros3_data __initconst = {
 
 #define L2C_ID(name, fns) { .compatible = name, .data = (void *)&fns }
 static const struct of_device_id l2x0_ids[] __initconst = {
-	L2C_ID("arm,l210-cache", of_l2x0_data),
+	L2C_ID("arm,l210-cache", of_l2c210_data),
 	L2C_ID("arm,l220-cache", of_l2x0_data),
 	L2C_ID("arm,pl310-cache", of_pl310_data),
 	L2C_ID("brcm,bcm11351-a2-pl310-cache", of_bcm_l2x0_data),
-- 
1.8.3.1
