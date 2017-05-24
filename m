From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 19:17:23 +0800
Subject: [PATCH 1/2] ARM: sun8i: v3s: add device nodes for DE2 display pipeline
Message-ID: <20170524111724.28431-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC features a "Display Engine 2.0" with only one mixer
and only one TCON connected to this mixer, which have RGB LCD output.

Add device nodes for this display pipeline.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index a49ebef53c91..3a06dc5b3746 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -61,6 +61,12 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun8i-v3s-display-engine";
+		allwinner,pipelines = <&mixer0>;
+		status = "disabled";
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -95,6 +101,83 @@
 		#size-cells = <1>;
 		ranges;
 
+		display_clocks: clock at 1000000 {
+			compatible = "allwinner,sun8i-v3s-de2-clk";
+			reg = <0x01000000 0x100000>;
+			clocks = <&ccu CLK_DE>,
+				 <&ccu CLK_BUS_DE>;
+			clock-names = "mod",
+				      "bus";
+			resets = <&ccu RST_BUS_DE>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		mixer0: mixer at 1100000 {
+			compatible = "allwinner,sun8i-v3s-de2-mixer";
+			reg = <0x01100000 0x100000>;
+			clocks = <&display_clocks 0>,
+				 <&display_clocks 6>;
+			clock-names = "bus",
+				      "mod";
+			resets = <&display_clocks 0>;
+			assigned-clocks = <&display_clocks 6>;
+			assigned-clock-rates = <150000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					mixer0_out_tcon0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon0_in_mixer0>;
+					};
+				};
+			};
+		};
+
+		tcon0: lcd-controller at 1c0c000 {
+			compatible = "allwinner,sun8i-v3s-tcon";
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON0>,
+				 <&ccu CLK_TCON0>;
+			clock-names = "ahb",
+				      "tcon-ch0";
+			clock-output-names = "tcon-pixel-clock";
+			resets = <&ccu RST_BUS_TCON0>;
+			reset-names = "lcd";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon0_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon0_in_mixer0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&mixer0_out_tcon0>;
+					};
+				};
+
+				tcon0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.12.2
