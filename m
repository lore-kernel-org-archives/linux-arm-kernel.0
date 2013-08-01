From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 17:07:33 +0200
Subject: [PATCHv2 7/9] ARM: kirkwood: convert LaCie Net{2,
 5}Big v2 platforms to DT
In-Reply-To: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375369655-1310-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit converts the LaCie Net2big and Net5Big Kirkwood boards to
use a Device Tree representation. All devices are converted to use a
DT representation, except the GPIO extension leds that use a special
leds-netxbig driver that does not yet have a DT binding.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/kirkwood-net2big-v2.dts | 219 ++++++++++++++++
 arch/arm/boot/dts/kirkwood-net5big-v2.dts | 265 +++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig            |  26 +-
 arch/arm/mach-kirkwood/Makefile           |   4 +-
 arch/arm/mach-kirkwood/board-dt.c         |   4 +
 arch/arm/mach-kirkwood/board-netxbig_v2.c | 199 ++++++++++++++
 arch/arm/mach-kirkwood/common.h           |   6 +
 arch/arm/mach-kirkwood/netxbig_v2-setup.c | 422 ------------------------------
 9 files changed, 709 insertions(+), 438 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-net2big-v2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net5big-v2.dts
 create mode 100644 arch/arm/mach-kirkwood/board-netxbig_v2.c
 delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d168bed..20a6886 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -85,6 +85,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-lsxhl.dtb \
 	kirkwood-mplcec4.dtb \
 	kirkwood-mv88f6281gtw-ge.dtb \
+	kirkwood-net2big-v2.dtb \
+	kirkwood-net5big-v2.dtb \
 	kirkwood-netgear_readynas_duo_v2.dtb \
 	kirkwood-ns2.dtb \
 	kirkwood-ns2lite.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-net2big-v2.dts b/arch/arm/boot/dts/kirkwood-net2big-v2.dts
new file mode 100644
index 0000000..608ef01
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-net2big-v2.dts
@@ -0,0 +1,219 @@
+/*
+ * LaCie 2Big Network v2
+ *
+ * Simon Guinot <sguinot@lacie.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "LaCie 2Big Network v2";
+	compatible = "lacie,net2big-v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		pinctrl at 10000 {
+			pinctrl-0 = <&pmx_misc &pmx_sysrst>;
+			pinctrl-names = "default";
+
+			pmx_keys: pmx-keys {
+				marvell,pins = "mpp13", "mpp15", "mpp34";
+				marvell,function = "gpio";
+			};
+
+			pmx_sata_power: pmx-sata-power {
+				marvell,pins = "mpp16", "mpp17";
+				marvell,function = "gpio";
+			};
+
+			pmx_sata1: pmx-sata1 {
+				marvell,pins = "mpp20";
+				marvell,function = "sata1";
+			};
+
+			pmx_sata0: pmx-sata0 {
+				marvell,pins = "mpp21";
+				marvell,function = "sata0";
+			};
+
+			pmx_poweroff: pmx-poweroff {
+				marvell,pins = "mpp7";
+				marvell,function = "gpo";
+			};
+
+			pmx_sysrst: pmx-sysrst {
+				marvell,pins = "mpp6";
+				marvell,function = "sysrst";
+			};
+
+			/*
+			 * MPP14: USB fuse alarm
+			 * MPP24: USB mode select
+			 * MPP26: USB device vbus
+			 * MPP28: USB enable host vbus
+			 * MPP35: inhibit switch power-off
+			 * MPP36: SATA HDD1 presence
+			 * MPP37: SATA HDD2 presence
+			 * MPP40: eSATA presence
+			 * MPP44: GPIO extension (data 0)
+			 * MPP45: GPIO extension (data 1)
+			 * MPP46: GPIO extension (data 2)
+			 * MPP47: GPIO extension (addr 0)
+			 * MPP48: GPIO extension (addr 1)
+			 * MPP49: GPIO extension (addr 2)
+			 */
+			pmx_misc: pmx-misc {
+				marvell,pins = "mpp14", "mpp24", "mpp26", "mpp28", "mpp29",
+					       "mpp35", "mpp36", "mpp37", "mpp40", "mpp44",
+					       "mpp45", "mpp46", "mpp47", "mpp48", "mpp49";
+				marvell,function = "gpio";
+			};
+		};
+
+		spi at 10600 {
+			status = "okay";
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
+
+			flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mx25l4005a";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				mode = <0>;
+
+				partition at 0 {
+					reg = <0x0 0x80000>;
+					label = "u-boot";
+				};
+			};
+		};
+
+		i2c at 11000 {
+			status = "okay";
+			pinctrl-0 = <&pmx_twsi0>;
+			pinctrl-names = "default";
+
+			eeprom at 50 {
+				compatible = "at,24c04";
+				pagesize = <16>;
+				reg = <0x50>;
+			};
+		};
+
+		serial at 12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		ehci at 50000 {
+			status = "okay";
+		};
+
+		sata at 80000 {
+			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+			pinctrl-names = "default";
+			status = "okay";
+			nr-ports = <2>;
+		};
+	};
+
+        gpio_poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_poweroff>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 7 0>;
+        };
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_keys>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "Back power switch (on|auto)";
+			linux,code = <0x1>;
+			linux,input-type = <5>; /* EV_SW */
+			gpios = <&gpio0 13 1>;
+		};
+		button at 2 {
+			label = "Back power switch (auto|off)";
+			linux,code = <0x2>;
+			linux,input-type = <5>; /* EV_SW */
+			gpios = <&gpio0 15 1>;
+		};
+		button at 3 {
+			label = "Function button";
+			linux,code = <0x165>; /* KEY_OPTION */
+			gpios = <&gpio1 3 1>;
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		pinctrl-0 = <&pmx_sata_power>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sata0_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA0 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 16 0>;
+		};
+
+		sata1_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA1 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 17 0>;
+		};
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <8>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-net5big-v2.dts b/arch/arm/boot/dts/kirkwood-net5big-v2.dts
new file mode 100644
index 0000000..46ca107
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-net5big-v2.dts
@@ -0,0 +1,265 @@
+/*
+ * LaCie 5Big Network v2
+ *
+ * Simon Guinot <sguinot@lacie.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "LaCie 5Big Network v2";
+	compatible = "lacie,net5big-v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		pinctrl at 10000 {
+			pinctrl-0 = <&pmx_misc &pmx_sysrst>;
+			pinctrl-names = "default";
+
+			pmx_keys: pmx-keys {
+				marvell,pins = "mpp13", "mpp15", "mpp34";
+				marvell,function = "gpio";
+			};
+
+			pmx_sata_power: pmx-sata-power {
+				marvell,pins = "mpp16", "mpp17", "mpp41", "mpp42", "mpp43";
+				marvell,function = "gpio";
+			};
+
+			pmx_poweroff: pmx-poweroff {
+				marvell,pins = "mpp7";
+				marvell,function = "gpo";
+			};
+
+			pmx_sysrst: pmx-sysrst {
+				marvell,pins = "mpp6";
+				marvell,function = "sysrst";
+			};
+
+			/*
+			 * MPP14: USB fuse alarm
+			 * MPP28: USB enable host vbus
+			 * MPP29: GPIO extension ALE
+			 * MPP35: inhibit switch power-off
+			 * MPP36: SATA HDD1 presence
+			 * MPP37: SATA HDD2 presence
+			 * MPP38: SATA HDD3 presence
+			 * MPP39: SATA HDD4 presence
+			 * MPP40: SATA HDD5 presence
+			 * MPP44: GPIO extension (data 0)
+			 * MPP45: GPIO extension (data 1)
+			 * MPP46: GPIO extension (data 2)
+			 * MPP47: GPIO extension (addr 0)
+			 * MPP48: GPIO extension (addr 1)
+			 * MPP49: GPIO extension (addr 2)
+			 */
+			pmx_misc: pmx-misc {
+				marvell,pins = "mpp14", "mpp28", "mpp29", "mpp35", "mpp36",
+					       "mpp37", "mpp38", "mpp39", "mpp40", "mpp44",
+					       "mpp45", "mpp46", "mpp47", "mpp48", "mpp49";
+				marvell,function = "gpio";
+			};
+
+			pmx_ge1: pmx-ge1 {
+				marvell,pins = "mpp20", "mpp21", "mpp22", "mpp23", "mpp24",
+					       "mpp25", "mpp26", "mpp27", "mpp30", "mpp31",
+					       "mpp32", "mpp33";
+				marvell,function = "ge1";
+			};
+		};
+
+		spi at 10600 {
+			status = "okay";
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
+
+			flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mx25l4005a";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				mode = <0>;
+
+				partition at 0 {
+					reg = <0x0 0x80000>;
+					label = "u-boot";
+				};
+			};
+		};
+
+		i2c at 11000 {
+			status = "okay";
+			pinctrl-0 = <&pmx_twsi0>;
+			pinctrl-names = "default";
+
+			eeprom at 50 {
+				compatible = "at,24c04";
+				pagesize = <16>;
+				reg = <0x50>;
+			};
+		};
+
+		serial at 12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		ehci at 50000 {
+			status = "okay";
+		};
+
+		sata at 80000 {
+			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+			pinctrl-names = "default";
+			status = "okay";
+			nr-ports = <2>;
+		};
+	};
+
+        gpio_poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_poweroff>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 7 0>;
+        };
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_keys>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "Back power switch (on|auto)";
+			linux,code = <0x1>;
+			linux,input-type = <5>; /* EV_SW */
+			gpios = <&gpio0 13 1>;
+		};
+		button at 2 {
+			label = "Back power switch (auto|off)";
+			linux,code = <0x2>;
+			linux,input-type = <5>; /* EV_SW */
+			gpios = <&gpio0 15 1>;
+		};
+		button at 3 {
+			label = "Function button";
+			linux,code = <0x165>; /* KEY_OPTION */
+			gpios = <&gpio1 3 1>;
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		pinctrl-0 = <&pmx_sata_power>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sata0_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA0 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 16 0>;
+		};
+
+		sata1_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA1 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 17 0>;
+		};
+
+		sata2_power: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA2 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 9 0>;
+		};
+
+		sata3_power: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA3 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 10 0>;
+		};
+
+		sata4_power: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA4 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 11 0>;
+                };
+        };
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <8>;
+	};
+
+	ethphy1: ethernet-phy at 1 {
+		device_type = "ethernet-phy";
+		reg = <0>;
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
+&eth1 {
+	status = "okay";
+	ethernet1-port at 0 {
+		phy-handle = <&ethphy1>;
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index f624162..b7e66fa 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -5,20 +5,6 @@ menu "Marvell Kirkwood Implementations"
 config KIRKWOOD_LEGACY
 	bool
 
-config MACH_NET2BIG_V2
-	bool "LaCie 2Big Network v2 NAS Board"
-	select KIRKWOOD_LEGACY
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie 2Big Network v2 NAS.
-
-config MACH_NET5BIG_V2
-	bool "LaCie 5Big Network v2 NAS Board"
-	select KIRKWOOD_LEGACY
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie 5Big Network v2 NAS.
-
 config MACH_OPENRD
 	select KIRKWOOD_LEGACY
         bool
@@ -113,6 +99,18 @@ config MACH_MV88F6281GTW_GE_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell 88F6281 GTW GE Board (Flattened Device Tree).
 
+config MACH_NET2BIG_V2_DT
+	bool "LaCie 2Big Network v2 NAS Board (Flattened Device Tree)"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie 2Big Network v2 NAS  (Flattened Device Tree).
+
+config MACH_NET5BIG_V2_DT
+	bool "LaCie 5Big Network v2 NAS Board (Flattened Device Tree)"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie 5Big Network v2 NAS  (Flattened Device Tree).
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 0dcc5d4..38d0d74 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,8 +1,6 @@
 obj-y				+= common.o pcie.o
 obj-$(CONFIG_KIRKWOOD_LEGACY)	+= irq.o mpp.o
 
-obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
-obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
@@ -13,3 +11,5 @@ obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE_DT)	+= board-mv88f6281gtw_ge.o
+obj-$(CONFIG_MACH_NET2BIG_V2)		+= board-netxbig_v2.o
+obj-$(CONFIG_MACH_NET5BIG_V2)		+= board-netxbig_v2.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index b129c65..80955cc 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -112,6 +112,10 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("marvell,mv88f6281gtw-ge"))
 		mv88f6281gtw_ge_init();
 
+	if (of_machine_is_compatible("lacie,net2big-v2") ||
+	    of_machine_is_compatible("lacie,net5big-v2"))
+		netxbig_v2_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-kirkwood/board-netxbig_v2.c b/arch/arm/mach-kirkwood/board-netxbig_v2.c
new file mode 100644
index 0000000..dd4a222
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-netxbig_v2.c
@@ -0,0 +1,199 @@
+/*
+ * arch/arm/mach-kirkwood/board-netxbig_v2.c
+ *
+ * LaCie 2Big and 5Big Network v2 board setup
+ *
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include <linux/platform_data/leds-kirkwood-netxbig.h>
+#include "common.h"
+
+/*****************************************************************************
+ * GPIO extension LEDs
+ ****************************************************************************/
+
+/*
+ * The LEDs are controlled by a CPLD and can be configured through a GPIO
+ * extension bus:
+ *
+ * - address register : bit [0-2] -> GPIO [47-49]
+ * - data register    : bit [0-2] -> GPIO [44-46]
+ * - enable register  : GPIO 29
+ */
+
+static int netxbig_v2_gpio_ext_addr[] = { 47, 48, 49 };
+static int netxbig_v2_gpio_ext_data[] = { 44, 45, 46 };
+
+static struct netxbig_gpio_ext netxbig_v2_gpio_ext = {
+	.addr		= netxbig_v2_gpio_ext_addr,
+	.num_addr	= ARRAY_SIZE(netxbig_v2_gpio_ext_addr),
+	.data		= netxbig_v2_gpio_ext_data,
+	.num_data	= ARRAY_SIZE(netxbig_v2_gpio_ext_data),
+	.enable		= 29,
+};
+
+/*
+ * Address register selection:
+ *
+ * addr | register
+ * ----------------------------
+ *   0  | front LED
+ *   1  | front LED brightness
+ *   2  | SATA LED brightness
+ *   3  | SATA0 LED
+ *   4  | SATA1 LED
+ *   5  | SATA2 LED
+ *   6  | SATA3 LED
+ *   7  | SATA4 LED
+ *
+ * Data register configuration:
+ *
+ * data | LED brightness
+ * -------------------------------------------------
+ *   0  | min (off)
+ *   -  | -
+ *   7  | max
+ *
+ * data | front LED mode
+ * -------------------------------------------------
+ *   0  | fix off
+ *   1  | fix blue on
+ *   2  | fix red on
+ *   3  | blink blue on=1 sec and blue off=1 sec
+ *   4  | blink red on=1 sec and red off=1 sec
+ *   5  | blink blue on=2.5 sec and red on=0.5 sec
+ *   6  | blink blue on=1 sec and red on=1 sec
+ *   7  | blink blue on=0.5 sec and blue off=2.5 sec
+ *
+ * data | SATA LED mode
+ * -------------------------------------------------
+ *   0  | fix off
+ *   1  | SATA activity blink
+ *   2  | fix red on
+ *   3  | blink blue on=1 sec and blue off=1 sec
+ *   4  | blink red on=1 sec and red off=1 sec
+ *   5  | blink blue on=2.5 sec and red on=0.5 sec
+ *   6  | blink blue on=1 sec and red on=1 sec
+ *   7  | fix blue on
+ */
+
+static int netxbig_v2_red_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 2,
+	[NETXBIG_LED_SATA]	= NETXBIG_LED_INVALID_MODE,
+	[NETXBIG_LED_TIMER1]	= 4,
+	[NETXBIG_LED_TIMER2]	= NETXBIG_LED_INVALID_MODE,
+};
+
+static int netxbig_v2_blue_pwr_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 1,
+	[NETXBIG_LED_SATA]	= NETXBIG_LED_INVALID_MODE,
+	[NETXBIG_LED_TIMER1]	= 3,
+	[NETXBIG_LED_TIMER2]	= 7,
+};
+
+static int netxbig_v2_blue_sata_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 7,
+	[NETXBIG_LED_SATA]	= 1,
+	[NETXBIG_LED_TIMER1]	= 3,
+	[NETXBIG_LED_TIMER2]	= NETXBIG_LED_INVALID_MODE,
+};
+
+static struct netxbig_led_timer netxbig_v2_led_timer[] = {
+	[0] = {
+		.delay_on	= 500,
+		.delay_off	= 500,
+		.mode		= NETXBIG_LED_TIMER1,
+	},
+	[1] = {
+		.delay_on	= 500,
+		.delay_off	= 1000,
+		.mode		= NETXBIG_LED_TIMER2,
+	},
+};
+
+#define NETXBIG_LED(_name, maddr, mval, baddr)			\
+	{ .name		= _name,				\
+	  .mode_addr	= maddr,				\
+	  .mode_val	= mval,					\
+	  .bright_addr	= baddr }
+
+static struct netxbig_led net2big_v2_leds_ctrl[] = {
+	NETXBIG_LED("net2big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
+	NETXBIG_LED("net2big-v2:red:power",  0, netxbig_v2_red_mled,       1),
+	NETXBIG_LED("net2big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net2big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net2big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net2big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
+};
+
+static struct netxbig_led_platform_data net2big_v2_leds_data = {
+	.gpio_ext	= &netxbig_v2_gpio_ext,
+	.timer		= netxbig_v2_led_timer,
+	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
+	.leds		= net2big_v2_leds_ctrl,
+	.num_leds	= ARRAY_SIZE(net2big_v2_leds_ctrl),
+};
+
+static struct netxbig_led net5big_v2_leds_ctrl[] = {
+	NETXBIG_LED("net5big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
+	NETXBIG_LED("net5big-v2:red:power",  0, netxbig_v2_red_mled,       1),
+	NETXBIG_LED("net5big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata2", 5, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata2",  5, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata3", 6, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata3",  6, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata4", 7, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata5",  7, netxbig_v2_red_mled,       2),
+};
+
+static struct netxbig_led_platform_data net5big_v2_leds_data = {
+	.gpio_ext	= &netxbig_v2_gpio_ext,
+	.timer		= netxbig_v2_led_timer,
+	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
+	.leds		= net5big_v2_leds_ctrl,
+	.num_leds	= ARRAY_SIZE(net5big_v2_leds_ctrl),
+};
+
+static struct platform_device netxbig_v2_leds = {
+	.name		= "leds-netxbig",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &net2big_v2_leds_data,
+	},
+};
+
+void __init netxbig_v2_init(void)
+{
+	if (of_machine_is_compatible("lacie,net5big-v2"))
+		netxbig_v2_leds.dev.platform_data = &net5big_v2_leds_data;
+	platform_device_register(&netxbig_v2_leds);
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index cc639bb..a9010a3 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -71,6 +71,12 @@ void mv88f6281gtw_ge_init(void);
 static inline void mv88f6281gtw_ge_init(void) {};
 #endif
 
+#if defined(MACH_NET2BIG_V2_DT) || defined(MACH_NET5BIG_V2_DT)
+void netxbig_v2_init(void);
+#else
+static inline void netxbig_v2_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
deleted file mode 100644
index 913d032..0000000
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ /dev/null
@@ -1,422 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/netxbig_v2-setup.c
- *
- * LaCie 2Big and 5Big Network v2 board setup
- *
- * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/input.h>
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/leds.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
-#include <linux/platform_data/leds-kirkwood-netxbig.h>
-#include "common.h"
-#include "mpp.h"
-#include "lacie_v2-common.h"
-
-/*****************************************************************************
- * Ethernet
- ****************************************************************************/
-
-static struct mv643xx_eth_platform_data netxbig_v2_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-static struct mv643xx_eth_platform_data netxbig_v2_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
-/*****************************************************************************
- * SATA
- ****************************************************************************/
-
-static struct mv_sata_platform_data netxbig_v2_sata_data = {
-	.n_ports	= 2,
-};
-
-/*****************************************************************************
- * GPIO keys
- ****************************************************************************/
-
-#define NETXBIG_V2_GPIO_SWITCH_POWER_ON		13
-#define NETXBIG_V2_GPIO_SWITCH_POWER_OFF	15
-#define NETXBIG_V2_GPIO_FUNC_BUTTON		34
-
-#define NETXBIG_V2_SWITCH_POWER_ON		0x1
-#define NETXBIG_V2_SWITCH_POWER_OFF		0x2
-
-static struct gpio_keys_button netxbig_v2_buttons[] = {
-	[0] = {
-		.type           = EV_SW,
-		.code           = NETXBIG_V2_SWITCH_POWER_ON,
-		.gpio           = NETXBIG_V2_GPIO_SWITCH_POWER_ON,
-		.desc           = "Back power switch (on|auto)",
-		.active_low     = 1,
-	},
-	[1] = {
-		.type           = EV_SW,
-		.code           = NETXBIG_V2_SWITCH_POWER_OFF,
-		.gpio           = NETXBIG_V2_GPIO_SWITCH_POWER_OFF,
-		.desc           = "Back power switch (auto|off)",
-		.active_low     = 1,
-	},
-	[2] = {
-		.code		= KEY_OPTION,
-		.gpio		= NETXBIG_V2_GPIO_FUNC_BUTTON,
-		.desc		= "Function button",
-		.active_low	= 1,
-	},
-};
-
-static struct gpio_keys_platform_data netxbig_v2_button_data = {
-	.buttons	= netxbig_v2_buttons,
-	.nbuttons	= ARRAY_SIZE(netxbig_v2_buttons),
-};
-
-static struct platform_device netxbig_v2_gpio_buttons = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &netxbig_v2_button_data,
-	},
-};
-
-/*****************************************************************************
- * GPIO extension LEDs
- ****************************************************************************/
-
-/*
- * The LEDs are controlled by a CPLD and can be configured through a GPIO
- * extension bus:
- *
- * - address register : bit [0-2] -> GPIO [47-49]
- * - data register    : bit [0-2] -> GPIO [44-46]
- * - enable register  : GPIO 29
- */
-
-static int netxbig_v2_gpio_ext_addr[] = { 47, 48, 49 };
-static int netxbig_v2_gpio_ext_data[] = { 44, 45, 46 };
-
-static struct netxbig_gpio_ext netxbig_v2_gpio_ext = {
-	.addr		= netxbig_v2_gpio_ext_addr,
-	.num_addr	= ARRAY_SIZE(netxbig_v2_gpio_ext_addr),
-	.data		= netxbig_v2_gpio_ext_data,
-	.num_data	= ARRAY_SIZE(netxbig_v2_gpio_ext_data),
-	.enable		= 29,
-};
-
-/*
- * Address register selection:
- *
- * addr | register
- * ----------------------------
- *   0  | front LED
- *   1  | front LED brightness
- *   2  | SATA LED brightness
- *   3  | SATA0 LED
- *   4  | SATA1 LED
- *   5  | SATA2 LED
- *   6  | SATA3 LED
- *   7  | SATA4 LED
- *
- * Data register configuration:
- *
- * data | LED brightness
- * -------------------------------------------------
- *   0  | min (off)
- *   -  | -
- *   7  | max
- *
- * data | front LED mode
- * -------------------------------------------------
- *   0  | fix off
- *   1  | fix blue on
- *   2  | fix red on
- *   3  | blink blue on=1 sec and blue off=1 sec
- *   4  | blink red on=1 sec and red off=1 sec
- *   5  | blink blue on=2.5 sec and red on=0.5 sec
- *   6  | blink blue on=1 sec and red on=1 sec
- *   7  | blink blue on=0.5 sec and blue off=2.5 sec
- *
- * data | SATA LED mode
- * -------------------------------------------------
- *   0  | fix off
- *   1  | SATA activity blink
- *   2  | fix red on
- *   3  | blink blue on=1 sec and blue off=1 sec
- *   4  | blink red on=1 sec and red off=1 sec
- *   5  | blink blue on=2.5 sec and red on=0.5 sec
- *   6  | blink blue on=1 sec and red on=1 sec
- *   7  | fix blue on
- */
-
-static int netxbig_v2_red_mled[NETXBIG_LED_MODE_NUM] = {
-	[NETXBIG_LED_OFF]	= 0,
-	[NETXBIG_LED_ON]	= 2,
-	[NETXBIG_LED_SATA]	= NETXBIG_LED_INVALID_MODE,
-	[NETXBIG_LED_TIMER1]	= 4,
-	[NETXBIG_LED_TIMER2]	= NETXBIG_LED_INVALID_MODE,
-};
-
-static int netxbig_v2_blue_pwr_mled[NETXBIG_LED_MODE_NUM] = {
-	[NETXBIG_LED_OFF]	= 0,
-	[NETXBIG_LED_ON]	= 1,
-	[NETXBIG_LED_SATA]	= NETXBIG_LED_INVALID_MODE,
-	[NETXBIG_LED_TIMER1]	= 3,
-	[NETXBIG_LED_TIMER2]	= 7,
-};
-
-static int netxbig_v2_blue_sata_mled[NETXBIG_LED_MODE_NUM] = {
-	[NETXBIG_LED_OFF]	= 0,
-	[NETXBIG_LED_ON]	= 7,
-	[NETXBIG_LED_SATA]	= 1,
-	[NETXBIG_LED_TIMER1]	= 3,
-	[NETXBIG_LED_TIMER2]	= NETXBIG_LED_INVALID_MODE,
-};
-
-static struct netxbig_led_timer netxbig_v2_led_timer[] = {
-	[0] = {
-		.delay_on	= 500,
-		.delay_off	= 500,
-		.mode		= NETXBIG_LED_TIMER1,
-	},
-	[1] = {
-		.delay_on	= 500,
-		.delay_off	= 1000,
-		.mode		= NETXBIG_LED_TIMER2,
-	},
-};
-
-#define NETXBIG_LED(_name, maddr, mval, baddr)			\
-	{ .name		= _name,				\
-	  .mode_addr	= maddr,				\
-	  .mode_val	= mval,					\
-	  .bright_addr	= baddr }
-
-static struct netxbig_led net2big_v2_leds_ctrl[] = {
-	NETXBIG_LED("net2big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
-	NETXBIG_LED("net2big-v2:red:power",  0, netxbig_v2_red_mled,       1),
-	NETXBIG_LED("net2big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
-	NETXBIG_LED("net2big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
-	NETXBIG_LED("net2big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
-	NETXBIG_LED("net2big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
-};
-
-static struct netxbig_led_platform_data net2big_v2_leds_data = {
-	.gpio_ext	= &netxbig_v2_gpio_ext,
-	.timer		= netxbig_v2_led_timer,
-	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
-	.leds		= net2big_v2_leds_ctrl,
-	.num_leds	= ARRAY_SIZE(net2big_v2_leds_ctrl),
-};
-
-static struct netxbig_led net5big_v2_leds_ctrl[] = {
-	NETXBIG_LED("net5big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
-	NETXBIG_LED("net5big-v2:red:power",  0, netxbig_v2_red_mled,       1),
-	NETXBIG_LED("net5big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
-	NETXBIG_LED("net5big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
-	NETXBIG_LED("net5big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
-	NETXBIG_LED("net5big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
-	NETXBIG_LED("net5big-v2:blue:sata2", 5, netxbig_v2_blue_sata_mled, 2),
-	NETXBIG_LED("net5big-v2:red:sata2",  5, netxbig_v2_red_mled,       2),
-	NETXBIG_LED("net5big-v2:blue:sata3", 6, netxbig_v2_blue_sata_mled, 2),
-	NETXBIG_LED("net5big-v2:red:sata3",  6, netxbig_v2_red_mled,       2),
-	NETXBIG_LED("net5big-v2:blue:sata4", 7, netxbig_v2_blue_sata_mled, 2),
-	NETXBIG_LED("net5big-v2:red:sata5",  7, netxbig_v2_red_mled,       2),
-};
-
-static struct netxbig_led_platform_data net5big_v2_leds_data = {
-	.gpio_ext	= &netxbig_v2_gpio_ext,
-	.timer		= netxbig_v2_led_timer,
-	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
-	.leds		= net5big_v2_leds_ctrl,
-	.num_leds	= ARRAY_SIZE(net5big_v2_leds_ctrl),
-};
-
-static struct platform_device netxbig_v2_leds = {
-	.name		= "leds-netxbig",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &net2big_v2_leds_data,
-	},
-};
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-
-static unsigned int net2big_v2_mpp_config[] __initdata = {
-	MPP0_SPI_SCn,
-	MPP1_SPI_MOSI,
-	MPP2_SPI_SCK,
-	MPP3_SPI_MISO,
-	MPP6_SYSRST_OUTn,
-	MPP7_GPO,		/* Request power-off */
-	MPP8_TW0_SDA,
-	MPP9_TW0_SCK,
-	MPP10_UART0_TXD,
-	MPP11_UART0_RXD,
-	MPP13_GPIO,		/* Rear power switch (on|auto) */
-	MPP14_GPIO,		/* USB fuse alarm */
-	MPP15_GPIO,		/* Rear power switch (auto|off) */
-	MPP16_GPIO,		/* SATA HDD1 power */
-	MPP17_GPIO,		/* SATA HDD2 power */
-	MPP20_SATA1_ACTn,
-	MPP21_SATA0_ACTn,
-	MPP24_GPIO,		/* USB mode select */
-	MPP26_GPIO,		/* USB device vbus */
-	MPP28_GPIO,		/* USB enable host vbus */
-	MPP29_GPIO,		/* GPIO extension ALE */
-	MPP34_GPIO,		/* Rear Push button */
-	MPP35_GPIO,		/* Inhibit switch power-off */
-	MPP36_GPIO,		/* SATA HDD1 presence */
-	MPP37_GPIO,		/* SATA HDD2 presence */
-	MPP40_GPIO,		/* eSATA presence */
-	MPP44_GPIO,		/* GPIO extension (data 0) */
-	MPP45_GPIO,		/* GPIO extension (data 1) */
-	MPP46_GPIO,		/* GPIO extension (data 2) */
-	MPP47_GPIO,		/* GPIO extension (addr 0) */
-	MPP48_GPIO,		/* GPIO extension (addr 1) */
-	MPP49_GPIO,		/* GPIO extension (addr 2) */
-	0
-};
-
-static unsigned int net5big_v2_mpp_config[] __initdata = {
-	MPP0_SPI_SCn,
-	MPP1_SPI_MOSI,
-	MPP2_SPI_SCK,
-	MPP3_SPI_MISO,
-	MPP6_SYSRST_OUTn,
-	MPP7_GPO,		/* Request power-off */
-	MPP8_TW0_SDA,
-	MPP9_TW0_SCK,
-	MPP10_UART0_TXD,
-	MPP11_UART0_RXD,
-	MPP13_GPIO,		/* Rear power switch (on|auto) */
-	MPP14_GPIO,		/* USB fuse alarm */
-	MPP15_GPIO,		/* Rear power switch (auto|off) */
-	MPP16_GPIO,		/* SATA HDD1 power */
-	MPP17_GPIO,		/* SATA HDD2 power */
-	MPP20_GE1_TXD0,
-	MPP21_GE1_TXD1,
-	MPP22_GE1_TXD2,
-	MPP23_GE1_TXD3,
-	MPP24_GE1_RXD0,
-	MPP25_GE1_RXD1,
-	MPP26_GE1_RXD2,
-	MPP27_GE1_RXD3,
-	MPP28_GPIO,		/* USB enable host vbus */
-	MPP29_GPIO,		/* GPIO extension ALE */
-	MPP30_GE1_RXCTL,
-	MPP31_GE1_RXCLK,
-	MPP32_GE1_TCLKOUT,
-	MPP33_GE1_TXCTL,
-	MPP34_GPIO,		/* Rear Push button */
-	MPP35_GPIO,		/* Inhibit switch power-off */
-	MPP36_GPIO,		/* SATA HDD1 presence */
-	MPP37_GPIO,		/* SATA HDD2 presence */
-	MPP38_GPIO,		/* SATA HDD3 presence */
-	MPP39_GPIO,		/* SATA HDD4 presence */
-	MPP40_GPIO,		/* SATA HDD5 presence */
-	MPP41_GPIO,		/* SATA HDD3 power */
-	MPP42_GPIO,		/* SATA HDD4 power */
-	MPP43_GPIO,		/* SATA HDD5 power */
-	MPP44_GPIO,		/* GPIO extension (data 0) */
-	MPP45_GPIO,		/* GPIO extension (data 1) */
-	MPP46_GPIO,		/* GPIO extension (data 2) */
-	MPP47_GPIO,		/* GPIO extension (addr 0) */
-	MPP48_GPIO,		/* GPIO extension (addr 1) */
-	MPP49_GPIO,		/* GPIO extension (addr 2) */
-	0
-};
-
-#define NETXBIG_V2_GPIO_POWER_OFF		7
-
-static void netxbig_v2_power_off(void)
-{
-	gpio_set_value(NETXBIG_V2_GPIO_POWER_OFF, 1);
-}
-
-static void __init netxbig_v2_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-	if (machine_is_net2big_v2())
-		kirkwood_mpp_conf(net2big_v2_mpp_config);
-	else
-		kirkwood_mpp_conf(net5big_v2_mpp_config);
-
-	if (machine_is_net2big_v2())
-		lacie_v2_hdd_power_init(2);
-	else
-		lacie_v2_hdd_power_init(5);
-
-	kirkwood_ehci_init();
-	kirkwood_ge00_init(&netxbig_v2_ge00_data);
-	if (machine_is_net5big_v2())
-		kirkwood_ge01_init(&netxbig_v2_ge01_data);
-	kirkwood_sata_init(&netxbig_v2_sata_data);
-	kirkwood_uart0_init();
-	lacie_v2_register_flash();
-	lacie_v2_register_i2c_devices();
-
-	if (machine_is_net5big_v2())
-		netxbig_v2_leds.dev.platform_data = &net5big_v2_leds_data;
-	platform_device_register(&netxbig_v2_leds);
-	platform_device_register(&netxbig_v2_gpio_buttons);
-
-	if (gpio_request(NETXBIG_V2_GPIO_POWER_OFF, "power-off") == 0 &&
-	    gpio_direction_output(NETXBIG_V2_GPIO_POWER_OFF, 0) == 0)
-		pm_power_off = netxbig_v2_power_off;
-	else
-		pr_err("netxbig_v2: failed to configure power-off GPIO\n");
-}
-
-#ifdef CONFIG_MACH_NET2BIG_V2
-MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
-	.atag_offset	= 0x100,
-	.init_machine	= netxbig_v2_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-#endif
-
-#ifdef CONFIG_MACH_NET5BIG_V2
-MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
-	.atag_offset	= 0x100,
-	.init_machine	= netxbig_v2_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-#endif
-- 
1.8.1.2
