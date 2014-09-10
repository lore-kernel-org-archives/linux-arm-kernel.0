From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Sep 2014 13:01:27 +0200
Subject: [PATCH v4] ARM: l2c: parse cache properties from ePAPR definitions
Message-ID: <1410346887-9195-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When both 'cache-size' and 'cache-sets' are specified for a L2 cache
controller node, parse those properties and set up the
set size based on which type of L2 cache controller we are using.

Update the L2 cache controller Device Tree binding with the optional
'cache-size', 'cache-sets', 'cache-block-size' and 'cache-line-size'
properties. These come from the ePAPR specification.

Using the cache size, number of sets and cache line size we can
calculate desired associativity of the L2 cache. This is done
by the calculation:

    set size = cache size / sets
    ways = set size / line size
    way size = cache size / ways = sets * line size
    associativity = cache size / way size

Example output from the PB1176 DT that look like this:

L2: l2-cache {
    compatible = "arm,l220-cache";
    (...)
    arm,override-auxreg;
    cache-size = <131072>; // 128kB
    cache-sets = <512>;
    cache-line-size = <32>;
};

Ends up like this:

L2C OF: override cache size: 131072 bytes (128KB)
L2C OF: override line size: 32 bytes
L2C OF: override way size: 16384 bytes (16KB)
L2C OF: override associativity: 8
L2C: DT/platform modifies aux control register: 0x02020fff -> 0x02030fff
L2C-220 cache controller enabled, 8 ways, 128 kB
L2C-220: CACHE_ID 0x41000486, AUX_CTRL 0x06030fff

Which is consistent with the value earlier hardcoded for the
PB1176 platform.

This patch is an extended version based on the initial patch
by Florian Fainelli.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Cut the boolean device tree property to specify whether the
  auxilary register should be overridden: always override of these
  properties are present.
- Add a pointer to the ePAPR v1.1 specification to the L2C device
  tree bindings document.
- Delete the Aurora support: this l2 cache have different ways of
  handling bits and pieces and need a specially rewritten piece of
  support code. Let's assume these caches do not need to be augmented
  from the device tree.
- Use ilog2() to calculate the way size bit field.
ChangeLog v2->v3:
- Fix up way size and associativity calculations using the combined
  wisdom of Arnd and Russell.
- Push associativity writes down to each cache hardware
  implementation, L2x0/PL3x0 respectively.
- Introduce a boolean device tree property to tell whether the
  auxilary register value containing these size and set-based
  configurations should be modified by the OS or not
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  10 ++
 arch/arm/mm/cache-l2x0.c                       | 121 +++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index af527ee111c2..292ef7ca3058 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -2,6 +2,10 @@
 
 ARM cores often have a separate level 2 cache controller. There are various
 implementations of the L2 cache controller with compatible programming models.
+Some of the properties that are just prefixed "cache-*" are taken from section
+3.7.3 of the ePAPR v1.1 specification which can be found at:
+https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf
+
 The ARM L2 cache representation in the device tree should be done as follows:
 
 Required properties:
@@ -44,6 +48,12 @@ Optional properties:
   I/O coherent mode. Valid only when the arm,pl310-cache compatible
   string is used.
 - interrupts : 1 combined interrupt.
+- cache-size : specifies the size in bytes of the cache
+- cache-sets : specifies the number of associativity sets of the cache
+- cache-block-size : specifies the size in bytes of a cache block
+- cache-line-size : specifies the size in bytes of a line in the cache,
+  if this is not specified, the line size is assumed to be equal to the
+  cache block size
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
 - wt-override: If present then L2 is forced to Write through mode
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5f2c988a06ac..55f9d6e0cc88 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/spinlock.h>
+#include <linux/log2.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -945,6 +946,98 @@ static int l2_wt_override;
  * pass it though the device tree */
 static u32 cache_id_part_number_from_dt;
 
+/**
+ * l2x0_cache_size_of_parse() - read cache size parameters from DT
+ * @np: the device tree node for the l2 cache
+ * @aux_val: pointer to machine-supplied auxilary register value, to
+ * be augmented by the call (bits to be set to 1)
+ * @aux_mask: pointer to machine-supplied auxilary register mask, to
+ * be augmented by the call (bits to be set to 0)
+ * @associativity: variable to return the calculated associativity in
+ * @max_way_size: the maximum size in bytes for the cache ways
+ */
+static void __init l2x0_cache_size_of_parse(const struct device_node *np,
+					    u32 *aux_val, u32 *aux_mask,
+					    u32 *associativity,
+					    u32 max_way_size)
+{
+	u32 mask = 0, val = 0;
+	u32 cache_size = 0, sets = 0;
+	u32 way_size_bits = 1;
+	u32 way_size = 0;
+	u32 block_size = 0;
+	u32 line_size = 0;
+
+	of_property_read_u32(np, "cache-size", &cache_size);
+	of_property_read_u32(np, "cache-sets", &sets);
+	of_property_read_u32(np, "cache-block-size", &block_size);
+	of_property_read_u32(np, "cache-line-size", &line_size);
+
+	if (!cache_size || !sets)
+		return;
+
+	/* All these l2 caches have the same line = block size actually */
+	if (!line_size) {
+		if (block_size) {
+			/* If linesize if not given, it is equal to blocksize */
+			line_size = block_size;
+		} else {
+			/* Fall back to known size */
+			pr_warn("L2C OF: no cache block/line size given: "
+				"falling back to default size %d bytes\n",
+				CACHE_LINE_SIZE);
+			line_size = CACHE_LINE_SIZE;
+		}
+	}
+
+	if (line_size != CACHE_LINE_SIZE)
+		pr_warn("L2C OF: DT supplied line size %d bytes does "
+			"not match hardware line size of %d bytes\n",
+			line_size,
+			CACHE_LINE_SIZE);
+
+	/*
+	 * Since:
+	 * set size = cache size / sets
+	 * ways = cache size / (sets * line size)
+	 * way size = cache size / (cache size / (sets * line size))
+	 * way size = sets * line size
+	 * associativity = ways = cache size / way size
+	 */
+	way_size = sets * line_size;
+	*associativity = cache_size / way_size;
+
+	if (way_size > max_way_size) {
+		pr_err("L2C OF: set size %dKB is too large\n", way_size);
+		return;
+	}
+
+	pr_info("L2C OF: override cache size: %d bytes (%dKB)\n",
+		cache_size, cache_size >> 10);
+	pr_info("L2C OF: override line size: %d bytes\n", line_size);
+	pr_info("L2C OF: override way size: %d bytes (%dKB)\n",
+		way_size, way_size >> 10);
+	pr_info("L2C OF: override associativity: %d\n", *associativity);
+
+	/*
+	 * Calculates the bits 17:19 to set for way size:
+	 * 512KB -> 6, 256KB -> 5, ... 16KB -> 1
+	 */
+	way_size_bits = ilog2(way_size >> 10) - 3;
+	if (way_size_bits < 1 || way_size_bits > 6) {
+		pr_err("L2C OF: cache way size illegal: %dKB is not mapped\n",
+		       way_size);
+		return;
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
@@ -952,6 +1045,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 	u32 tag = 0;
 	u32 dirty = 0;
 	u32 val = 0, mask = 0;
+	u32 assoc;
 
 	of_property_read_u32(np, "arm,tag-latency", &tag);
 	if (tag) {
@@ -974,6 +1068,15 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
 	}
 
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_256K);
+	if (assoc > 8) {
+		pr_err("l2x0 of: cache setting yield too high associativity\n");
+		pr_err("l2x0 of: %d calculated, max 8\n", assoc);
+	} else {
+		mask |= L2X0_AUX_CTRL_ASSOC_MASK;
+		val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
+	}
+
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
@@ -1021,6 +1124,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	u32 data[3] = { 0, 0, 0 };
 	u32 tag[3] = { 0, 0, 0 };
 	u32 filter[2] = { 0, 0 };
+	u32 assoc;
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
@@ -1047,6 +1151,23 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
+
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_512K);
+	switch (assoc) {
+	case 16:
+		*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+		*aux_val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
+		*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+		break;
+	case 8:
+		*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+		*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+		break;
+	default:
+		pr_err("PL310 OF: cache setting yield illegal associativity\n");
+		pr_err("PL310 OF: %d calculated, only 8 and 16 legal\n", assoc);
+		break;
+	}
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
-- 
1.9.3
