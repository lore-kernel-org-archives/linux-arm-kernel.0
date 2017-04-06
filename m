From: w.egorov@phytec.de (Wadim Egorov)
Date: Thu, 6 Apr 2017 15:04:25 +0200
Subject: [PATCH v2 2/3] ARM: dts: rockchip: Add support for PCM-947 carrier
 board
In-Reply-To: <1491483866-18368-1-git-send-email-w.egorov@phytec.de>
References: <1491483866-18368-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1491483866-18368-2-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for the PCM-947 carrier board, a RK3288 based development
board made by PHYTEC. This board works in a combination with
the phyCORE-RK3288 System on Module.

Following interfaces and devices are available on the PCM-947 carrier board:

  - 2x UART
  - micro SDMMC
  - USB host and USB otg
  - USB 3503 HSIC hub
  - Ethernet
  - 2nd alternative KSZ9031 ethernet phy
  - Display connectors: PHYTEC LVDS, DDG LVDS, parallel signals, HDMI
  - Parallel Camera CIF
  - SGTL5000-32QFN audio codec
  - 4x LEDs connected via PCA9533
  - 2 user buttons
  - Expansion connectors for WiFi and other modules
  - RTC RV-4162-C7
  - Resistive touch STMPE811
  - EEPROM M24C32

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
Changes in v2:
- Added a dual license which is used for all rk3288 based boards.
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/rk3288-phycore-rdk.dts | 298 +++++++++++++++++++++++++++++++
 2 files changed, 299 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-phycore-rdk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0118084..8c3cb4d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -692,6 +692,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-firefly.dtb \
 	rk3288-firefly-reload.dtb \
 	rk3288-miqi.dtb \
+	rk3288-phycore-rdk.dtb \
 	rk3288-popmetal.dtb \
 	rk3288-r89.dtb \
 	rk3288-rock2-square.dtb \
diff --git a/arch/arm/boot/dts/rk3288-phycore-rdk.dts b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
new file mode 100644
index 0000000..870f96b
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
@@ -0,0 +1,298 @@
+/*
+ * Device tree file for Phytec PCM-947 carrier board
+ * Copyright (C) 2017 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>
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
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/leds-pca9532.h>
+#include "rk3288-phycore-som.dtsi"
+
+/ {
+	model = "Phytec RK3288 PCM-947";
+	compatible = "phytec,rk3288-pcm-947", "phytec,rk3288-phycore-som", "rockchip,rk3288";
+
+	user_buttons: user-buttons {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_button_pins>;
+
+		button at 0 {
+			label = "home";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpio8 0 GPIO_ACTIVE_HIGH>;
+			wakeup-source;
+		};
+
+		button at 1 {
+			label = "menu";
+			linux,code = <KEY_MENU>;
+			gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
+			wakeup-source;
+		};
+	};
+
+	vcc_host0_5v: usb-host0-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host0_vbus_drv>;
+		regulator-name = "vcc_host0_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&vdd_in_otg_out>;
+	};
+
+	vcc_host1_5v: usb-host1-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio2 0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host1_vbus_drv>;
+		regulator-name = "vcc_host1_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&vdd_in_otg_out>;
+	};
+
+	vcc_otg_5v: usb-otg-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		regulator-name = "vcc_otg_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&vdd_in_otg_out>;
+	};
+};
+
+&gmac {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	stmpe at 44 {
+		compatible = "st,stmpe811";
+		reg = <0x44>;
+	};
+
+	adc at 64 {
+		compatible = "maxim,max1037";
+		reg = <0x64>;
+	};
+
+	i2c_rtc: rtc at 68 {
+		compatible = "rv4162";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c_rtc_int>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <10 0>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c_eeprom_cb: eeprom at 51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	/* PCA9533 - 4-bit LED dimmer */
+	leddim: leddimmer at 62 {
+		compatible = "nxp,pca9533";
+		reg = <0x62>;
+
+		led1 {
+			label = "red:user1";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led2 {
+			label = "green:user2";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led3 {
+			label = "blue:user3";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led4 {
+			label = "red:user4";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&pinctrl {
+	pcfg_pull_up_drv_12ma: pcfg-pull-up-drv-12ma {
+		bias-pull-up;
+		drive-strength = <12>;
+	};
+
+	buttons {
+		user_button_pins: user-button-pins {
+			/* button 1 */
+			rockchip,pins = <8 3 RK_FUNC_GPIO &pcfg_pull_up>,
+			/* button 2 */
+					<8 0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	rv4162 {
+		i2c_rtc_int: i2c-rtc-int {
+			rockchip,pins = <5 10 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdmmc {
+		/*
+		 * Default drive strength isn't enough to achieve even
+		 * high-speed mode on pcm-947 board so bump up to 12 mA.
+		 */
+		sdmmc_bus4: sdmmc-bus4 {
+			rockchip,pins = <6 16 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
+					<6 17 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
+					<6 18 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
+					<6 19 RK_FUNC_1 &pcfg_pull_up_drv_12ma>;
+		};
+
+		sdmmc_clk: sdmmc-clk {
+			rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none_12ma>;
+		};
+
+		sdmmc_cmd: sdmmc-cmd {
+			rockchip,pins = <6 21 RK_FUNC_1 &pcfg_pull_up_drv_12ma>;
+		};
+
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	touchscreen {
+		ts_irq_pin: ts-irq-pin {
+			rockchip,pins = <5 15 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb_host {
+		host0_vbus_drv: host0-vbus-drv {
+			rockchip,pins = <2 13 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		host1_vbus_drv: host1-vbus-drv {
+			rockchip,pins = <2 0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb_otg {
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins = <2 12 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
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
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	vmmc-supply = <&vdd_io_sd>;
+	vqmmc-supply = <&vdd_io_sd>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
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
+};
+
+&usb_host1 {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
-- 
1.9.1
