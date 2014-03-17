From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:19 +0000
Subject: [PATCH 33/44] ARM: l2c: move way size calculation data into
 l2c_init_data
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLE3-0002e5-T2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the way size calculation data (base of way size) out of the
switch statement into the provided initialisation data.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index f9829c7165e8..44b8fd6ae2f6 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,6 +30,7 @@
 
 struct l2c_init_data {
 	const char *type;
+	unsigned way_size_0;
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
 	void (*enable)(void __iomem *, u32);
 	void (*fixup)(void __iomem *, u32, struct outer_cache_fns *);
@@ -469,6 +470,7 @@ static void l2c210_resume(void)
 
 static const struct l2c_init_data l2c210_data __initconst = {
 	.type = "L2C-210",
+	.way_size_0 = SZ_8K,
 	.enable = l2c210_enable,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
@@ -612,6 +614,7 @@ static void l2c220_sync(void)
 
 static const struct l2c_init_data l2c220_data = {
 	.type = "L2C-220",
+	.way_size_0 = SZ_8K,
 	.enable = l2c210_enable,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
@@ -853,6 +856,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 
 static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.type = "L2C-310",
+	.way_size_0 = SZ_8K,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
 	.save = l2c310_save,
@@ -872,10 +876,8 @@ static void __init __l2c_init(const struct l2c_init_data *data,
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
@@ -906,7 +908,6 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	case AURORA_CACHE_ID:
 		ways = (aux >> 13) & 0xf;
 		ways = 2 << ((ways + 1) >> 2);
-		way_size_shift = AURORA_WAY_SIZE_SHIFT;
 		break;
 
 	default:
@@ -918,12 +919,15 @@ static void __init __l2c_init(const struct l2c_init_data *data,
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
@@ -1020,6 +1024,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 
 static const struct l2c_init_data of_l2c210_data __initconst = {
 	.type = "L2C-210",
+	.way_size_0 = SZ_8K,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c210_enable,
 	.outer_cache = {
@@ -1035,6 +1040,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 
 static const struct l2c_init_data of_l2c220_data __initconst = {
 	.type = "L2C-220",
+	.way_size_0 = SZ_8K,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c210_enable,
 	.outer_cache = {
@@ -1084,6 +1090,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
 	.type = "L2C-310",
+	.way_size_0 = SZ_8K,
 	.of_parse = l2c310_of_parse,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
@@ -1266,6 +1273,7 @@ static void __init aurora_of_parse(const struct device_node *np,
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 	.type = "Aurora",
+	.way_size_0 = SZ_4K,
 	.of_parse = aurora_of_parse,
 	.enable = aurora_enable,
 	.fixup = aurora_fixup,
@@ -1283,6 +1291,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 
 static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 	.type = "Aurora",
+	.way_size_0 = SZ_4K,
 	.of_parse = aurora_of_parse,
 	.enable = aurora_enable_no_outer,
 	.fixup = aurora_fixup,
@@ -1435,6 +1444,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.type = "BCM-L2C-310",
+	.way_size_0 = SZ_8K,
 	.of_parse = l2c310_of_parse,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
@@ -1474,6 +1484,7 @@ static void tauros3_resume(void)
 
 static const struct l2c_init_data of_tauros3_data __initconst = {
 	.type = "Tauros3",
+	.way_size_0 = SZ_8K, /* FIXME: a guess */
 	.enable = l2x0_enable,
 	.save  = tauros3_save,
 	/* Tauros3 broadcasts L1 cache operations to L2 */
-- 
1.8.3.1
