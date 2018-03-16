From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Mar 2018 01:53:52 +0800
Subject: [PATCH 5/7] arm64: allwinner: a64: add DE2 CCU related device tree
 nodes
In-Reply-To: <20180316175354.21437-1-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
Message-ID: <20180316175354.21437-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have all necessary parts to enable the DE2 CCU on the Allwinner
A64 SoC, add the needed device tree nodes, including the SRAM controller
node, SRAM C node, DE2 bus node and DE2 CCU node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b6dc31e7d91..1f92015503ea 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -148,6 +148,48 @@
 		#size-cells = <1>;
 		ranges;
 
+		de2 at 1000000 {
+			compatible = "allwinner,sun50i-a64-de2";
+			reg = <0x1000000 0x400000>;
+			allwinner,sram = <&de2_sram 1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1000000 0x400000>;
+
+			display_clocks: clock at 0 {
+				compatible = "allwinner,sun50i-a64-de2-clk";
+				reg = <0x0 0x100000>;
+				clocks = <&ccu CLK_DE>,
+					 <&ccu CLK_BUS_DE>;
+				clock-names = "mod",
+					      "bus";
+				resets = <&ccu RST_BUS_DE>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+		};
+
+		sram-controller at 1c00000 {
+			compatible = "allwinner,sun50i-a64-sram-controller";
+			reg = <0x01c00000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_c: sram at 18000 {
+				compatible = "mmio-sram";
+				reg = <0x00018000 0x28000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00018000 0x28000>;
+
+				de2_sram: sram-section at 0 {
+					compatible = "allwinner,sun50i-a64-sram-c";
+					reg = <0x0000 0x28000>;
+				};
+			};
+		};
+
 		syscon: syscon at 1c00000 {
 			compatible = "allwinner,sun50i-a64-system-controller",
 				"syscon";
-- 
2.15.1
