From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  4 Nov 2018 19:27:04 +0100
Subject: [PATCH v3 27/28] arm64: dts: allwinner: h6: Add HDMI pipeline
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
Message-ID: <20181104182705.18047-28-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds all entries needed for HDMI to function properly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
[added DE3 bus]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 201 +++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 040828d2e2c0..59dda8f89d23 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -6,8 +6,11 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun50i-h6-ccu.h>
 #include <dt-bindings/clock/sun50i-h6-r-ccu.h>
+#include <dt-bindings/clock/sun8i-de2.h>
+#include <dt-bindings/clock/sun8i-tcon-top.h>
 #include <dt-bindings/reset/sun50i-h6-ccu.h>
 #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
+#include <dt-bindings/reset/sun8i-de2.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -86,12 +89,63 @@
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun50i-h6-display-engine";
+		allwinner,pipelines = <&mixer0>;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
+		de3 at 1000000 {
+			compatible = "allwinner,sun50i-h6-de3",
+				     "allwinner,sun50i-a64-de2";
+			reg = <0x1000000 0x400000>;
+			allwinner,sram = <&de2_sram 1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1000000 0x400000>;
+
+			display_clocks: clock at 0 {
+				compatible = "allwinner,sun50i-h6-de3-clk";
+				reg = <0x0 0x10000>;
+				clocks = <&ccu CLK_DE>,
+					 <&ccu CLK_BUS_DE>;
+				clock-names = "mod",
+					      "bus";
+				resets = <&ccu RST_BUS_DE>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			mixer0: mixer at 100000 {
+				compatible = "allwinner,sun50i-h6-de3-mixer-0";
+				reg = <0x100000 0x100000>;
+				clocks = <&display_clocks CLK_BUS_MIXER0>,
+					 <&display_clocks CLK_MIXER0>;
+				clock-names = "bus",
+					      "mod";
+				resets = <&display_clocks RST_MIXER0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					mixer0_out: port at 1 {
+						reg = <1>;
+
+						mixer0_out_tcon_top_mixer0: endpoint {
+							remote-endpoint = <&tcon_top_mixer0_in_mixer0>;
+						};
+					};
+				};
+			};
+		};
+
 		syscon: syscon at 3000000 {
 			compatible = "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
@@ -149,6 +203,11 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			hdmi_pins: hdmi-pins {
+				pins = "PH8", "PH9", "PH10";
+				function = "hdmi";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
@@ -258,6 +317,148 @@
 			status = "disabled";
 		};
 
+		hdmi: hdmi at 6000000 {
+			compatible = "allwinner,sun50i-h6-dw-hdmi";
+			reg = <0x06000000 0x10000>;
+			reg-io-width = <1>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_SLOW>,
+				 <&ccu CLK_HDMI>, <&ccu CLK_HDMI_CEC>,
+				 <&ccu CLK_HDCP>, <&ccu CLK_BUS_HDCP>;
+			clock-names = "iahb", "isfr", "tmds", "cec", "hdcp",
+				      "hdcp-bus";
+			resets = <&ccu RST_BUS_HDMI_SUB>, <&ccu RST_BUS_HDCP>;
+			reset-names = "ctrl", "hdcp";
+			phys = <&hdmi_phy>;
+			phy-names = "hdmi-phy";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdmi_pins>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port at 0 {
+					reg = <0>;
+
+					hdmi_in_tcon_top: endpoint {
+						remote-endpoint = <&tcon_top_hdmi_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port at 1 {
+					reg = <1>;
+				};
+			};
+		};
+
+		hdmi_phy: hdmi-phy at 6010000 {
+			compatible = "allwinner,sun50i-h6-hdmi-phy";
+			reg = <0x06010000 0x10000>;
+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_SLOW>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_HDMI>;
+			reset-names = "phy";
+			#phy-cells = <0>;
+		};
+
+		tcon_top: tcon-top at 6510000 {
+			compatible = "allwinner,sun50i-h6-tcon-top";
+			reg = <0x06510000 0x1000>;
+			clocks = <&ccu CLK_BUS_TCON_TOP>,
+				 <&ccu CLK_TCON_TV0>;
+			clock-names = "bus",
+				      "tcon-tv0";
+			clock-output-names = "tcon-top-tv0";
+			resets = <&ccu RST_BUS_TCON_TOP>;
+			reset-names = "rst";
+			#clock-cells = <1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_top_mixer0_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon_top_mixer0_in_mixer0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&mixer0_out_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_mixer0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					tcon_top_mixer0_out_tcon_tv: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&tcon_tv_in_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_hdmi_in: port at 4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+
+					tcon_top_hdmi_in_tcon_tv: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_tv_out_tcon_top>;
+					};
+				};
+
+				tcon_top_hdmi_out: port at 5 {
+					reg = <5>;
+
+					tcon_top_hdmi_out_hdmi: endpoint {
+						remote-endpoint = <&hdmi_in_tcon_top>;
+					};
+				};
+			};
+		};
+
+		tcon_tv: lcd-controller at 6515000 {
+			compatible = "allwinner,sun50i-h6-tcon-tv",
+				     "allwinner,sun8i-r40-tcon-tv";
+			reg = <0x06515000 0x1000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_TV0>,
+				 <&tcon_top CLK_TCON_TOP_TV0>;
+			clock-names = "ahb",
+				      "tcon-ch1";
+			resets = <&ccu RST_BUS_TCON_TV0>;
+			reset-names = "lcd";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_tv_in: port at 0 {
+					reg = <0>;
+
+					tcon_tv_in_tcon_top_mixer0: endpoint {
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_tv>;
+					};
+				};
+
+				tcon_tv_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					tcon_tv_out_tcon_top: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_hdmi_in_tcon_tv>;
+					};
+				};
+			};
+		};
+
 		r_ccu: clock at 7010000 {
 			compatible = "allwinner,sun50i-h6-r-ccu";
 			reg = <0x07010000 0x400>;
-- 
2.19.1
