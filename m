From: naobsd@gmail.com (FUKAUMI Naoki)
Date: Sun, 25 Jan 2015 21:39:35 +0900
Subject: [PATCH v4 2/3] ARM: dts: rockchip: add dts for Firefly Firefly-RK3288
 boards
In-Reply-To: <1422189576-19478-1-git-send-email-naobsd@gmail.com>
References: <1422189576-19478-1-git-send-email-naobsd@gmail.com>
Message-ID: <1422189576-19478-3-git-send-email-naobsd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for Firefly-RK3288, Rockchip RK3288 based development
boards made by Firefly.

There are 2 dts for 2 versions of the board. rk3288-firefly-beta.dts is
for the beta version, rk3288-firefly.dts is for the mass production version.

Signed-off-by: FUKAUMI Naoki <naobsd@gmail.com>
---

Changes in v4:
- revert wrong clock-* fixes in v3
- remove non-working tsadc
- remove spi2 which uses only clk and cs0 pins
- remove vqmmc-supply from sdmmc and keep vccio_sd 3.3V to make SD card works
- update gmac regulator properties to match with recent Romain Perier's change

Changes in v3:
- fix ordering more
- fix clock-* properties
- enable tsadc with clock-* properties

Changes in v2:
- use own compatible property for Firefly-RK3288 beta version
- remove disabled tsadc node
- fix ordering for the nodes without address element
- add commit messages

 arch/arm/boot/dts/Makefile                |   4 +-
 arch/arm/boot/dts/rk3288-firefly-beta.dts |  71 +++++
 arch/arm/boot/dts/rk3288-firefly.dts      |  71 +++++
 arch/arm/boot/dts/rk3288-firefly.dtsi     | 483 ++++++++++++++++++++++++++++++
 4 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-beta.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index add823d..f586bd5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -453,7 +453,9 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3066a-marsboard.dtb \
 	rk3188-radxarock.dtb \
 	rk3288-evb-act8846.dtb \
-	rk3288-evb-rk808.dtb
+	rk3288-evb-rk808.dtb \
+	rk3288-firefly-beta.dtb \
+	rk3288-firefly.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += \
 	s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_S3C64XX) += \
diff --git a/arch/arm/boot/dts/rk3288-firefly-beta.dts b/arch/arm/boot/dts/rk3288-firefly-beta.dts
new file mode 100644
index 0000000..75d77e3
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-firefly-beta.dts
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2014, 2015 FUKAUMI Naoki <naobsd@gmail.com>
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
+#include "rk3288-firefly.dtsi"
+
+/ {
+	model = "Firefly-RK3288 Beta";
+	compatible = "firefly,firefly-rk3288-beta", "rockchip,rk3288";
+};
+
+&ir {
+	gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+};
+
+&pinctrl {
+	act8846 {
+		pmic_vsel: pmic-vsel {
+			rockchip,pins = <7 1 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+	};
+
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <7 5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dts b/arch/arm/boot/dts/rk3288-firefly.dts
new file mode 100644
index 0000000..c07fe92
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-firefly.dts
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2014, 2015 FUKAUMI Naoki <naobsd@gmail.com>
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
+#include "rk3288-firefly.dtsi"
+
+/ {
+	model = "Firefly-RK3288";
+	compatible = "firefly,firefly-rk3288", "rockchip,rk3288";
+};
+
+&ir {
+	gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+};
+
+&pinctrl {
+	act8846 {
+		pmic_vsel: pmic-vsel {
+			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+	};
+
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <7 0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
new file mode 100644
index 0000000..ef6729b
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -0,0 +1,483 @@
+/*
+ * Copyright (c) 2014, 2015 FUKAUMI Naoki <naobsd@gmail.com>
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
+#include "rk3288.dtsi"
+
+/ {
+	memory {
+		reg = <0 0x80000000>;
+	};
+
+	ext_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "ext_gmac";
+	};
+
+	ir: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_int>;
+	};
+
+	keys: gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 0 {
+			gpio-key,wakeup = <1>;
+			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			label = "GPIO Power";
+			linux,code = <116>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwr_key>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		work {
+			gpios = <&gpio8 1 GPIO_ACTIVE_LOW>;
+			label = "firefly:blue:user";
+			linux,default-trigger = "rc-feedback";
+			pinctrl-names = "default";
+			pinctrl-0 = <&work_led>;
+		};
+
+		power {
+			gpios = <&gpio8 2 GPIO_ACTIVE_LOW>;
+			label = "firefly:green:power";
+			linux,default-trigger = "default-on";
+			pinctrl-names = "default";
+			pinctrl-0 = <&power_led>;
+		};
+	};
+
+	vcc_sys: vsys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_sd: sdmmc-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwr>;
+		regulator-name = "vcc_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_flash: flash-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_flash";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_5v: usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc_host_5v: usb-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-name = "vcc_host_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&vcc_5v>;
+	};
+
+	vcc_otg_5v: usb-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		regulator-name = "vcc_otg_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&vcc_5v>;
+	};
+};
+
+&cpu0 {
+	cpu0-supply = <&vdd_cpu>;
+};
+
+&emmc {
+	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_pwr>, <&emmc_bus8>;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vcc_flash>;
+	status = "okay";
+};
+
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&ext_gmac>;
+	clock_in_out = "input";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
+	phy-supply = <&vcc_lan>;
+	phy-mode = "rgmii";
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	tx_delay = <0x30>;
+	rx_delay = <0x10>;
+	status = "ok";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	vdd_cpu: syr827 at 40 {
+		compatible = "silergy,syr827";
+		fcs,suspend-voltage-selector = <1>;
+		reg = <0x40>;
+		regulator-name = "vdd_cpu";
+		regulator-min-microvolt = <850000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vdd_gpu: syr828 at 41 {
+		compatible = "silergy,syr828";
+		fcs,suspend-voltage-selector = <1>;
+		reg = <0x41>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <850000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	hym8563: hym8563 at 51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		interrupt-parent = <&gpio7>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_int>;
+	};
+
+	act8846: act8846 at 5a {
+		compatible = "active-semi,act8846";
+		reg = <0x5a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_vsel>, <&pwr_hold>;
+		system-power-controller;
+
+		regulators {
+			vcc_ddr: REG1 {
+				regulator-name = "vcc_ddr";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			vcc_io: REG2 {
+				regulator-name = "vcc_io";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_log: REG3 {
+				regulator-name = "vdd_log";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			vcc_20: REG4 {
+				regulator-name = "vcc_20";
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
+			};
+
+			vccio_sd: REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd10_lcd: REG6 {
+				regulator-name = "vdd10_lcd";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+			};
+
+			vcca_18: REG7 {
+				regulator-name = "vcca_18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			vcca_33: REG8 {
+				regulator-name = "vcca_33";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			vcc_lan: REG9 {
+				regulator-name = "vcc_lan";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			vdd_10: REG10 {
+				regulator-name = "vdd_10";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			vcc_18: REG11 {
+				regulator-name = "vcc_18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			vcc18_lcd: REG12 {
+				regulator-name = "vcc18_lcd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&pinctrl {
+	pcfg_output_high: pcfg-output-high {
+		output-high;
+	};
+
+	pcfg_output_low: pcfg-output-low {
+		output-low;
+	};
+
+	act8846 {
+		pwr_hold: pwr-hold {
+			rockchip,pins = <0 1 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+	};
+
+	gmac {
+		phy_int: phy-int {
+			rockchip,pins = <0 9 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		phy_pmeb: phy-pmeb {
+			rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		phy_rst: phy-rst {
+			rockchip,pins = <4 8 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+	};
+
+	hym8563 {
+		rtc_int: rtc-int {
+			rockchip,pins = <7 4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	keys {
+		pwr_key: pwr-key {
+			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		power_led: power-led {
+			rockchip,pins = <8 2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		work_led: work-led {
+			rockchip,pins = <8 1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb_host {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		usbhub_rst: usbhub-rst {
+			rockchip,pins = <8 3 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+	};
+
+	usb_otg {
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins = <0 12 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&saradc {
+	vref-supply = <&vcc_18>;
+	status = "okay";
+};
+
+&sdio0 {
+	broken-cd;
+	bus-width = <4>;
+	disable-wp;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
+	vmmc-supply = <&vcc_18>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	disable-wp;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
+	vmmc-supply = <&vcc_sd>;
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_clk>, <&spi0_cs0>, <&spi0_tx>, <&spi0_rx>, <&spi0_cs1>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usb_host1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usbhub_rst>;
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
2.2.2
