From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Thu, 10 Dec 2015 06:33:08 +0100
Subject: [PATCHv2] ARM: dts: kirkwood: Add DTS for Zyxel NSA325
Message-ID: <1449725588-9438-1-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new DTS file to support the Zyxel NSA325(v2) dual bay
NAS device, based on the NSA320 DTS files.

The only difference to the NSA320 device is GPIO47.
This en/disables the power for the hdd in slot2, currently
fixed to on.

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---

v2
- using kirkwood-nsa325.dts as template, this removes the odd 
  indentation and unneeded partitions nodes.

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/kirkwood-nsa325.dts | 236 ++++++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa325.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bb8fa02..0fcae90 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -193,6 +193,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ns2mini.dtb \
 	kirkwood-nsa310.dtb \
 	kirkwood-nsa310a.dtb \
+	kirkwood-nsa325.dtb \
 	kirkwood-openblocks_a6.dtb \
 	kirkwood-openblocks_a7.dtb \
 	kirkwood-openrd-base.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-nsa325.dts b/arch/arm/boot/dts/kirkwood-nsa325.dts
new file mode 100644
index 0000000..6e9ffb5
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsa325.dts
@@ -0,0 +1,236 @@
+/* Device tree file for the Zyxel NSA 325 NAS box.
+ *
+ * Copyright (c) 2015, Hans Ulli Kroll <ulli.kroll@googlemail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Based upon the board setup file created by Peter Schildmann */
+
+/dts-v1/;
+
+#include "kirkwood-nsa3x0-common.dtsi"
+
+/ {
+	model = "ZyXEL NSA325";
+	compatible = "zyxel,nsa325", "marvell,kirkwood-88f6282", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
+	ocp at f1000000 {
+		pinctrl: pin-controller at 10000 {
+			pinctrl-names = "default";
+
+			pmx_led_hdd2_green: pmx-led-hdd2-green {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd2_red: pmx-led-hdd2-red {
+				marvell,pins = "mpp13";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_data: pmx-mcu-data {
+				marvell,pins = "mpp14";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_usb_green: pmx-led-usb-green {
+				marvell,pins = "mpp15";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_clk: pmx-mcu-clk {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_act: pmx-mcu-act {
+				marvell,pins = "mpp17";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_green: pmx-led-sys-green {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_orange: pmx-led-sys-orange {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd1_green: pmx-led-hdd1-green {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd1_red: pmx-led-hdd1-red {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+
+			pmx_htp: pmx-htp {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+
+			/* Buzzer needs to be switched at around 1kHz so is
+			   not compatible with the gpio-beeper driver. */
+			pmx_buzzer: pmx-buzzer {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+
+			pmx_vid_b1: pmx-vid-b1 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+
+			pmx_power_resume_data: pmx-power-resume-data {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+
+			pmx_power_resume_clk: pmx-power-resume-clk {
+				marvell,pins = "mpp49";
+				marvell,function = "gpio";
+			};
+
+			pmx_pwr_sata1: pmx-pwr-sata1 {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+		};
+
+		/* This board uses the pcf8563 RTC instead of the SoC RTC */
+		rtc at 10300 {
+			status = "disabled";
+		};
+
+		i2c at 11000 {
+			status = "okay";
+
+			pcf8563: pcf8563 at 51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_pwr_sata1>;
+		pinctrl-names = "default";
+
+		usb0_power: regulator at 1 {
+			enable-active-high;
+		};
+
+		sata1_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "SATA1 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+			regulator-boot-on;
+			enable-active-high;
+			gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_hdd2_green &pmx_led_hdd2_red
+			     &pmx_led_usb_green
+			     &pmx_led_sys_green &pmx_led_sys_orange
+			     &pmx_led_copy_green &pmx_led_copy_red
+			     &pmx_led_hdd1_green &pmx_led_hdd1_red>;
+		pinctrl-names = "default";
+
+		green-sys {
+			label = "nsa325:green:sys";
+			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
+		};
+		orange-sys {
+			label = "nsa325:orange:sys";
+			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+		};
+		green-hdd1 {
+			label = "nsa325:green:hdd1";
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+		red-hdd1 {
+			label = "nsa325:red:hdd1";
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+		green-hdd2 {
+			label = "nsa325:green:hdd2";
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		};
+		red-hdd2 {
+			label = "nsa325:red:hdd2";
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+		};
+		green-usb {
+			label = "nsa325:green:usb";
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+		};
+		green-copy {
+			label = "nsa325:green:copy";
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+		red-copy {
+			label = "nsa325:red:copy";
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+
+	/* The following pins are currently not assigned to a driver,
+	   some of them should be configured as inputs.
+	pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
+		     &pmx_htp &pmx_vid_b1
+		     &pmx_power_resume_data &pmx_power_resume_clk>; */
+		
+	};
+
+
+};
+
+&mdio {
+	status = "okay";
+	ethphy0: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};
+
-- 
2.6.0
