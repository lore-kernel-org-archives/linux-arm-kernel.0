From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:34:16 +0100
Subject: [PATCH 039/222] ARM: l2c: move way size calculation data into
 l2c_init_data
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeOW-0007Fm-6y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the way size calculation data (base of way size) out of the
switch statement into the provided initialisation data.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 69a18316b239..b4d373ab1a5c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,6 +30,7 @@
 
 struct l2c_init_data {
 	const char *type;
+	unsigned way_size_0;
 	unsigned num_lock;
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
 	void (*enable)(void __iomem *, u32, unsigned);
@@ -276,6 +277,7 @@ static void l2c210_resume(void)
 
 static const struct l2c_init_data l2c210_data __initconst = {
 	.type = "L2C-210",
+	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.enable = l2c_enable,
 	.outer_cache = {
@@ -419,6 +421,7 @@ static void l2c220_sync(void)
 
 static const struct l2c_init_data l2c220_data = {
 	.type = "L2C-220",
+	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.enable = l2c_enable,
 	.outer_cache = {
@@ -654,6 +657,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 
 static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.type = "L2C-310",
+	.way_size_0 = SZ_8K,
 	.num_lock = 8,
 	.enable = l2c_enable,
 	.fixup = l2c310_fixup,
@@ -674,10 +678,8 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	u32 aux_val, u32 aux_mask, u32 cache_id)
 {
 	struct outer_cache_fns fns;
+	unsigned way_size_bits, ways;
 	u32 aux;
-	u32 way_size = 0;
-	int ways;
-	int way_size_shift = L2X0_WAY_SIZE_SHIFT;
 
 	/*
 	 * It is strange to save the register state before initialisation,
@@ -708,7 +710,6 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	case AURORA_CACHE_ID:
 		ways = (aux >> 13) & 0xf;
 		ways = 2 << ((ways + 1) >> 2);
-		way_size_shift = AURORA_WAY_SIZE_SHIFT;
 		break;
 
 	default:
@@ -720,12 +721,15 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	l2x0_way_mask = (1 << ways) - 1;
 
 	/*
-	 * L2 cache Size =  Way size * Number of ways
+	 * way_size_0 is the size that a way_size value of zero would be
+	 * given the calculation: way_size = way_size_0 << way_size_bits.
+	 * So, if way_size_bits=0 is reserved, but way_size_bits=1 is 16k,
+	 * then way_size_0 would be 8k.
+	 *
+	 * L2 cache size = number of ways * way size.
 	 */
-	way_size = (aux & L2X0_AUX_CTRL_WAY_SIZE_MASK) >> 17;
-	way_size = 1 << (way_size + way_size_shift);
-
-	l2x0_size = ways * way_size * SZ_1K;
+	way_size_bits = (aux & L2X0_AUX_CTRL_WAY_SIZE_MASK) >> 17;
+	l2x0_size = ways * (data->way_size_0 << way_size_bits);
 
 	fns = data->outer_cache;
 	if (data->fixup)
@@ -822,6 +826,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 
 static const struct l2c_init_data of_l2c210_data __initconst = {
 	.type = "L2C-210",
+	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
@@ -838,6 +843,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 
 static const struct l2c_init_data of_l2c220_data __initconst = {
 	.type = "L2C-220",
+	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
@@ -888,6 +894,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
 	.type = "L2C-310",
+	.way_size_0 = SZ_8K,
 	.num_lock = 8,
 	.of_parse = l2c310_of_parse,
 	.enable = l2c_enable,
@@ -1067,6 +1074,7 @@ static void __init aurora_of_parse(const struct device_node *np,
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 	.type = "Aurora",
+	.way_size_0 = SZ_4K,
 	.num_lock = 4,
 	.of_parse = aurora_of_parse,
 	.enable = l2c_enable,
@@ -1085,6 +1093,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 
 static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 	.type = "Aurora",
+	.way_size_0 = SZ_4K,
 	.num_lock = 4,
 	.of_parse = aurora_of_parse,
 	.enable = aurora_enable_no_outer,
@@ -1234,6 +1243,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 /* Broadcom L2C-310 start from ARMs R3P2 or later, and require no fixups */
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.type = "BCM-L2C-310",
+	.way_size_0 = SZ_8K,
 	.num_lock = 8,
 	.of_parse = l2c310_of_parse,
 	.enable = l2c_enable,
@@ -1273,6 +1283,7 @@ static void tauros3_resume(void)
 
 static const struct l2c_init_data of_tauros3_data __initconst = {
 	.type = "Tauros3",
+	.way_size_0 = SZ_8K,
 	.num_lock = 8,
 	.enable = l2c_enable,
 	.save  = tauros3_save,
-- 
1.8.3.1
