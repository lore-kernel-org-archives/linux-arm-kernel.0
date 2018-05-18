From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:19 +0530
Subject: [PATCH v2 09/26] arm64: dts: allwinner: a64: Add DE2 tcon1 pipeline
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-10-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DE2 on the A64 is mainly composed of the mixers and tcons,
plus various encoders.

This patch add second mixer and tcon which eventually useful
for testing HDMI. the other part of DE2 will add in future.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Change compatibles and other based on previous patch changes

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 26c2a9c44727..9c1452ee8027 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -107,6 +107,12 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun50i-a64-display-engine";
+		allwinner,pipelines = <&mixer1>;
+		status = "disabled";
+	};
+
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -183,6 +189,30 @@
 			#reset-cells = <1>;
 		};
 
+		mixer1: mixer at 1200000 {
+			compatible = "allwinner,sun50i-a64-de2-mixer-1";
+			reg = <0x01200000 0x100000>;
+			clocks = <&display_clocks CLK_BUS_MIXER1>,
+				 <&display_clocks CLK_MIXER1>;
+			clock-names = "bus",
+				      "mod";
+			resets = <&display_clocks RST_WB>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer1_out: port at 1 {
+					reg = <1>;
+
+					mixer1_out_tcon1: endpoint {
+						remote-endpoint = <&tcon1_in_mixer1>;
+					};
+				};
+			};
+		};
+
+
 		syscon: syscon at 1c00000 {
 			compatible = "allwinner,sun50i-a64-system-controller",
 				"syscon";
@@ -200,6 +230,37 @@
 			#dma-cells = <1>;
 		};
 
+		tcon1: lcd-controller at 1c0d000 {
+			compatible = "allwinner,sun50i-a64-tcon-tv",
+				     "allwinner,sun8i-a83t-tcon-tv";
+			reg = <0x01c0d000 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON1>, <&ccu CLK_TCON1>;
+			clock-names = "ahb", "tcon-ch1";
+			resets = <&ccu RST_BUS_TCON1>;
+			reset-names = "lcd";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon1_in: port at 0 {
+					reg = <0>;
+
+					tcon1_in_mixer1: endpoint {
+						remote-endpoint = <&mixer1_out_tcon1>;
+					};
+				};
+
+				tcon1_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+				};
+			};
+		};
+
 		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun50i-a64-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.14.3
