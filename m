From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 31 Jul 2017 15:36:42 +0800
Subject: [PATCH v5 09/10] arm: dts: mt7623: add support for Bananapi R2
 (BPI-R2) board
In-Reply-To: <cover.1501486190.git.sean.wang@mediatek.com>
References: <cover.1501486190.git.sean.wang@mediatek.com>
Message-ID: <03f3fe78a96588ae9bd62e0dc1c4b0a9fa1f933c.1501486190.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add support for the Bananapi R2 (BPI-R2) development board from
BIPAI KEJI. Detailed hardware information for BPI-R2 which could be
found on http://www.banana-pi.org/r2.html

The patch added nodes into the SoC-level file mt7623.dtsi such as CPU OPP
table and thermal zone treating CPU as one of cooling devices and also
added nodes into board-level file mt7623n-bananapi-bpi-r2.dts such as
MediaTek GMAC, MT7530 Switch, the crypto engine, USB, IR, I2S, I2C, UART,
SPI, PWM, GPIO keys, GPIO LEDs and PMIC LEDs. As to the other missing
hardware and peripherals, they would be added and integrated continuously.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mt7623.dtsi                      | 120 +++++-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      | 443 +++++++++++++++++++++
 4 files changed, 561 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index ae011b2..1caa9d2 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -49,6 +49,8 @@ Supported boards:
 - Reference  board for MT7623n with NAND:
     Required root node properties:
       - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
+- Bananapi BPI-R2 board:
+      - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
 - MTK mt8127 tablet moose EVB:
     Required root node properties:
       - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f3a2442..736abbf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1050,6 +1050,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
 	mt7623n-rfb-nand.dtb \
+	mt7623n-bananapi-bpi-r2.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 937a550..86cab5c 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -21,12 +21,58 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/mt2701-resets.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "skeleton64.dtsi"
 
 / {
 	compatible = "mediatek,mt7623";
 	interrupt-parent = <&sysirq>;
 
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-98000000 {
+			opp-hz = /bits/ 64 <98000000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp-198000000 {
+			opp-hz = /bits/ 64 <198000000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp-398000000 {
+			opp-hz = /bits/ 64 <398000000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp-598000000 {
+			opp-hz = /bits/ 64 <598000000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp-747500000 {
+			opp-hz = /bits/ 64 <747500000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp-1040000000 {
+			opp-hz = /bits/ 64 <1040000000>;
+			opp-microvolt = <1150000>;
+		};
+
+		opp-1196000000 {
+			opp-hz = /bits/ 64 <1196000000>;
+			opp-microvolt = <1200000>;
+		};
+
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1300000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -36,21 +82,31 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
+			clocks = <&infracfg CLK_INFRA_CPUSEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
 		};
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x1>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x2>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x3>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 	};
 
@@ -74,6 +130,56 @@
 		clock-output-names = "clk26m";
 	};
 
+	thermal-zones {
+			cpu_thermal: cpu_thermal {
+				polling-delay-passive = <1000>;
+				polling-delay = <1000>;
+
+				thermal-sensors = <&thermal 0>;
+
+				trips {
+					cpu_passive: cpu_passive {
+						temperature = <47000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+
+					cpu_active: cpu_active {
+						temperature = <67000>;
+						hysteresis = <2000>;
+						type = "active";
+					};
+
+					cpu_hot: cpu_hot {
+						temperature = <87000>;
+						hysteresis = <2000>;
+						type = "hot";
+					};
+
+					cpu_crit {
+						temperature = <107000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_passive>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_active>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map2 {
+					trip = <&cpu_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&gic>;
@@ -172,7 +278,7 @@
 		clock-names = "spi", "wrap";
 	};
 
-	cir: cir at 0x10013000 {
+	cir: cir at 10013000 {
 		compatible = "mediatek,mt7623-cir";
 		reg = <0 0x10013000 0 0x1000>;
 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
@@ -193,7 +299,7 @@
 	efuse: efuse at 10206000 {
 		compatible = "mediatek,mt7623-efuse",
 			     "mediatek,mt8173-efuse";
-		reg	   = <0 0x10206000 0 0x1000>;
+		reg = <0 0x10206000 0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		thermal_calibration_data: calib at 424 {
@@ -561,7 +667,8 @@
 	};
 
 	u3phy1: usb-phy at 1a1c4000 {
-		compatible = "mediatek,mt7623-u3phy", "mediatek,mt2701-u3phy";
+		compatible = "mediatek,mt7623-u3phy",
+			     "mediatek,mt2701-u3phy";
 		reg = <0 0x1a1c4000 0 0x0700>;
 		clocks = <&clk26m>;
 		clock-names = "u3phya_ref";
@@ -599,7 +706,8 @@
 	};
 
 	u3phy2: usb-phy at 1a244000 {
-		compatible = "mediatek,mt7623-u3phy", "mediatek,mt2701-u3phy";
+		compatible = "mediatek,mt7623-u3phy",
+			     "mediatek,mt2701-u3phy";
 		reg = <0 0x1a244000 0 0x0700>;
 		clocks = <&clk26m>;
 		clock-names = "u3phya_ref";
@@ -639,7 +747,9 @@
 	};
 
 	eth: ethernet at 1b100000 {
-		compatible = "mediatek,mt2701-eth", "syscon";
+		compatible = "mediatek,mt7623-eth",
+			     "mediatek,mt2701-eth",
+			     "syscon";
 		reg = <0 0x1b100000 0 0x20000>;
 		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 199 IRQ_TYPE_LEVEL_LOW>,
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
new file mode 100644
index 0000000..9f3e6dd
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -0,0 +1,443 @@
+/*
+ * Copyright 2017 Sean Wang <sean.wang@mediatek.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "mt7623.dtsi"
+#include "mt6323.dtsi"
+
+/ {
+	model = "Bananapi BPI-R2";
+	compatible = "bananapi,bpi-r2", "mediatek,mt7623";
+
+	aliases {
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	cpus {
+		cpu at 0 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu at 1 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu at 2 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu at 3 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_pins_a>;
+
+		factory {
+			label = "factory";
+			linux,code = <BTN_0>;
+			gpios = <&pio 256 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 257 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_a>;
+
+		red {
+			label = "bpi-r2:pio:red";
+			gpios = <&pio 239 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green {
+			label = "bpi-r2:pio:green";
+			gpios = <&pio 240 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue {
+			label = "bpi-r2:pio:blue";
+			gpios = <&pio 241 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	memory at 80000000 {
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+};
+
+&cir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cir_pins_a>;
+	status = "okay";
+};
+
+&crypto {
+	status = "okay";
+};
+
+&eth {
+	status = "okay";
+	gmac0: mac at 0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		phy-mode = "trgmii";
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+			pause;
+		};
+	};
+
+	mdio: mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		switch at 0 {
+			compatible = "mediatek,mt7530";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			pinctrl-names = "default";
+			reset-gpios = <&pio 33 0>;
+			core-supply = <&mt6323_vpa_reg>;
+			io-supply = <&mt6323_vemc3v3_reg>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				port at 0 {
+					reg = <0>;
+					label = "wan";
+				};
+
+				port at 1 {
+					reg = <1>;
+					label = "lan0";
+				};
+
+				port at 2 {
+					reg = <2>;
+					label = "lan1";
+				};
+
+				port at 3 {
+					reg = <3>;
+					label = "lan2";
+				};
+
+				port at 4 {
+					reg = <4>;
+					label = "lan3";
+				};
+
+				port at 6 {
+					reg = <6>;
+					label = "cpu";
+					ethernet = <&gmac0>;
+					phy-mode = "trgmii";
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&pio {
+	cir_pins_a:cir at 0 {
+		pins_cir {
+			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
+			bias-disable;
+		};
+	};
+
+	i2c0_pins_a: i2c at 0 {
+		pins_i2c0 {
+			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
+				 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
+			bias-disable;
+		};
+	};
+
+	i2c1_pins_a: i2c at 1 {
+		pin_i2c1 {
+			pinmux = <MT7623_PIN_57_SDA1_FUNC_SDA1>,
+				 <MT7623_PIN_58_SCL1_FUNC_SCL1>;
+			bias-disable;
+		};
+	};
+
+	i2s0_pins_a: i2s at 0 {
+		pin_i2s0 {
+			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
+				 <MT7623_PIN_72_I2S0_DATA_IN_FUNC_I2S0_DATA_IN>,
+				 <MT7623_PIN_73_I2S0_LRCK_FUNC_I2S0_LRCK>,
+				 <MT7623_PIN_74_I2S0_BCK_FUNC_I2S0_BCK>,
+				 <MT7623_PIN_126_I2S0_MCLK_FUNC_I2S0_MCLK>;
+			drive-strength = <MTK_DRIVE_12mA>;
+			bias-pull-down;
+		};
+	};
+
+	i2s1_pins_a: i2s at 1 {
+		pin_i2s1 {
+			pinmux = <MT7623_PIN_33_I2S1_DATA_FUNC_I2S1_DATA>,
+				 <MT7623_PIN_34_I2S1_DATA_IN_FUNC_I2S1_DATA_IN>,
+				 <MT7623_PIN_35_I2S1_BCK_FUNC_I2S1_BCK>,
+				 <MT7623_PIN_36_I2S1_LRCK_FUNC_I2S1_LRCK>,
+				 <MT7623_PIN_37_I2S1_MCLK_FUNC_I2S1_MCLK>;
+			drive-strength = <MTK_DRIVE_12mA>;
+			bias-pull-down;
+		};
+	};
+
+	key_pins_a: keys at 0 {
+		pins_keys {
+			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
+				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257> ;
+			input-enable;
+		};
+	};
+
+	led_pins_a: leds at 0 {
+		pins_leds {
+			pinmux = <MT7623_PIN_239_EXT_SDIO0_FUNC_GPIO239>,
+				 <MT7623_PIN_240_EXT_XCS_FUNC_GPIO240>,
+				 <MT7623_PIN_241_EXT_SCK_FUNC_GPIO241>;
+		};
+	};
+
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
+				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins_clk {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		pins_rst {
+			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0 {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
+				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_clk {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_rst {
+			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_default: mmc1default {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
+				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
+				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
+				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
+				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_4mA>;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1 {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
+				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
+				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
+				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
+				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	spi0_pins_a: spi at 0 {
+		pins_spi {
+			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
+				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
+				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
+				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
+			bias-disable;
+		};
+	};
+
+	pwm_pins_a: pwm at 0 {
+		pins_pwm {
+			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
+				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
+				 <MT7623_PIN_205_PWM2_FUNC_PWM2>,
+				 <MT7623_PIN_206_PWM3_FUNC_PWM3>,
+				 <MT7623_PIN_207_PWM4_FUNC_PWM4>;
+		};
+	};
+
+	uart0_pins_a: uart at 0 {
+		pins_dat {
+			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
+				 <MT7623_PIN_80_UTXD0_FUNC_UTXD0>;
+		};
+	};
+
+	uart1_pins_a: uart at 1 {
+		pins_dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
+				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
+		};
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins_a>;
+	status = "okay";
+};
+
+&pwrap {
+	mt6323 {
+		mt6323led: led {
+			compatible = "mediatek,mt6323-led";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led at 0 {
+				reg = <0>;
+				label = "bpi-r2:isink:green";
+				default-state = "off";
+			};
+			led at 1 {
+				reg = <1>;
+				label = "bpi-r2:isink:red";
+				default-state = "off";
+			};
+			led at 2 {
+				reg = <2>;
+				label = "bpi-r2:isink:blue";
+				default-state = "off";
+			};
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_a>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "disabled";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_a>;
+	status = "disabled";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb1 {
+	vusb33-supply = <&mt6323_vusb_reg>;
+	status = "okay";
+};
+
+&usb2 {
+	vusb33-supply = <&mt6323_vusb_reg>;
+	status = "okay";
+};
-- 
2.7.4
