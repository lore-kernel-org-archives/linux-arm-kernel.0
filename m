From: stefan@agner.ch (Stefan Agner)
Date: Tue,  7 Jun 2016 19:37:09 -0700
Subject: [PATCH 3/3] ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D support
In-Reply-To: <20160608023709.32090-1-stefan@agner.ch>
References: <20160608023709.32090-1-stefan@agner.ch>
Message-ID: <20160608023709.32090-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Computer on Module Colibri iMX7S/iMX7D along
with the development/evaluation carrier board device trees. Follow
the usual hierarchic include model, maintaining shared configuration
in imx7-colibri.dtsi and imx7-colibri-eval-v3.dtsi respectively.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/Makefile                  |   4 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 149 ++++++++
 arch/arm/boot/dts/imx7-colibri.dtsi         | 568 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts |  66 ++++
 arch/arm/boot/dts/imx7d-colibri.dtsi        |  54 +++
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts |  51 +++
 arch/arm/boot/dts/imx7s-colibri.dtsi        |  50 +++
 7 files changed, 941 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 06b6c2d..3bb6c14 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -399,9 +399,11 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-mainboard.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
+	imx7d-colibri-eval-v3.dtb \
 	imx7d-nitrogen7.dtb \
 	imx7d-sbc-imx7.dtb \
-	imx7d-sdb.dtb
+	imx7d-sdb.dtb \
+	imx7s-colibri-eval-v3.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-qds.dtb \
 	ls1021a-twr.dtb
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
new file mode 100644
index 0000000..29744c3
--- /dev/null
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -0,0 +1,149 @@
+/*
+ * Copyright 2016 Toradex AG
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
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&bl {
+	brightness-levels = <0 4 8 16 32 64 128 255>;
+	default-brightness-level = <6>;
+	status = "okay";
+};
+
+&adc1 {
+	status = "okay";
+};
+
+&adc2 {
+	status = "okay";
+};
+
+&fec1 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc: m41t0m6 at 68 {
+		compatible = "st,m41t00";
+		reg = <0x68>;
+	};
+};
+
+&lcdif {
+	status = "okay";
+	display = <&display0>;
+
+	display0: lcd-display {
+		bits-per-pixel = <16>;
+		bus-width = <18>;
+
+		display-timings {
+			native-mode = <&timing_vga>;
+
+			/* Standard VGA timing */
+			timing_vga: 640x480 {
+				clock-frequency = <25175000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <40>;
+				hfront-porch = <24>;
+				vback-porch = <32>;
+				vfront-porch = <11>;
+				hsync-len = <96>;
+				vsync-len = <2>;
+				de-active = <1>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
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
+&usbotg1 {
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
+	no-1-8-v;
+	cd-gpios = <&gpio1 0 0>;
+	enable-sdio-wakeup;
+	fsl,tuning-step = <2>;
+	keep-power-in-suspend;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
new file mode 100644
index 0000000..4afa545
--- /dev/null
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -0,0 +1,568 @@
+/*
+ * Copyright 2016 Toradex AG
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
+/ {
+	bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_vref_1v8: regulator-vref-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+};
+
+&adc2 {
+	vref-supply = <&reg_vref_1v8>;
+};
+
+&cpu0 {
+	arm-supply = <&reg_DCDC2>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+		<&clks IMX7D_ENET_AXI_ROOT_CLK>,
+		<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
+		<&clks IMX7D_PLL_ENET_MAIN_50M_CLK>;
+	clock-names = "ipg", "ahb", "ptp", "enet_clk_ref";
+
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rmii";
+	phy-supply = <&reg_LDO1>;
+	fsl,magic-packet;
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1 &pinctrl_i2c1_int>;
+	status = "okay";
+
+	ad7879 at 2c {
+		compatible = "adi,ad7879-1";
+		reg = <0x2c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-max-pressure = <4096>;
+		adi,resistance-plate-x = <120>;
+		adi,first-conversion-delay = /bits/ 8 <3>;
+		adi,acquisition-time = /bits/ 8 <1>;
+		adi,median-filter-size = /bits/ 8 <2>;
+		adi,averaging = /bits/ 8 <1>;
+		adi,conversion-interval = /bits/ 8 <255>;
+	};
+
+	pmic at 33 {
+		compatible = "ricoh,rn5t567";
+		reg = <0x33>;
+
+		regulators {
+			reg_DCDC1: DCDC1 {  /* V1.0_SOC */
+				regulator-min-microvolt =  <975000>;
+				regulator-max-microvolt = <1125000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_DCDC2: DCDC2 { /* V1.1_ARM */
+				regulator-min-microvolt =  <975000>;
+				regulator-max-microvolt = <1125000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_DCDC3: DCDC3 { /* V1.8 */
+				regulator-min-microvolt = <1775000>;
+				regulator-max-microvolt = <1825000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_DCDC4: DCDC4 { /* V1.35_DRAM */
+				regulator-min-microvolt = <1325000>;
+				regulator-max-microvolt = <1375000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_LDO1: LDO1 { /* PWR_EN_+V3.3_ETH */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			reg_LDO2: LDO2 { /* +V1.8_SD */
+				regulator-min-microvolt = <1775000>;
+				regulator-max-microvolt = <3325000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_LDO3: LDO3 { /* PWR_EN_+V3.3_LPSR */
+				regulator-min-microvolt = <3275000>;
+				regulator-max-microvolt = <3325000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_LDO4: LDO4 { /* V1.8_LPSR */
+				regulator-min-microvolt = <1775000>;
+				regulator-max-microvolt = <1825000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_LDO5: LDO5 { /* PWR_EN_+V3.3 */
+				regulator-min-microvolt = <1775000>;
+				regulator-max-microvolt = <1825000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+};
+
+&snvs_pwrkey {
+	status = "disabled";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_ctrl1 &pinctrl_uart1_ctrl2>;
+	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	fsl,uart-has-rtscts;
+	fsl,dte-mode;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	fsl,uart-has-rtscts;
+	fsl,dte-mode;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	fsl,dte-mode;
+};
+
+&usbotg1 {
+	dr_mode = "host";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4>;
+
+	pinctrl_gpio1: gpio1-grp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3	0x14 /* SODIMM 55 */
+			MX7D_PAD_ENET1_RGMII_RD2__GPIO7_IO2	0x14 /* SODIMM 63 */
+			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0X14 /* SODIMM 73 */
+			MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0X14 /* SODIMM 77 */
+			MX7D_PAD_EPDC_DATA09__GPIO2_IO9		0x14 /* SODIMM 89 */
+			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x14 /* SODIMM 91 */
+			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14 /* SODIMM 93 */
+			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14 /* SODIMM 95 */
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x14 /* SODIMM 99 */
+			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x14 /* SODIMM 105 */
+			MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x14 /* SODIMM 107 */
+			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14 /* SODIMM 111 */
+			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14 /* SODIMM 113 */
+			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x14 /* SODIMM 115 */
+			MX7D_PAD_EPDC_DATA03__GPIO2_IO3		0x14 /* SODIMM 117 */
+			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x14 /* SODIMM 119 */
+			MX7D_PAD_EPDC_DATA05__GPIO2_IO5		0x14 /* SODIMM 121 */
+			MX7D_PAD_EPDC_DATA06__GPIO2_IO6		0x14 /* SODIMM 123 */
+			MX7D_PAD_EPDC_DATA07__GPIO2_IO7		0x14 /* SODIMM 125 */
+			MX7D_PAD_EPDC_SDCE2__GPIO2_IO22		0x14 /* SODIMM 127 */
+			MX7D_PAD_UART3_RTS_B__GPIO4_IO6		0x14 /* SODIMM 131 */
+			MX7D_PAD_EPDC_GDRL__GPIO2_IO26		0x14 /* SODIMM 133 */
+			MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x14 /* SODIMM 24 */
+			MX7D_PAD_SD2_DATA2__GPIO5_IO16		0x14 /* SODIMM 100 */
+			MX7D_PAD_SD2_DATA3__GPIO5_IO17		0x14 /* SODIMM 102 */
+			MX7D_PAD_EPDC_GDSP__GPIO2_IO27		0x14 /* SODIMM 104 */
+			MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x14 /* SODIMM 106 */
+			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x14 /* SODIMM 110 */
+			MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30	0x14 /* SODIMM 112 */
+			MX7D_PAD_EPDC_SDCLK__GPIO2_IO16		0x14 /* SODIMM 114 */
+			MX7D_PAD_EPDC_SDLE__GPIO2_IO17		0x14 /* SODIMM 116 */
+			MX7D_PAD_EPDC_SDOE__GPIO2_IO18		0x14 /* SODIMM 118 */
+			MX7D_PAD_EPDC_SDSHR__GPIO2_IO19		0x14 /* SODIMM 120 */
+			MX7D_PAD_EPDC_SDCE0__GPIO2_IO20		0x14 /* SODIMM 122 */
+			MX7D_PAD_EPDC_SDCE1__GPIO2_IO21		0x14 /* SODIMM 124 */
+			MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x14 /* SODIMM 126 */
+			MX7D_PAD_EPDC_PWR_STAT__GPIO2_IO31	0x14 /* SODIMM 128 */
+			MX7D_PAD_EPDC_SDCE3__GPIO2_IO23		0x14 /* SODIMM 130 */
+			MX7D_PAD_EPDC_GDCLK__GPIO2_IO24		0x14 /* SODIMM 132 */
+			MX7D_PAD_EPDC_GDOE__GPIO2_IO25		0x14 /* SODIMM 134 */
+			MX7D_PAD_EPDC_DATA12__GPIO2_IO12	0x14 /* SODIMM 150 */
+			MX7D_PAD_EPDC_DATA11__GPIO2_IO11	0x14 /* SODIMM 152 */
+			MX7D_PAD_SD2_CLK__GPIO5_IO12		0x14 /* SODIMM 184 */
+			MX7D_PAD_SD2_CMD__GPIO5_IO13		0x14 /* SODIMM 186 */
+		>;
+	};
+
+	pinctrl_gpio2: gpio2-grp { /* On X22 Camera interface */
+		fsl,pins = <
+			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x14 /* SODIMM 65 */
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x14 /* SODIMM 69 */
+			MX7D_PAD_SD1_WP__GPIO5_IO1		0x14 /* SODIMM 71 */
+			MX7D_PAD_I2C4_SDA__GPIO4_IO15		0x14 /* SODIMM 75 */
+			MX7D_PAD_ECSPI1_MISO__GPIO4_IO18	0x14 /* SODIMM 79 */
+			MX7D_PAD_I2C3_SCL__GPIO4_IO12		0x14 /* SODIMM 81 */
+			MX7D_PAD_ECSPI2_MISO__GPIO4_IO22	0x14 /* SODIMM 85 */
+			MX7D_PAD_ECSPI1_SS0__GPIO4_IO19		0x14 /* SODIMM 97 */
+			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x14 /* SODIMM 101 */
+			MX7D_PAD_ECSPI1_MOSI__GPIO4_IO17	0x14 /* SODIMM 103 */
+			MX7D_PAD_I2C3_SDA__GPIO4_IO13		0x14 /* SODIMM 94 */
+			MX7D_PAD_I2C4_SCL__GPIO4_IO14		0x14 /* SODIMM 96 */
+			MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x14 /* SODIMM 98 */
+		>;
+	};
+
+	pinctrl_gpio3: gpio3-grp { /* LCD 18-23 */
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA18__GPIO3_IO23		0x14 /* SODIMM 136 */
+			MX7D_PAD_LCD_DATA19__GPIO3_IO24		0x14 /* SODIMM 138 */
+			MX7D_PAD_LCD_DATA20__GPIO3_IO25		0x14 /* SODIMM 140 */
+			MX7D_PAD_LCD_DATA21__GPIO3_IO26		0x14 /* SODIMM 142 */
+			MX7D_PAD_LCD_DATA22__GPIO3_IO27		0x14 /* SODIMM 146 */
+			MX7D_PAD_LCD_DATA23__GPIO3_IO28		0x14 /* SODIMM 148 */
+		>;
+	};
+
+	pinctrl_gpio4: gpio4-grp { /* Alternatively CAN2 */
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO15__GPIO1_IO15		0x14 /* SODIMM 178 */
+			MX7D_PAD_GPIO1_IO14__GPIO1_IO14		0x14 /* SODIMM 188 */
+		>;
+	};
+
+	pinctrl_i2c1_int: i2c1-int-grp { /* PMIC / TOUCH */
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x79
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_CRS__GPIO7_IO14			0x14
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x73
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x73
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x73
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RX_ER		0x73
+
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x73
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x73
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x73
+			MX7D_PAD_GPIO1_IO12__CCM_ENET_REF_CLK1		0x73
+			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
+			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
+		>;
+	};
+
+	pinctrl_ecspi3_cs: ecspi3-cs-grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3-grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2
+			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0x2
+			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0x2
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
+			MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x59
+		>;
+	};
+
+	pinctrl_gpmi_nand: gpmi-nand-grp {
+		fsl,pins = <
+			MX7D_PAD_SD3_CLK__NAND_CLE		0x71
+			MX7D_PAD_SD3_CMD__NAND_ALE		0x71
+			MX7D_PAD_SAI1_TX_BCLK__NAND_CE0_B	0x71
+			MX7D_PAD_SAI1_RX_DATA__NAND_CE1_B	0x71
+			MX7D_PAD_SAI1_TX_DATA__NAND_READY_B	0x74
+			MX7D_PAD_SD3_STROBE__NAND_RE_B		0x71
+			MX7D_PAD_SD3_RESET_B__NAND_WE_B		0x71
+			MX7D_PAD_SD3_DATA0__NAND_DATA00		0x71
+			MX7D_PAD_SD3_DATA1__NAND_DATA01		0x71
+			MX7D_PAD_SD3_DATA2__NAND_DATA02		0x71
+			MX7D_PAD_SD3_DATA3__NAND_DATA03		0x71
+			MX7D_PAD_SD3_DATA4__NAND_DATA04		0x71
+			MX7D_PAD_SD3_DATA5__NAND_DATA05		0x71
+			MX7D_PAD_SD3_DATA6__NAND_DATA06		0x71
+			MX7D_PAD_SD3_DATA7__NAND_DATA07		0x71
+		>;
+	};
+
+	pinctrl_i2c4: i2c4-grp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RGMII_TD3__I2C4_SDA	0x4000007f
+			MX7D_PAD_ENET1_RGMII_TD2__I2C4_SCL	0x4000007f
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdif-dat-grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+		>;
+	};
+
+	pinctrl_lcdif_dat_24: lcdif-dat-24-grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+		>;
+	};
+
+	pinctrl_pwm1: pwm1-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO08__PWM1_OUT		0x79
+		>;
+	};
+
+	pinctrl_pwm2: pwm2-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__PWM2_OUT		0x79
+		>;
+	};
+
+	pinctrl_pwm3: pwm3-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO10__PWM3_OUT		0x79
+		>;
+	};
+
+	pinctrl_pwm4: pwm4-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO11__PWM4_OUT 		0x79
+		>;
+	};
+
+	pinctrl_uart1: uart1-grp {
+		fsl,pins = <
+			MX7D_PAD_UART1_TX_DATA__UART1_DTE_RX	0x79
+			MX7D_PAD_UART1_RX_DATA__UART1_DTE_TX	0x79
+			MX7D_PAD_SAI2_TX_BCLK__UART1_DTE_CTS	0x79
+			MX7D_PAD_SAI2_TX_SYNC__UART1_DTE_RTS	0x79
+		>;
+	};
+
+	pinctrl_uart1_ctrl1: uart1-ctrl1-grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_DATA1__GPIO5_IO15		0x14 /* DCD */
+			MX7D_PAD_SD2_DATA0__GPIO5_IO14		0x14 /* DTR */
+		>;
+	};
+
+	pinctrl_uart2: uart2-grp {
+		fsl,pins = <
+			MX7D_PAD_UART2_TX_DATA__UART2_DTE_RX 0x79
+			MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX 0x79
+			MX7D_PAD_SAI2_RX_DATA__UART2_DTE_RTS 0x79
+			MX7D_PAD_SAI2_TX_DATA__UART2_DTE_CTS 0x79
+		>;
+	};
+	pinctrl_uart3: uart3-grp {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__UART3_DTE_RX 0x79
+			MX7D_PAD_UART3_RX_DATA__UART3_DTE_TX 0x79
+		>;
+	};
+
+	pinctrl_usbotg2_reg: gpio-usbotg2-vbus {
+		fsl,pins = <
+			MX7D_PAD_UART3_CTS_B__GPIO4_IO7	0x14 /* SODIMM 129 USBH PEN */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1-grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK	0x19
+			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x59
+			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x59
+			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x59
+			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x59
+		>;
+	};
+
+	pinctrl_sai1: sai1-grp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
+			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
+			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
+			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
+			MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
+		>;
+	};
+};
+
+&iomuxc_lpsr {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_lpsr>;
+
+	pinctrl_gpio_lpsr: gpio1-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO01__GPIO1_IO1	0x59
+			MX7D_PAD_GPIO1_IO02__GPIO1_IO2	0x59
+			MX7D_PAD_GPIO1_IO03__GPIO1_IO3	0x59
+		>;
+	};
+
+	pinctrl_i2c1: i2c1-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO05__I2C1_SDA	0x4000007f
+			MX7D_PAD_GPIO1_IO04__I2C1_SCL	0x4000007f
+		>;
+	};
+
+	pinctrl_cd_usdhc1: usdhc1-cd-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO00__GPIO1_IO0	0x59 /* CD */
+		>;
+	};
+
+	pinctrl_uart1_ctrl2: uart1-ctrl2-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO07__GPIO1_IO7	0x14 /* DSR */
+			MX7D_PAD_GPIO1_IO06__GPIO1_IO6	0x14 /* RI */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
new file mode 100644
index 0000000..ae56381
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -0,0 +1,66 @@
+/*
+ * Copyright 2016 Toradex AG
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
+#include "imx7d-colibri.dtsi"
+#include "imx7-colibri-eval-v3.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7D on Colibri Evaluation Board V3";
+	compatible = "toradex,colibri_imx7d-eval", "toradex,colibri_imx7d", \
+		     "fsl,imx7d";
+
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg2_reg>;
+		regulator-name = "VCC_USB[1-4]";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
new file mode 100644
index 0000000..3c2cb50
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -0,0 +1,54 @@
+/*
+ * Copyright 2016 Toradex AG
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
+#include "imx7d.dtsi"
+#include "imx7-colibri.dtsi"
+
+/ {
+	memory {
+		reg = <0x80000000 0x20000000>;
+	};
+};
+
+&usbotg2 {
+	dr_mode = "host";
+};
diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
new file mode 100644
index 0000000..a9608dd
--- /dev/null
+++ b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2016 Toradex AG
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
+#include "imx7s-colibri.dtsi"
+#include "imx7-colibri-eval-v3.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7S on Colibri Evaluation Board V3";
+	compatible = "toradex,colibri_imx7s-eval", "toradex,colibri_imx7s", \
+		     "fsl,imx7s", "fsl,imx7d";
+};
diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
new file mode 100644
index 0000000..b810134
--- /dev/null
+++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2016 Toradex AG
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
+#include "imx7s.dtsi"
+#include "imx7-colibri.dtsi"
+
+/ {
+	memory {
+		reg = <0x80000000 0x10000000>;
+	};
+};
-- 
2.8.3
