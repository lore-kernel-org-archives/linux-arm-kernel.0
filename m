From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:16:02 +0000
Subject: [PATCH 20/75] ARM: l2c: provide enable method
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYVm-0006FF-Kb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Providing an enable method gives L2 cache controllers a chance to do
special handling at enable time.  This allows us to remove a hack in
l2x0_unlock() for Marvell Aurora L2 caches.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 80 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 09fe0f5eada5..2adb82e7f4b3 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -29,7 +29,9 @@
 #include "cache-aurora-l2.h"
 
 struct l2c_init_data {
+	unsigned num_lock;
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
+	void (*enable)(void __iomem *, u32, unsigned);
 	void (*save)(void __iomem *);
 	struct outer_cache_fns outer_cache;
 };
@@ -82,6 +84,36 @@ static inline void l2c_unlock(void __iomem *base, unsigned num)
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
+static void l2c_disable(void)
+{
+	void __iomem *base = l2x0_base;
+
+	outer_cache.flush_all();
+	writel_relaxed(0, base + L2X0_CTRL);
+	dsb(st);
+}
+
 #ifdef CONFIG_CACHE_PL310
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
 {
@@ -325,9 +357,6 @@ static void l2x0_unlock(u32 cache_id)
 	case L2X0_CACHE_ID_PART_L310:
 		lockregs = 8;
 		break;
-	case AURORA_CACHE_ID:
-		lockregs = 4;
-		break;
 	default:
 		/* L210 and unknown types */
 		lockregs = 1;
@@ -337,7 +366,22 @@ static void l2x0_unlock(u32 cache_id)
 	l2c_unlock(l2x0_base, lockregs);
 }
 
+static void l2x0_enable(void __iomem *base, u32 aux, unsigned num_lock)
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
@@ -412,22 +456,11 @@ static void __init __l2c_init(const struct l2c_init_data *data,
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
+		data->enable(l2x0_base, aux, data->num_lock);
 
 	/* Re-read it in case some bits are reserved. */
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
@@ -515,6 +548,7 @@ static void l2x0_resume(void)
 
 static const struct l2c_init_data of_l2x0_data __initconst = {
 	.of_parse = l2x0_of_parse,
+	.enable = l2x0_enable,
 	.outer_cache = {
 		.inv_range   = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
@@ -620,7 +654,9 @@ static void pl310_resume(void)
 }
 
 static const struct l2c_init_data of_pl310_data __initconst = {
+	.num_lock = 8,
 	.of_parse = pl310_of_parse,
+	.enable = l2c_enable,
 	.save  = pl310_save,
 	.outer_cache = {
 		.inv_range   = l2x0_inv_range,
@@ -779,7 +815,9 @@ static void __init aurora_of_parse(const struct device_node *np,
 }
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
+	.num_lock = 4,
 	.of_parse = aurora_of_parse,
+	.enable = l2c_enable,
 	.save  = aurora_save,
 	.outer_cache = {
 		.inv_range   = aurora_inv_range,
@@ -793,7 +831,9 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 };
 
 static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
+	.num_lock = 4,
 	.of_parse = aurora_of_parse,
+	.enable = l2c_enable,
 	.save  = aurora_save,
 	.outer_cache = {
 		.resume      = aurora_resume,
@@ -942,7 +982,9 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 }
 
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
+	.num_lock = 8,
 	.of_parse = pl310_of_parse,
+	.enable = l2c_enable,
 	.save  = pl310_save,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
@@ -976,6 +1018,8 @@ static void tauros3_resume(void)
 }
 
 static const struct l2c_init_data of_tauros3_data __initconst = {
+	.num_lock = 8,
+	.enable = l2c_enable,
 	.save  = tauros3_save,
 	/* Tauros3 broadcasts L1 cache operations to L2 */
 	.outer_cache = {
-- 
1.8.3.1
