From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 20:18:04 +0800
Subject: [PATCH 07/10] ARM: dts: sun4i: Add device nodes for display pipelines
In-Reply-To: <20171017121807.2994-1-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
Message-ID: <20171017121807.2994-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 has two interconnected display pipelines, much like the A31,
but without the DRCs between the backend and TCONs.

Add all the device nodes for them, including the downstream HDMI
controller that we already support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 306 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 306 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index eb5256685de0..5840f5c75c3b 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -180,6 +180,12 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun4i-a10-display-engine";
+		allwinner,pipelines = <&fe0>, <&fe1>;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -292,6 +298,104 @@
 			#size-cells = <0>;
 		};
 
+		tcon0: lcd-controller at 1c0c000 {
+			compatible = "allwinner,sun4i-a10-tcon";
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <44>;
+			resets = <&ccu RST_TCON0>;
+			reset-names = "lcd";
+			clocks = <&ccu CLK_AHB_LCD0>,
+				 <&ccu CLK_TCON0_CH0>,
+				 <&ccu CLK_TCON0_CH1>;
+			clock-names = "ahb",
+				      "tcon-ch0",
+				      "tcon-ch1";
+			clock-output-names = "tcon0-pixel-clock";
+			dmas = <&dma SUN4I_DMA_DEDICATED 14>;
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
+					tcon0_in_be0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&be0_out_tcon0>;
+					};
+
+					tcon0_in_be1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&be1_out_tcon0>;
+					};
+				};
+
+				tcon0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					tcon0_out_hdmi: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&hdmi_in_tcon0>;
+						allwinner,tcon-channel = <1>;
+					};
+				};
+			};
+		};
+
+		tcon1: lcd-controller at 1c0d000 {
+			compatible = "allwinner,sun4i-a10-tcon";
+			reg = <0x01c0d000 0x1000>;
+			interrupts = <45>;
+			resets = <&ccu RST_TCON1>;
+			reset-names = "lcd";
+			clocks = <&ccu CLK_AHB_LCD1>,
+				 <&ccu CLK_TCON1_CH0>,
+				 <&ccu CLK_TCON1_CH1>;
+			clock-names = "ahb",
+				      "tcon-ch0",
+				      "tcon-ch1";
+			clock-output-names = "tcon1-pixel-clock";
+			dmas = <&dma SUN4I_DMA_DEDICATED 15>;
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
+					tcon1_in_be0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&be0_out_tcon1>;
+					};
+
+					tcon1_in_be1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&be1_out_tcon1>;
+					};
+				};
+
+				tcon1_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					tcon1_out_hdmi: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&hdmi_in_tcon1>;
+						allwinner,tcon-channel = <1>;
+					};
+				};
+			};
+		};
+
 		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -393,6 +497,48 @@
 			clock-names = "ahb", "mod";
 		};
 
+		hdmi: hdmi at 1c16000 {
+			compatible = "allwinner,sun4i-a10-hdmi";
+			reg = <0x01c16000 0x1000>;
+			interrupts = <58>;
+			clocks = <&ccu CLK_AHB_HDMI0>, <&ccu CLK_HDMI>,
+				 <&ccu CLK_PLL_VIDEO0_2X>,
+				 <&ccu CLK_PLL_VIDEO1_2X>;
+			clock-names = "ahb", "mod", "pll-0", "pll-1";
+			dmas = <&dma SUN4I_DMA_NORMAL 16>,
+			       <&dma SUN4I_DMA_NORMAL 16>,
+			       <&dma SUN4I_DMA_DEDICATED 24>;
+			dma-names = "ddc-tx", "ddc-rx", "audio-tx";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					hdmi_in_tcon0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon0_out_hdmi>;
+					};
+
+					hdmi_in_tcon1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&tcon1_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
 		spi2: spi at 1c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
@@ -856,5 +1002,165 @@
 			clocks = <&ccu CLK_APB1_CAN>;
 			status = "disabled";
 		};
+
+		fe0: display-frontend at 1e00000 {
+			compatible = "allwinner,sun4i-a10-display-frontend";
+			reg = <0x01e00000 0x20000>;
+			interrupts = <47>;
+			clocks = <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_DE_FE0>,
+				 <&ccu CLK_DRAM_DE_FE0>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_DE_FE0>;
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
+
+					fe0_out_be1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&be1_in_fe0>;
+					};
+				};
+			};
+		};
+
+		fe1: display-frontend at 1e20000 {
+			compatible = "allwinner,sun4i-a10-display-frontend";
+			reg = <0x01e20000 0x20000>;
+			interrupts = <48>;
+			clocks = <&ccu CLK_AHB_DE_FE1>, <&ccu CLK_DE_FE1>,
+				 <&ccu CLK_DRAM_DE_FE1>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_DE_FE1>;
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
+		be1: display-backend at 1e40000 {
+			compatible = "allwinner,sun4i-a10-display-backend";
+			reg = <0x01e40000 0x10000>;
+			interrupts = <48>;
+			clocks = <&ccu CLK_AHB_DE_BE1>, <&ccu CLK_DE_BE1>,
+				 <&ccu CLK_DRAM_DE_BE1>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_DE_BE1>;
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
+					be1_out_tcon0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon1_in_be0>;
+					};
+
+					be1_out_tcon1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&tcon1_in_be1>;
+					};
+				};
+			};
+		};
+
+		be0: display-backend at 1e60000 {
+			compatible = "allwinner,sun4i-a10-display-backend";
+			reg = <0x01e60000 0x10000>;
+			interrupts = <47>;
+			clocks = <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_DE_BE0>,
+				 <&ccu CLK_DRAM_DE_BE0>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_DE_BE0>;
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
+
+					be0_in_fe1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&fe1_out_be0>;
+					};
+				};
+
+				be0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					be0_out_tcon0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon0_in_be0>;
+					};
+
+					be0_out_tcon1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&tcon1_in_be0>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
2.14.2
