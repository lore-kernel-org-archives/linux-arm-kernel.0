From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 29 Mar 2017 01:30:11 +0800
Subject: [RFC PATCH 1/3] dt-bindings: update the Allwinner GPADC device tree
 binding for H3
In-Reply-To: <20170328173013.16539-1-icenowy@aosc.io>
References: <20170328173013.16539-1-icenowy@aosc.io>
Message-ID: <20170328173013.16539-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H3 features a thermal sensor like the one in A33, but has its
register re-arranged, the clock divider moved to CCU (originally the
clock divider is in ADC) and added a pair of bus clock and reset.

Update the binding document to cover H3.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
index badff3611a98..7753133ca0ff 100644
--- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
+++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
@@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also act as a thermal sensor
 and sometimes as a touchscreen controller.
 
 Required properties:
-  - compatible: "allwinner,sun8i-a33-ths",
+  - compatible: must contain one of the following compatibles:
+		- "allwinner,sun8i-a33-ths"
+		- "allwinner,sun8i-h3-ths"
   - reg: mmio address range of the chip,
   - #thermal-sensor-cells: shall be 0,
   - #io-channel-cells: shall be 0,
 
-Example:
+Required properties for the following compatibles:
+		- "allwinner,sun8i-h3-ths"
+  - clocks: the bus clock and the input clock of the ADC,
+  - clock-names: should be "bus" and "ths",
+  - resets: the bus reset of the ADC,
+
+Example for A33:
 	ths: ths at 01c25000 {
 		compatible = "allwinner,sun8i-a33-ths";
 		reg = <0x01c25000 0x100>;
@@ -17,6 +25,17 @@ Example:
 		#io-channel-cells = <0>;
 	};
 
+Example for H3:
+	ths: ths at 01c25000 {
+		compatible = "allwinner,sun8i-h3-ths";
+		reg = <0x01c25000 0x100>;
+		clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+		clock-names = "bus", "ths";
+		resets = <&ccu RST_BUS_THS>;
+		#thermal-sensor-cells = <0>;
+		#io-channel-cells = <0>;
+	};
+
 sun4i, sun5i and sun6i SoCs are also supported via the older binding:
 
 sun4i resistive touchscreen controller
-- 
2.12.0
