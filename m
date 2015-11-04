From: luka.perkov@sartura.hr (Luka Perkov)
Date: Wed, 4 Nov 2015 22:25:08 +0000
Subject: [PATCH 3/4] ARM: dts: kirkwood: add Seagate GoFlex Home
In-Reply-To: <1446675888-24495-1-git-send-email-luka.perkov@sartura.hr>
References: <1446675888-24495-1-git-send-email-luka.perkov@sartura.hr>
Message-ID: <00000150d49a8745-1c2bc8d4-1333-46bb-bf0e-5508ef988c73-000000@email.amazonses.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on dts files from OpenWrt.

Signed-off-by: Luka Perkov <luka.perkov@sartura.hr>
---
 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/kirkwood-goflexhome.dts          | 127 +++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-goflexhome.dts

diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
index ed381a3..37bd190 100644
--- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
@@ -72,6 +72,7 @@ board. Currently known boards are:
 "raidsonic,ib-nas6220-b"
 "raidsonic,ib-nas62x0"
 "seagate,dockstar"
+"seagate,goflexhome"
 "seagate,goflexnet"
 "synology,ds109"
 "synology,ds110jv10"
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ebe5b73..1d6fb0d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -170,6 +170,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ds411slim.dtb \
 	kirkwood-ea3500.dtb \
 	kirkwood-ea4500.dtb \
+	kirkwood-goflexhome.dtb \
 	kirkwood-goflexnet.dtb \
 	kirkwood-guruplug-server-plus.dtb \
 	kirkwood-ib62x0.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-goflexhome.dts b/arch/arm/boot/dts/kirkwood-goflexhome.dts
new file mode 100644
index 0000000..5f933d4
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-goflexhome.dts
@@ -0,0 +1,127 @@
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+
+/ {
+	model = "Seagate GoFlex Home";
+	compatible = "seagate,goflexhome", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk root=/dev/sda1 rootdelay=10";
+		stdout-path = &uart0;
+	};
+
+	ocp at f1000000 {
+		pinctrl: pin-controller at 10000 {
+			pmx_usb_power_enable: pmx-usb-power-enable {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+			pmx_led_white: pmx-led-white {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+			pmx_led_green: pmx-led_green {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+			pmx_led_orange: pmx-led-orange {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+		};
+		serial at 12000 {
+			status = "ok";
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		health {
+			label = "status:green:health";
+			gpios = <&gpio1 14 1>;
+			linux,default-trigger = "default-on";
+		};
+		fault {
+			label = "status:orange:fault";
+			gpios = <&gpio1 15 1>;
+		};
+		misc {
+			label = "status:white:misc";
+			gpios = <&gpio1 8 1>;
+			linux,default-trigger = "ide-disk";
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
+		reg = <0x02500000 0xd800000>;
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
2.6.2
