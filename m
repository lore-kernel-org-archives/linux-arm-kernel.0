From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Mar 2018 01:53:49 +0800
Subject: [PATCH 2/7] dt-bindings: add binding for the Allwinner A64 DE2 bus
In-Reply-To: <20180316175354.21437-1-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
Message-ID: <20180316175354.21437-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64 SoC to
be claimed, otherwise the whole DE2 space is inaccessible.

Add a device tree binding of the DE2 part as a sub-bus.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/bus/sun50i-de2-bus.txt     | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt

diff --git a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
new file mode 100644
index 000000000000..87dfb33fb3be
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
@@ -0,0 +1,37 @@
+Device tree bindings for Allwinner A64 DE2 bus
+
+The Allwinner A64 DE2 is on a special bus, which needs a SRAM region (SRAM C)
+to be claimed for enabling the access.
+
+Required properties:
+
+ - compatible:		Should contain "allwinner,sun50i-a64-de2"
+ - reg:			A resource specifier for the register space
+ - #address-cells:	Must be set to 1
+ - #size-cells:		Must be set to 1
+ - ranges:		Must be set up to map the address space inside the
+			DE2, for the sub-blocks of DE2.
+ - allwinner,sram:	the SRAM that needs to be claimed
+
+Example:
+
+	de2 at 1000000 {
+		compatible = "allwinner,sun50i-a64-de2";
+		reg = <0x1000000 0x400000>;
+		allwinner,sram = <&de2_sram 1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1000000 0x400000>;
+
+		display_clocks: clock at 0 {
+			compatible = "allwinner,sun50i-a64-de2-clk";
+			reg = <0x0 0x100000>;
+			clocks = <&ccu CLK_DE>,
+				 <&ccu CLK_BUS_DE>;
+			clock-names = "mod",
+				      "bus";
+			resets = <&ccu RST_BUS_DE>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+	};
-- 
2.15.1
