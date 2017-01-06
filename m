From: david@lechnology.com (David Lechner)
Date: Thu,  5 Jan 2017 22:33:48 -0600
Subject: [PATCH v2 5/5] ARM: dts: Add LEGO MINDSTORMS EV3 dts
In-Reply-To: <1483677228-2325-1-git-send-email-david@lechnology.com>
References: <1483677228-2325-1-git-send-email-david@lechnology.com>
Message-ID: <1483677228-2325-6-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a device tree definition file for LEGO MINDSTORMS EV3.

What is working:

* Pin muxing
* Pinconf
* GPIOs
* MicroSD card reader
* UART on input ports 1 and 2
* Buttons
* LEDs
* Poweroff/reset
* Flash memory
* EEPROM
* Speaker
* USB host port
* USB perepheral port
* A/DC chip

What is not working/to be added later:

* Display - waiting for "simple DRM" to be mainlined
* Bluetooth - needs new driver for sequencing power/enable/clock - usable
  now by manipulating gpios/pwm in userspace
* Input and output ports - need some sort of new phy or extcon driver
* Battery indication - needs new power supply driver

Note on flash partitions:

These partitions are based on the official EV3 firmware from LEGO. It is
expected that most users of the mainline kernel on EV3 will be booting from
an SD card while retaining the official firmware in the flash memory.
Furthermore, the official firmware uses an ancient U-Boot (2009) that has
no device tree support. So, it makes sense to have this partition table in
the EV3 device tree file. In the unlikely case that anyone does create their
own firmware image with different partitioning, they can use a modern
U-Boot in that firmware image that modifies the device tree with the custom
partitions.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/Makefile           |   3 +-
 arch/arm/boot/dts/da850-lego-ev3.dts | 381 +++++++++++++++++++++++++++++++++++
 2 files changed, 383 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/da850-lego-ev3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9a7375c..471b802 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -128,7 +128,8 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
 dtb-$(CONFIG_ARCH_DAVINCI) += \
 	da850-lcdk.dtb \
 	da850-enbw-cmc.dtb \
-	da850-evm.dtb
+	da850-evm.dtb \
+	da850-lego-ev3.dtb
 dtb-$(CONFIG_ARCH_DIGICOLOR) += \
 	cx92755_equinox.dtb
 dtb-$(CONFIG_ARCH_EFM32) += \
diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
new file mode 100644
index 0000000..d720c58
--- /dev/null
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -0,0 +1,381 @@
+/*
+ * Device tree for LEGO MINDSTORMS EV3
+ *
+ * Copyright (C) 2017 David Lechner <david@lechnology.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation, version 2.
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/pwm/pwm.h>
+
+#include "da850.dtsi"
+
+/ {
+	compatible = "lego,ev3", "ti,da850";
+	model = "LEGO MINDSTORMS EV3";
+
+	/*
+	 * The buttons on the EV3 are mapped to keyboard keys.
+	 */
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		label = "Brick buttons";
+		pinctrl-names = "default";
+		pinctrl-0 = <&button_pins>, <&button_bias>;
+
+		enter {
+			label = "Brick button ENTER";
+			linux,code = <KEY_ENTER>;
+			gpios = <&gpio 29 GPIO_ACTIVE_HIGH>;
+		};
+		left {
+			label = "Brick button LEFT";
+			linux,code = <KEY_LEFT>;
+			gpios = <&gpio 102 GPIO_ACTIVE_HIGH>;
+		};
+		back {
+			label = "Brick button BACK";
+			linux,code = <KEY_BACKSPACE>;
+			gpios = <&gpio 106 GPIO_ACTIVE_HIGH>;
+		};
+		right {
+			label = "Brick button RIGHT";
+			linux,code = <KEY_RIGHT>;
+			gpios = <&gpio 124 GPIO_ACTIVE_HIGH>;
+		};
+		down {
+			label = "Brick button DOWN";
+			linux,code = <KEY_DOWN>;
+			gpios = <&gpio 126 GPIO_ACTIVE_HIGH>;
+		};
+		up {
+			label = "Brick button UP";
+			linux,code = <KEY_UP>;
+			gpios = <&gpio 127 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/*
+	 * The EV3 has two built-in bi-color LEDs behind the buttons.
+	 */
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		left_green {
+			label = "led0:green:brick-status";
+			/* GP6[13] */
+			gpios = <&gpio 103 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+		right_red {
+			label = "led1:red:brick-status";
+			/* GP6[7] */
+			gpios = <&gpio 108 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+		left_red {
+			label = "led0:red:brick-status";
+			/* GP6[12] */
+			gpios = <&gpio 109 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+		right_green {
+			label = "led1:green:brick-status";
+			/* GP6[14] */
+			gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+	};
+
+	beeper {
+		compatible = "pwm-beeper";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ehrpwm0b_pins>, <&amp_pins>;
+		pwms = <&ehrpwm0 1 0 0>;
+		enable-gpios = <&gpio 111 GPIO_ACTIVE_HIGH>;
+	};
+
+	/*
+	 * The EV3 is powered down by turning off the main 5V supply.
+	 */
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio 107 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&system_power_pin>;
+	};
+
+	/*
+	 * The Bluetooth chip requires a clock at 32768Hz. One of the PWMs
+	 * is used to generate this signal.
+	 */
+	bt-slow-clock {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "slow_clk";
+		pwms = <&ecap2 0 30517>;
+	};
+
+	/*
+	 * This is a 5V current limiting regulator that is shared by USB,
+	 * the sensor (input) ports, the motor (output) ports and the A/DC.
+	 */
+	vcc5v: regulator1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v_pins>;
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio 101 0>;
+		over-current-gpios = <&gpio 99 GPIO_ACTIVE_LOW>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	/*
+	 * This is a simple voltage divider on VCC5V to provide a 2.5V
+	 * reference signal to the ADC.
+	 */
+	adc_ref: regulator2 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-supply";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-boot-on;
+		vin-supply = <&vcc5v>;
+	};
+};
+
+&pmx_core {
+	status = "okay";
+
+	spi0_cs3_pin: pinmux_spi0_cs3_pin {
+		pinctrl-single,bits = <
+			/* CS3 */
+			0xc 0x01000000 0x0f000000
+		>;
+	};
+	mmc0_cd_pin: pinmux_mmc0_cd {
+		pinctrl-single,bits = <
+			/* GP5[14] */
+			0x2C 0x00000080 0x000000f0
+		>;
+	};
+	button_pins: pinmux_button_pins {
+		pinctrl-single,bits = <
+			/* GP1[13] */
+			0x8 0x00000800 0x00000f00
+			/* GP6[10] */
+			0x34 0x00800000 0x00f00000
+			/* GP6[6] */
+			0x38 0x00000080 0x000000f0
+			/* GP7[12], GP7[14], GP7[15] */
+			0x40 0x00808800 0x00f0ff00
+		>;
+	};
+	led_pins: pinmux_led_pins {
+		pinctrl-single,bits = <
+			/* GP6[12], GP6[13], GP6[14] */
+			0x34 0x00008880 0x0000fff0
+			/* GP6[7] */
+			0x38 0x00000008 0x0000000f
+		>;
+	};
+	amp_pins: pinmux_amp_pins {
+		pinctrl-single,bits = <
+			/* GP6[15] */
+			0x34 0x00000008 0x0000000f
+		>;
+	};
+	system_power_pin: pinmux_system_power {
+		pinctrl-single,bits = <
+			/* GP6[11] */
+			0x34 0x00080000 0x000f0000
+		>;
+	};
+	vcc5v_pins: pinmux_vcc5v {
+		pinctrl-single,bits = <
+			/* GP6[5] */
+			0x40 0x00000080 0x000000f0
+			/* GP6[3] */
+			0x4c 0x00008000 0x0000f000
+		>;
+	};
+};
+
+&pinconf {
+	status = "okay";
+
+	/* Buttons have external pulldown resistors */
+	button_bias: button-bias-groups {
+		disable {
+			groups = "cp5", "cp24", "cp25", "cp28";
+			bias-disable;
+		};
+	};
+};
+
+/* Input port 2 */
+&serial0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&serial0_rxtx_pins>;
+};
+
+/* Input port 1 */
+&serial1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&serial1_rxtx_pins>;
+};
+
+/* Bluetooth */
+&serial2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&serial2_rxtx_pins>, <&serial2_rtscts_pins>;
+};
+
+&rtc0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	/*
+	 * EEPROM contains the first stage bootloader, HW ID and Bluetooth MAC.
+	 */
+	eeprom at 50 {
+		compatible = "at24,24c128";
+		pagesize = <64>;
+		read-only;
+		reg = <0x50>;
+	};
+};
+
+&wdt {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+	max-frequency = <50000000>;
+	bus-width = <4>;
+	cd-gpios = <&gpio 94 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin>;
+};
+
+&ehrpwm0 {
+	status = "okay";
+};
+
+&ehrpwm1 {
+	status = "okay";
+	pinctrl-names = "default";
+	/* MBPWM, MAPWM */
+	pinctrl-0 = <&ehrpwm1a_pins>, <&ehrpwm1b_pins>;
+};
+
+&ecap0 {
+	status = "okay";
+	pinctrl-names = "default";
+	/* MCPWM */
+	pinctrl-0 = <&ecap0_pins>;
+};
+
+&ecap1 {
+	status = "okay";
+	pinctrl-names = "default";
+	/* MDPWM */
+	pinctrl-0 = <&ecap1_pins>;
+};
+
+&ecap2 {
+	status = "okay";
+	pinctrl-names = "default";
+	/* BTSLOWCLK */
+	pinctrl-0 = <&ecap2_pins>;
+};
+
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>, <&spi0_cs3_pin>;
+
+	flash at 0 {
+		compatible = "n25q128a13", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		ti,spi-wdelay = <8>;
+
+		/* Partitions are based on the official firmware from LEGO */
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0 0x40000>;
+			};
+
+			partition at 40000 {
+				label = "U-Boot Env";
+				reg = <0x40000 0x10000>;
+			};
+
+			partition at 50000 {
+				label = "Kernel";
+				reg = <0x50000 0x200000>;
+			};
+
+			partition at 250000 {
+				label = "Filesystem";
+				reg = <0x250000 0xa50000>;
+			};
+
+			partition at cb0000 {
+				label = "Storage";
+				reg = <0xcb0000 0x2f0000>;
+			};
+		};
+	};
+
+	adc at 3 {
+		compatible = "ti-ads7957";
+		reg = <3>;
+		spi-max-frequency = <10000000>;
+		refin-supply = <&adc_ref>;
+	};
+};
+
+&gpio {
+	status = "okay";
+};
+
+&usb_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+	vbus-supply = <&vcc5v>;
+};
-- 
2.7.4
