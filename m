From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:17:16 +0000
Subject: [PATCH 44/44] ARM: l2c: add L2C-310 power control DT properties
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLEy-0002er-51@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two new properties for setting thte L3 power control register.  Two
new properties are added:

	arm,dynamic-clk-gating
	arm,standby-mode

iMX6 sets both these, add the properties there.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  2 ++
 arch/arm/boot/dts/imx6qdl.dtsi                 |  2 ++
 arch/arm/boot/dts/imx6sl.dtsi                  |  2 ++
 arch/arm/mm/cache-l2x0.c                       | 10 ++++++++++
 4 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index b513cb8196fe..e0dd400ecea6 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -40,6 +40,8 @@ implementations of the L2 cache controller with compatible programming models.
 - arm,filter-ranges : <start length> Starting address and length of window to
   filter. Addresses in the filter window are directed to the M1 port. Other
   addresses will go to the M0 port.
+- arm,dynamic-clk-gating : Enables dynamic clock gating (PL310)
+- arm,standby-mode : Enables standby mode (PL310)
 - interrupts : 1 combined interrupt.
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 64a8cbe9480f..c96b7bc90dfe 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -114,6 +114,8 @@
 			cache-level = <2>;
 			arm,tag-latency = <4 2 3>;
 			arm,data-latency = <4 2 3>;
+			arm,dynamic-clk-gating;
+			arm,standby-mode;
 		};
 
 		pcie: pcie at 0x01000000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1aaf2d..8094ac1cedc5 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -81,6 +81,8 @@
 			cache-level = <2>;
 			arm,tag-latency = <4 2 3>;
 			arm,data-latency = <4 2 3>;
+			arm,dynamic-clk-gating;
+			arm,standby-mode;
 		};
 
 		pmu {
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 831c65d55ab3..547072b16768 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1079,6 +1079,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	u32 data[3] = { 0, 0, 0 };
 	u32 tag[3] = { 0, 0, 0 };
 	u32 filter[2] = { 0, 0 };
+	u32 val;
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
@@ -1105,6 +1106,15 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
+
+	val = 0;
+	if (of_property_read_bool(np, "arm,dynamic-clk-gating"))
+		val |= L310_DYNAMIC_CLK_GATING_EN;
+	if (of_property_read_bool(np, "arm,standby-mode"))
+		val |= L310_STNDBY_MODE_EN;
+
+	if (val)
+		l2c_write_sec(val, l2x0_base, L310_POWER_CTRL);
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
-- 
1.8.3.1
