From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Oct 2016 11:43:42 +0800
Subject: [PATCH v2 6/8] ARM: dts: sun6i: Add device nodes for first display
 pipeline
In-Reply-To: <20161020034344.14154-1-wens@csie.org>
References: <20161020034344.14154-1-wens@csie.org>
Message-ID: <20161020034344.14154-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has 2 parallel display pipelines, which can be intermixed.
However the driver currently only supports one of them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi  | 152 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31s.dtsi |   8 ++
 2 files changed, 160 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c1b891e75f18..4d2c7786b92a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -231,6 +231,11 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun6i-a31-display-engine";
+		allwinner,pipelines = <&fe0>;
+	};
+
 	soc at 01c00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -246,6 +251,44 @@
 			#dma-cells = <1>;
 		};
 
+		tcon0: lcd-controller at 01c0c000 {
+			compatible = "allwinner,sun6i-a31-tcon";
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_AHB1_LCD0>;
+			reset-names = "lcd";
+			clocks = <&ccu CLK_AHB1_LCD0>,
+				 <&ccu CLK_LCD0_CH0>,
+				 <&ccu CLK_LCD0_CH1>;
+			clock-names = "ahb",
+				      "tcon-ch0",
+				      "tcon-ch1";
+			clock-output-names = "tcon0-pixel-clock";
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
+					tcon0_in_drc0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&drc0_out_tcon0>;
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
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -799,6 +842,115 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		fe0: display-frontend at 01e00000 {
+			compatible = "allwinner,sun6i-a31-display-frontend";
+			reg = <0x01e00000 0x20000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_AHB1_FE0>, <&ccu CLK_FE0>,
+				 <&ccu CLK_DRAM_FE0>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_AHB1_FE0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fe0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					fe0_out_be0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&be0_in_fe0>;
+					};
+				};
+			};
+		};
+
+		be0: display-backend at 01e60000 {
+			compatible = "allwinner,sun6i-a31-display-backend";
+			reg = <0x01e60000 0x10000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_AHB1_BE0>, <&ccu CLK_BE0>,
+				 <&ccu CLK_DRAM_BE0>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_AHB1_BE0>;
+
+			assigned-clocks = <&ccu CLK_BE0>;
+			assigned-clock-rates = <300000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				be0_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					be0_in_fe0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&fe0_out_be0>;
+					};
+				};
+
+				be0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					be0_out_drc0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&drc0_in_be0>;
+					};
+				};
+			};
+		};
+
+		drc0: drc at 01e70000 {
+			compatible = "allwinner,sun6i-a31-drc";
+			reg = <0x01e70000 0x10000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_AHB1_DRC0>, <&ccu CLK_IEP_DRC0>,
+				 <&ccu CLK_DRAM_DRC0>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_AHB1_DRC0>;
+
+			assigned-clocks = <&ccu CLK_IEP_DRC0>;
+			assigned-clock-rates = <300000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				drc0_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					drc0_in_be0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&be0_out_drc0>;
+					};
+				};
+
+				drc0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					drc0_out_tcon0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon0_in_drc0>;
+					};
+				};
+			};
+		};
+
 		rtc: rtc at 01f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
diff --git a/arch/arm/boot/dts/sun6i-a31s.dtsi b/arch/arm/boot/dts/sun6i-a31s.dtsi
index c17a32771b98..97e2c51d0aea 100644
--- a/arch/arm/boot/dts/sun6i-a31s.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31s.dtsi
@@ -48,6 +48,14 @@
 
 #include "sun6i-a31.dtsi"
 
+&de {
+	compatible = "allwinner,sun6i-a31s-display-engine";
+};
+
 &pio {
 	compatible = "allwinner,sun6i-a31s-pinctrl";
 };
+
+&tcon0 {
+	compatible = "allwinner,sun6i-a31s-tcon";
+};
-- 
2.9.3
