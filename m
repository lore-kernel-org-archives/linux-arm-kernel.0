From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 18 Nov 2014 00:28:20 +0100
Subject: [PATCHv3 11/12] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <cover.1416266432.git.arno@natisbad.org>
References: <cover.1416266432.git.arno@natisbad.org>
Message-ID: <9aa66f22b192c4d2f646ba04ff186cb09205a51f.1416266432.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Synology DS213j is a 2-bay NAS powered by a Marvell Armada 370
(88F6710 @1.2Ghz). It is very similar on many aspects to previous
2-bay synology models based on Marvell kirkwood SoC. Here is a
short summary of the device:

 - 512MB RAM
 - boot on SPI flash (64Mbit Micron N25Q064)
 - 1 GbE interface (Armada MAC connected to a Marvell 88E1512
   PHY via SGMII)
 - 2 rear USB 2.0 ports (directly handled by the Armada 370)
 - 2 internal SATA ports handled by the Armada 370: 2 GPIO for
   presence, 2 for powering them
 - two front amber LED (disk1, disk2) controlled by the SoC
 - Seiko S-35390A I2C RTC chip
 - UART0 providing serial console
 - UART1 used for poweroff (connected to a TI MSP430F2111)
 - Fan handled via 4 GPIO (3 for speed, 1 for alarm)

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/Makefile                       |   3 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 321 +++++++++++++++++++++++
 2 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/armada-370-synology-ds213j.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c89cafa1ab..95387b59ebb2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -495,7 +495,8 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 	armada-370-mirabox.dtb \
 	armada-370-netgear-rn102.dtb \
 	armada-370-netgear-rn104.dtb \
-	armada-370-rd.dtb
+	armada-370-rd.dtb \
+	armada-370-synology-ds213j.dtb
 dtb-$(CONFIG_MACH_ARMADA_375) += \
 	armada-375-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_38X) += \
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
new file mode 100644
index 000000000000..6e37c1f8b798
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -0,0 +1,321 @@
+/*
+ * Device Tree file for Synology DS213j
+ *
+ * Copyright (C) 2014, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the old 0xd0000000).
+ * The 0xf1000000 is the default used by the recent, DT-capable, U-Boot
+ * bootloaders provided by Marvell. It is used in recent versions of
+ * DSM software provided by Synology. Nonetheless, some earlier boards
+ * were delivered with an older version of u-boot that left internal
+ * registers mapped at 0xd0000000. If you have such a device you will
+ * not be able to directly boot a kernel based on this Device Tree. In
+ * that case, the preferred solution is to update your bootloader (e.g.
+ * by upgrading to latest version of DSM, or building a new one and
+ * installing it from u-boot prompt) or adjust the Devive Tree
+ * (s/0xf1000000/0xd0000000/ in 'ranges' below).
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-370.dtsi"
+
+/ {
+	model = "Synology DS213j";
+	compatible = "synology,ds213j", "marvell,armada370",
+		     "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+
+		internal-regs {
+
+			sata at a0000 {
+				nr-ports = <2>;
+				status = "okay";
+			};
+
+			pinctrl {
+				disk1_led_pin: disk1-led-pin {
+					marvell,pins = "mpp31";
+					marvell,function = "gpio";
+				};
+
+				disk2_led_pin: disk2-led-pin {
+					marvell,pins = "mpp32";
+					marvell,function = "gpio";
+				};
+
+				sata1_pwr_pin: sata1-pwr-pin {
+					marvell,pins = "mpp37";
+					marvell,function = "gpio";
+				};
+
+				sata2_pwr_pin: sata2-pwr-pin {
+					marvell,pins = "mpp62";
+					marvell,function = "gpio";
+				};
+
+				sata1_pres_pin: sata1-pres-pin {
+					marvell,pins = "mpp60";
+					marvell,function = "gpio";
+				};
+
+				sata2_pres_pin: sata2-pres-pin {
+					marvell,pins = "mpp48";
+					marvell,function = "gpio";
+				};
+
+				syno_id_bit0_pin: syno-id-bit0-pin {
+					marvell,pins = "mpp55";
+					marvell,function = "gpio";
+				};
+
+				syno_id_bit1_pin: syno-id-bit1-pin {
+					marvell,pins = "mpp56";
+					marvell,function = "gpio";
+				};
+
+				syno_id_bit2_pin: syno-id-bit2-pin {
+					marvell,pins = "mpp57";
+					marvell,function = "gpio";
+				};
+
+				syno_id_bit3_pin: syno-id-bit3-pin {
+					marvell,pins = "mpp58";
+					marvell,function = "gpio";
+				};
+
+				fan_ctrl_low_pin: fan-ctrl-low-pin {
+					marvell,pins = "mpp65";
+					marvell,function = "gpio";
+				};
+
+				fan_ctrl_mid_pin: fan-ctrl-mid-pin {
+					marvell,pins = "mpp64";
+					marvell,function = "gpio";
+				};
+
+				fan_ctrl_high_pin: fan-ctrl-high-pin {
+					marvell,pins = "mpp63";
+					marvell,function = "gpo";
+				};
+
+				fan_alarm_pin: fan-alarm-pin {
+					marvell,pins = "mpp38";
+					marvell,function = "gpio";
+				};
+
+				poweroff_pin: poweroff-pin {
+					marvell,pins = "mpp4";
+					marvell,function = "gpio";
+				};
+			};
+
+			mdio {
+				phy1: ethernet-phy at 1 { /* Marvell 88E1512 */
+					reg = <1>;
+				};
+			};
+
+			ethernet at 70000 {
+			       status = "okay";
+			       phy = <&phy1>;
+			       phy-mode = "sgmii";
+			};
+
+			spi0: spi at 10600 {
+				status = "okay";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "micron,n25q064";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <20000000>;
+
+					/*
+					 * Warning!
+					 *
+					 * Synology u-boot uses its compiled-in environment
+					 * and it seems Synology did not care to change u-boot
+					 * default configuration in order to allow saving a
+					 * modified environment at a sensible location. So,
+					 * if you do a 'saveenv' under u-boot, your modified
+					 * environment will be saved at 1MB after the start
+					 * of the flash, i.e. in the middle of the uImage.
+					 * For that reason, it is strongly advised not to
+					 * change the default environment, unless you know
+					 * what you are doing.
+					 */
+					partition at 00000000 { /* u-boot */
+						label = "RedBoot";
+						reg = <0x00000000 0x000c0000>; /* 768KB */
+					};
+
+					partition at 000c0000 { /* uImage */
+						label = "zImage";
+						reg = <0x000c0000 0x002d0000>; /* 2880KB */
+					};
+
+					partition at 00390000 { /* uInitramfs */
+						label = "rd.gz";
+						reg = <0x00390000 0x00440000>; /* 4250KB */
+					};
+
+					partition at 007d0000 { /* MAC address and serial number */
+						label = "vendor";
+						reg = <0x007d0000 0x00010000>; /* 64KB */
+					};
+
+					partition at 007e0000 {
+						label = "RedBoot config";
+						reg = <0x007e0000 0x00010000>; /* 64KB */
+					};
+
+					partition at 007f0000 {
+						label = "FIS directory";
+						reg = <0x007f0000 0x00010000>; /* 64KB */
+					};
+				};
+			};
+
+			/* rear USB port, near reset button */
+			usb at 50000 {
+				status = "okay";
+			};
+
+			/* rear USB port, near RJ45 port */
+			usb at 51000 {
+				status = "okay";
+			};
+
+			i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				pinctrl-0 = <&i2c0_pins>;
+				pinctrl-names = "default";
+				clock-frequency = <400000>;
+				status = "okay";
+
+				/* Main device RTC chip */
+				s35390a: s35390a at 30 {
+					 compatible = "sii,s35390a";
+					 reg = <0x30>;
+				};
+			};
+
+			/* RTC provided by Seiko S-35390A above */
+			rtc at 10300 {
+				status = "disabled";
+			};
+
+			/* Connected to a header on device's PCB */
+			serial at 12000 {
+				status = "okay";
+			};
+
+			/* Connected to a TI MSP430F2111 for power control */
+			serial at 12100 {
+				status = "okay";
+			};
+
+			poweroff at 12100 {
+				compatible = "synology,power-off";
+				reg = <0x12100 0x100>;
+				clocks = <&coreclk 0>;
+			};
+		};
+	};
+
+	gpio-fan-32-38 {
+		status = "okay";
+		compatible = "gpio-fan";
+		pinctrl-0 = <&fan_ctrl_low_pin &fan_ctrl_mid_pin
+			     &fan_ctrl_high_pin &fan_alarm_pin>;
+		pinctrl-names = "default";
+		gpios = <&gpio1 31 GPIO_ACTIVE_HIGH
+			 &gpio2  0 GPIO_ACTIVE_HIGH
+			 &gpio2  1 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <    0 0
+				       1000 1
+				       1150 2
+				       1350 4
+				       1500 3
+				       1650 5
+				       1750 6
+				       1900 7 >;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&disk1_led_pin
+			     &disk2_led_pin>;
+		pinctrl-names = "default";
+
+		disk1-led-amber {
+			label = "synology:amber:disk1";
+			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+		};
+
+		disk2-led-amber {
+			label = "synology:amber:disk2";
+			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&sata1_pwr_pin &sata2_pwr_pin>;
+		pinctrl-names = "default";
+
+		sata1_regulator: sata1-regulator {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA1 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			startup-delay-us = <2000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		sata2_regulator: sata2-regulator {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "SATA2 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			startup-delay-us = <4000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
-- 
2.1.1
