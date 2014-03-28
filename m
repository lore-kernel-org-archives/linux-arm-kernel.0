From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:17:35 +0000
Subject: [PATCH 37/75] ARM: l2c: move type string into l2c_init_data structure
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYXH-0007FM-Pr@rmk-PC.arm.linux.org.uk>
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
index fc7ce31d9b52..75680809815f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -29,6 +29,7 @@
 #include "cache-aurora-l2.h"
 
 struct l2c_init_data {
+	const char *type;
 	unsigned num_lock;
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
 	void (*enable)(void __iomem *, u32, unsigned);
@@ -274,6 +275,7 @@ static void l2c210_resume(void)
 }
 
 static const struct l2c_init_data l2c210_data __initconst = {
+	.type = "L2C-210",
 	.num_lock = 1,
 	.enable = l2c_enable,
 	.outer_cache = {
@@ -416,6 +418,7 @@ static void l2c220_sync(void)
 }
 
 static const struct l2c_init_data l2c220_data = {
+	.type = "L2C-220",
 	.num_lock = 1,
 	.enable = l2c_enable,
 	.outer_cache = {
@@ -650,6 +653,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 }
 
 static const struct l2c_init_data l2c310_init_fns __initconst = {
+	.type = "L2C-310",
 	.num_lock = 8,
 	.enable = l2c_enable,
 	.fixup = l2c310_fixup,
@@ -674,7 +678,6 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	u32 way_size = 0;
 	int ways;
 	int way_size_shift = L2X0_WAY_SIZE_SHIFT;
-	const char *type;
 
 	/*
 	 * It is strange to save the register state before initialisation,
@@ -695,25 +698,21 @@ static void __init __l2c_init(const struct l2c_init_data *data,
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
 
@@ -747,9 +746,9 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	outer_cache = fns;
 
 	pr_info("%s cache controller enabled, %d ways, %d kB\n",
-		type, ways, l2x0_size >> 10);
+		data->type, ways, l2x0_size >> 10);
 	pr_info("%s: CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",
-		type, cache_id, aux);
+		data->type, cache_id, aux);
 }
 
 void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
@@ -821,6 +820,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 }
 
 static const struct l2c_init_data of_l2c210_data __initconst = {
+	.type = "L2C-210",
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
@@ -836,6 +836,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 };
 
 static const struct l2c_init_data of_l2c220_data __initconst = {
+	.type = "L2C-220",
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
@@ -885,6 +886,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
+	.type = "L2C-310",
 	.num_lock = 8,
 	.of_parse = l2c310_of_parse,
 	.enable = l2c_enable,
@@ -1063,6 +1065,7 @@ static void __init aurora_of_parse(const struct device_node *np,
 }
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
+	.type = "Aurora",
 	.num_lock = 4,
 	.of_parse = aurora_of_parse,
 	.enable = l2c_enable,
@@ -1080,6 +1083,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 };
 
 static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
+	.type = "Aurora",
 	.num_lock = 4,
 	.of_parse = aurora_of_parse,
 	.enable = aurora_enable_no_outer,
@@ -1228,6 +1232,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 
 /* Broadcom L2C-310 start from ARMs R3P2 or later, and require no fixups */
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
+	.type = "BCM-L2C-310",
 	.num_lock = 8,
 	.of_parse = l2c310_of_parse,
 	.enable = l2c_enable,
@@ -1266,6 +1271,7 @@ static void tauros3_resume(void)
 }
 
 static const struct l2c_init_data of_tauros3_data __initconst = {
+	.type = "Tauros3",
 	.num_lock = 8,
 	.enable = l2c_enable,
 	.save  = tauros3_save,
-- 
1.8.3.1
