From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:09 +0000
Subject: [PATCH 31/44] ARM: l2c: move type string into l2c_init_data structure
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLDt-0002dx-LV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than decoding this from the ID register, store it in the
l2c_init_data structure.  This simplifies things some more, and
allows us to better provide further details as to how we're
driving the cache.  We print the cache ID value anyway should we
need to precisely identify the cache hardware.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 606f9eed1b23..b932513366a3 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -29,6 +29,7 @@
 #include "cache-aurora-l2.h"
 
 struct l2c_init_data {
+	const char *type;
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
 	void (*enable)(void __iomem *, u32);
 	void (*fixup)(void __iomem *, u32, struct outer_cache_fns *);
@@ -467,6 +468,7 @@ static void l2c210_resume(void)
 }
 
 static const struct l2c_init_data l2c210_data __initconst = {
+	.type = "L2C-210",
 	.enable = l2c210_enable,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
@@ -609,6 +611,7 @@ static void l2c220_sync(void)
 }
 
 static const struct l2c_init_data l2c220_data = {
+	.type = "L2C-220",
 	.enable = l2c210_enable,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
@@ -849,6 +852,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 }
 
 static const struct l2c_init_data l2c310_init_fns __initconst = {
+	.type = "L2C-310",
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.save = l2c310_save,
@@ -872,7 +876,6 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	u32 way_size = 0;
 	int ways;
 	int way_size_shift = L2X0_WAY_SIZE_SHIFT;
-	const char *type;
 
 	/*
 	 * It is strange to save the register state before initialisation,
@@ -893,25 +896,21 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 			ways = 16;
 		else
 			ways = 8;
-		type = "L310";
 		break;
 
 	case L2X0_CACHE_ID_PART_L210:
 		ways = (aux >> 13) & 0xf;
-		type = "L210";
 		break;
 
 	case AURORA_CACHE_ID:
 		ways = (aux >> 13) & 0xf;
 		ways = 2 << ((ways + 1) >> 2);
 		way_size_shift = AURORA_WAY_SIZE_SHIFT;
-		type = "Aurora";
 		break;
 
 	default:
 		/* Assume unknown chips have 8 ways */
 		ways = 8;
-		type = "L2x0 series";
 		break;
 	}
 
@@ -945,9 +944,9 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	outer_cache = fns;
 
 	pr_info("%s cache controller enabled, %d ways, %d kB\n",
-		type, ways, l2x0_size >> 10);
+		data->type, ways, l2x0_size >> 10);
 	pr_info("%s: CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",
-		type, cache_id, aux);
+		data->type, cache_id, aux);
 }
 
 void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
@@ -1019,6 +1018,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 }
 
 static const struct l2c_init_data of_l2c210_data __initconst = {
+	.type = "L2C-210",
 	.of_parse = l2x0_of_parse,
 	.enable = l2c210_enable,
 	.outer_cache = {
@@ -1033,6 +1033,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 };
 
 static const struct l2c_init_data of_l2c220_data __initconst = {
+	.type = "L2C-220",
 	.of_parse = l2x0_of_parse,
 	.enable = l2c210_enable,
 	.outer_cache = {
@@ -1081,6 +1082,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
+	.type = "L2C-310",
 	.of_parse = l2c310_of_parse,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
@@ -1262,6 +1264,7 @@ static void __init aurora_of_parse(const struct device_node *np,
 }
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
+	.type = "Aurora",
 	.of_parse = aurora_of_parse,
 	.enable = aurora_enable,
 	.fixup = aurora_fixup,
@@ -1278,6 +1281,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 };
 
 static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
+	.type = "Aurora",
 	.of_parse = aurora_of_parse,
 	.enable = aurora_enable_no_outer,
 	.fixup = aurora_fixup,
@@ -1429,6 +1433,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 }
 
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
+	.type = "BCM-L2C-310",
 	.of_parse = l2c310_of_parse,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
@@ -1467,6 +1472,7 @@ static void tauros3_resume(void)
 }
 
 static const struct l2c_init_data of_tauros3_data __initconst = {
+	.type = "Tauros3",
 	.enable = l2x0_enable,
 	.save  = tauros3_save,
 	/* Tauros3 broadcasts L1 cache operations to L2 */
-- 
1.8.3.1
