From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Aug 2014 16:29:31 -0700
Subject: [PATCH 3/3] ARM: l2c: parse 'cache-size' and 'cache-sets' properties
In-Reply-To: <1407972571-8986-1-git-send-email-f.fainelli@gmail.com>
References: <1407972571-8986-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1407972571-8986-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When both 'cache-size' and 'cache-sets' are specified for a L2 cache
controller node, parse those properties and make sure we validate the
way_size based on which type of L2 cache controller we are using.

Update the L2 cache controller Device Tree binding with the optional
'cache-size' and 'cache-sets' properties.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  2 +
 arch/arm/mm/cache-l2x0.c                       | 61 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index b265ef25e55d..e5d9bbe540e2 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -45,6 +45,8 @@ Optional properties:
   string is used.
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
+- cache-size : specifies the size in bytes of the cache
+- cache-sets : specifies the number of associativity sets of the cache
 - interrupts : 1 combined interrupt.
 - wt-override: If present then L2 is forced to Write through mode
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 80488e78ce32..e681f36e9c07 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -945,6 +945,61 @@ static int l2_wt_override;
  * pass it though the device tree */
 static u32 cache_id_part_number_from_dt;
 
+static void __init l2x0_cache_size_of_parse(const struct device_node *np,
+					    u32 *aux_val, u32 *aux_mask,
+					    u32 max_way_size)
+{
+	u32 mask = 0, val = 0;
+	u32 size = 0, sets = 0;
+	u32 way_size = 0, way_size_bits = 1;
+
+	of_property_read_u32(np, "cache-size", &size);
+	of_property_read_u32(np, "cache-sets", &sets);
+
+	if (!size || !sets)
+		return;
+
+	way_size = size / sets;
+
+	if (way_size > max_way_size) {
+		pr_warn("L2C: way size %dKB is too large\n", way_size >> 10);
+		return;
+	}
+
+	way_size >>= 10;
+	switch (way_size) {
+	case 512:
+		way_size_bits = 6;
+		break;
+	case 256:
+		way_size_bits = 5;
+		break;
+	case 128:
+		way_size_bits = 4;
+		break;
+	case 64:
+		way_size_bits = 3;
+		break;
+	case 32:
+		way_size_bits = 2;
+		break;
+	case 16:
+		way_size_bits = 1;
+		break;
+	default:
+		pr_err("cache way size: %d KB is not mapped\n",
+		       way_size);
+		break;
+	}
+
+	mask |= L2C_AUX_CTRL_WAY_SIZE_MASK;
+	val |= (way_size_bits << L2C_AUX_CTRL_WAY_SIZE_SHIFT);
+
+	*aux_val &= ~mask;
+	*aux_val |= val;
+	*aux_mask &= ~mask;
+}
+
 static void __init l2x0_of_parse(const struct device_node *np,
 				 u32 *aux_val, u32 *aux_mask)
 {
@@ -974,6 +1029,8 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
 	}
 
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K);
+
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
@@ -1047,6 +1104,8 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
+
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_512K);
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
@@ -1253,6 +1312,8 @@ static void __init aurora_of_parse(const struct device_node *np,
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
+
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K);
 }
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
-- 
1.9.1
