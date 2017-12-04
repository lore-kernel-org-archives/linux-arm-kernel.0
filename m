From: peda@axentia.se (Peter Rosin)
Date: Mon,  4 Dec 2017 14:57:08 +0100
Subject: [PATCH v2] ARM: dts: at91: add devicetree for the Axentia Nattis with
 Natte power
Message-ID: <20171204135708.8234-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Axentia Nattis is a device designed for presenting departures for
public transport systems. The Natte helper board provides power and
features a battery of battery chargers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---

This was part of a two-patch series, but the first patch in that
series was redundant, so I dropped it (there was a dt binding
recently added for the tfa9879 amplifier that I had not noticed).

Changes since v1:    https://lkml.org/lkml/2017/12/1/844
- removed chip-ids from before the @-sign instead naming the nodes
  for the function, e.g sx1502q at 20 -> ioexp at 20
- added #sound-dai-cells to the amplifier node
- switch to SPDX license tags

Cheers,
Peter

Documentation/devicetree/bindings/arm/axentia.txt |   9 +
 MAINTAINERS                                       |   2 +
 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/at91-natte.dtsi                 | 244 ++++++++++++++++++++
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts       | 258 ++++++++++++++++++++++
 5 files changed, 514 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-natte.dtsi
 create mode 100644 arch/arm/boot/dts/at91-nattis-2-natte-2.dts

diff --git a/Documentation/devicetree/bindings/arm/axentia.txt b/Documentation/devicetree/bindings/arm/axentia.txt
index ea3fb96ae465..de58f2463880 100644
--- a/Documentation/devicetree/bindings/arm/axentia.txt
+++ b/Documentation/devicetree/bindings/arm/axentia.txt
@@ -10,6 +10,15 @@ compatible = "axentia,linea",
 and following the rules from atmel-at91.txt for a sama5d31 SoC.
 
 
+Nattis v2 board with Natte v2 power board
+-----------------------------------------
+
+Required root node properties:
+compatible = "axentia,nattis-2", "axentia,natte-2", "axentia,linea",
+	     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
+and following the rules from above for the axentia,linea CPU module.
+
+
 TSE-850 v3 board
 ----------------
 
diff --git a/MAINTAINERS b/MAINTAINERS
index d4fdcb12616c..ec8a33f7cb01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2500,6 +2500,8 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/axentia.txt
 F:	arch/arm/boot/dts/at91-linea.dtsi
+F:	arch/arm/boot/dts/at91-natte.dtsi
+F:	arch/arm/boot/dts/at91-nattis-2-natte-2.dts
 F:	arch/arm/boot/dts/at91-tse850-3.dts
 
 AXENTIA ASOC DRIVERS
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..d62ee6f0271d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -47,6 +47,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91sam9x35ek.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2.dtb \
+	at91-nattis-2-natte-2.dtb \
 	at91-sama5d27_som1_ek.dtb \
 	at91-sama5d2_xplained.dtb \
 	at91-sama5d3_xplained.dtb \
diff --git a/arch/arm/boot/dts/at91-natte.dtsi b/arch/arm/boot/dts/at91-natte.dtsi
new file mode 100644
index 000000000000..49f0a0c46cde
--- /dev/null
+++ b/arch/arm/boot/dts/at91-natte.dtsi
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * at91-natte.dts - Device Tree include file for the Natte board
+ *
+ * Copyright (C) 2017 Axentia Technologies AB
+ *
+ * Author: Peter Rosin <peda@axentia.se>
+ */
+
+/ {
+	mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&ioexp 0 GPIO_ACTIVE_HIGH>,
+			    <&ioexp 1 GPIO_ACTIVE_HIGH>,
+			    <&ioexp 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	batntc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 5>;
+		io-channel-names = "parent";
+		mux-controls = <&mux>;
+
+		channels =
+			"batntc0", "batntc1", "batntc2", "batntc3",
+			"batntc4", "batntc5", "batntc6", "batntc7";
+	};
+
+	batv-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 6>;
+		io-channel-names = "parent";
+		mux-controls = <&mux>;
+
+		channels =
+			"batv0", "batv1", "batv2", "batv3",
+			"batv4", "batv5", "batv6", "batv7";
+	};
+
+	iout-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 7>;
+		io-channel-names = "parent";
+		mux-controls = <&mux>;
+
+		channels =
+			"iout0", "iout1", "iout2", "iout3",
+			"iout4", "iout5", "iout6", "iout7";
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux";
+		mux-locked;
+		i2c-parent = <&i2c0>;
+		mux-controls = <&mux>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger at 9 {
+				compatible = "ti,bq24735";
+				reg = <0x9>;
+
+				ti,charge-current = <2000>;
+				ti,charge-voltage = <16800>;
+
+				poll-interval = <20000>;
+			};
+		};
+
+		i2c at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger at 9 {
+				compatible = "ti,bq24735";
+				reg = <0x9>;
+
+				ti,charge-current = <2000>;
+				ti,charge-voltage = <16800>;
+
+				poll-interval = <20000>;
+			};
+		};
+
+		i2c at 2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger at 9 {
+				compatible = "ti,bq24735";
+				reg = <0x9>;
+
+				ti,charge-current = <2000>;
+				ti,charge-voltage = <16800>;
+
+				poll-interval = <20000>;
+			};
+		};
+
+		i2c at 3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger at 9 {
+				compatible = "ti,bq24735";
+				reg = <0x9>;
+
+				ti,charge-current = <2000>;
+				ti,charge-voltage = <16800>;
+
+				poll-interval = <20000>;
+			};
+		};
+
+		i2c at 4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger at 9 {
+				compatible = "ti,bq24735";
+				reg = <0x9>;
+
+				ti,charge-current = <2000>;
+				ti,charge-voltage = <16800>;
+
+				poll-interval = <20000>;
+			};
+		};
+
+		i2c at 5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger at 9 {
+				compatible = "ti,bq24735";
+				reg = <0x9>;
+
+				ti,charge-current = <2000>;
+				ti,charge-voltage = <16800>;
+
+				poll-interval = <20000>;
+			};
+		};
+
+		i2c at 6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger at 9 {
+				compatible = "ti,bq24735";
+				reg = <0x9>;
+
+				ti,charge-current = <2000>;
+				ti,charge-voltage = <16800>;
+
+				poll-interval = <20000>;
+			};
+		};
+
+		i2c at 7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger at 9 {
+				compatible = "ti,bq24735";
+				reg = <0x9>;
+
+				ti,charge-current = <2000>;
+				ti,charge-voltage = <16800>;
+
+				poll-interval = <20000>;
+			};
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	ioexp: ioexp at 20 {
+		#gpio-cells = <2>;
+		compatible = "semtech,sx1502q";
+		reg = <0x20>;
+
+		gpio-controller;
+		ngpios = <8>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio3_cfg_pins>;
+
+		gpio3_cfg_pins: gpio3_cfg {
+			pins = "gpio3";
+			bias-pull-up;
+		};
+	};
+
+	adc: adc at 48 {
+		compatible = "ti,ads1015";
+		reg = <0x48>;
+		#io-channel-cells = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel at 4 {
+			reg = <4>;
+			ti,gain = <2>;
+			ti,datarate = <4>;
+		};
+
+		channel at 5 {
+			reg = <5>;
+			ti,gain = <2>;
+			ti,datarate = <4>;
+		};
+
+		channel at 6 {
+			reg = <6>;
+			ti,gain = <1>;
+			ti,datarate = <4>;
+		};
+
+		channel at 7 {
+			reg = <7>;
+			ti,gain = <3>;
+			ti,datarate = <4>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
new file mode 100644
index 000000000000..3ea1d26e1c68
--- /dev/null
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * at91-nattis-2-natte-2.dts - Device Tree file for the Linea/Nattis board
+ *
+ * Copyright (C) 2017 Axentia Technologies AB
+ *
+ * Author: Peter Rosin <peda@axentia.se>
+ */
+/dts-v1/;
+#include "at91-linea.dtsi"
+#include "sama5d3_lcd.dtsi"
+#include "at91-natte.dtsi"
+
+/ {
+	model = "Axentia Linea-Nattis v2 Natte v2";
+	compatible = "axentia,nattis-2", "axentia,natte-2", "axentia,linea",
+		     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
+
+	ahb {
+		apb {
+			pinctrl at fffff200 {
+				nattis {
+					pinctrl_usba_vbus: usba_vbus {
+						atmel,pins =
+							<AT91_PIOD 28
+							 AT91_PERIPH_GPIO
+							 AT91_PINCTRL_DEGLITCH>;
+					};
+
+					pinctrl_mmc0_cd: mmc0_cd {
+						atmel,pins =
+							<AT91_PIOD 5
+							 AT91_PERIPH_GPIO
+							 AT91_PINCTRL_PULL_UP_DEGLITCH>;
+					};
+
+					pinctrl_lcd_prlud0: lcd_prlud0 {
+						atmel,pins =
+							<AT91_PIOA 21
+							 AT91_PERIPH_GPIO
+							 AT91_PINCTRL_OUTPUT_VAL(0)>;
+					};
+
+					pinctrl_lcd_hipow0: lcd_hipow0 {
+						atmel,pins =
+							<AT91_PIOA 23
+							 AT91_PERIPH_GPIO
+							 AT91_PINCTRL_OUTPUT_VAL(0)>;
+					};
+				};
+			};
+
+			watchdog at fffffe40 {
+				status = "okay";
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		wakeup {
+			label = "Wakeup";
+			linux,code = <10>;
+			gpio-key,wakeup;
+			gpios = <&pioB 27 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	panel_reg: panel-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "panel-VCC";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	bl_reg: backlight-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "panel-VDD";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	panel_bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&hlcdc_pwm 0 100000 0>;
+
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <40>;
+
+		power-supply = <&bl_reg>;
+		enable-gpios = <&pioA 20 GPIO_ACTIVE_HIGH>;
+	};
+
+	panel: panel {
+		compatible = "sharp,lq150x1lg11";
+		backlight = <&panel_bl>;
+		power-supply = <&panel_reg>;
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&hlcdc_panel_output>;
+			};
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,name = "nattis-tfa9879";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&cpu_dai>;
+		simple-audio-card,frame-master = <&cpu_dai>;
+		simple-audio-card,widgets = "Line", "Line Out Jack";
+		simple-audio-card,routing = "Line Out Jack", "LINEOUT";
+
+		cpu_dai: simple-audio-card,cpu {
+			sound-dai = <&ssc0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&amp>;
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	clock-frequency = <100000>;
+
+	temp at 18 {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x18>;
+		smbus-timeout-disable;
+	};
+
+	eeprom at 50 {
+		compatible = "nxp,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+
+	amp: amplifier at 6c {
+		 compatible = "nxp,tfa9879";
+		 reg = <0x6c>;
+		 #sound-dai-cells = <0>;
+	};
+};
+
+&ssc0 {
+	status = "okay";
+
+	atmel,clk-from-rk-pin;
+	#sound-dai-cells = <0>;
+};
+
+&hlcdc {
+	status = "okay";
+
+	hlcdc-display-controller {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd_base
+			     &pinctrl_lcd_rgb565
+			     &pinctrl_lcd_prlud0
+			     &pinctrl_lcd_hipow0>;
+
+		port at 0 {
+			hlcdc_panel_output: endpoint {
+				remote-endpoint = <&panel_input>;
+			};
+		};
+	};
+};
+
+&mmc0 {
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0
+		     &pinctrl_mmc0_dat1_3
+		     &pinctrl_mmc0_cd>;
+
+	slot at 0 {
+		reg = <0>;
+		bus-width = <4>;
+		cd-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&usart0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart0>;
+	atmel,use-dma-rx;
+};
+
+&nand {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		at91bootstrap at 0 {
+			label = "at91bootstrap";
+			reg = <0x0 0x40000>;
+		};
+
+		bootloader at 40000 {
+			label = "bootloader";
+			reg = <0x40000 0x80000>;
+		};
+
+		bootloaderenv at c0000 {
+			label = "bootloader env";
+			reg = <0xc0000 0xc0000>;
+		};
+
+		dtb at 180000 {
+			label = "device tree";
+			reg = <0x180000 0x80000>;
+		};
+
+		kernel at 200000 {
+			label = "kernel";
+			reg = <0x200000 0x600000>;
+		};
+
+		rootfs at 800000 {
+			label = "rootfs";
+			reg = <0x800000 0x0f800000>;
+		};
+	};
+};
+
+&dbgu {
+	status = "okay";
+
+	atmel,use-dma-rx;
+};
+
+&usb0 {
+	status = "okay";
+
+	atmel,vbus-gpio = <&pioD 28 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+};
-- 
2.11.0
