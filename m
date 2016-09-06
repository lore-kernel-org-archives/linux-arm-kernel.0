From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Sep 2016 16:46:18 +0200
Subject: [PATCH v2 7/9] ARM: sun8i: a33: Add display pipeline
In-Reply-To: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
Message-ID: <20160906144620.6322-8-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add all the needed blocks to the A33 DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 152 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index f3d91d2c96ef..1d21d488cb3e 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -59,11 +59,53 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun8i-a33-display-engine";
+		allwinner,pipelines = <&fe0>;
+		status = "disabled";
+	};
+
 	memory {
 		reg = <0x40000000 0x80000000>;
 	};
 
 	soc at 01c00000 {
+		tcon0: lcd-controller at 01c0c000 {
+			compatible = "allwinner,sun8i-a33-tcon";
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LCD>,
+				 <&ccu CLK_LCD_CH0>;
+			clock-names = "ahb",
+				      "tcon-ch0";
+			clock-output-names = "tcon-pixel-clock";
+			resets = <&ccu RST_BUS_LCD>;
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
 		crypto: crypto-engine at 01c15000 {
 			compatible = "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
@@ -104,6 +146,116 @@
 			status = "disabled";
 			#phy-cells = <1>;
 		};
+
+		fe0: display-frontend at 01e00000 {
+			compatible = "allwinner,sun8i-a33-display-frontend";
+			reg = <0x01e00000 0x20000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DE_FE>, <&ccu CLK_DE_FE>,
+				 <&ccu CLK_DRAM_DE_FE>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_BUS_DE_FE>;
+			status = "disabled";
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
+			compatible = "allwinner,sun8i-a33-display-backend";
+			reg = <0x01e60000 0x10000>, <0x01e80000 0x1000>;
+			reg-names = "be", "sat";
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DE_BE>, <&ccu CLK_DE_BE>,
+				 <&ccu CLK_DRAM_DE_BE>, <&ccu CLK_BUS_SAT>;
+			clock-names = "ahb", "mod",
+				      "ram", "sat";
+			resets = <&ccu RST_BUS_DE_BE>, <&ccu RST_BUS_SAT>;
+			reset-names = "be", "sat";
+			assigned-clocks = <&ccu CLK_DE_BE>;
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
+			compatible = "allwinner,sun8i-a33-drc";
+			reg = <0x01e70000 0x10000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DRC>, <&ccu CLK_DRC>,
+				 <&ccu CLK_DRAM_DRC>;
+			clock-names = "ahb", "mod", "ram";
+			resets = <&ccu RST_BUS_DRC>;
+
+			assigned-clocks = <&ccu CLK_DRC>;
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
 	};
 };
 
-- 
2.9.3
