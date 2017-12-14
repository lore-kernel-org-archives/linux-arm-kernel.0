From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 12:23:49 +0800
Subject: [PATCH v2 2/3] ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux
 settings
In-Reply-To: <20171214042350.29469-1-wens@csie.org>
References: <20171214042350.29469-1-wens@csie.org>
Message-ID: <20171214042350.29469-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has 3 I2C controllers under the standard bus. There is one
more in the R_ block section. The pin functions for the 3 controllers
are on PH 0~6. I2C2 can also be used on pins PE14 and PE15, but these
pins can also mux the CSI (camera sensor interface) controller's
embedded I2C controller. The latter seems to be preferred in the
reference designs for I2C camera sensor access, freeing I2C2 for other
uses.

This patch adds device nodes for the three standard I2C controllers,
as well as pinmux settings for the PH pins. For I2C0 and I2C1, since
they only have one possible setting, just set them by default.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 354cb4b48f47..de5119a2a91c 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -348,6 +348,21 @@
 				drive-strength = <40>;
 			};
 
+			i2c0_pins: i2c0-pins {
+				pins = "PH0", "PH1";
+				function = "i2c0";
+			};
+
+			i2c1_pins: i2c1-pins {
+				pins = "PH2", "PH3";
+				function = "i2c1";
+			};
+
+			i2c2_ph_pins: i2c2-ph-pins {
+				pins = "PH4", "PH5";
+				function = "i2c2";
+			};
+
 			i2s1_pins: i2s1-pins {
 				/* I2S1 does not have external MCLK pin */
 				pins = "PG10", "PG11", "PG12", "PG13";
@@ -499,6 +514,46 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c at 1c2ac00 {
+			compatible = "allwinner,sun8i-a83t-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c at 1c2b000 {
+			compatible = "allwinner,sun8i-a83t-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c at 1c2b400 {
+			compatible = "allwinner,sun8i-a83t-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		emac: ethernet at 1c30000 {
 			compatible = "allwinner,sun8i-a83t-emac";
 			syscon = <&syscon>;
-- 
2.15.0
