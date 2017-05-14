From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 May 2017 00:30:43 +0800
Subject: [PATCH v7 11/13] ARM: sun8i: v3s: add device nodes for DE2 display
 pipeline
In-Reply-To: <20170514163045.40366-1-icenowy@aosc.io>
References: <20170514163045.40366-1-icenowy@aosc.io>
Message-ID: <20170514163045.40366-12-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC features a "Display Engine 2.0" with only one mixer
and only one TCON connected to this mixer, which have RGB LCD output.

Add device nodes for this display pipeline.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v7:
- Change DE2 clock compatible to V3s one.
- Mention only one TCON in commit message.
- Changed commit brief.

 arch/arm/boot/dts/sun8i-v3s.dtsi | 87 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 71075969e5e6..b71b35734515 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -41,6 +41,10 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun8i-v3s-ccu.h>
+#include <dt-bindings/clock/sun8i-de2.h>
+#include <dt-bindings/reset/sun8i-v3s-ccu.h>
+#include <dt-bindings/reset/sun8i-de2.h>
 
 / {
 	#address-cells = <1>;
@@ -59,6 +63,12 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun8i-v3s-display-engine";
+		allwinner,pipelines = <&de2_mixer0>;
+		status = "disabled";
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -93,6 +103,83 @@
 		#size-cells = <1>;
 		ranges;
 
+		de2_clocks: clock at 1000000 {
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
+		de2_mixer0: mixer at 1100000 {
+			compatible = "allwinner,sun8i-v3s-de2-mixer";
+			reg = <0x01100000 0x100000>;
+			clocks = <&de2_clocks CLK_MIXER0>,
+				 <&de2_clocks CLK_BUS_MIXER0>;
+			clock-names = "mod",
+				      "bus";
+			resets = <&de2_clocks RST_MIXER0>;
+			assigned-clocks = <&de2_clocks CLK_MIXER0>;
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
