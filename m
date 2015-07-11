From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 11 Jul 2015 02:29:20 +0200
Subject: [PATCH 2/4] ARM: dts: rockchip: add shared rk3288-veyron files
In-Reply-To: <1436574562-16308-1-git-send-email-heiko@sntech.de>
References: <1436574562-16308-1-git-send-email-heiko@sntech.de>
Message-ID: <1436574562-16308-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandru M Stan <amstan@chromium.org>

This adds the shared devicetree files for the Veyron device family.
They are split, as not all veyron devices are chromebooks and
not all contain a sd-card slot.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 234 ++++++++++
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi      | 122 +++++
 arch/arm/boot/dts/rk3288-veyron.dtsi            | 583 ++++++++++++++++++++++++
 3 files changed, 939 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron.dtsi

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
new file mode 100644
index 0000000..5a8f44a
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -0,0 +1,234 @@
+/*
+ * Google Veyron (and derivatives) board device tree source
+ * Chromebook specific parts
+ *
+ * Copyright 2015 Google, Inc
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
+ *  Or, alternatively,
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
+#include <dt-bindings/clock/rockchip,rk808.h>
+#include <dt-bindings/input/input.h>
+#include "rk3288-veyron.dtsi"
+#include "rk3288-veyron-sdmmc.dtsi"
+
+/ {
+	aliases {
+		/* Assign 20 so we don't get confused w/ builtin ones */
+		i2c20 = &i2c_tunnel;
+	};
+
+	gpio-charger {
+		compatible = "gpio-charger";
+		charger-type = "mains";
+		gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ac_present_ap>;
+	};
+
+	/* A non-regulated voltage from power supply or battery */
+	vccsys: vccsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vccsys";
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc33_sys: vcc33-sys {
+		vin-supply = <&vccsys>;
+	};
+
+	vcc_5v: vcc-5v {
+		vin-supply = <&vccsys>;
+	};
+
+	/* This turns on vbus for host1 (dwc2) */
+	vcc5_host1: vcc5-host1-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host1_pwr_en>;
+		regulator-name = "vcc5_host1";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* This turns on vbus for otg for host mode (dwc2) */
+	vcc5v_otg: vcc5v-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbotg_pwren_h>;
+		regulator-name = "vcc5_host2";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&gpio_keys {
+	pinctrl-0 = <&pwr_key_l &ap_lid_int_l>;
+	lid {
+		label = "Lid";
+		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+		gpio-key,wakeup;
+		linux,code = <0>; /* SW_LID */
+		linux,input-type = <5>; /* EV_SW */
+		debounce-interval = <1>;
+	};
+};
+
+&rk808 {
+	vcc11-supply = <&vcc_5v>;
+
+	regulators {
+		vcc33_ccd: LDO_REG8 {
+			regulator-name = "vcc33_ccd";
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-suspend-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&spi0 {
+	status = "okay";
+
+	cros_ec: ec at 0 {
+		compatible = "google,cros-ec-spi";
+		reg = <0>;
+		google,cros-ec-spi-pre-delay = <30>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ec_int>;
+		spi-max-frequency = <3000000>;
+
+		i2c_tunnel: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			google,remote-bus = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c4 {
+	trackpad at 15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_int>;
+		vcc-supply = <&vcc33_io>;
+		wakeup-source;
+	};
+};
+
+&pinctrl {
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&global_pwroff
+
+		/* Wake only */
+		&suspend_l_wake
+		&bt_dev_wake_awake
+	>;
+	pinctrl-1 = <
+		/* Common for sleep and wake, but no owners */
+		&global_pwroff
+
+		/* Sleep only */
+		&suspend_l_sleep
+		&bt_dev_wake_sleep
+	>;
+
+	buttons {
+		ap_lid_int_l: ap-lid-int-l {
+			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	charger {
+		ac_present_ap: ac-present-ap {
+			rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	cros-ec {
+		ec_int: ec-int {
+			rockchip,pins = <7 7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	suspend {
+		suspend_l_wake: suspend-l-wake {
+			rockchip,pins = <0 17 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+
+		suspend_l_sleep: suspend-l-sleep {
+			rockchip,pins = <0 17 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+	};
+
+	trackpad {
+		trackpad_int: trackpad-int {
+			rockchip,pins = <7 3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb-host {
+		host1_pwr_en: host1-pwr-en {
+			rockchip,pins = <0 11 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		usbotg_pwren_h: usbotg-pwren-h {
+			rockchip,pins = <0 12 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+#include "cros-ec-keyboard.dtsi"
diff --git a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
new file mode 100644
index 0000000..788468a
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
@@ -0,0 +1,122 @@
+/*
+ * Google Veyron (and derivatives) fragment for sdmmc cards
+ *
+ * Copyright 2015 Google, Inc
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
+ *  Or, alternatively,
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
+&io_domains {
+	sdcard-supply = <&vccio_sd>;
+};
+
+&pinctrl {
+	sdmmc {
+		/*
+		 * We run sdmmc at max speed; bump up drive strength.
+		 * We also have external pulls, so disable the internal ones.
+		 */
+		sdmmc_bus4: sdmmc-bus4 {
+			rockchip,pins = <6 16 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
+					<6 17 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
+					<6 18 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
+					<6 19 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
+		};
+
+		sdmmc_clk: sdmmc-clk {
+			rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
+		};
+
+		sdmmc_cmd: sdmmc-cmd {
+			rockchip,pins = <6 21 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
+		};
+
+		/*
+		 * Builtin CD line is hooked to ground to prevent JTAG at boot
+		 * (and also to get the voltage rail correct).
+		 * Configure gpio6_C6 as GPIO so dw_mmc builtin CD doesn't
+		 * think there's a card inserted
+		 */
+		sdmmc_cd_disabled: sdmmc-cd-disabled {
+			rockchip,pins = <6 22 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		/* This is where we actually hook up CD */
+		sdmmc_cd_gpio: sdmmc-cd-gpio {
+			rockchip,pins = <7 5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&rk808 {
+	vcc9-supply = <&vcc_5v>;
+
+	regulators {
+		vccio_sd: LDO_REG4 {
+			regulator-name = "vccio_sd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
+		};
+
+		vcc33_sd: LDO_REG5 {
+			regulator-name = "vcc33_sd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
+		};
+	};
+};
+
+&sdmmc {
+	status = "okay";
+
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	cd-gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+	num-slots = <1>;
+	vmmc-supply = <&vcc33_sd>;
+	vqmmc-supply = <&vccio_sd>;
+};
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
new file mode 100644
index 0000000..627d113
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -0,0 +1,583 @@
+/*
+ * Google Veyron (and derivatives) board device tree source
+ *
+ * Copyright 2015 Google, Inc
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
+ *  Or, alternatively,
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
+#include <dt-bindings/clock/rockchip,rk808.h>
+#include <dt-bindings/input/input.h>
+#include "rk3288.dtsi"
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_key_l>;
+		power {
+			label = "Power";
+			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			debounce-interval = <100>;
+			gpio-key,wakeup;
+		};
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ap_warm_reset_h>;
+		priority = /bits/ 8 <200>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-0 = <&emmc_reset>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
+	};
+
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		bb-supply = <&vcc33_io>;
+		dvp-supply = <&vcc_18>;
+		flash0-supply = <&vcc18_flashio>;
+		gpio1830-supply = <&vcc33_io>;
+		gpio30-supply = <&vcc33_io>;
+		lcdc-supply = <&vcc33_lcd>;
+		wifi-supply = <&vcc18_wl>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk808 RK808_CLKOUT1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_enable_l>, <&wifi_enable_h>;
+
+		/*
+		 * On the module itself this is one of these (depending
+		 * on the actual card populated):
+		 * - SDIO_RESET_L_WL_REG_ON
+		 * - PDN (power down when low)
+		 */
+		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+	};
+
+	vcc_5v: vcc-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc33_sys: vcc33-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc33_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vcc50_hdmi: vcc50-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc50_hdmi";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_5v>;
+	};
+};
+
+&cpu0 {
+	cpu0-supply = <&vdd_cpu>;
+};
+
+&emmc {
+	status = "okay";
+
+	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	i2c-scl-falling-time-ns = <50>;		/* 2.5ns measured */
+	i2c-scl-rising-time-ns = <100>;		/* 45ns measured */
+
+	rk808: pmic at 1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		clock-output-names = "xin32k", "wifibt_32kin";
+		interrupt-parent = <&gpio0>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+
+		vcc1-supply = <&vcc33_sys>;
+		vcc2-supply = <&vcc33_sys>;
+		vcc3-supply = <&vcc33_sys>;
+		vcc4-supply = <&vcc33_sys>;
+		vcc6-supply = <&vcc_5v>;
+		vcc7-supply = <&vcc33_sys>;
+		vcc8-supply = <&vcc33_sys>;
+		vcc12-supply = <&vcc_18>;
+		vddio-supply = <&vcc33_io>;
+
+		regulators {
+			vdd_cpu: DCDC_REG1 {
+				regulator-name = "vdd_arm";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1450000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc135_ddr: DCDC_REG3 {
+				regulator-name = "vcc135_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			/*
+			 * vcc_18 has several aliases.  (vcc18_flashio and
+			 * vcc18_wl).  We'll add those aliases here just to
+			 * make it easier to follow the schematic.  The signals
+			 * are actually hooked together and only separated for
+			 * power measurement purposes).
+			 */
+			vcc18_wl: vcc18_flashio: vcc_18: DCDC_REG4 {
+				regulator-name = "vcc_18";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			/*
+			 * Note that both vcc33_io and vcc33_pmuio are always
+			 * powered together. To simplify the logic in the dts
+			 * we just refer to vcc33_io every time something is
+			 * powered from vcc33_pmuio. In fact, on later boards
+			 * (such as danger) they're the same net.
+			 */
+			vcc33_io: LDO_REG1 {
+				regulator-name = "vcc33_io";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vdd_10: LDO_REG3 {
+				regulator-name = "vdd_10";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vdd10_lcd_pwren_h: LDO_REG7 {
+				regulator-name = "vdd10_lcd_pwren_h";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc33_lcd: SWITCH_REG1 {
+				regulator-name = "vcc33_lcd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	i2c-scl-falling-time-ns = <50>;		/* 2.5ns measured */
+	i2c-scl-rising-time-ns = <100>;		/* 40ns measured */
+
+	tpm: tpm at 20 {
+		compatible = "infineon,slb9645tt";
+		reg = <0x20>;
+		powered-while-suspended;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	/* 100kHz since 4.7k resistors don't rise fast enough */
+	clock-frequency = <100000>;
+	i2c-scl-falling-time-ns = <50>;		/* 10ns measured */
+	i2c-scl-rising-time-ns = <800>;		/* 600ns measured */
+};
+
+&i2c4 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	i2c-scl-falling-time-ns = <50>;		/* 11ns measured */
+	i2c-scl-rising-time-ns = <300>;		/* 225ns measured */
+};
+
+&i2c5 {
+	status = "okay";
+
+	clock-frequency = <100000>;
+	i2c-scl-falling-time-ns = <300>;
+	i2c-scl-rising-time-ns = <1000>;
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&sdio0 {
+	status = "okay";
+
+	broken-cd;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_clk &sdio0_cmd &sdio0_bus4>;
+	vmmc-supply = <&vcc33_sys>;
+	vqmmc-supply = <&vcc18_wl>;
+};
+
+&spi2 {
+	status = "okay";
+
+	rx-sample-delay-ns = <12>;
+};
+
+&tsadc {
+	status = "okay";
+
+	tsadc-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
+	tsadc-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
+};
+
+&uart0 {
+	status = "okay";
+
+	/* We need to go faster than 24MHz, so adjust clock parents / rates */
+	assigned-clocks = <&cru SCLK_UART0>;
+	assigned-clock-rates = <48000000>;
+
+	/* Pins don't include flow control by default; add that in */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
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
+&usbphy {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+
+	needs-reset-on-resume;
+};
+
+&usb_host1 {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+
+	assigned-clocks = <&cru SCLK_USBPHY480M_SRC>;
+	assigned-clock-parents = <&cru SCLK_OTGPHY0>;
+	dr_mode = "host";
+};
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&global_pwroff
+
+		/* Wake only */
+		&bt_dev_wake_awake
+	>;
+	pinctrl-1 = <
+		/* Common for sleep and wake, but no owners */
+		&global_pwroff
+
+		/* Sleep only */
+		&bt_dev_wake_sleep
+	>;
+
+	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
+		bias-disable;
+		drive-strength = <8>;
+	};
+
+	pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
+		bias-pull-up;
+		drive-strength = <8>;
+	};
+
+	pcfg_output_high: pcfg-output-high {
+		output-high;
+	};
+
+	pcfg_output_low: pcfg-output-low {
+		output-low;
+	};
+
+	buttons {
+		pwr_key_l: pwr-key-l {
+			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	emmc {
+		emmc_reset: emmc-reset {
+			rockchip,pins = <2 9 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		/*
+		 * We run eMMC at max speed; bump up drive strength.
+		 * We also have external pulls, so disable the internal ones.
+		 */
+		emmc_clk: emmc-clk {
+			rockchip,pins = <3 18 RK_FUNC_2 &pcfg_pull_none_drv_8ma>;
+		};
+
+		emmc_cmd: emmc-cmd {
+			rockchip,pins = <3 16 RK_FUNC_2 &pcfg_pull_none_drv_8ma>;
+		};
+
+		emmc_bus8: emmc-bus8 {
+			rockchip,pins = <3 0 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
+					<3 1 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
+					<3 2 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
+					<3 3 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
+					<3 4 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
+					<3 5 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
+					<3 6 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
+					<3 7 RK_FUNC_2 &pcfg_pull_none_drv_8ma>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	reboot {
+		ap_warm_reset_h: ap-warm-reset-h {
+			rockchip,pins = <RK_GPIO0 13 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	recovery-switch {
+		rec_mode_l: rec-mode-l {
+			rockchip,pins = <0 9 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdio0 {
+		wifi_enable_h: wifienable-h {
+			rockchip,pins = <4 28 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		/* NOTE: mislabelled on schematic; should be bt_enable_h */
+		bt_enable_l: bt-enable-l {
+			rockchip,pins = <4 29 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		/*
+		 * We run sdio0 at max speed; bump up drive strength.
+		 * We also have external pulls, so disable the internal ones.
+		 */
+		sdio0_bus4: sdio0-bus4 {
+			rockchip,pins = <4 20 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
+					<4 21 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
+					<4 22 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
+					<4 23 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
+		};
+
+		sdio0_cmd: sdio0-cmd {
+			rockchip,pins = <4 24 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
+		};
+
+		sdio0_clk: sdio0-clk {
+			rockchip,pins = <4 25 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
+		};
+
+		/*
+		 * These pins are only present on very new veyron boards; on
+		 * older boards bt_dev_wake is simply always high.  Note that
+		 * gpio4_26 is a NC on old veyron boards, so it doesn't hurt
+		 * to map this pin everywhere
+		 */
+		bt_dev_wake_sleep: bt-dev-wake-sleep {
+			rockchip,pins = <4 26 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+
+		bt_dev_wake_awake: bt-dev-wake-awake {
+			rockchip,pins = <4 26 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+	};
+
+	tpm {
+		tpm_int_h: tpm-int-h {
+			rockchip,pins = <7 4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	/*
+	 * On Marvell-based hardware this is a no-connect.  Make sure we enable
+	 * the pullup so that the line doesn't float.  The pullup shouldn't
+	 * hurt on Broadcom-based hardware since the other side is actively
+	 * driving this signal.  As proof: we've already got a pullup on RX.
+	 */
+	uart0 {
+		uart0_cts: uart0-cts {
+			rockchip,pins = <4 18 RK_FUNC_1 &pcfg_pull_up>;
+		};
+	};
+
+	write-protect {
+		fw_wp_ap: fw-wp-ap {
+			rockchip,pins = <7 6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
-- 
2.1.4
