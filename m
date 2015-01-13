From: junghans@votca.org (Christoph Junghans)
Date: Mon, 12 Jan 2015 23:13:11 -0700
Subject: [PATCH v3] Added support for pogoplug e02 (pink/gray)
In-Reply-To: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
References: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
Message-ID: <1421129591-18479-1-git-send-email-junghans@votca.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoph Junghans <ottxor@gentoo.org>

The pogoplug differs from the SheevaPlug only by a
few details, but especially in the led assignments.
This patch was tested under Gentoo Linux and is
based on dts files from Arch Linux ARM and OpenWrt.

Suggested-by: Felix Kaechele <heffer@fedoraproject.org>
Suggested-by: Oleg Rakhmanov <moonman.ca@gmail.com>
Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
---

V1: initial patch
V2: added GPL-2 header
    dropped earlyprintk from bootargs
    added stdout-path
    change leds name to scheme "devicename:colour:function"
V3: rebase on v3.19-rc4
    fixed stdout-path to be &uart0
    fixed compiling issue by using pin-controller

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/kirkwood-pogo_e02.dts            | 129 +++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-pogo_e02.dts

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b1df0ad..61888db 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -34,6 +34,7 @@ chipidea	Chipidea, Inc
 chrp	Common Hardware Reference Platform
 chunghwa	Chunghwa Picture Tubes Ltd.
 cirrus	Cirrus Logic, Inc.
+cloudengines	Cloud Engines, Inc.
 cnm	Chips&Media, Inc.
 cortina	Cortina Systems, Inc.
 crystalfontz	Crystalfontz America, Inc.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd..a3463ff 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -160,6 +160,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
 	kirkwood-openrd-base.dtb \
 	kirkwood-openrd-client.dtb \
 	kirkwood-openrd-ultimate.dtb \
+	kirkwood-pogo_e02.dtb \
 	kirkwood-rd88f6192.dtb \
 	kirkwood-rd88f6281-z0.dtb \
 	kirkwood-rd88f6281-a.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-pogo_e02.dts b/arch/arm/boot/dts/kirkwood-pogo_e02.dts
new file mode 100644
index 0000000..ee9eab1
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-pogo_e02.dts
@@ -0,0 +1,129 @@
+/*
+ * kirkwood-pogo_e02.dts - Device tree file for Pogoplug E02
+ *
+ * Copyright (C) 2015 Christoph Junghans <ottxor@gentoo.org>
+ *
+ * based on information of dts files from
+ *  Arch Linux ARM by Oleg Rakhmanov <moonman.ca@gmail.com>
+ *  OpenWrt by Felix Kaechele <heffer@fedoraproject.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+
+/ {
+	model = "Cloud Engines Pogoplug E02";
+	compatible = "cloudengines,pogoe02", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+		stdout-path = &uart0;
+	};
+
+	ocp at f1000000 {
+		pinctrl: pin-controller at 10000 {
+			pmx_usb_power_enable: pmx-usb-power-enable {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+			pmx_led_green: pmx-led-green {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+			pmx_led_orange: pmx-led-orange {
+				marvell,pins = "mpp49";
+				marvell,function = "gpio";
+			};
+		};
+		serial at 12000 {
+			status = "ok";
+		};
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = < &pmx_usb_power_enable &pmx_led_orange
+			      &pmx_led_green >;
+		pinctrl-names = "default";
+
+		health {
+			label = "pogo_e02:green:health";
+			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+		};
+		fault {
+			label = "pogo_e02:orange:fault";
+			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_usb_power_enable>;
+		pinctrl-names = "default";
+
+		usb_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&nand {
+	chip-delay = <40>;
+	status = "okay";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x0100000 0x400000>;
+	};
+
+	partition at 500000 {
+		label = "pogoplug";
+		reg = <0x0500000 0x2000000>;
+	};
+
+	partition at 2500000 {
+		label = "root";
+		reg = <0x02500000 0x5b00000>;
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
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
-- 
2.0.5
