From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 25 Oct 2014 22:42:07 +0200
Subject: [PATCHv0] arm: mvebu: add .dts file for Synology DS213j
Message-ID: <3d0cc6de9ea5506d5fb201129ad277e57d0cdfc8.1414268057.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Synology DS213j is a 2-bay NAS powered by a Marvell Armada 370
(88F6710 @1.2Ghz). It is very similar on many aspects to previous
2-bay Synology models based on Marvell kirkwood SoC. Here is a
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
 - UART1 used for poweroff
 - Fan handled via 4 GPIO (3 for speed, 1 for alarm)

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---

This v0 is just to gather initial comments. Some random notes and
questions (Andrew, Ben, Simon):

- Simon: why does fan_alarm_irq_handler in gpio-fan.c returns IRQ_NONE?

- When I bought the NAS, it had an old Marvell bootloader. After install
  of latest DSM version, the u-boot was a new one w/ I had to change the
  'ranges' in the .dts to the ones below to have the kernel boot. I guess
  new DS213j hardware will be shipped with new u-boot version at some
  point and this will be fine; Otherwise, users will either have to
  upgrade their DSM or manually s/1f/d0/ in .dts.

- Andrew,Ben: SPI flash partitions are correct, I can read all those,
  'file' recognize them and the content looks kosher. Nonetheless, I did
  a diff before and after a 'saveenv' under u-boot and u-boot
  environment is saved by u-boot itself in the middle of the kernel
  (0x40000 after the start of mtd1). This make kernel CRC incorrect and
  prevent u-boot to boot the kernel. If you have any idea on this, I am
  interested.

- Andrew, Ben: I did a single file for the .dts but I intend to create
  a .dtsi; I have started a .dts for the DS414 (2-core Armada XP) and
  they share various nodes.

 arch/arm/boot/dts/Makefile                       |   3 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 312 +++++++++++++++++++++++
 2 files changed, 314 insertions(+), 1 deletion(-)
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
index 000000000000..a99ccd0df20d
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -0,0 +1,312 @@
+/*
+ * Device Tree file for Synology DS213j
+ *
+ * Copyright (C) 2014, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
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
+	compatible = "synology,ds213j", "marvell,armada370", "marvell,armada-370-xp";
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
+				pmx_ge0: pmx-ge0 {
+					marvell,pins = "mpp5", "mpp6", "mpp7", "mpp8",
+						       "mpp9", "mpp10", "mpp11", "mpp12",
+						       "mpp13", "mpp14", "mpp15", "mpp16";
+					marvell,function = "ge0";
+				};
+
+				pmx_uart0: pmx-uart0 {
+					marvell,pins = "mpp0", "mpp1";
+					marvell,function = "uart0";
+				};
+
+				pmx_i2c: pmx-i2c {
+					marvell,pins = "mpp2", "mpp3";
+					marvell,function = "i2c0";
+				};
+
+				pmx_spi: pmx-spi {
+					marvell,pins = "mpp33", "mpp34",
+						       "mpp35", "mpp36";
+					marvell,function = "spi0";
+				};
+
+				pmx_disk1_led: pmx-disk1-led {
+					marvell,pins = "mpp31";
+					marvell,function = "gpio";
+				};
+
+				pmx_disk2_led: pmx-disk2-led {
+					marvell,pins = "mpp32";
+					marvell,function = "gpio";
+				};
+
+				pmx_sata1_pwr: pmx-sata1-pwr {
+					marvell,pins = "mpp37";
+					marvell,function = "gpio";
+				};
+
+				pmx_sata2_pwr: pmx-sata2-pwr {
+					marvell,pins = "mpp62";
+					marvell,function = "gpio";
+				};
+
+				pmx_sata1_pres: pmx-sata1-pres {
+					marvell,pins = "mpp60";
+					marvell,function = "gpio";
+				};
+
+				pmx_sata2_pres: pmx-sata2-pres {
+					marvell,pins = "mpp48";
+					marvell,function = "gpio";
+				};
+
+				pmx_smi: pmx-smi {
+					marvell,pins = "mpp17", "mpp18";
+					marvell,function = "ge";
+				};
+
+				pmx_syno_id_bit0: pmx_syno_id_bit0 {
+					marvell,pins = "mpp55";
+					marvell,function = "gpio";
+				};
+
+				pmx_syno_id_bit1: pmx_syno_id_bit1 {
+					marvell,pins = "mpp56";
+					marvell,function = "gpio";
+				};
+
+				pmx_syno_id_bit2: pmx_syno_id_bit2 {
+					marvell,pins = "mpp57";
+					marvell,function = "gpio";
+				};
+
+				pmx_syno_id_bit3: pmx_syno_id_bit3 {
+					marvell,pins = "mpp58";
+					marvell,function = "gpio";
+				};
+
+				pmx_fan_ctrl_low: pmx-fan-ctrl-low {
+					marvell,pins = "mpp65";
+					marvell,function = "gpio";
+				};
+
+				pmx_fan_ctrl_mid: pmx-fan-ctrl-mid {
+					marvell,pins = "mpp64";
+					marvell,function = "gpio";
+				};
+
+				pmx_fan_ctrl_high: pmx-fan-ctrl-high {
+					marvell,pins = "mpp63";
+					marvell,function = "gpo";
+				};
+
+				pmx_fan_alarm: pmx-fan-alarm {
+					marvell,pins = "mpp38";
+					marvell,function = "gpio";
+				};
+
+				pmx_poweroff: pmx-poweroff {
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
+			       pinctrl-0 = <&pmx_ge0>;
+			       pinctrl-names = "default";
+			       phy = <&phy1>;
+			       phy-mode = "sgmii";
+			};
+
+			spi0: spi at 10600 {
+				status = "okay";
+				pinctrl-0 = <&pmx_spi>;
+				pinctrl-names = "default";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "n25q064";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <20000000>;
+
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
+			usb at 50000 {
+				status = "okay";
+			};
+
+			usb at 51000 {
+				status = "okay";
+			};
+
+			i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				clock-frequency = <400000>;
+				status = "okay";
+
+				s35390a: s35390a at 30 {
+					 compatible = "ssi,s35390a";
+					 reg = <0x30>;
+				};
+			};
+
+			serial at 12000 {
+				status = "okay";
+			};
+
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
+	gpio-fan-100-32-35 {
+		status = "okay";
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fan_ctrl_low &pmx_fan_ctrl_mid
+			     &pmx_fan_ctrl_high &pmx_fan_alarm>;
+		pinctrl-names = "default";
+		gpios = <&gpio1 31 GPIO_ACTIVE_HIGH
+			 &gpio2  0 GPIO_ACTIVE_HIGH
+			 &gpio2  1 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <    0 0
+				       2200 1
+				       2500 2
+				       3000 4
+				       3300 3
+				       3700 5
+				       3800 6
+				       4200 7 >;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_disk1_led
+			     &pmx_disk2_led>;
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
+		pinctrl-0 = <&pmx_sata1_pwr &pmx_sata2_pwr>;
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
