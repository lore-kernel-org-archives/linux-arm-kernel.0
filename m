From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 22 Dec 2017 20:22:42 +0800
Subject: [PATCH v3 10/11] arm64: allwinner: a64: add DE2 CCU for A64 SoC
In-Reply-To: <20171222122243.25735-1-icenowy@aosc.io>
References: <20171222122243.25735-1-icenowy@aosc.io>
Message-ID: <20171222122243.25735-11-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC features a DE2 CCU like the one in H5, but needs to claim a
section of SRAM (SRAM C) to be accessed.

Adds the device tree nodes for the SRAM controller and the DE2 CCU.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v3:
- Fixed the alliwnner,sram property (the 1 after SRAM phadle is missing
  in v2).

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d783d164b9c3..fb8ea7c414e1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -130,6 +130,40 @@
 		#size-cells = <1>;
 		ranges;
 
+		display_clocks: clock at 1000000 {
+			compatible = "allwinner,sun50i-a64-de2-clk";
+			reg = <0x01000000 0x100000>;
+			clocks = <&ccu CLK_DE>,
+				 <&ccu CLK_BUS_DE>;
+			clock-names = "mod",
+				      "bus";
+			resets = <&ccu RST_BUS_DE>;
+			allwinner,sram = <&de2_sram 1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
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
2.14.2
