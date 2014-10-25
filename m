From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 25 Oct 2014 10:06:32 -0200
Subject: [PATCH] ARM: l2c: Make l2x0_cache_size_of_parse() return 'int'
Message-ID: <1414238792-13811-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit f3354ab67476dc80 ("ARM: 8169/1: l2c: parse cache properties from
ePAPR definitions") the following error is seen on imx6q:

[    0.000000] PL310 OF: cache setting yield illegal associativity
[    0.000000] PL310 OF: -2147097556 calculated, only 8 and 16 legal

As imx6q does not pass the "cache-size" and "cache-sets" properties in DT, the
function l2x0_cache_size_of_parse() returns early and keep the 'associativity' 
pointer uninitialized.

To fix this problem, return error codes inside l2x0_cache_size_of_parse() and
only use the 'associativity' pointer result if l2x0_cache_size_of_parse() 
succeeds.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mm/cache-l2x0.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 55f9d6e..4a785fc 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -956,7 +956,7 @@ static u32 cache_id_part_number_from_dt;
  * @associativity: variable to return the calculated associativity in
  * @max_way_size: the maximum size in bytes for the cache ways
  */
-static void __init l2x0_cache_size_of_parse(const struct device_node *np,
+static int __init l2x0_cache_size_of_parse(const struct device_node *np,
 					    u32 *aux_val, u32 *aux_mask,
 					    u32 *associativity,
 					    u32 max_way_size)
@@ -974,7 +974,7 @@ static void __init l2x0_cache_size_of_parse(const struct device_node *np,
 	of_property_read_u32(np, "cache-line-size", &line_size);
 
 	if (!cache_size || !sets)
-		return;
+		return -ENODEV;
 
 	/* All these l2 caches have the same line = block size actually */
 	if (!line_size) {
@@ -1009,7 +1009,7 @@ static void __init l2x0_cache_size_of_parse(const struct device_node *np,
 
 	if (way_size > max_way_size) {
 		pr_err("L2C OF: set size %dKB is too large\n", way_size);
-		return;
+		return -EINVAL;
 	}
 
 	pr_info("L2C OF: override cache size: %d bytes (%dKB)\n",
@@ -1027,7 +1027,7 @@ static void __init l2x0_cache_size_of_parse(const struct device_node *np,
 	if (way_size_bits < 1 || way_size_bits > 6) {
 		pr_err("L2C OF: cache way size illegal: %dKB is not mapped\n",
 		       way_size);
-		return;
+		return -EINVAL;
 	}
 
 	mask |= L2C_AUX_CTRL_WAY_SIZE_MASK;
@@ -1036,6 +1036,8 @@ static void __init l2x0_cache_size_of_parse(const struct device_node *np,
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
+
+	return 0;
 }
 
 static void __init l2x0_of_parse(const struct device_node *np,
@@ -1046,6 +1048,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 	u32 dirty = 0;
 	u32 val = 0, mask = 0;
 	u32 assoc;
+	int ret;
 
 	of_property_read_u32(np, "arm,tag-latency", &tag);
 	if (tag) {
@@ -1068,7 +1071,10 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
 	}
 
-	l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_256K);
+	ret = l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_256K);
+	if (ret)
+		return;
+
 	if (assoc > 8) {
 		pr_err("l2x0 of: cache setting yield too high associativity\n");
 		pr_err("l2x0 of: %d calculated, max 8\n", assoc);
@@ -1125,6 +1131,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	u32 tag[3] = { 0, 0, 0 };
 	u32 filter[2] = { 0, 0 };
 	u32 assoc;
+	int ret;
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
@@ -1152,7 +1159,10 @@ static void __init l2c310_of_parse(const struct device_node *np,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
 
-	l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_512K);
+	ret = l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_512K);
+	if (ret)
+		return;
+
 	switch (assoc) {
 	case 16:
 		*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
-- 
1.9.1
