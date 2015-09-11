From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sat, 12 Sep 2015 00:36:45 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add dtb for the Radxa Rock 2 Square
 board
In-Reply-To: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1442011005-4828-2-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Radxa Rock 2 Square board is a combination of the Radxa Rock 2 SoM
with the Square baseboard. Add a dtsi for the SoM which can be included
into the dts for the various baseboards (e.g. full and square) and a dts
for the square board.

Currently supported are serial console, wired networking, hdmi output
and USB.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/rk3288-rock2-som.dtsi   | 267 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-rock2-square.dts | 164 ++++++++++++++++++
 3 files changed, 432 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-rock2-som.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-rock2-square.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 233159d..1ed8ec1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -507,6 +507,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-firefly-beta.dtb \
 	rk3288-firefly.dtb \
 	rk3288-r89.dtb \
+	rk3288-rock2-square.dtb \
 	rk3288-veyron-jerry.dtb \
 	rk3288-veyron-minnie.dtb \
 	rk3288-veyron-pinky.dtb \
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
new file mode 100644
index 0000000..01e69e8
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -0,0 +1,267 @@
+/*
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
+#include <dt-bindings/pwm/pwm.h>
+#include "rk3288.dtsi"
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+
+	ext_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "ext_gmac";
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
+};
+
+&cpu0 {
+	cpu0-supply = <&vdd_cpu>;
+};
+
+
+&emmc {
+	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
+	vmmc-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&ext_gmac>;
+	clock_in_out = "input";
+	phy-mode = "rgmii";
+	phy-supply = <&vccio_pmu>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins &phy_rst>;
+	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 30000>;
+	rx_delay = <0x10>;
+	tx_delay = <0x30>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	act8846: act8846 at 5a {
+		compatible = "active-semi,act8846";
+		reg = <0x5a>;
+		inl1-supply = <&vcc_io>;
+		inl2-supply = <&vcc_sys>;
+		inl3-supply = <&vcc_20>;
+		vp1-supply = <&vcc_sys>;
+		vp2-supply = <&vcc_sys>;
+		vp3-supply = <&vcc_sys>;
+		vp4-supply = <&vcc_sys>;
+		status = "okay";
+
+		regulators {
+			vcc_ddr: REG1 {
+				regulator-name = "VCC_DDR";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			vcc_io: REG2 {
+				regulator-name = "VCC_IO";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_log: REG3 {
+				regulator-name = "VDD_LOG";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			vcc_20: REG4 {
+				regulator-name = "VCC_20";
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
+			};
+
+			vccio_sd: REG5 {
+				regulator-name = "VCCIO_SD";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd10_lcd: REG6 {
+				regulator-name = "VDD10_LCD";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			vcca_codec: REG7 {
+				regulator-name = "VCCA_CODEC";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vcca_tp: REG8 {
+				regulator-name = "VCCA_TP";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vccio_pmu: REG9 {
+				regulator-name = "VCCIO_PMU";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_10: REG10 {
+				regulator-name = "VDD_10";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			vcc_18: REG11 {
+				regulator-name = "VCC_18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			vcc18_lcd: REG12 {
+				regulator-name = "VCC18_LCD";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	vdd_cpu: syr827 at 40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-enable-ramp-delay = <300>;
+		regulator-name = "vdd_cpu";
+		regulator-min-microvolt = <850000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-ramp-delay = <8000>;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vdd_gpu: syr828 at 41 {
+		compatible = "silergy,syr828";
+		reg = <0x41>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-always-on;
+		regulator-enable-ramp-delay = <300>;
+		regulator-min-microvolt = <850000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-name = "vdd_gpu";
+		regulator-ramp-delay = <8000>;
+		vin-supply = <&vcc_sys>;
+	};
+};
+
+&wdt {
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
+	status = "okay";
+};
+
+&pinctrl {
+	pcfg_output_high: pcfg-output-high {
+		output-high;
+	};
+
+	gmac {
+		phy_rst: phy-rst {
+			rockchip,pins = <RK_GPIO4 8 RK_FUNC_GPIO  &pcfg_output_high>;
+		};
+	};
+};
+
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
new file mode 100644
index 0000000..42b72bb
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -0,0 +1,164 @@
+/*
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
+#include "rk3288-rock2-som.dtsi"
+
+/ {
+	model = "Radxa Rock 2 Square";
+	compatible = "rockchip,rk3288-rock2-square", "rockchip,rk3288";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	vcc_usb_host: vcc-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		/* Always on as the rockchip usb phy doesn't have a vbus-supply
+		 * property */
+		regulator-always-on;
+		regulator-name = "vcc_host";
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
+		vin-supply = <&vcc_io>;
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	disable-wp;	/* wp not hooked up */
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&gmac {
+	status = "ok";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c5>;
+	status = "okay";
+};
+
+&i2c0 {
+	hym8563 at 51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		interrupt-parent = <&gpio0>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&pinctrl {
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins = <RK_GPIO0 14 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <RK_GPIO7 11 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
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
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
-- 
2.5.1
