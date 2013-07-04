From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 04 Jul 2013 23:16:46 +0200
Subject: [PATCHv1] arm: armada: Add .dts file for Netgear ReadyNAS 102
Message-ID: <878v1mgh4x.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


All hardware parts of the (Armada 370 based) NETGEAR ReadyNAS 102 are
supported by mainline kernel (USB 3.0 rear ports, USB 2.0 front port,
Gigabit controller and PHY, serial port, leds, buttons, SATA ports,
G762 fan controller) except for:

 - the Intersil ISL12057 I2C RTC Chip,
 - the Armada NAND controller.

Support for both of those is currently work in progress and does not
prevent boot.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
Hi Jason and Andrew,

As requested

 - this version is tested against current head of linus tree (+ I2C
   fixes for a race condition; for details, see message #94 of
   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=622325).
 - nand layout entry and ISL12057 entry have been removed until support
   is available in mainline kernel for eahc of those
 - clock, gpio led and keys have been made siblings of soc, memory and
   chosen (reported by Sebastian).

Is it still acceptable for current merge window or am I too late?

Cheers,

a+

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 176 +++++++++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-netgear-rn102.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..d869d83 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-370-mirabox.dtb \
+	armada-370-netgear-rn102.dtb \
 	armada-370-rd.dtb \
 	armada-xp-db.dtb \
 	armada-xp-gp.dtb \
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
new file mode 100644
index 0000000..9d813d2
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -0,0 +1,176 @@
+/*
+ * Device Tree file for NETGEAR ReadyNAS 102
+ *
+ * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+/include/ "armada-370.dtsi"
+
+/ {
+	model = "NETGEAR ReadyNAS 102";
+	compatible = "netgear,readynas-102", "marvell,armada370", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		internal-regs {
+			serial at 12000 {
+				clock-frequency = <200000000>;
+				status = "okay";
+			};
+
+			sata at a0000 {
+				nr-ports = <2>;
+				status = "okay";
+			};
+
+			pinctrl {
+				power_led_pin: power-led-pin {
+					marvell,pins = "mpp57";
+					marvell,function = "gpio";
+				};
+				sata1_led_pin: sata1-led-pin {
+					marvell,pins = "mpp15";
+					marvell,function = "gpio";
+				};
+
+				sata2_led_pin: sata2-led-pin {
+					marvell,pins = "mpp14";
+					marvell,function = "gpio";
+				};
+
+				backup_led_pin: backup-led-pin {
+					marvell,pins = "mpp56";
+					marvell,function = "gpio";
+				};
+			};
+
+			mdio {
+				phy0: ethernet-phy at 0 {
+					reg = <0>;
+				};
+			};
+
+			ethernet at 74000 {
+				status = "okay";
+				phy = <&phy0>;
+				phy-mode = "rgmii-id";
+			};
+
+			usb at 50000 {
+				status = "okay";
+			};
+
+			i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				clock-frequency = <100000>;
+				status = "okay";
+
+				g762: g762 at 3e {
+					compatible = "gmt,g762";
+					reg = <0x3e>;
+					clocks = <&g762_clk>; /* input clock */
+					fan_gear_mode = <0>;
+					fan_startv = <1>;
+					pwm_polarity = <0>;
+				};
+			};
+
+			pcie-controller {
+				status = "okay";
+
+				/* Connected to Marvell SATA controller */
+				pcie at 1,0 {
+					/* Port 0, Lane 0 */
+					status = "okay";
+				};
+
+				/* Connected to FL1009 USB 3.0 controller */
+				pcie at 2,0 {
+					/* Port 1, Lane 0 */
+					status = "okay";
+				};
+			};
+		};
+	};
+
+	clocks {
+	       #address-cells = <1>;
+	       #size-cells = <0>;
+
+	       g762_clk: fixedclk {
+			 compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			 clock-frequency = <8192>;
+	       };
+	};
+
+	gpio_leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = < &power_led_pin
+			      &sata1_led_pin
+			      &sata2_led_pin
+			      &backup_led_pin >;
+		pinctrl-names = "default";
+
+		blue_power_led {
+			label = "rn102:blue:pwr";
+			gpios = <&gpio1 25 1>;  /* GPIO 57 Active Low */
+			linux,default-trigger = "heartbeat";
+		};
+
+		green_sata1_led {
+			label = "rn102:green:sata1";
+			gpios = <&gpio0 15 1>;  /* GPIO 15 Active Low */
+			default-state = "on";
+		};
+
+		green_sata2_led {
+			label = "rn102:green:sata2";
+			gpios = <&gpio0 14 1>;   /* GPIO 14 Active Low */
+			default-state = "on";
+		};
+
+		green_backup_led {
+			label = "rn102:green:backup";
+			gpios = <&gpio1 24 1>;   /* GPIO 56 Active Low */
+			default-state = "on";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "Power Button";
+			linux,code = <116>;     /* KEY_POWER */
+			gpios = <&gpio1 30 1>;
+		};
+		button at 2 {
+			label = "Reset Button";
+			linux,code = <0x198>;   /* KEY_RESTART */
+			gpios = <&gpio0 6 1>;
+		};
+		button at 3 {
+			label = "Backup Button";
+			linux,code = <133>;     /* KEY_COPY */
+			gpios = <&gpio1 26 1>;
+		};
+	};
+
+};
-- 
1.8.3.1
