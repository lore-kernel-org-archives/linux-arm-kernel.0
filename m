From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue,  7 Jan 2014 17:11:28 +0530
Subject: [PATCH] ARM: cache-l2x0: Parse properties from DT for PL310 cache
 controller
Message-ID: <1389094888-24348-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parsed auxiliary control properties for PL310 cache controller.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
These properties are set for Exynos4 platform. If we can pass these properties
through device tree for Exynos4, then we can remove the hard-coded L2_AUX_VAL.

 Documentation/devicetree/bindings/arm/l2cc.txt |   10 ++++++++++
 arch/arm/include/asm/hardware/cache-l2x0.h     |    1 +
 arch/arm/mm/cache-l2x0.c                       |   25 ++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index b513cb8..213546d 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -44,6 +44,16 @@ Optional properties:
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
 - wt-override: If present then L2 is forced to Write through mode
+- arm,early-write: If present then BRSEP mode (early write response) is enabled.
+- arm,data-prefetch: If present then data prefetching is enabled.
+- arm,instruction-prefetch: If present then instruction prefetching is enabled.
+- arm,ns-interrupt-access: If present then interrupt mask and interrupt clear
+  registers can be read or modified in both secure or non-secure accesses.
+- arm,ns-lockdown: If present then non-secure accesses can write to lockdown
+  register.
+- arm,share-override: If present then shared attribute is ignored internally.
+- arm,full-line-of-zero: If present then 'full line of write zero' behaviour is
+  enabled.
 
 Example:
 
diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 6795ff7..aefdec0 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -78,6 +78,7 @@
 #define L2X0_CACHE_ID_RTL_R3P2          0x8
 
 #define L2X0_AUX_CTRL_MASK			0xc0000fff
+#define L2X0_AUX_CTRL_FULL_LINE_OF_ZERO_SHIFT	0
 #define L2X0_AUX_CTRL_DATA_RD_LATENCY_SHIFT	0
 #define L2X0_AUX_CTRL_DATA_RD_LATENCY_MASK	0x7
 #define L2X0_AUX_CTRL_DATA_WR_LATENCY_SHIFT	3
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 7abde2c..03357f1 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -705,6 +705,7 @@ static void __init pl310_of_setup(const struct device_node *np,
 	u32 data[3] = { 0, 0, 0 };
 	u32 tag[3] = { 0, 0, 0 };
 	u32 filter[2] = { 0, 0 };
+	u32 val = 0;
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
@@ -731,6 +732,30 @@ static void __init pl310_of_setup(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
 			       l2x0_base + L2X0_ADDR_FILTER_START);
 	}
+
+	if (of_find_property(np, "arm,early-write", NULL))
+		val |= BIT(L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
+
+	if (of_find_property(np, "arm,instruction-prefetch", NULL))
+		val |= BIT(L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT);
+
+	if (of_find_property(np, "arm,data-prefetch", NULL))
+		val |= BIT(L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT);
+
+	if (of_find_property(np, "arm,ns-interrupt-access", NULL))
+		val |= BIT(L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT);
+
+	if (of_find_property(np, "arm,ns-lockdown", NULL))
+		val |= BIT(L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT);
+
+	if (of_find_property(np, "arm,share-override", NULL))
+		val |= BIT(L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT);
+
+	if (of_find_property(np, "arm,full-line-of-zero", NULL))
+		val |= BIT(L2X0_AUX_CTRL_FULL_LINE_OF_ZERO_SHIFT);
+
+	*aux_val |= val;
+	*aux_mask &= ~val;
 }
 
 static void __init pl310_save(void)
-- 
1.7.9.5
