From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 11 May 2014 22:21:50 +0200
Subject: [PATCH v3 2/4] ARM: Kirkwood: Add DT descriptions for net2big and
 net5big.
In-Reply-To: <1399839712-2416-1-git-send-email-andrew@lunn.ch>
References: <1399839712-2416-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399839712-2416-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe LaCie 2Big and 5Big Network v2 using device tree.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
v1->v2
Fix size of memory
Clean up ethernet nodes
s/at/atmel/

v2->v3
gpio_poweroff->gpio-poweroff
gpio_key->gpio-key
s/ok/okay
Remove spi pinctrl properties.
---
 arch/arm/boot/dts/Makefile              |   2 +
 arch/arm/boot/dts/kirkwood-net2big.dts  |  30 ++++++
 arch/arm/boot/dts/kirkwood-net5big.dts  |  83 ++++++++++++++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi | 166 ++++++++++++++++++++++++++++++++
 4 files changed, 281 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 629eee22e606..facbf0cc2fca 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -118,6 +118,8 @@ kirkwood := \
 	kirkwood-lsxhl.dtb \
 	kirkwood-mplcec4.dtb \
 	kirkwood-mv88f6281gtw-ge.dtb \
+	kirkwood-net2big.dtb \
+	kirkwood-net5big.dtb \
 	kirkwood-netgear_readynas_duo_v2.dtb \
 	kirkwood-netgear_readynas_nv+_v2.dtb \
 	kirkwood-ns2.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
new file mode 100644
index 000000000000..c3f5281a52f5
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-net2big.dts
@@ -0,0 +1,30 @@
+/*
+ * Device Tree file for LaCie 2Big Network v2
+ *
+ * Copyright (C) 2014
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * Based on netxbig_v2-setup.c,
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+*/
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "kirkwood-netxbig.dtsi"
+
+/ {
+	model = "LaCie 2Big Network v2";
+	compatible = "lacie,net2big", "lacie,netxbig", "marvell,kirkwood-88f6192", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-net5big.dts b/arch/arm/boot/dts/kirkwood-net5big.dts
new file mode 100644
index 000000000000..20abe7e37ca2
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-net5big.dts
@@ -0,0 +1,83 @@
+/*
+ * Device Tree file for LaCie 5Big Network v2
+ *
+ * Copyright (C) 2014
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * Based on netxbig_v2-setup.c,
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+*/
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "kirkwood-netxbig.dtsi"
+
+/ {
+	model = "LaCie 5Big Network v2";
+	compatible = "lacie,net2big", "lacie,netxbig", "marvell,kirkwood-88f6192", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+};
+
+&regulators {
+	regulator at 3 {
+		compatible = "regulator-fixed";
+		reg = <3>;
+		regulator-name = "hdd2power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio0 19 GPIO_ACTIVE_HIGH>;
+	};
+
+	regulator at 4 {
+		compatible = "regulator-fixed";
+		reg = <4>;
+		regulator-name = "hdd3power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+	};
+
+	regulator at 5 {
+		compatible = "regulator-fixed";
+		reg = <5>;
+		regulator-name = "hdd4power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&mdio {
+	ethphy1: ethernet-phy at 1 {
+		reg = <0>;
+	};
+};
+
+&eth1 {
+	status = "okay";
+	ethernet1-port at 0 {
+		phy-handle = <&ethphy1>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
new file mode 100644
index 000000000000..eca522316560
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
@@ -0,0 +1,166 @@
+/*
+ * Device Tree common file for LaCie 2Big and 5Big Network v2
+ *
+ * Copyright (C) 2014
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * Based on netxbig_v2-setup.c,
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+*/
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+
+/ {
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+		stdout-path = &uart0;
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			status = "okay";
+		};
+
+		spi at 10600 {
+			status = "okay";
+
+			flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mxicy,mx25l4005a";
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
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*
+		 * button at 1 and button at 2 represent a three position rocker
+		 * switch. Thus the conventional KEY_POWER does not fit
+		 */
+		button at 1 {
+			label = "Back power switch (on|auto)";
+			linux,code = <KEY_ESC>;
+			linux,input-type = <5>;
+			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+		};
+		button at 2 {
+			label = "Back power switch (auto|off)";
+			linux,code = <KEY_1>;
+			linux,input-type = <5>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
+		};
+		button at 3 {
+			label = "Function button";
+			linux,code = <KEY_OPTION>;
+			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+		};
+
+	};
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+	};
+
+       	regulators: regulators {
+                status = "okay";
+                compatible = "simple-bus";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                pinctrl-names = "default";
+
+                regulator at 1 {
+                        compatible = "regulator-fixed";
+                        reg = <1>;
+                        regulator-name = "hdd0power";
+                        regulator-min-microvolt = <5000000>;
+                        regulator-max-microvolt = <5000000>;
+                        enable-active-high;
+                        regulator-always-on;
+                        regulator-boot-on;
+                        gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+                };
+
+                regulator at 2 {
+                        compatible = "regulator-fixed";
+                        reg = <2>;
+                        regulator-name = "hdd1power";
+                        regulator-min-microvolt = <5000000>;
+                        regulator-max-microvolt = <5000000>;
+                        enable-active-high;
+                        regulator-always-on;
+                        regulator-boot-on;
+                        gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+                };
+        };
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		reg = <8>;
+	};
+
+	ethphy1: ethernet-phy at 1 {
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
+&pinctrl {
+	pinctrl-names = "default";
+
+	pmx_button_function: pmx-button-function {
+		marvell,pins = "mpp34";
+		marvell,function = "gpio";
+	};
+	pmx_button_power_off: pmx-button-power-off {
+		marvell,pins = "mpp15";
+		marvell,function = "gpio";
+	};
+	pmx_button_power_on: pmx-button-power-on {
+		marvell,pins = "mpp13";
+		marvell,function = "gpio";
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c04";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
+};
-- 
2.0.0.rc2
