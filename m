From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:01 +0000
Subject: [PATCH 06/44] ARM: l2c: rename OF specific things, making
 l2x0_of_data available to all
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLBp-0002c7-Gr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename a few things to help distinguish their function(s):
 l2x0_of_data -> l2c_init_data
 setup -> of_parse
 add of_ prefix to OF specific data

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 64 ++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 063e1787e8c3..d659c4ca46bb 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -28,6 +28,12 @@
 #include "cache-tauros3.h"
 #include "cache-aurora-l2.h"
 
+struct l2c_init_data {
+	void (*of_parse)(const struct device_node *, u32 *, u32 *);
+	void (*save)(void);
+	struct outer_cache_fns outer_cache;
+};
+
 #define CACHE_LINE_SIZE		32
 
 static void __iomem *l2x0_base;
@@ -42,12 +48,6 @@ static u32  cache_id_part_number_from_dt;
 
 struct l2x0_regs l2x0_saved_regs;
 
-struct l2x0_of_data {
-	void (*setup)(const struct device_node *, u32 *, u32 *);
-	void (*save)(void);
-	struct outer_cache_fns outer_cache;
-};
-
 static bool of_init = false;
 
 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
@@ -664,7 +664,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 		new_end);
 }
 
-static void __init l2x0_of_setup(const struct device_node *np,
+static void __init l2x0_of_parse(const struct device_node *np,
 				 u32 *aux_val, u32 *aux_mask)
 {
 	u32 data[2] = { 0, 0 };
@@ -698,7 +698,7 @@ static void __init l2x0_of_setup(const struct device_node *np,
 	*aux_mask &= ~mask;
 }
 
-static void __init pl310_of_setup(const struct device_node *np,
+static void __init pl310_of_parse(const struct device_node *np,
 				  u32 *aux_val, u32 *aux_mask)
 {
 	u32 data[3] = { 0, 0, 0 };
@@ -851,7 +851,7 @@ static void __init aurora_broadcast_l2_commands(void)
 	isb();
 }
 
-static void __init aurora_of_setup(const struct device_node *np,
+static void __init aurora_of_parse(const struct device_node *np,
 				u32 *aux_val, u32 *aux_mask)
 {
 	u32 val = AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU;
@@ -873,8 +873,8 @@ static void __init aurora_of_setup(const struct device_node *np,
 	*aux_mask &= ~mask;
 }
 
-static const struct l2x0_of_data pl310_data __initconst = {
-	.setup = pl310_of_setup,
+static const struct l2c_init_data of_pl310_data __initconst = {
+	.of_parse = pl310_of_parse,
 	.save  = pl310_save,
 	.outer_cache = {
 		.inv_range   = l2x0_inv_range,
@@ -887,8 +887,8 @@ static const struct l2x0_of_data pl310_data __initconst = {
 	},
 };
 
-static const struct l2x0_of_data l2x0_data __initconst = {
-	.setup = l2x0_of_setup,
+static const struct l2c_init_data of_l2x0_data __initconst = {
+	.of_parse = l2x0_of_parse,
 	.outer_cache = {
 		.inv_range   = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
@@ -900,8 +900,8 @@ static const struct l2x0_of_data l2x0_data __initconst = {
 	},
 };
 
-static const struct l2x0_of_data aurora_with_outer_data __initconst = {
-	.setup = aurora_of_setup,
+static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
+	.of_parse = aurora_of_parse,
 	.save  = aurora_save,
 	.outer_cache = {
 		.inv_range   = aurora_inv_range,
@@ -914,15 +914,15 @@ static const struct l2x0_of_data aurora_with_outer_data __initconst = {
 	},
 };
 
-static const struct l2x0_of_data aurora_no_outer_data __initconst = {
-	.setup = aurora_of_setup,
+static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
+	.of_parse = aurora_of_parse,
 	.save  = aurora_save,
 	.outer_cache = {
 		.resume      = aurora_resume,
 	},
 };
 
-static const struct l2x0_of_data tauros3_data __initconst = {
+static const struct l2c_init_data of_tauros3_data __initconst = {
 	.save  = tauros3_save,
 	/* Tauros3 broadcasts L1 cache operations to L2 */
 	.outer_cache = {
@@ -930,8 +930,8 @@ static const struct l2x0_of_data tauros3_data __initconst = {
 	},
 };
 
-static const struct l2x0_of_data bcm_l2x0_data __initconst = {
-	.setup = pl310_of_setup,
+static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
+	.of_parse = pl310_of_parse,
 	.save  = pl310_save,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
@@ -946,22 +946,22 @@ static const struct l2x0_of_data bcm_l2x0_data __initconst = {
 
 #define L2C_ID(name, fns) { .compatible = name, .data = (void *)&fns }
 static const struct of_device_id l2x0_ids[] __initconst = {
-	L2C_ID("arm,l210-cache", l2x0_data),
-	L2C_ID("arm,l220-cache", l2x0_data),
-	L2C_ID("arm,pl310-cache", pl310_data),
-	L2C_ID("brcm,bcm11351-a2-pl310-cache", bcm_l2x0_data),
-	L2C_ID("marvell,aurora-outer-cache", aurora_with_outer_data),
-	L2C_ID("marvell,aurora-system-cache", aurora_no_outer_data),
-	L2C_ID("marvell,tauros3-cache", tauros3_data),
+	L2C_ID("arm,l210-cache", of_l2x0_data),
+	L2C_ID("arm,l220-cache", of_l2x0_data),
+	L2C_ID("arm,pl310-cache", of_pl310_data),
+	L2C_ID("brcm,bcm11351-a2-pl310-cache", of_bcm_l2x0_data),
+	L2C_ID("marvell,aurora-outer-cache", of_aurora_with_outer_data),
+	L2C_ID("marvell,aurora-system-cache", of_aurora_no_outer_data),
+	L2C_ID("marvell,tauros3-cache", of_tauros3_data),
 	/* Deprecated IDs */
-	L2C_ID("bcm,bcm11351-a2-pl310-cache", bcm_l2x0_data),
+	L2C_ID("bcm,bcm11351-a2-pl310-cache", of_bcm_l2x0_data),
 	{}
 };
 
 int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 {
+	const struct l2c_init_data *data;
 	struct device_node *np;
-	const struct l2x0_of_data *data;
 	struct resource res;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
@@ -981,12 +981,12 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
 	/* L2 configuration can only be changed if the cache is disabled */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
-		if (data->setup)
-			data->setup(np, &aux_val, &aux_mask);
+		if (data->of_parse)
+			data->of_parse(np, &aux_val, &aux_mask);
 
 		/* For aurora cache in no outer mode select the
 		 * correct mode using the coprocessor*/
-		if (data == &aurora_no_outer_data)
+		if (data == &of_aurora_no_outer_data)
 			aurora_broadcast_l2_commands();
 	}
 
-- 
1.8.3.1
