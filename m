From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Sat, 11 Apr 2015 23:29:20 +0300
Subject: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
References: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
Message-ID: <1428784160-19431-3-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
---
 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts |  309 ++++++++++++++++++++++++
 2 files changed, 310 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..8535e4e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -612,6 +612,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-zybo.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
 	armada-370-db.dtb \
+	armada-370-dlink-dns327l.dtb \
 	armada-370-mirabox.dtb \
 	armada-370-netgear-rn102.dtb \
 	armada-370-netgear-rn104.dtb \
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
new file mode 100644
index 0000000..12bc072
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -0,0 +1,309 @@
+/*
+ * Device Tree file for DLINK DNS-327L
+ *
+ * Copyright (C) 2014, Andrew Andrianov <andrew@ncrmnt.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/* Remaining mysteries:
+ *
+ * There's still something unknown on i2c address 0x13
+ * CONFIG_ARM_MVEBU_V7_CPUIDLE=y causes hard freezes every 1-8 hours
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-370.dtsi"
+
+/ {
+	model = "DLINK DNS-327L";
+	compatible = "dlink,dns327l",
+		"marvell,armada370",
+		"marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MiB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
+			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+
+		pcie-controller {
+			status = "okay";
+
+			/* Connected to Marvell SATA controller */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+
+			/* Connected to NEC USB 3.0 controller */
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+		};
+
+		internal-regs {
+			serial at 12000 {
+				status = "okay";
+			};
+
+			serial at 12100 {
+				status = "okay";
+			};
+
+			sata at a0000 {
+				nr-ports = <2>;
+				status = "okay";
+			};
+
+			mdio {
+			phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
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
+			};
+
+			nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+
+				partition at 0 {
+					label = "u-boot";
+					/* 1.0 MiB */
+					reg = <0x0000000 0x100000>;
+					read-only;
+				};
+
+				partition at 100000 {
+					label = "u-boot-env";
+					/* 128 KiB */
+					reg = <0x100000 0x20000>;
+					read-only;
+				};
+
+				partition at 120000 {
+					label = "uImage";
+					/* 7 MiB */
+					reg = <0x120000 0x700000>;
+				};
+
+				partition at 820000 {
+					label = "ubifs";
+					/* ~ 84 MiB */
+					reg = <0x820000 0x54e0000>;
+				};
+
+				/* Hardwired into stock bootloader */
+				partition at 800000 {
+					label = "failsafe-uImage";
+					/* 5 MiB */
+					reg = <0x5d00000 0x500000>;
+				};
+
+				partition at 6200000 {
+					label = "failsafe-fs";
+					/* 29 MiB */
+					reg = <0x6200000 0x1d00000>;
+				};
+
+				partition at 7f00000 {
+					label = "bbt";
+					/* 1 MiB for BBT */
+					reg = <0x7f00000 0x100000>;
+				};
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <
+			&backup_button_pin
+			&power_button_pin>;
+		pinctrl-names = "default";
+
+		power-button {
+			label = "Power Button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+		};
+
+		backup-button {
+			label = "Backup Button";
+			linux,code = <KEY_COPY>;
+			gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
+		};
+
+		reset-button {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+		};
+
+
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <
+			&sata_l_amber_pin
+			&sata_r_amber_pin
+			&backup_led_pin>;
+
+		pinctrl-names = "default";
+
+		sata-r-amber-pin {
+			label = "dns327l:amber:sata-r";
+			gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
+		default-state = "keep";
+		};
+
+		sata-l-amber-pin {
+			label = "dns327l:amber:sata-l";
+			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+		default-state = "keep";
+		};
+
+		backup-led-pin {
+			label = "dns327l:white:usb";
+			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+		default-state = "keep";
+		};
+
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&xhci_pwr_pin
+			&sata1_pwr_pin
+			&sata2_pwr_pin>;
+
+		pinctrl-names = "default";
+
+	usb_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB3.0 Port Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-boot-on;
+			regulator-always-on;
+			gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+		};
+
+	sata1_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA-1 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
+		};
+
+	sata2_power: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA-2 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&pinctrl {
+	sata1_white_pin: sata1-white-pin {
+		marvell,pins = "mpp55";
+		marvell,function = "sata1";
+	};
+
+	sata_r_amber_pin: sata-r-amber-pin {
+		marvell,pins = "mpp52";
+		marvell,function = "gpio";
+	};
+
+	sata2_white_pin: sata2-white-pin {
+		marvell,pins = "mpp57";
+		marvell,function = "sata0";
+	};
+
+	sata_l_amber_pin: sata-l-amber-pin {
+		marvell,pins = "mpp53";
+		marvell,function = "gpio";
+	};
+
+	backup_led_pin: backup-led-pin {
+		marvell,pins = "mpp61";
+		marvell,function = "gpo";
+	};
+
+	xhci_pwr_pin: xhci-pwr-pin {
+		marvell,pins = "mpp13";
+		marvell,function = "gpio";
+	};
+
+	sata1_pwr_pin: sata1-pwr-pin {
+		marvell,pins = "mpp54";
+		marvell,function = "gpio";
+	};
+
+	sata2_pwr_pin: sata2-pwr-pin {
+		marvell,pins = "mpp56";
+		marvell,function = "gpio";
+	};
+
+	power_button_pin: power-button-pin {
+		marvell,pins = "mpp65";
+		marvell,function = "gpio";
+	};
+
+	backup_button_pin: backup-button-pin {
+		marvell,pins = "mpp63";
+		marvell,function = "gpio";
+	};
+
+	reset_button_pin: reset-button-pin {
+		marvell,pins = "mpp64";
+		marvell,function = "gpio";
+	};
+};
-- 
1.7.10.4
