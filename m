From: ping.bai@nxp.com (Bai Ping)
Date: Fri, 2 Dec 2016 14:39:29 +0800
Subject: [PATCH 06/11] ARM: dts: imx: Add imx6sll EVK board dts support
In-Reply-To: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1480660774-25055-7-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic dts support for imx6sll EVK baoard.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/boot/dts/Makefile        |   2 +
 arch/arm/boot/dts/imx6sll-evk.dts | 652 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 654 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sll-evk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c595d..24eb4bd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -416,6 +416,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
 	imx6sl-warp.dtb
+dtb-$(CONFIG_SOC_IMX6SLL) += \
+	imx6sll-evk.dtb
 dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-nitrogen6sx.dtb \
 	imx6sx-sabreauto.dtb \
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
new file mode 100644
index 0000000..2a624cb
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -0,0 +1,652 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
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
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "imx6sll.dtsi"
+
+/ {
+	model = "Freescale i.MX6SLL EVK Board";
+	compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
+
+	memory {
+		reg = <0x80000000 0x80000000>;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	battery: max8903 at 0 {
+		compatible = "fsl,max8903-charger";
+		pinctrl-names = "default";
+		dok_input = <&gpio4 13 1>;
+		uok_input = <&gpio4 13 1>;
+		chg_input = <&gpio4 15 1>;
+		flt_input = <&gpio4 14 1>;
+		fsl,dcm_always_high;
+		fsl,dc_valid;
+		fsl,adc_disable;
+		status = "okay";
+	};
+
+	pxp_v4l2_out {
+		compatible = "fsl,imx6sl-pxp-v4l2";
+		status = "okay";
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_otg1_vbus: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_otg1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_usb_otg2_vbus: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "usb_otg2_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio4 2 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_aud3v: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "wm8962-supply-3v15";
+			regulator-min-microvolt = <3150000>;
+			regulator-max-microvolt = <3150000>;
+			regulator-boot-on;
+		};
+
+		reg_aud4v: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "wm8962-supply-4v2";
+			regulator-min-microvolt = <4325000>;
+			regulator-max-microvolt = <4325000>;
+			regulator-boot-on;
+		};
+
+		reg_lcd: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "lcd-pwr";
+			gpio = <&gpio4 8 0>;
+			enable-active-high;
+		};
+
+		reg_sd1_vmmc: sd1_vmmc {
+			compatible = "regulator-fixed";
+			regulator-name = "SD1_SPWR";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_sd3_vmmc: sd3_vmmc {
+			compatible = "regulator-fixed";
+			regulator-name = "SD3_WIFI";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			gpio = <&gpio4 4 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx6sl-evk-wm8962", "fsl,imx-audio-wm8962";
+		model = "wm8962-audio";
+		cpu-dai = <&ssi2>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Ext Spk", "SPKOUTL",
+			"Ext Spk", "SPKOUTR",
+			"AMIC", "MICBIAS",
+			"IN3R", "AMIC";
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+		codec-master;
+		hp-det-gpios = <&gpio4 24 1>;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux3>;
+	status = "okay";
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6SLL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <393216000>;
+};
+
+&cpu0 {
+	arm-supply = <&sw1a_reg>;
+	soc-supply = <&sw1c_reg>;
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pfuze100 at 08 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	max17135: max17135 at 48 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_max17135>;
+		compatible = "maxim,max17135";
+		reg = <0x48>;
+		status = "okay";
+
+		vneg_pwrup = <1>;
+		gvee_pwrup = <2>;
+		vpos_pwrup = <10>;
+		gvdd_pwrup = <12>;
+		gvdd_pwrdn = <1>;
+		vpos_pwrdn = <2>;
+		gvee_pwrdn = <8>;
+		vneg_pwrdn = <10>;
+		gpio_pmic_pwrgood = <&gpio2 13 0>;
+		gpio_pmic_vcom_ctrl = <&gpio2 3 0>;
+		gpio_pmic_wakeup = <&gpio2 14 0>;
+		gpio_pmic_v3p3 = <&gpio2 7 0>;
+		gpio_pmic_intr = <&gpio2 12 0>;
+
+		regulators {
+			DISPLAY_reg: DISPLAY {
+				regulator-name = "DISPLAY";
+			};
+
+			GVDD_reg: GVDD {
+				/* 20v */
+				regulator-name = "GVDD";
+			};
+
+			GVEE_reg: GVEE {
+				/* -22v */
+				regulator-name = "GVEE";
+			};
+
+			HVINN_reg: HVINN {
+				/* -22v */
+				regulator-name = "HVINN";
+			};
+
+			HVINP_reg: HVINP {
+				/* 20v */
+				regulator-name = "HVINP";
+			};
+
+			VCOM_reg: VCOM {
+				regulator-name = "VCOM";
+				/* 2's-compliment, -4325000 */
+				regulator-min-microvolt = <0xffbe0178>;
+				/* 2's-compliment, -500000 */
+				regulator-max-microvolt = <0xfff85ee0>;
+			};
+
+			VNEG_reg: VNEG {
+				/* -15v */
+				regulator-name = "VNEG";
+			};
+
+			VPOS_reg: VPOS {
+				/* 15v */
+				regulator-name = "VPOS";
+			};
+
+			V3P3_reg: V3P3 {
+				regulator-name = "V3P3";
+			};
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	codec: wm8962 at 1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clks IMX6SLL_CLK_EXTERN_AUDIO>;
+		DCVDD-supply = <&vgen3_reg>;
+		DBVDD-supply = <&reg_aud3v>;
+		AVDD-supply = <&vgen3_reg>;
+		CPVDD-supply = <&vgen3_reg>;
+		MICVDD-supply = <&reg_aud3v>;
+		PLLVDD-supply = <&vgen3_reg>;
+		SPKVDD1-supply = <&reg_aud4v>;
+		SPKVDD2-supply = <&reg_aud4v>;
+		amic-mono;
+	};
+};
+
+&gpc {
+	fsl,ldo-bypass = <1>;
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6SLL_PAD_KEY_ROW7__GPIO4_IO07 0x17059
+			MX6SLL_PAD_GPIO4_IO22__GPIO4_IO22 0x17059
+			MX6SLL_PAD_KEY_COL3__GPIO3_IO30	0x17059
+			/*
+			 * Must set the LVE of pad SD2_RESET, otherwise current
+			 * leakage through eMMC chip will pull high the VCCQ to
+			 * 2.6v, which will impact SD1 and SD3 SD3.0 voltage switch.
+			 */
+			MX6SLL_PAD_SD2_RESET__GPIO4_IO27 0x417059
+			MX6SLL_PAD_KEY_COL4__GPIO4_IO00 0x17059
+			MX6SLL_PAD_REF_CLK_32K__GPIO3_IO22 0x17059 /* SD3 CD */
+			MX6SLL_PAD_KEY_COL6__GPIO4_IO04 0x17059 /*SD3 RESET */
+			MX6SLL_PAD_KEY_COL5__GPIO4_IO02 0x17059
+			MX6SLL_PAD_GPIO4_IO24__GPIO4_IO24 0x17059 /* HP DETECT */
+			/* CHG_FLT, CHG_UOK/DOK, CHG_STATUS */
+			MX6SLL_PAD_ECSPI2_MISO__GPIO4_IO14 0x17000
+			MX6SLL_PAD_ECSPI2_MOSI__GPIO4_IO13 0x17000
+			MX6SLL_PAD_ECSPI2_SS0__GPIO4_IO15  0x17000
+		>;
+	};
+
+	pinctrl_audmux3: audmux3grp {
+		fsl,pins = <
+			MX6SLL_PAD_AUD_TXC__AUD3_TXC		0x4130b0
+			MX6SLL_PAD_AUD_TXFS__AUD3_TXFS		0x4130b0
+			MX6SLL_PAD_AUD_TXD__AUD3_TXD		0x4110b0
+			MX6SLL_PAD_AUD_RXD__AUD3_RXD		0x4130b0
+			MX6SLL_PAD_AUD_MCLK__AUDIO_CLK_OUT	0x4130b0
+		>;
+	};
+
+	pinctrl_csi1: csi1grp {
+		fsl,pins = <
+			MX6SLL_PAD_EPDC_GDRL__CSI_MCLK		0x1b088
+			MX6SLL_PAD_EPDC_GDCLK__CSI_PIXCLK	0x1b088
+			MX6SLL_PAD_EPDC_GDSP__CSI_VSYNC		0x1b088
+			MX6SLL_PAD_EPDC_GDOE__CSI_HSYNC		0x1b088
+			MX6SLL_PAD_EPDC_DATA02__CSI_DATA02	0x1b088
+			MX6SLL_PAD_EPDC_DATA03__CSI_DATA03	0x1b088
+			MX6SLL_PAD_EPDC_DATA04__CSI_DATA04	0x1b088
+			MX6SLL_PAD_EPDC_DATA05__CSI_DATA05	0x1b088
+			MX6SLL_PAD_EPDC_DATA06__CSI_DATA06	0x1b088
+			MX6SLL_PAD_EPDC_DATA07__CSI_DATA07	0x1b088
+			MX6SLL_PAD_EPDC_SDCLK__CSI_DATA08	0x1b088
+			MX6SLL_PAD_EPDC_SDLE__CSI_DATA09	0x1b088
+			MX6SLL_PAD_EPDC_SDSHR__GPIO1_IO26	0x80000000
+			MX6SLL_PAD_EPDC_SDOE__GPIO1_IO25	0x80000000
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdifdatgrp {
+		fsl,pins = <
+			MX6SLL_PAD_LCD_DATA00__LCD_DATA00	0x79
+			MX6SLL_PAD_LCD_DATA01__LCD_DATA01	0x79
+			MX6SLL_PAD_LCD_DATA02__LCD_DATA02	0x79
+			MX6SLL_PAD_LCD_DATA03__LCD_DATA03	0x79
+			MX6SLL_PAD_LCD_DATA04__LCD_DATA04	0x79
+			MX6SLL_PAD_LCD_DATA05__LCD_DATA05	0x79
+			MX6SLL_PAD_LCD_DATA06__LCD_DATA06	0x79
+			MX6SLL_PAD_LCD_DATA07__LCD_DATA07	0x79
+			MX6SLL_PAD_LCD_DATA08__LCD_DATA08	0x79
+			MX6SLL_PAD_LCD_DATA09__LCD_DATA09	0x79
+			MX6SLL_PAD_LCD_DATA10__LCD_DATA10	0x79
+			MX6SLL_PAD_LCD_DATA11__LCD_DATA11	0x79
+			MX6SLL_PAD_LCD_DATA12__LCD_DATA12	0x79
+			MX6SLL_PAD_LCD_DATA13__LCD_DATA13	0x79
+			MX6SLL_PAD_LCD_DATA14__LCD_DATA14	0x79
+			MX6SLL_PAD_LCD_DATA15__LCD_DATA15	0x79
+			MX6SLL_PAD_LCD_DATA16__LCD_DATA16	0x79
+			MX6SLL_PAD_LCD_DATA17__LCD_DATA17	0x79
+			MX6SLL_PAD_LCD_DATA18__LCD_DATA18	0x79
+			MX6SLL_PAD_LCD_DATA19__LCD_DATA19	0x79
+			MX6SLL_PAD_LCD_DATA20__LCD_DATA20	0x79
+			MX6SLL_PAD_LCD_DATA21__LCD_DATA21	0x79
+			MX6SLL_PAD_LCD_DATA22__LCD_DATA22	0x79
+			MX6SLL_PAD_LCD_DATA23__LCD_DATA23	0x79
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX6SLL_PAD_LCD_CLK__LCD_CLK		0x79
+			MX6SLL_PAD_LCD_ENABLE__LCD_ENABLE	0x79
+			MX6SLL_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX6SLL_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX6SLL_PAD_LCD_RESET__LCD_RESET		0x79
+			MX6SLL_PAD_ECSPI1_SCLK__GPIO4_IO08	0x79
+		>;
+	};
+
+	pinctrl_max17135: max17135grp-1 {
+		fsl,pins = <
+			MX6SLL_PAD_EPDC_PWR_STAT__GPIO2_IO13	0x80000000  /* pwrgood */
+			MX6SLL_PAD_EPDC_VCOM0__GPIO2_IO03	0x80000000  /* vcom_ctrl */
+			MX6SLL_PAD_EPDC_PWR_WAKE__GPIO2_IO14	0x80000000  /* wakeup */
+			MX6SLL_PAD_EPDC_PWR_CTRL0__GPIO2_IO07	0x80000000  /* v3p3 */
+			MX6SLL_PAD_EPDC_PWR_IRQ__GPIO2_IO12	0x80000000  /* pwr int */
+		>;
+	};
+
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			MX6SLL_PAD_SD2_DATA4__SPDIF_OUT 0x4130b0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6SLL_PAD_UART1_TXD__UART1_DCE_TX 0x1b0b1
+			MX6SLL_PAD_UART1_RXD__UART1_DCE_RX 0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6SLL_PAD_SD1_CMD__SD1_CMD	0x17059
+			MX6SLL_PAD_SD1_CLK__SD1_CLK	0x13059
+			MX6SLL_PAD_SD1_DATA0__SD1_DATA0	0x17059
+			MX6SLL_PAD_SD1_DATA1__SD1_DATA1	0x17059
+			MX6SLL_PAD_SD1_DATA2__SD1_DATA2	0x17059
+			MX6SLL_PAD_SD1_DATA3__SD1_DATA3	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+		fsl,pins = <
+			MX6SLL_PAD_SD1_CMD__SD1_CMD	0x170b9
+			MX6SLL_PAD_SD1_CLK__SD1_CLK	0x130b9
+			MX6SLL_PAD_SD1_DATA0__SD1_DATA0	0x170b9
+			MX6SLL_PAD_SD1_DATA1__SD1_DATA1	0x170b9
+			MX6SLL_PAD_SD1_DATA2__SD1_DATA2	0x170b9
+			MX6SLL_PAD_SD1_DATA3__SD1_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+		fsl,pins = <
+			MX6SLL_PAD_SD1_CMD__SD1_CMD	0x170f9
+			MX6SLL_PAD_SD1_CLK__SD1_CLK	0x130f9
+			MX6SLL_PAD_SD1_DATA0__SD1_DATA0	0x170f9
+			MX6SLL_PAD_SD1_DATA1__SD1_DATA1	0x170f9
+			MX6SLL_PAD_SD1_DATA2__SD1_DATA2	0x170f9
+			MX6SLL_PAD_SD1_DATA3__SD1_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX6SLL_PAD_EPDC_PWR_COM__USB_OTG1_ID 0x17059
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6SLL_PAD_I2C1_SCL__I2C1_SCL	 0x4001b8b1
+			MX6SLL_PAD_I2C1_SDA__I2C1_SDA	 0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SLL_PAD_AUD_RXFS__I2C3_SCL  0x4041b8b1
+			MX6SLL_PAD_AUD_RXC__I2C3_SDA   0x4041b8b1
+		>;
+	};
+
+	pinctrl_pwm1: pmw1grp {
+		fsl,pins = <
+			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
+		>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	lcd-supply = <&reg_lcd>;
+	display = <&display>;
+	status = "okay";
+
+	display: display {
+		bits-per-pixel = <16>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <33500000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <89>;
+				hfront-porch = <164>;
+				vback-porch = <23>;
+				vfront-porch = <10>;
+				hsync-len = <10>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pxp {
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	cd-gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&ssi2 {
+	status = "okay";
+};
-- 
1.9.1
