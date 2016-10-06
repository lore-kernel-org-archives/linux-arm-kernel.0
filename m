From: paweljarosz3691@gmail.com (=?utf-8?B?UGF3ZcWC?= Jarosz)
Date: Thu, 6 Oct 2016 19:38:15 +0200
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Add rk3066 MK808 board
In-Reply-To: <cover.1475774981.git.paweljarosz3691@gmail.com>
References: <cover.1475774981.git.paweljarosz3691@gmail.com>
Message-ID: <b63a0ad452a487beb1d0c07addb9208cc3b3eeef.1475774981.git.paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MK808 is a tv stick which has rockchip rk3066 CPU inside, two usb ports
- host and otg, micro sd card slot and onboard wifi RK901.

Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
---

Changes in v2:
- included Heiko sugestion.

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3066a-mk808.dts                | 184 +++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-mk808.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 55f388f..c09595b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -17,6 +17,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
 
+- Rikomagic MK808 v1 board:
+    Required root node properties:
+      - compatible = "rikomagic,mk808", "rockchip,rk3066a";
+
 - Radxa Rock board:
     Required root node properties:
       - compatible = "radxa,rock", "rockchip,rk3188";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..f19cc1d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -639,6 +639,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3036-kylin.dtb \
 	rk3066a-bqcurie2.dtb \
 	rk3066a-marsboard.dtb \
+	rk3066a-mk808.dtb \
 	rk3066a-rayeager.dtb \
 	rk3188-radxarock.dtb \
 	rk3228-evb.dtb \
diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
new file mode 100644
index 0000000..2878562
--- /dev/null
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -0,0 +1,184 @@
+/*
+ * Copyright (c) 2016 Pawe? Jarosz <paweljarosz3691@gmail.com>
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
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "rk3066a.dtsi"
+
+/ {
+	model = "Rikomagic MK808";
+	compatible = "rikomagic,mk808", "rockchip,rk3066a";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory at 60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		blue {
+			label = "mk808:blue:power";
+			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "default-on";
+		};
+	};
+
+	mmc_pwrseq: mmc-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwr>;
+		reset-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_pwr>;
+		reset-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
+	};
+
+	vcc_io: vcc-io {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_io";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vcc_host: usb-host-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&host_drv>;
+		pinctrl-names = "default";
+		regulator-always-on;
+		regulator-name = "host-pwr";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_otg: usb-otg-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&otg_drv>;
+		pinctrl-names = "default";
+		regulator-always-on;
+		regulator-name = "vcc_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	mmc-pwrseq = <&mmc_pwrseq>;
+	num-slots = <1>;
+	status = "okay";
+	vmmc-supply = <&vcc_io>;
+};
+
+&mmc1 {
+	bus-width = <4>;
+	disable-wp;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	status = "okay";
+	vmmc-supply = <&vcc_io>;
+};
+
+&pinctrl {
+	usb-host {
+		host_drv: host-drv {
+			rockchip,pins = <RK_GPIO0 6 RK_FUNC_GPIO &pcfg_pull_default>;
+		};
+	};
+
+	usb-otg {
+		otg_drv: otg-drv {
+			rockchip,pins = <RK_GPIO0 5 RK_FUNC_GPIO &pcfg_pull_default>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <RK_GPIO3 7 RK_FUNC_GPIO &pcfg_pull_default>;
+		};
+	};
+
+	sdio {
+		wifi_pwr: wifi-pwr {
+			rockchip,pins = <RK_GPIO3 24 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
+
-- 
2.7.4
