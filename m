From: luka.perkov@sartura.hr (Luka Perkov)
Date: Wed, 4 Nov 2015 22:25:07 +0000
Subject: [PATCH 2/4] ARM: dts: kirkwood: add Linksys EA3500
In-Reply-To: <1446675888-24495-1-git-send-email-luka.perkov@sartura.hr>
References: <1446675888-24495-1-git-send-email-luka.perkov@sartura.hr>
Message-ID: <00000150d49a832c-f77d66d7-8f66-4b36-ac2c-df85deee46b6-000000@email.amazonses.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on dts files from OpenWrt.

Signed-off-by: Luka Perkov <luka.perkov@sartura.hr>
---
 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/kirkwood-ea3500.dts              | 149 +++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-ea3500.dts

diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
index 7a99d4a..ed381a3 100644
--- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
@@ -50,6 +50,7 @@ board. Currently known boards are:
 "lacie,netspace_mini_v2"
 "lacie,netspace_v2"
 "linksys,ea4500"
+"linksys,ea3500"
 "marvell,db-88f6281-bp"
 "marvell,db-88f6282-bp"
 "marvell,mv88f6281gtw-ge"
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a16c04b..ebe5b73 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -168,6 +168,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ds411.dtb \
 	kirkwood-ds411j.dtb \
 	kirkwood-ds411slim.dtb \
+	kirkwood-ea3500.dtb \
 	kirkwood-ea4500.dtb \
 	kirkwood-goflexnet.dtb \
 	kirkwood-guruplug-server-plus.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-ea3500.dts b/arch/arm/boot/dts/kirkwood-ea3500.dts
new file mode 100644
index 0000000..3a064f6
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ea3500.dts
@@ -0,0 +1,149 @@
+/*
+ * kirkwood-ea3500.dts - Device Tree file for Linksys EA3500
+ *
+ * (c) 2013 Jonas Gorski <jogo@openwrt.org>
+ * (c) 2013 Deutsche Telekom Innovation Laboratories
+ * (c) 2014 Luka Perkov <luka.perkov@sartura.hr>
+ * (c) 2014 Dan Walters <dan@walters.io>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+
+/ {
+	model = "Linksys EA3500";
+	compatible = "linksys,ea3500", "marvell,kirkwood-88f6282", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x4000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+
+			pcie at 2,0 {
+				status = "okay";
+			};
+		};
+	};
+
+	ocp at f1000000 {
+		pinctrl: pin-controller at 10000 {
+			pmx_led_green_power: pmx-led-green-power {
+				marvell,pins = "mpp7";
+				marvell,function = "gpo";
+			};
+			pmx_btn_wps: pmx-btn-wps {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+			pmx_btn_reset: pmx-btn-reset {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+		};
+
+		rtc at 10300 {
+			status = "disabled";
+		};
+
+		serial at 12000 {
+			status = "okay";
+		};
+
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = < &pmx_btn_wps &pmx_btn_reset >;
+		pinctrl-names = "default";
+
+		button at 15 {
+			label = "WPS Button";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+		};
+
+		button at 16 {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = < &pmx_led_green_power >;
+		pinctrl-names = "default";
+
+		green-power {
+			label = "ea3500:green:power";
+			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&nand {
+	status = "okay";
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x80000>;
+		read-only;
+	};
+
+	partition at 80000 {
+		label = "u-boot environment";
+		reg = <0x80000 0x20000>;
+	};
+
+	partition at 200000 {
+		label = "kernel";
+		reg = <0x200000 0x200000>;
+	};
+
+	partition at 400000 {
+		label = "root";
+		reg = <0x400000 0x1200000>;
+	};
+};
+
+&mdio {
+	status = "okay";
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		speed = <1000>;
+		duplex = <1>;
+	};
+};
+
+&eth1 {
+	status = "okay";
+	ethernet1-port at 0 {
+		speed = <1000>;
+		duplex = <1>;
+	};
+};
-- 
2.6.2
