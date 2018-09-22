From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 22 Sep 2018 17:10:03 +0200
Subject: [PATCH v2 5/5] ARM: dts: meson8b: Add support for the Endless Mini
 (EC-100)
In-Reply-To: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
References: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180922151003.4736-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Endless Mini (EC-100) is a grapefruit-sized computer based on the
Amlogic Meson8b (S805) SoC which comes in two variants.

Both variants have in common:
- Amlogic Meson8b (S805) SoC
- two USB 2.0 ports on the rear, one one the front (connected to the SoC
  through an internal hub)
- 3.5mm Stereo out and MIC combo port
- HDMI and CVBS output
- 5V power supply (rated at 3A / 15W)
- an internal embedded micro-controller (called "EC") which implements a
  "breathing" effect for the LED and allows shutting down (powering off)
  the whole device
- 10/100 Mbit/s Ethernet using an IC Plus IP101A/G PHY (note: the website
  incorrectly lists a Gigabit Ethernet port)
- the CPU voltage is regulated using a PWM regulator. The GPL sources of
  the EC-100 are using a PWM value of 0x1c0000 for 0.86V and a PWM value
  of 0x00001c for 1.14V. When using the XTAL (24MHz) as input this
  translates into a PWM period of 1148ns with 0.86V using a duty cycle of
  100% and 1.14V using a duty cycle of 0%.

The main differences are:
- the main indicator for the variant is the RAM size: the "cheaper"
  variant has 1 GB of RAM, while the more expensive one comes with 2GB
- the storage size differs: 24 GB vs 32 GB
- the "1 GB RAM" variant has Ethernet connectivity only, while the "2 GB"
  variant has a Realtek RTL8723BS SDIO chip which adds 802.11b/g/n wifi
  and Bluetooth 4.0 support

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/meson8b-ec100.dts | 248 ++++++++++++++++++++++++++++
 2 files changed, 249 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson8b-ec100.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..856ebc036cc4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -321,6 +321,7 @@ dtb-$(CONFIG_MACH_MESON6) += \
 	meson6-atv1200.dtb
 dtb-$(CONFIG_MACH_MESON8) += \
 	meson8-minix-neo-x8.dtb \
+	meson8b-ec100.dtb \
 	meson8b-mxq.dtb \
 	meson8b-odroidc1.dtb \
 	meson8m2-mxiii-plus.dtb
diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
new file mode 100644
index 000000000000..0872f6e3abf5
--- /dev/null
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+#include "meson8b.dtsi"
+
+/ {
+	model = "Endless Computers Endless Mini";
+	compatible = "endless,ec100", "amlogic,meson8b";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		pal-switch {
+			label = "pal";
+			linux,input-type = <EV_SW>;
+			linux,code = <KEY_SWITCHVIDEOMODE>;
+			gpios = <&gpio GPIOH_7 GPIO_ACTIVE_LOW>;
+		};
+
+		ntsc-switch {
+			label = "ntsc";
+			linux,input-type = <EV_SW>;
+			linux,code = <KEY_SWITCHVIDEOMODE>;
+			gpios = <&gpio GPIOH_8 GPIO_ACTIVE_HIGH>;
+		};
+
+		power-button {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio GPIOH_9 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		/*
+		 * shutdown is managed by the EC (embedded micro-controller)
+		 * which is configured through GPIOAO_2 (poweroff GPIO) and
+		 * GPIOAO_7 (power LED, which has to go LOW as well).
+		 */
+		gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		timeout-ms = <20000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power {
+			label = "ec100:red:power";
+			/*
+			 * Needs to go LOW (together with the poweroff GPIO)
+			 * during shutdown to allow the EC (embedded
+			 * micro-controller) to shutdown the system. Setting
+			 * the output to LOW signals the EC to start a
+			 * "breathing"/pulsing effect until the power is fully
+			 * turned off.
+			 */
+			gpios = <&gpio_ao GPIOAO_7 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_VBUS";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc_5v: regulator-vcc5v {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC5V";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio GPIODV_29 GPIO_ACTIVE_LOW>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcck: regulator-vcck {
+		compatible = "pwm-regulator";
+
+		regulator-name = "VCCK";
+		regulator-min-microvolt = <860000>;
+		regulator-max-microvolt = <1140000>;
+
+		pwms = <&pwm_cd 0 1148 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_1v8: regulator-vcc1v8 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vcc_3v3: regulator-vcc3v3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vcck>;
+};
+
+&ethmac {
+	status = "okay";
+
+	pinctrl-0 = <&eth_rmii_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&eth_phy0>;
+	phy-mode = "rmii";
+
+	snps,reset-gpio = <&gpio GPIOH_4 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy at 0 {
+			/* IC Plus IP101A/G (0x02430c54) */
+			reg = <0>;
+		};
+	};
+};
+
+&i2c_A {
+	status = "okay";
+	pinctrl-0 = <&i2c_a_pins>;
+	pinctrl-names = "default";
+
+	rt5640: codec at 1c {
+		compatible = "realtek,rt5640";
+		reg = <0x1c>;
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <13 IRQ_TYPE_EDGE_BOTH>; /* GPIOAO_13 */
+		realtek,in1-differential;
+	};
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vcc_1v8>;
+};
+
+&sdio {
+	status = "okay";
+
+	pinctrl-0 = <&sd_b_pins>;
+	pinctrl-names = "default";
+
+	/* SD card */
+	sd_card_slot: slot at 1 {
+		compatible = "mmc-slot";
+		reg = <1>;
+		status = "okay";
+
+		bus-width = <4>;
+		no-sdio;
+		cap-mmc-highspeed;
+		cap-sd-highspeed;
+		disable-wp;
+
+		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
+		cd-inverted;
+
+		vmmc-supply = <&vcc_3v3>;
+	};
+};
+
+&pwm_cd {
+	status = "okay";
+	pinctrl-0 = <&pwm_c1_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_XTAL>;
+	clock-names = "clkin0";
+};
+
+/* exposed through the pin headers labeled "URDUG1" on the top of the PCB */
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+/*
+ * connected to the Bluetooth part of the RTL8723BS SDIO wifi / Bluetooth
+ * combo chip. This is only available on the variant with 2GB RAM.
+ */
+&uart_B {
+	status = "okay";
+	pinctrl-0 = <&uart_b0_pins>, <&uart_b0_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+};
+
+&usb1 {
+	status = "okay";
+	vbus-supply = <&usb_vbus>;
+};
+
+&usb1_phy {
+	status = "okay";
+};
-- 
2.19.0
