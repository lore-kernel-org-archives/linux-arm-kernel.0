From: linux@baker-net.org.uk (Adam Baker)
Date: Sun,  6 Apr 2014 22:42:48 +0100
Subject: [PATCH 2/3] ARM: kirkwood: Add DTS file for NSA320
In-Reply-To: <1396820569-3841-1-git-send-email-linux@baker-net.org.uk>
References: <5341C91D.4060007@baker-net.org.uk>
 <1396820569-3841-1-git-send-email-linux@baker-net.org.uk>
Message-ID: <1396820569-3841-2-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Add a new DTS file to support the Zyxel NSA320 dual bay
 NAS Drive. This DTS just describes the features that
 work with the current kernel drivers. New drivers still
 need writing to support the temperature sensor, the
 power on behaviour control and the buzzer.

Signed-off-by: Adam Baker <linux@baker-net.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-nsa320.dts |  214 +++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa320.dts

diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/kirkwood-nsa320.dts
new file mode 100644
index 0000000..6c8f692
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -0,0 +1,214 @@
+/* Device tree file for the Zyxel NSA 320 NAS box.
+ *
+ * Copyright (c) 2014, Adam Baker <linux@baker-net.org.uk>
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
+#include "kirkwood-nsa310-common.dtsi"
+
+/ {
+	model = "Zyxel NSA320";
+	compatible = "zyxel,nsa320", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
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
+		pinctrl: pinctrl at 10000 {
+			pinctrl-names = "default";
+
+			/* SATA Activity and Present pins are not connected */
+			pmx_sata0: pmx-sata0 {
+				marvell,pins ;
+				marvell,function = "sata0";
+			};
+
+			pmx_sata1: pmx-sata1 {
+				marvell,pins ;
+				marvell,function = "sata1";
+			};
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
+		usb0_power: regulator at 1 {
+			enable-active-high;
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
+			label = "nsa320:green:sys";
+			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
+		};
+		orange-sys {
+			label = "nsa320:orange:sys";
+			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+		};
+		green-hdd1 {
+			label = "nsa320:green:hdd1";
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+		red-hdd1 {
+			label = "nsa320:red:hdd1";
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+		green-hdd2 {
+			label = "nsa320:green:hdd2";
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		};
+		red-hdd2 {
+			label = "nsa320:red:hdd2";
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+		};
+		green-usb {
+			label = "nsa320:green:usb";
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+		};
+		green-copy {
+			label = "nsa320:green:copy";
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+		red-copy {
+			label = "nsa320:red:copy";
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* The following pins are currently not assigned to a driver,
+	   some of them should be configured as inputs.
+	pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
+		     &pmx_htp &pmx_vid_b1
+		     &pmx_power_resume_data &pmx_power_resume_clk>; */
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
-- 
1.7.10.4
