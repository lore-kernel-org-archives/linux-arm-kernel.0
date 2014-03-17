From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:54 +0000
Subject: [PATCH 28/44] ARM: l2c: use L2C-210 handlers for L2C-310 errata-less
 implementations
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLDe-0002dl-Al@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Where no errata affect the L2C-310 handlers, they are functionally
equivalent to L2C-210.  Re-use the L2C-210 handlers for the L2C-310
part.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 59 ++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 684bb5464f9a..568d76016040 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -495,6 +495,19 @@ static const struct l2c_init_data l2c210_data __initconst = {
 /*
  * L2C-310 specific code.
  *
+ * Very similar to L2C-210, the PA, set/way and sync operations are atomic,
+ * and the way operations are all background tasks.  However, issuing an
+ * operation while a background operation is in progress results in a
+ * SLVERR response.  We can reuse:
+ *
+ *  __l2c210_cache_sync (using sync_reg_offset)
+ *  l2c210_sync
+ *  l2c210_inv_range (if 588369 is not applicable)
+ *  l2c210_clean_range
+ *  l2c210_flush_range (if 588369 is not applicable)
+ *  l2c210_flush_all (if 727915 is not applicable)
+ *  l2c210_disable
+ *
  * Errata:
  * 588369: PL310 R0P0->R1P0, fixed R2P0.
  *	Affects: all clean+invalidate operations
@@ -674,7 +687,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	if (IS_ENABLED(CONFIG_PL310_ERRATA_588369) &&
 	    revision < L310_CACHE_ID_RTL_R2P0 &&
 	    /* For compatibility */
-	    fns->inv_range == l2x0_inv_range) {
+	    fns->inv_range == l2c210_inv_range) {
 		fns->inv_range = l2c310_inv_range_erratum;
 		fns->flush_range = l2c310_flush_range_erratum;
 		errata[n++] = "533369";
@@ -711,12 +724,13 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.fixup = l2c310_fixup,
 	.save = l2c310_save,
 	.outer_cache = {
-		.inv_range = l2x0_inv_range,
-		.clean_range = l2x0_clean_range,
-		.flush_range = l2x0_flush_range,
-		.flush_all = l2x0_flush_all,
-		.disable = l2x0_disable,
-		.sync = l2x0_cache_sync,
+		.inv_range = l2c210_inv_range,
+		.clean_range = l2c210_clean_range,
+		.flush_range = l2c210_flush_range,
+		.flush_all = l2c210_flush_all,
+		.disable = l2c210_disable,
+		.sync = l2c210_sync,
+		.set_debug = l2c310_set_debug,
 		.resume = l2c310_resume,
 	},
 };
@@ -902,8 +916,8 @@ static const struct l2c_init_data of_l2x0_data __initconst = {
 	},
 };
 
-static void __init pl310_of_parse(const struct device_node *np,
-				  u32 *aux_val, u32 *aux_mask)
+static void __init l2c310_of_parse(const struct device_node *np,
+	u32 *aux_val, u32 *aux_mask)
 {
 	u32 data[3] = { 0, 0, 0 };
 	u32 tag[3] = { 0, 0, 0 };
@@ -936,18 +950,19 @@ static void __init pl310_of_parse(const struct device_node *np,
 	}
 }
 
-static const struct l2c_init_data of_pl310_data __initconst = {
-	.of_parse = pl310_of_parse,
+static const struct l2c_init_data of_l2c310_data __initconst = {
+	.of_parse = l2c310_of_parse,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.save  = l2c310_save,
 	.outer_cache = {
-		.inv_range   = l2x0_inv_range,
-		.clean_range = l2x0_clean_range,
-		.flush_range = l2x0_flush_range,
-		.flush_all   = l2x0_flush_all,
-		.disable     = l2x0_disable,
-		.sync        = l2x0_cache_sync,
+		.inv_range   = l2c210_inv_range,
+		.clean_range = l2c210_clean_range,
+		.flush_range = l2c210_flush_range,
+		.flush_all   = l2c210_flush_all,
+		.disable     = l2c210_disable,
+		.sync        = l2c210_sync,
+		.set_debug   = l2c310_set_debug,
 		.resume      = l2c310_resume,
 	},
 };
@@ -1284,7 +1299,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 }
 
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
-	.of_parse = pl310_of_parse,
+	.of_parse = l2c310_of_parse,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.save  = l2c310_save,
@@ -1292,9 +1307,9 @@ static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 		.inv_range   = bcm_inv_range,
 		.clean_range = bcm_clean_range,
 		.flush_range = bcm_flush_range,
-		.flush_all   = l2x0_flush_all,
-		.disable     = l2x0_disable,
-		.sync        = l2x0_cache_sync,
+		.flush_all   = l2c210_flush_all,
+		.disable     = l2c210_disable,
+		.sync        = l2c210_sync,
 		.resume      = l2c310_resume,
 	},
 };
@@ -1334,7 +1349,7 @@ static const struct l2c_init_data of_tauros3_data __initconst = {
 static const struct of_device_id l2x0_ids[] __initconst = {
 	L2C_ID("arm,l210-cache", of_l2c210_data),
 	L2C_ID("arm,l220-cache", of_l2x0_data),
-	L2C_ID("arm,pl310-cache", of_pl310_data),
+	L2C_ID("arm,pl310-cache", of_l2c310_data),
 	L2C_ID("brcm,bcm11351-a2-pl310-cache", of_bcm_l2x0_data),
 	L2C_ID("marvell,aurora-outer-cache", of_aurora_with_outer_data),
 	L2C_ID("marvell,aurora-system-cache", of_aurora_no_outer_data),
-- 
1.8.3.1
