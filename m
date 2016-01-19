From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 19 Jan 2016 22:49:02 +0900
Subject: [PATCH 2/2] ARM: dts: kirkwood: split lswvl into linkstation lsvl and
 lswvl
In-Reply-To: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1453211342-25214-3-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS-WVL/VL are both kirkwood-6282 based NAS devices, which share
many MPP pins. However they are slightly different:
  - There're two red LED indicator on LS-WVL to show when HDD fails,
    which is similar to LS-WXL, but there's no such on LS-VL.
  - LS-WVL is 2-Bay NAS, and LS-VL is only 1-Bay.

So after the split, common part goes into .dtsi file:
  - kirkwood-linkstation-6282.dtsi
while all rest part goes into device specific .dts file:
  - kirkwood-linkstation-lsvl.dts
  - kirkwood-linkstation-lswvl.dts

License all newly created files under GPLv2/X11.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   3 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   | 190 +++++++++++++
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    |  57 ++++
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   | 112 ++++++++
 arch/arm/boot/dts/kirkwood-lswvl.dts               | 301 ---------------------
 6 files changed, 363 insertions(+), 302 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
 delete mode 100644 arch/arm/boot/dts/kirkwood-lswvl.dts

diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
index c7f8e3e..0d5d0f6 100644
--- a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
@@ -19,10 +19,11 @@ SoC. Currently known SoC compatibles are:
 And in addition, the compatible shall be extended with the specific
 board. Currently known boards are:
 
+"buffalo,linkstation-lsvl"
 "buffalo,linkstation-lswsxl"
 "buffalo,linkstation-lswxl"
+"buffalo,linkstation-lswvl"
 "buffalo,lschlv2"
-"buffalo,lswvl"
 "buffalo,lsxhl"
 "buffalo,lsxl"
 "dlink,dns-320"
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6dff6af..3e2cf27 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -183,7 +183,9 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-is2.dtb \
 	kirkwood-km_kirkwood.dtb \
 	kirkwood-laplug.dtb \
+	kirkwood-linkstation-lsvl.dtb \
 	kirkwood-linkstation-lswsxl.dtb \
+	kirkwood-linkstation-lswvl.dtb \
 	kirkwood-linkstation-lswxl.dtb \
 	kirkwood-lschlv2.dtb \
 	kirkwood-lsxhl.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi b/arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
new file mode 100644
index 0000000..73594d1
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi
@@ -0,0 +1,190 @@
+/*
+ * Device Tree common file for kirkwood-6282 based Buffalo Linkstation
+ *
+ * Copyright (C) 2015, 2016
+ * Roger Shimizu <rogershimizu@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "kirkwood-linkstation.dtsi"
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pin-controller at 10000 {
+			pmx_power_hdd0: pmx-power-hdd0 {
+				marvell,pins = "mpp8";
+				marvell,function = "gpio";
+			};
+			pmx_usb_vbus: pmx-usb-vbus {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+			pmx_fan_high: pmx-fan-high {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+			pmx_fan_low: pmx-fan-low {
+				marvell,pins = "mpp17";
+				marvell,function = "gpio";
+			};
+			pmx_led_alarm: pmx-led-alarm {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+			pmx_led_function_red: pmx-led-function-red {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+			pmx_led_function_blue: pmx-led-function-blue {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+			pmx_led_info: pmx-led-info {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+			pmx_led_power: pmx-led-power {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+			pmx_fan_lock: pmx-fan-lock {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+			pmx_button_function: pmx-button-function {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+			pmx_power_switch: pmx-power-switch {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+			pmx_power_auto_switch: pmx-power-auto-switch {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
+	gpio_keys {
+		function-button {
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		};
+
+		power-on-switch {
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		};
+
+		power-auto-switch {
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio_leds {
+		red-alarm-led {
+			label = "red:alarm";
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		red-function-led {
+			label = "red:function";
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		amber-info-led {
+			label = "amber:info";
+			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		blue-function-led {
+			label = "blue:function";
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		blue-power-led {
+			label = "blue:power";
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio_fan {
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 17 GPIO_ACTIVE_LOW
+			 &gpio0 16 GPIO_ACTIVE_LOW>;
+
+		gpio-fan,speed-map = <0 3
+				1500 2
+				3250 1
+				5000 0>;
+
+		alarm-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+	};
+
+	regulators {
+		usb_power: regulator at 1 {
+			gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		};
+
+		hdd_power0: regulator at 2 {
+			gpio = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts b/arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
new file mode 100644
index 0000000..edcba5c
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts
@@ -0,0 +1,57 @@
+/*
+ * Device Tree file for Buffalo Linkstation LS-VL
+ *
+ * Copyright (C) 2015, 2016
+ * Roger Shimizu <rogershimizu@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "kirkwood-linkstation-6282.dtsi"
+
+/ {
+	model = "Buffalo Linkstation LS-VL";
+	compatible = "buffalo,lsvl", "marvell,kirkwood-88f6282", "marvell,kirkwood";
+
+	memory { /* 256 MB */
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts b/arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
new file mode 100644
index 0000000..cc369c0
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts
@@ -0,0 +1,112 @@
+/*
+ * Device Tree file for Buffalo Linkstation LS-WVL
+ *
+ * Copyright (C) 2015, 2016
+ * Roger Shimizu <rogershimizu@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "kirkwood-linkstation-6282.dtsi"
+
+/ {
+	model = "Buffalo Linkstation LS-WVL";
+	compatible = "buffalo,lswvl","marvell,kirkwood-88f6282", "marvell,kirkwood";
+
+	memory { /* 256 MB */
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	ocp at f1000000 {
+		pinctrl: pin-controller at 10000 {
+			pmx_power_hdd1: pmx-power-hdd1 {
+				marvell,pins = "mpp9";
+				marvell,function = "gpio";
+			};
+			pmx_led_hdderr0: pmx-led-hdderr0 {
+				marvell,pins = "mpp34";
+				marvell,function = "gpio";
+			};
+			pmx_led_hdderr1: pmx-led-hdderr1 {
+				marvell,pins = "mpp35";
+				marvell,function = "gpio";
+			};
+		};
+
+		sata at 80000 {
+			nr-ports = <2>;
+		};
+	};
+
+	gpio_leds {
+		pinctrl-0 = <&pmx_led_function_red &pmx_led_alarm
+			     &pmx_led_info &pmx_led_power
+			     &pmx_led_function_blue
+			     &pmx_led_hdderr0
+			     &pmx_led_hdderr1>;
+
+		red-hdderr0-led {
+			label = "red:hdderr0";
+			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		red-hdderr1-led {
+			label = "red:hdderr1";
+			gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	regulators {
+		pinctrl-0 = <&pmx_power_hdd0 &pmx_power_hdd1 &pmx_usb_vbus>;
+
+		hdd_power1: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "HDD1 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-lswvl.dts b/arch/arm/boot/dts/kirkwood-lswvl.dts
deleted file mode 100644
index 09eed3c..0000000
--- a/arch/arm/boot/dts/kirkwood-lswvl.dts
+++ /dev/null
@@ -1,301 +0,0 @@
-/*
- * Device Tree file for Buffalo Linkstation LS-WVL/VL
- *
- * Copyright (C) 2015, rogershimizu at gmail.com
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-/dts-v1/;
-
-#include "kirkwood.dtsi"
-#include "kirkwood-6282.dtsi"
-
-/ {
-	model = "Buffalo Linkstation LS-WVL/VL";
-	compatible = "buffalo,lswvl", "buffalo,lsvl", "marvell,kirkwood-88f6282", "marvell,kirkwood";
-
-	memory { /* 256 MB */
-		device_type = "memory";
-		reg = <0x00000000 0x10000000>;
-	};
-
-	chosen {
-		bootargs = "console=ttyS0,115200n8 earlyprintk";
-		stdout-path = &uart0;
-	};
-
-	mbus {
-		pcie-controller {
-			status = "okay";
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
-	ocp at f1000000 {
-		pinctrl: pin-controller at 10000 {
-			pmx_power_hdd0: pmx-power-hdd0 {
-				marvell,pins = "mpp8";
-				marvell,function = "gpio";
-			};
-			pmx_power_hdd1: pmx-power-hdd1 {
-				marvell,pins = "mpp9";
-				marvell,function = "gpio";
-			};
-			pmx_usb_vbus: pmx-usb-vbus {
-				marvell,pins = "mpp12";
-				marvell,function = "gpio";
-			};
-			pmx_fan_high: pmx-fan-high {
-				marvell,pins = "mpp16";
-				marvell,function = "gpio";
-			};
-			pmx_fan_low: pmx-fan-low {
-				marvell,pins = "mpp17";
-				marvell,function = "gpio";
-			};
-			pmx_led_hdderr0: pmx-led-hdderr0 {
-				marvell,pins = "mpp34";
-				marvell,function = "gpio";
-			};
-			pmx_led_hdderr1: pmx-led-hdderr1 {
-				marvell,pins = "mpp35";
-				marvell,function = "gpio";
-			};
-			pmx_led_alarm: pmx-led-alarm {
-				marvell,pins = "mpp36";
-				marvell,function = "gpio";
-			};
-			pmx_led_function_red: pmx-led-function-red {
-				marvell,pins = "mpp37";
-				marvell,function = "gpio";
-			};
-			pmx_led_info: pmx-led-info {
-				marvell,pins = "mpp38";
-				marvell,function = "gpio";
-			};
-			pmx_led_function_blue: pmx-led-function-blue {
-				marvell,pins = "mpp39";
-				marvell,function = "gpio";
-			};
-			pmx_led_power: pmx-led-power {
-				marvell,pins = "mpp40";
-				marvell,function = "gpio";
-			};
-			pmx_fan_lock: pmx-fan-lock {
-				marvell,pins = "mpp43";
-				marvell,function = "gpio";
-			};
-			pmx_button_function: pmx-button-function {
-				marvell,pins = "mpp45";
-				marvell,function = "gpio";
-			};
-			pmx_power_switch: pmx-power-switch {
-				marvell,pins = "mpp46";
-				marvell,function = "gpio";
-			};
-			pmx_power_auto_switch: pmx-power-auto-switch {
-				marvell,pins = "mpp47";
-				marvell,function = "gpio";
-			};
-		};
-
-		serial at 12000 {
-			status = "okay";
-		};
-
-		sata at 80000 {
-			status = "okay";
-			nr-ports = <2>;
-		};
-
-		spi at 10600 {
-			status = "okay";
-
-			m25p40 at 0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "st,m25p40", "jedec,spi-nor";
-				reg = <0>;
-				spi-max-frequency = <25000000>;
-				mode = <0>;
-
-				partition at 0 {
-					reg = <0x0 0x60000>;
-					label = "uboot";
-					read-only;
-				};
-
-				partition at 60000 {
-					reg = <0x60000 0x10000>;
-					label = "dtb";
-					read-only;
-				};
-
-				partition at 70000 {
-					reg = <0x70000 0x10000>;
-					label = "uboot_env";
-				};
-			};
-		};
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&pmx_button_function &pmx_power_switch
-			     &pmx_power_auto_switch>;
-		pinctrl-names = "default";
-
-		button at 1 {
-			label = "Function Button";
-			linux,code = <KEY_OPTION>;
-			gpios = <&gpio0 45 GPIO_ACTIVE_LOW>;
-		};
-
-		button at 2 {
-			label = "Power-on Switch";
-			linux,code = <KEY_RESERVED>;
-			linux,input-type = <5>;
-			gpios = <&gpio0 46 GPIO_ACTIVE_LOW>;
-		};
-
-		button at 3 {
-			label = "Power-auto Switch";
-			linux,code = <KEY_ESC>;
-			linux,input-type = <5>;
-			gpios = <&gpio0 47 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	gpio_leds {
-		compatible = "gpio-leds";
-		pinctrl-0 = <&pmx_led_function_red &pmx_led_alarm
-			     &pmx_led_info &pmx_led_power
-			     &pmx_led_function_blue
-			     &pmx_led_hdderr0
-			     &pmx_led_hdderr1>;
-		pinctrl-names = "default";
-
-		led at 1 {
-			label = "lswvl:red:alarm";
-			gpios = <&gpio0 36 GPIO_ACTIVE_LOW>;
-		};
-
-		led at 2 {
-			label = "lswvl:red:func";
-			gpios = <&gpio0 37 GPIO_ACTIVE_LOW>;
-		};
-
-		led at 3 {
-			label = "lswvl:amber:info";
-			gpios = <&gpio0 38 GPIO_ACTIVE_LOW>;
-		};
-
-		led at 4 {
-			label = "lswvl:blue:func";
-			gpios = <&gpio0 39 GPIO_ACTIVE_LOW>;
-		};
-
-		led at 5 {
-			label = "lswvl:blue:power";
-			gpios = <&gpio0 40 GPIO_ACTIVE_LOW>;
-			default-state = "keep";
-		};
-
-		led at 6 {
-			label = "lswvl:red:hdderr0";
-			gpios = <&gpio0 34 GPIO_ACTIVE_LOW>;
-		};
-
-		led at 7 {
-			label = "lswvl:red:hdderr1";
-			gpios = <&gpio0 35 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	gpio_fan {
-		compatible = "gpio-fan";
-		pinctrl-0 = <&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
-		pinctrl-names = "default";
-
-		gpios = <&gpio0 17 GPIO_ACTIVE_LOW
-			 &gpio0 16 GPIO_ACTIVE_LOW>;
-
-		gpio-fan,speed-map = <0 3
-				1500 2
-				3250 1
-				5000 0>;
-
-		alarm-gpios = <&gpio0 43 GPIO_ACTIVE_HIGH>;
-	};
-
-	restart_poweroff {
-		compatible = "restart-poweroff";
-	};
-
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&pmx_power_hdd0 &pmx_power_hdd1 &pmx_usb_vbus>;
-		pinctrl-names = "default";
-
-		usb_power: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "USB Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
-		};
-		hdd_power0: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "HDD0 Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio0 8 GPIO_ACTIVE_HIGH>;
-		};
-		hdd_power1: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "HDD1 Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio0 9 GPIO_ACTIVE_HIGH>;
-		};
-	};
-};
-
-&mdio {
-	status = "okay";
-
-	ethphy0: ethernet-phy at 0 {
-		device_type = "ethernet-phy";
-		reg = <0>;
-	};
-};
-
-&eth0 {
-	status = "okay";
-
-	ethernet0-port at 0 {
-		phy-handle = <&ethphy0>;
-	};
-};
-- 
2.1.4
