From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:47 +0000
Subject: [PATCH 15/44] ARM: l2c: provide enable method
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCZ-0002cr-HC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Providing an enable method gives L2 cache controllers a chance to do
special handling at enable time.  This allows us to remove a hack in
l2x0_unlock() for Marvell Aurora L2 caches.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 70 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 3b6213838054..ee60a53357d9 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,6 +30,7 @@
 
 struct l2c_init_data {
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
+	void (*enable)(void __iomem *, u32);
 	void (*save)(void __iomem *);
 	struct outer_cache_fns outer_cache;
 };
@@ -82,6 +83,27 @@ static inline void l2c_unlock(void __iomem *base, unsigned num)
 	}
 }
 
+/*
+ * Enable the L2 cache controller.  This function must only be
+ * called when the cache controller is known to be disabled.
+ */
+static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
+{
+	unsigned long flags;
+
+	l2c_unlock(base, num_lock);
+
+	writel_relaxed(aux, base + L2X0_AUX_CTRL);
+
+	local_irq_save(flags);
+	__l2c_op_way(base + L2X0_INV_WAY);
+	writel_relaxed(0, base + sync_reg_offset);
+	l2c_wait_mask(base + sync_reg_offset, 1);
+	local_irq_restore(flags);
+
+	writel_relaxed(L2X0_CTRL_EN, base + L2X0_CTRL);
+}
+
 #ifdef CONFIG_CACHE_PL310
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
 {
@@ -325,9 +347,6 @@ static void l2x0_unlock(u32 cache_id)
 	case L2X0_CACHE_ID_PART_L310:
 		lockregs = 8;
 		break;
-	case AURORA_CACHE_ID:
-		lockregs = 4;
-		break;
 	default:
 		/* L210 and unknown types */
 		lockregs = 1;
@@ -337,7 +356,22 @@ static void l2x0_unlock(u32 cache_id)
 	l2c_unlock(l2x0_base, lockregs);
 }
 
+static void l2x0_enable(void __iomem *base, u32 aux)
+{
+	/* Make sure that I&D is not locked down when starting */
+	l2x0_unlock(readl_relaxed(base + L2X0_CACHE_ID));
+
+	/* l2x0 controller is disabled */
+	writel_relaxed(aux, base + L2X0_AUX_CTRL);
+
+	l2x0_inv_all();
+
+	/* enable L2X0 */
+	writel_relaxed(L2X0_CTRL_EN, base + L2X0_CTRL);
+}
+
 static const struct l2c_init_data l2x0_init_fns __initconst = {
+	.enable = l2x0_enable,
 	.outer_cache = {
 		.inv_range = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
@@ -412,22 +446,11 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	l2x0_size = ways * way_size * SZ_1K;
 
 	/*
-	 * Check if l2x0 controller is already enabled.
-	 * If you are booting from non-secure mode
-	 * accessing the below registers will fault.
+	 * Check if l2x0 controller is already enabled.  If we are booting
+	 * in non-secure mode accessing the below registers will fault.
 	 */
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
-		/* Make sure that I&D is not locked down when starting */
-		l2x0_unlock(cache_id);
-
-		/* l2x0 controller is disabled */
-		writel_relaxed(aux, l2x0_base + L2X0_AUX_CTRL);
-
-		l2x0_inv_all();
-
-		/* enable L2X0 */
-		writel_relaxed(L2X0_CTRL_EN, l2x0_base + L2X0_CTRL);
-	}
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN))
+		data->enable(l2x0_base, aux);
 
 	/* Re-read it in case some bits are reserved. */
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
@@ -880,6 +903,11 @@ static void tauros3_resume(void)
 	l2x0_resume();
 }
 
+static void aurora_enable(void __iomem *base, u32 aux)
+{
+	l2c_enable(base, aux, 4);
+}
+
 static void __init aurora_broadcast_l2_commands(void)
 {
 	__u32 u;
@@ -914,6 +942,7 @@ static void __init aurora_of_parse(const struct device_node *np,
 
 static const struct l2c_init_data of_pl310_data __initconst = {
 	.of_parse = pl310_of_parse,
+	.enable = l2x0_enable,
 	.save  = pl310_save,
 	.outer_cache = {
 		.inv_range   = l2x0_inv_range,
@@ -928,6 +957,7 @@ static const struct l2c_init_data of_pl310_data __initconst = {
 
 static const struct l2c_init_data of_l2x0_data __initconst = {
 	.of_parse = l2x0_of_parse,
+	.enable = l2x0_enable,
 	.outer_cache = {
 		.inv_range   = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
@@ -941,6 +971,7 @@ static const struct l2c_init_data of_l2x0_data __initconst = {
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 	.of_parse = aurora_of_parse,
+	.enable = aurora_enable,
 	.save  = aurora_save,
 	.outer_cache = {
 		.inv_range   = aurora_inv_range,
@@ -955,6 +986,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 
 static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 	.of_parse = aurora_of_parse,
+	.enable = aurora_enable,
 	.save  = aurora_save,
 	.outer_cache = {
 		.resume      = aurora_resume,
@@ -962,6 +994,7 @@ static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 };
 
 static const struct l2c_init_data of_tauros3_data __initconst = {
+	.enable = l2x0_enable,
 	.save  = tauros3_save,
 	/* Tauros3 broadcasts L1 cache operations to L2 */
 	.outer_cache = {
@@ -971,6 +1004,7 @@ static const struct l2c_init_data of_tauros3_data __initconst = {
 
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.of_parse = pl310_of_parse,
+	.enable = l2x0_enable,
 	.save  = pl310_save,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
-- 
1.8.3.1
