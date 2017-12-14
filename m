From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 12:23:48 +0800
Subject: [PATCH v2 1/3] ARM: dts: sun8i: a83t: Add I2S controller device nodes
In-Reply-To: <20171214042350.29469-1-wens@csie.org>
References: <20171214042350.29469-1-wens@csie.org>
Message-ID: <20171214042350.29469-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has 3 I2S controllers. The first is multiplexed with the TDM
controller. The pins are generally connected to the codec side of the
AXP81x PMIC/codec/RTC chip. The second is free for other uses. The
third only supports output, and is connected internally to the HDMI
controller for HDMI audio output.

This patch adds device nodes for the controllers, and a default pinmux
setting for the second controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index a384b766f3dc..354cb4b48f47 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -348,6 +348,12 @@
 				drive-strength = <40>;
 			};
 
+			i2s1_pins: i2s1-pins {
+				/* I2S1 does not have external MCLK pin */
+				pins = "PG10", "PG11", "PG12", "PG13";
+				function = "i2s1";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
@@ -430,6 +436,47 @@
 			status = "disabled";
 		};
 
+		i2s0: i2s at 1c22000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a83t-i2s";
+			reg = <0x01c22000 0x400>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S0>, <&ccu CLK_I2S0>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 3>, <&dma 3>;
+			resets = <&ccu RST_BUS_I2S0>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2s1: i2s at 1c22400 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a83t-i2s";
+			reg = <0x01c22400 0x400>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 4>, <&dma 4>;
+			resets = <&ccu RST_BUS_I2S1>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s1_pins>;
+			status = "disabled";
+		};
+
+		i2s2: i2s at 1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a83t-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.15.0
