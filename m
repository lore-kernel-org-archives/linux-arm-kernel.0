From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Mar 2017 18:05:33 +0800
Subject: [PATCH 10/11] ARM: dts: sun6i: Add second display pipeline device
 nodes
In-Reply-To: <20170309100534.14023-1-wens@csie.org>
References: <20170309100534.14023-1-wens@csie.org>
Message-ID: <20170309100534.14023-11-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A31/A31s SoCs have 2 display pipelines, as in 2 display
frontends, backends, and tcons each. The relationship between the
backends and tcons are 1:1, but the frontends can feed either backend.

Add device nodes and of graph nodes describing this relationship.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 168 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a4b96184cac1..40f020824ccc 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -233,7 +233,7 @@
 
 	de: display-engine {
 		compatible = "allwinner,sun6i-a31-display-engine";
-		allwinner,pipelines = <&fe0>;
+		allwinner,pipelines = <&fe0>, <&fe1>;
 		status = "disabled";
 	};
 
@@ -290,6 +290,43 @@
 			};
 		};
 
+		tcon1: lcd-controller at 01c0d000 {
+			compatible = "allwinner,sun6i-a31-tcon";
+			reg = <0x01c0d000 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_AHB1_LCD1>;
+			reset-names = "lcd";
+			clocks = <&ccu CLK_AHB1_LCD1>,
+				 <&ccu CLK_LCD1_CH0>,
+				 <&ccu CLK_LCD1_CH1>;
+			clock-names = "ahb",
+				      "tcon-ch0",
+				      "tcon-ch1";
+			clock-output-names = "tcon1-pixel-clock";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon1_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon1_in_drc1: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&drc1_out_tcon1>;
+					};
+				};
+
+				tcon1_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -897,6 +934,130 @@
 						reg = <0>;
 						remote-endpoint = <&be0_in_fe0>;
 					};
+
+					fe0_out_be1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&be1_in_fe0>;
+					};
+				};
+			};
+		};
+
+		fe1: display-frontend at 01e20000 {
+			compatible = "allwinner,sun6i-a31-display-frontend";
+			reg = <0x01e20000 0x20000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_AHB1_FE1>, <&ccu CLK_FE1>,
+				 <&ccu CLK_DRAM_FE1>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_AHB1_FE1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fe1_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					fe1_out_be0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&be0_in_fe1>;
+					};
+
+					fe1_out_be1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&be1_in_fe1>;
+					};
+				};
+			};
+		};
+
+		be1: display-backend at 01e40000 {
+			compatible = "allwinner,sun6i-a31-display-backend";
+			reg = <0x01e40000 0x10000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_AHB1_BE1>, <&ccu CLK_BE1>,
+				 <&ccu CLK_DRAM_BE1>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_AHB1_BE1>;
+
+			assigned-clocks = <&ccu CLK_BE1>;
+			assigned-clock-rates = <300000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				be1_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					be1_in_fe0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&fe0_out_be1>;
+					};
+
+					be1_in_fe1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&fe1_out_be1>;
+					};
+				};
+
+				be1_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					be1_out_drc1: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&drc1_in_be1>;
+					};
+				};
+			};
+		};
+
+		drc1: drc at 01e50000 {
+			compatible = "allwinner,sun6i-a31-drc";
+			reg = <0x01e50000 0x10000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_AHB1_DRC1>, <&ccu CLK_IEP_DRC1>,
+				 <&ccu CLK_DRAM_DRC1>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_AHB1_DRC1>;
+
+			assigned-clocks = <&ccu CLK_IEP_DRC1>;
+			assigned-clock-rates = <300000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				drc1_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					drc1_in_be1: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&be1_out_drc1>;
+					};
+				};
+
+				drc1_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					drc1_out_tcon1: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon1_in_drc1>;
+					};
 				};
 			};
 		};
@@ -927,6 +1088,11 @@
 						reg = <0>;
 						remote-endpoint = <&fe0_out_be0>;
 					};
+
+					be0_in_fe1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&fe1_out_be0>;
+					};
 				};
 
 				be0_out: port at 1 {
-- 
2.11.0
