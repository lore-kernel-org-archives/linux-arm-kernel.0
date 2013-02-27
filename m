From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 26 Feb 2013 22:20:37 -0500
Subject: [PATCH] ARM: cache-l2x0: add device tree support for power control
Message-ID: <1361935237-12466-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After version r3p0, cache pl310 has the power control register.
Adding the device tree support for power control.
So it can parse the power control register settings.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |    6 ++++++
 arch/arm/mm/cache-l2x0.c                       |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index cbef09b..435ead2 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -34,6 +34,10 @@ Optional properties:
 - arm,filter-ranges : <start length> Starting address and length of window to
   filter. Addresses in the filter window are directed to the M1 port. Other
   addresses will go to the M0 port.
+- arm,pwr-dynamic-clk-gating: If it is defined. The dynamic clock gating for
+  better power is enabled. Only availabe after r3p0.
+- arm,pwr-standby-mode: If it is defined, standby mode is enabled. On available
+  after r3p0.
 - interrupts : 1 combined interrupt.
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
@@ -47,6 +51,8 @@ L2: cache-controller {
         arm,data-latency = <1 1 1>;
         arm,tag-latency = <2 2 2>;
         arm,filter-ranges = <0x80000000 0x8000000>;
+        arm,pwr-dynamic-clk-gating;
+        arm,pwr-standby-mode;
         cache-unified;
         cache-level = <2>;
 	interrupts = <45>;
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c2f3739..95a338a 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -564,6 +564,9 @@ static void __init pl310_of_setup(const struct device_node *np,
 	u32 data[3] = { 0, 0, 0 };
 	u32 tag[3] = { 0, 0, 0 };
 	u32 filter[2] = { 0, 0 };
+	u32 l2x0_revision;
+	u32 power;
+	const unsigned char *prop;
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
@@ -590,6 +593,19 @@ static void __init pl310_of_setup(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
 			       l2x0_base + L2X0_ADDR_FILTER_START);
 	}
+
+	l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
+		L2X0_CACHE_ID_RTL_MASK;
+	if (l2x0_revision >= L2X0_CACHE_ID_RTL_R3P0) {
+		power = 0;
+		prop = of_get_property(np, "arm,pwr-dynamic-clk-gating", NULL);
+		if (prop)
+			power |= L2X0_DYNAMIC_CLK_GATING_EN;
+		prop = of_get_property(np, "arm,pwr-standby-mode", NULL);
+		if (prop)
+			power |= L2X0_STNDBY_MODE_EN;
+		writel_relaxed(power, l2x0_base + L2X0_POWER_CTRL);
+	}
 }
 
 static void __init pl310_save(void)
-- 
1.7.4.1
