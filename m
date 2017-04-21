From: Jens.Rottmann@ADLINKtech.com (Jens Rottmann)
Date: Fri, 21 Apr 2017 21:27:09 +0200
Subject: [PATCH] ARM: add DTS, defconfig for ADLINK LEC-iMX6
Message-ID: <21d6a333-7771-24de-c05f-07e2865a2c16@ADLINKtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are SMARC form factor modules with NXP/Freescale i.MX6 Q/D/DL/S,
1-2 GB RAM, optional eMMC, optional PCIe switch. The DTS files support
the modules on ADLINK's LEC-Base R1 and LEC-Base Mini eval carriers.

Signed-off-by: Jens Rottmann <Jens.Rottmann@ADLINKtech.com>
---

--- /dev/null
+++ b/arch/arm/boot/dts/lec-imx6.dtsi
@@ -0,0 +1,1244 @@
+/*
+ * Copyright 2014-2016 LiPPERT ADLINK Technology GmbH
+ * Copyright 2012-2015 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/* On-module multiplexer: 0 enables SMARC SPI0, !=0 enables I2S0 instead:
+ * 1=TI TLV320AIC23 on LEC-Base R1 carrier, 2=Freescale SGTL5000 on LEC-Base R2/Mini */
+#define CONFIG_I2S_AUDIO	0
+/* The LEC-Base carrier doesn't include cameras, but allows connecting some. */
+//#define CONFIG_SER_CAMERA	3c /* I2C addr of serial camera, hex without "0x" */
+//#define CONFIG_PAR_CAMERA	3c /* I2C addr of parallel camera */
+
+/* The on-module Freescale PF0100 PMIC provides VDD_ARM_IN, VDD_SOC_IN to the
+ * on-SoC Anatop LDOs, which then generate VDD_ARM (CPU cores), VDD_PU
+ * (GPU/VPU), VDD_SOC (the rest). To save power clock and voltage need to vary
+ * according to the workload.
+ * Normal: PMIC provides fixed voltage, internal LDO lowers voltage further to
+ *         required value, depending on clock frequency.
+ * LDO bypass: PMIC (switched!) provides variable voltage directly, controlled
+ *             via I2C; internal LDOs bridged (FETs permanently on).
+ * Bypassing saves power, but requires steady communication on i2c2 to work. */
+#define LDO_BYPASS	1
+
+/* Freescale defines 2 alternative DT nodes for the VPU: The one normally active
+ * loads a driver called 'mxc_vpu'. The other, disabled one, would invoke a
+ * different driver named 'coda'. I don't know what state it is in; none of
+ * Freescale's sample dts files enable it, but the code is there, appearently
+ * dormant, in imx6qdl.dtsi. 'Coda' requires a v4l-coda960-imx6*.bin firmware. */
+#define VPU_CODA	0
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#define __0x(X) 0x##X	/* prefix hex digits with "0x" */
+#define _0x(X) __0x(X)
+
+/ {
+	aliases {
+		mxcfb0 = &mxcfb1;
+		mxcfb1 = &mxcfb2;
+		mxcfb2 = &mxcfb3;
+	};
+
+	chosen {
+		/* U-Boot provides this via "console=..." in the 'params' variable. */
+		//stdout-path = &uart1;
+	};
+
+	/* The LEC-Base carriers don't have any LEDs, just show how it's done. */
+	//leds {
+	//	compatible = "gpio-leds";
+	//
+	//	example-led {
+	//		gpios = <&smarc_gpio 5 GPIO_ACTIVE_LOW>; /* SMARC GPIO5/PWM_OUT */
+	//		linux,default-trigger = "mmc1"; /* more triggers in menuconfig */
+	//	};
+	//};
+
+	memory: memory {
+		reg = <0x10000000 0x40000000>;	/* dummy size, overwritten by U-Boot */
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_regulators>;
+
+		reg_smarc_lcd_vdd: regulator at 130 {
+			compatible = "regulator-fixed";
+			reg = <130>;
+			regulator-name = "smarc_lcd_vdd";
+			gpio = <&gpio1 30 GPIO_ACTIVE_HIGH>; /* SMARC LCD_VDD_EN */
+			enable-active-high;
+			regulator-always-on; /* Freescale's fb/lcd/ldb drivers can't control a regulator yet :-( */
+			regulator-state-mem { regulator-off-in-suspend; }; /* no effect? */
+		};
+
+		reg_smarc_usb0: regulator at 127 {
+			compatible = "regulator-fixed";
+			reg = <127>;
+			regulator-name = "smarc_usb0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 27 GPIO_ACTIVE_HIGH>; /* SMARC USB0_EN_OC# */
+			enable-active-high;
+		};
+
+		reg_smarc_usb1: regulator at 329 {
+			compatible = "regulator-fixed";
+			reg = <329>;
+			regulator-name = "smarc_usb1";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>; /* SMARC USB1_EN_OC# */
+			enable-active-high;
+			/* Before enabling Vbus on the carrier power up the host phy's Vbus. */
+			vin-supply = <&swbst_reg>;
+		};
+
+		reg_smarc_usb2: regulator at 330 {
+			compatible = "regulator-fixed";
+			reg = <330>;
+			regulator-name = "smarc_usb2";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>; /* SMARC USB2_EN_OC# */
+			enable-active-high;
+			/* An on-module hub splits the i.MX6's usbh1 port into SMARC USB1 and 2.
+			 * Devices on both are powered independently, via reg_smarc_usb1 and 2.
+			 * But I've seen no way to model the hub in the device tree and usbh1
+			 * takes only 1 "vbus-supply" line. So by declaring one as vin-supply
+			 * for the other we trick usbh1 into enabling both. If someone needed to
+			 * enable them separately they'd have to do it manually in user mode. */
+			vin-supply = <&reg_smarc_usb1>;
+		};
+
+		reg_smarc_sdio_pwr: regulator at 411 {
+			compatible = "regulator-fixed";
+			reg = <411>;
+			regulator-name = "smarc_sdio_pwr";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio4 11 GPIO_ACTIVE_HIGH>; /* SMARC SDIO_PWR_EN */
+			enable-active-high;
+			regulator-boot-on;
+		};
+
+#if CONFIG_I2S_AUDIO == 2
+		/* Power supplies on the LEC-Base R2 carrier. They cannot be
+		 * controlled, but the SGTL5000 driver won't work without
+		 * regulator definitions. */
+		reg_base_1v8: regulator at 18 {
+			compatible = "regulator-fixed";
+			reg = <18>;
+			regulator-name = "base_1v8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		reg_base_3v3: regulator at 33 {
+			compatible = "regulator-fixed";
+			reg = <33>;
+			regulator-name = "base_3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+#endif
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		lid {
+			label = "Lid switch";
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>; /* SMARC LID# */
+			gpio-key,wakeup;
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <0>; /* SW_LID */
+		};
+
+		power {
+			label = "Power button";
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>; /* SMARC POWER_BTN# */
+			gpio-key,wakeup;
+			linux,code = <KEY_POWER>;
+		};
+
+		sleep {
+			label = "Sleep button";
+			gpios = <&gpio2 7 GPIO_ACTIVE_LOW>; /* SMARC SLEEP# */
+			gpio-key,wakeup;
+			linux,code = <KEY_SLEEP>;
+		};
+
+		test {
+			label = "Test button"; /* LEC-Base R2 carrier provides a button */
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>; /* SMARC TEST# */
+			/* SMARC spec: "invoke module vendor specific test function(s)" */
+			linux,code = <KEY_PROG1>; /* adapt to your needs */
+		};
+
+		/* The PCIe driver doesn't implement a wakeup GPIO yet. For now,
+		 * this can serve as workaround. */
+		//pcie_wake {
+		//	label = "PCIe wake workaround";
+		//	gpios = <&gpio5 20 GPIO_ACTIVE_LOW>; /* PCIE_WAKE_B */
+		//	gpio-key,wakeup;
+		//	linux,code = <KEY_WAKEUP>;
+		//};
+	};
+
+#if CONFIG_I2S_AUDIO == 1
+	sound-i2s {	/* Audio codec on LEC-Base R1 carrier */
+		compatible = "fsl,imx-audio-tlv320aic23";
+		model = "imx-tlv320aic23";
+		ssi-controller = <&ssi2>;
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+		audio-codec = <&codec>;
+	};
+#elif CONFIG_I2S_AUDIO == 2
+	sound-i2s {	/* Audio codec on LEC-Base R2 carrier */
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx-sgtl5000";
+		ssi-controller = <&ssi2>;
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+		audio-codec = <&codec>;
+		asrc-controller = <&asrc>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+		//	"Headphone Jack", "HP_OUT",
+			"Line Out Jack", "LINE_OUT";
+	};
+#endif
+
+	sound-hdmi {
+		compatible = "fsl,imx6q-audio-hdmi",
+			     "fsl,imx-audio-hdmi";
+		model = "imx-audio-hdmi";
+		hdmi-controller = <&hdmi_audio>;
+	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		spdif-controller = <&spdif>;
+		spdif-in;
+		spdif-out;
+	};
+
+	mxcfb1: fb at 0 {	/* IPU1 DI1: /dev/fb0=HDMI, fb1=IPU1's overlay */
+		compatible = "fsl,mxc_sdc_fb";
+		disp_dev = "hdmi";
+		interface_pix_fmt = "RGB24";
+		mode_str ="1920x1080M at 60";
+		default_bpp = <24>;
+		int_clk = <0>;
+		late_init = <0>;
+		status = "okay";
+	};
+
+	mxcfb2: fb at 1 {	/* IPU1 DI0: /dev/fb2=parallel RGB */
+		compatible = "fsl,mxc_sdc_fb";
+		disp_dev = "lcd";
+		interface_pix_fmt = "RGB24";
+		mode_str ="CLAA-WVGA";
+		default_bpp = <24>;
+		int_clk = <0>;
+		late_init = <0>;
+		status = "okay";
+	};
+
+	mxcfb3: fb at 2 {	/* IPU2 DI0: /dev/fb3=LVDS, fb4=IPU2's overlay
+		         * Solo/DL: IPU1, fb2 competing with par. RGB, no overlay */
+		compatible = "fsl,mxc_sdc_fb";
+		disp_dev = "ldb";
+		interface_pix_fmt = "RGB24";
+		default_bpp = <24>;
+		int_clk = <0>;
+		late_init = <0>;
+		status = "okay";
+	};
+
+	rgb: lcd at 0 {	/* parallel RGB (see fb above) */
+		compatible = "fsl,lcd";
+		ipu_id = <0>;
+		disp_id = <0>;
+		default_ifmt = "RGB24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1>;
+		disp-power-on-supply = <&reg_smarc_lcd_vdd>; /* unsupported by driver */
+		status = "okay";
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		enable-gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>; /* SMARC LCD_BKLT_EN */
+		status = "okay";
+	};
+
+#ifdef CONFIG_PAR_CAMERA
+	v4l2_cap_0 {
+		compatible = "fsl,imx6q-v4l2-capture";
+		ipu_id = <0>;
+		csi_id = <0>;
+		mclk_source = <0>;
+		status = "okay";
+	};
+#endif
+
+#ifdef CONFIG_SER_CAMERA
+	v4l2_cap_1 {
+		compatible = "fsl,imx6q-v4l2-capture";
+		ipu_id = <0>;
+		csi_id = <1>;
+		mclk_source = <0>;
+		status = "okay";
+	};
+#endif
+
+	v4l2_out {
+		compatible = "fsl,mxc_v4l2_output";
+		status = "okay";
+	};
+};
+
+#if VPU_CODA
+&vpu {
+	status = "okay";
+};
+&vpu_fsl {
+	status = "disabled";
+};
+#endif
+
+#if CONFIG_I2S_AUDIO
+&audmux {	/* SMARC I2S0 (instead of SPI0) */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	/* Freescale-specific; vanilla relies on U-Boot to set GPIO accordingly. */
+	//pinctrl-assert-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>; /* AEN# */
+	status = "okay";
+};
+#endif
+
+&cpu0 {
+#if LDO_BYPASS
+	arm-supply = <&sw1a_reg>;
+	soc-supply = <&sw1c_reg>;
+#else
+	arm-supply = <&reg_arm>;
+	soc-supply = <&reg_soc>;
+#endif
+};
+
+&clks {
+	fsl,ldb-di0-parent = <&clks IMX6QDL_CLK_PLL2_PFD0_352M>; /* LVDS */
+	fsl,ldb-di1-parent = <&clks IMX6QDL_CLK_PLL2_PFD0_352M>; /* unused */
+};
+
+#if !CONFIG_I2S_AUDIO
+&ecspi1 {	/* SMARC SPI0 (instead of I2S0) */
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>, /* SMARC CS0 */
+	           <&gpio3 24 GPIO_ACTIVE_LOW>; /* SMARC CS1 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	/* Freescale-specific; vanilla relies on U-Boot to set GPIO accordingly. */
+	//pinctrl-assert-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>; /* AEN# */
+	status = "okay";
+
+	tsc2046 at 0 {		/* Touch screen controller on LEC-Base R1 carrier */
+		compatible = "ti,tsc2046";
+		reg = <0>;
+		vcc-supply = <&reg_smarc_lcd_vdd>;
+		spi-max-frequency = <2500000>;
+		interrupt-parent = <&smarc_gpio>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>; /* SMARC GPIO10 */
+		pendown-gpio = <&smarc_gpio 10 GPIO_ACTIVE_LOW>;
+		ti,vref-mv = /bits/ 16 <3300>;
+	};
+};
+#endif
+
+&ecspi2 {	/* SMARC SPI1 */
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio2 27 GPIO_ACTIVE_LOW>, /* SMARC CS0 */
+	           <&gpio2 26 GPIO_ACTIVE_LOW>; /* SMARC CS1 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	status = "okay";
+};
+
+&ecspi4 {	/* on-module U-Boot SPI */
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi4>;
+	status = "okay";
+
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q64";
+		spi-max-frequency = <66000000>; /* slowest we used was SST25VF032B; i.MX6 provides 60MHz max */
+		reg = <0>;
+		m25p,fast-read;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>; /* RGMII_nRST */
+	/* Can't power off phy because sw2_reg is permanently needed. We could
+	 * turn off i.MX6's NVCC_RGMII (I/O voltage) only, but that's risky when
+	 * the phy remains powered. */
+	//phy-supply = <&vgen1_reg>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	/* The next 2 options are documented, but not implemented by Freescale's
+	 * driver. Their recent DTs replace trx-stby-gpio and trx-en-gpio (also
+	 * missing) with 'xceiver-supply' regulators (is this really the same?),
+	 * however we won't bother, the GPIOs don't connect anyway. */
+	//trx-nerr-gpio = <&smarc_gpio 8 GPIO_ACTIVE_LOW>; /* SMARC GPIO8/CAN0_ERR#, unused on LEC-Base carrier */
+	//trx-stby-gpio = <&carrier_misc_control 1 GPIO_ACTIVE_HIGH>; /* CAN1_STB, solder jumper not populated */
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	//trx-nerr-gpio = <&smarc_gpio 9 GPIO_ACTIVE_LOW>; /* SMARC GPIO9/CAN1_ERR#, unused on LEC-Base carrier */
+	//trx-stby-gpio = <&carrier_misc_control 2 GPIO_ACTIVE_HIGH>; /* CAN2_STB, solder jumper not populated */
+	status = "okay";
+};
+
+&gpc {
+	fsl,ldo-bypass = <LDO_BYPASS>; /* U-Boot will check it and configure */
+};
+
+&dcic1 {
+	dcic_id = <0>;
+	dcic_mux = "dcic-hdmi";
+	status = "okay";
+};
+
+&dcic2 {
+	dcic_id = <1>;
+	dcic_mux = "dcic-lvds0";
+	status = "okay";
+};
+
+&hdmi_audio {
+	status = "okay";
+};
+
+&hdmi_cec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi_cec>;
+	status = "okay";
+};
+
+&hdmi_core {		/* HDMI (see fb above) */
+	ipu_id = <0>;
+	disp_id = <1>;
+	status = "okay";
+};
+
+&hdmi_video {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi_hdcp>;
+	fsl,hdcp; /* also means we use the dedicated DDC function */
+	fsl,phy_reg_vlev = <0x03f4>;
+	fsl,phy_reg_cksymtx = <0x800f>;
+	status = "okay";
+};
+
+&i2c1 {		/* RTC, optional PCIe switch, SMARC I2C_CAM */
+	clock-frequency = <100000>; /* 66 MHz / 768 = 86 kHz */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pcf8563 at 51 {				/* Real Time Clock */
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+
+	pex8605 at 58 {				/* optional PCIe switch */
+		compatible = "plx,pex8605"; /* guessing, no driver found */
+		reg = <0x58>;
+	};
+
+#if CONFIG_I2S_AUDIO == 2
+	codec: sgtl5000 at 0a {		/* Audio codec on LEC-Base R2 carrier */
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>; /* SMARC AUDIO_MCK, actually unused on carrier */
+		VDDA-supply = <&reg_base_3v3>;
+		VDDIO-supply = <&reg_base_1v8>;
+		VDDD-supply = <&reg_base_1v8>;
+		micbias-resistor-k-ohms = <4>;
+		micbias-voltage-m-volts = <1250>;
+	};
+#endif
+
+	carrier_misc_control: pcf8575 at 20 {	/* GPIO expander on LEC-Base R1 carrier */
+		compatible = "nxp,pcf8575";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		/* 0: HUB1_RESET	 8: 3G1_DISABLE#
+		 * 1: CAN1_STB (NC)	 9: 3G1_DOWN#
+		 * 2: CAN2_STB (NC)	10: 3G2_DISABLE#
+		 * 3: LCD_RESET# (NC)	11: 3G2_DOWN#
+		 * 4: SUP_RESET# (NC)	12: HDMI_RESET#
+		 * 5: LVDS_VDD_EN	13: 3G_PW_EN
+		 * 6: CAM_PW_EN (NC)	14: PCAM_LE#
+		 * 7: GPS_VDD_EN	15: HUB2_RESET */
+		lines-initial-states = <0xc001>; /* bitmask: 0=high(!)/input, 1=pulled low */
+	};
+
+#ifdef CONFIG_PAR_CAMERA
+	ov564x at CONFIG_PAR_CAMERA {		/* Parallel camera connected to carrier */
+		compatible = "ovti,ov564x";
+		reg = <_0x(CONFIG_PAR_CAMERA)>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_pcam>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		clock-names = "csi_mclk";
+		pwn-gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>; /* SMARC GPIO1/CAM1_PWR# */
+		rst-gpios = <&gpio6 16 GPIO_ACTIVE_LOW>;  /* SMARC GPIO3/CAM1_RST# */
+		csi_id = <0>; /* but on SMARC CSI1_...! */
+		mclk = <24000000>;
+		mclk_source = <0>;
+	};
+#endif
+
+#ifdef CONFIG_SER_CAMERA
+	ov564x_mipi at CONFIG_SER_CAMERA {		/* Serial camera connected to carrier */
+		compatible = "ovti,ov564x_mipi";
+		reg = <_0x(CONFIG_SER_CAMERA)>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		clock-names = "csi_mclk";
+		pwn-gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>; /* SMARC GPIO0/CAM0_PWR# */
+		rst-gpios = <&gpio6 15 GPIO_ACTIVE_LOW>;  /* SMARC GPIO2/CAM0_RST# */
+		csi_id = <1>; /* but on SMARC CSI0_...! */
+		mclk = <24000000>;
+		mclk_source = <0>;
+	};
+#endif
+};
+
+&i2c2 {		/* PFUZE100 PMIC, SMARC I2C_LCD, SMARC I2C_GP */
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pmic: pfuze100 at 08 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab { /* VDDCORE: VDDARM */
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c { /* VDDSOC */
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 { /* GEN_3V3: NVCC_ENET (eth mac), eth phy, USB hub, eMMC, lots of misc stuff */
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw3a_reg: sw3a { /* DDR_1V5 */
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b { /* dito */
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 { /* PMIC_1V8: VDD_IO and lots of stuff everywhere */
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst { /* PMIC_5V: USB h1 Vbus (for phy, rest is provided by carrier) */
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+				regulator-boot-on;
+			};
+
+			snvs_reg: vsnvs { /* PMIC_VSNVS (3V) */
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr { /* DDR_VREF */
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 { /* VGEN1_1V5: NVCC_RGMII (i.MX6's I/O to external eth phy) */
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-boot-on;
+				regulator-always-on; /* we can't power off phy itself */
+			};
+
+			vgen2_reg: vgen2 { /* unused */
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 { /* VGEN3_2V5: NVCC_LVDS (LVDS, DRAM, RGMII), SPI/I2S mux */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on; /* despite its name, NVCC_LVDS also supplies DRAM_IO */
+			};
+
+			vgen4_reg: vgen4 { /* VDDHIGH_IN (2.8V): SATA, PCIe, HDMI, MIPI, LVDS, USB, PLLs */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 { /* dito, but unused per default (since LEC-iMX6 rev A4) */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				//regulator-always-on; /* solder jumper */
+			};
+
+			vgen6_reg: vgen6 { /* VGEN6_3V3: PCIe switch, PCIe reset */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				/* no driver for PCIe switch, no regulator in i.MX6 driver and we couldn't
+				   power down carrier devices or host, only PCIe switch in between */
+				regulator-always-on;
+			};
+		};
+	};
+
+#if CONFIG_I2S_AUDIO == 1
+	codec: tlv320aic23 at 1a {		/* Audio codec on LEC-Base R1 carrier */
+		compatible = "ti,tlv320aic23";
+		reg = <0x1a>;
+		clocks = <&clks IMX6QDL_CLK_CKO>; /* SMARC AUDIO_MCK, actually unused on carrier */
+	};
+#endif
+
+	/* Current driver depends on MXS framebuffer not present on i.MX6Q/D/DL/S.
+	 * Also assuming LEC-Base R1 JP3=1-2, JP15=2-3. */
+	sii902x at 39 {			/* HDMI transmitter on LEC-Base R1 carrier */
+		compatible = "SiI,sii902x";
+		reg = <0x39>;
+		interrupt-parent = <&smarc_gpio>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>; /* SMARC GPIO4/HDA_RST# */
+		mode_str = "1280x720M at 60";
+		bits-per-pixel = <32>;
+	};
+
+	mma7660 at 4c {			/* Accelerometer on LEC-Base R1 carrier */
+		compatible = "fsl,mma7660"; /* guessing, no driver mainlined */
+		reg = <0x4c>;
+		interrupt-parent = <&smarc_gpio>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* SMARC GPIO11 */
+	};
+
+	at24c08 at 54 {			/* 1KB EEPROM on LEC-Base R1 carrier */
+		compatible = "atmel,24c08";
+		reg = <0x54>;
+		pagesize = <16>;
+	};
+
+	/* Driver disabled in defconfig, we have an on-module RTC already. */
+	ds1337 at 68 {			/* RTC on LEC-Base R1 carrier */
+		compatible = "maxim,ds1337";
+		reg = <0x68>;
+	};
+};
+
+&i2c3 {		/* GPIO expander, SEMA BMC, SMARC I2C_PM */
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	smarc_gpio: pca9535 at 20 {	/* GPIO expander */
+		/* GPIOs 4-6, 8-11 map directly to the SMARC connector's GPIOx.
+		 * GPIOs 0-3, 7 are unused unless a solder jumper is changed, per default
+		 * SMARC GPIO0-3,7 are provided by the i.MX6 (CAM0/1_PWR/RST#,PCAM_FLD). */
+		compatible = "nxp,pca9535";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>; /* GPIO_INT_B */
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sema_bmc at 28 {			/* SEMA Board Management Controller */
+		compatible = "adlink,sema_bmc"; /* no driver needed */
+		reg = <0x28>;
+	};
+
+	ltc1760 at 0a {			/* Battery charger on LEC-Base R1 carrier */
+		compatible = "linear,ltc1760"; /* guessing, no driver found */
+		reg = <0x0a>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	lec-imx6 {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				/* Native pad functions */
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
+				/* Pads used for GPIOs */
+				MX6QDL_PAD_GPIO_3__GPIO1_IO03        0x80000000 /* AEN# (mux: 0=SPI0, 1=I2S0) */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29     0x80000000 /* GPIO_INT_B */
+				MX6QDL_PAD_NANDF_CS0__GPIO6_IO11     0x80000000 /* SMARC GPIO0/CAM0_PWR# */
+				MX6QDL_PAD_NANDF_CS1__GPIO6_IO14     0x80000000 /* SMARC GPIO1/CAM1_PWR# */
+				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15     0x80000000 /* SMARC GPIO2/CAM0_RST# */
+				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16     0x80000000 /* SMARC GPIO3/CAM1_RST# */
+				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07     0x80000000 /* SMARC GPIO7/PCAM_FLD */
+			>;
+		};
+
+		pinctrl_regulators: regulatorsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30     0x80000000 /* SMARC LCD_VDD_EN */
+				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x1a8b0 /* SMARC USB0_EN_OC# (open-drain) */
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1a8b0 /* SMARC USB1_EN_OC# (open-drain) */
+				MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1a8b0 /* SMARC USB2_EN_OC# (open-drain) */
+				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11      0x80000000 /* SMARC SDIO_PWR_EN */
+				//MX6QDL_PAD_GPIO_18__GPIO7_IO13     0x80000000 /* PMIC_INT_B */
+			>;
+		};
+
+#if CONFIG_I2S_AUDIO
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <	/* SMARC I2S0 (instead of SPI0) */
+				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
+				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
+				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
+				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
+			>;
+		};
+#else
+		pinctrl_ecspi1: ecspi1grp {
+			fsl,pins = <	/* SMARC SPI0 (instead of I2S0) */
+				MX6QDL_PAD_CSI0_DAT6__ECSPI1_MISO	0x100b1
+				MX6QDL_PAD_CSI0_DAT5__ECSPI1_MOSI	0x100b1
+				MX6QDL_PAD_CSI0_DAT4__ECSPI1_SCLK	0x100b1
+				MX6QDL_PAD_CSI0_DAT7__GPIO5_IO25	0x1b0b0 /* SMARC CS0 */
+				MX6QDL_PAD_EIM_D24__GPIO3_IO24		0x1b0b0 /* SMARC CS1 */
+			>;
+		};
+#endif
+
+		pinctrl_ecspi2: ecspi2grp {
+			fsl,pins = <	/* SMARC SPI1 */
+				MX6QDL_PAD_EIM_OE__ECSPI2_MISO		0x100b1
+				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI		0x100b1
+				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK		0x100b1
+				MX6QDL_PAD_EIM_RW__GPIO2_IO26		0x1b0b0 /* SMARC CS1 */
+				MX6QDL_PAD_EIM_LBA__GPIO2_IO27		0x1b0b0 /* SMARC CS0 */
+			>;
+		};
+
+		pinctrl_ecspi4: ecspi4grp {
+			fsl,pins = <	/* on-module U-Boot SPI */
+				MX6QDL_PAD_EIM_D22__ECSPI4_MISO		0x100b1
+				MX6QDL_PAD_EIM_D28__ECSPI4_MOSI		0x100b1
+				MX6QDL_PAD_EIM_D21__ECSPI4_SCLK		0x100b1
+				MX6QDL_PAD_EIM_D25__GPIO3_IO25		0x1b0b0 /* CS3 */
+			>;
+		};
+
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b8 /* serial resistor added */
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25   0x80000000 /* RGMII_nRST */
+				//MX6QDL_PAD_ENET_RXD1__GPIO1_IO26   0x80000000 /* RGMII_INT */
+				/* For the workaround improving network latency described in i.MX6
+				 * erratum 6687 disable the power button, re-mux as follows and
+				 * add "interrupts-extended" as in imx6q-sabresd-enetirq.dts. */
+				//MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
+			>;
+		};
+
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins = <	/* SMARC CAN0 */
+				MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX		0x17059
+				MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX		0x17059
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins = <	/* SMARC CAN1 */
+				MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX	0x17059
+				MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX	0x17059
+			>;
+		};
+
+		pinctrl_gpio_keys: gpio_keysgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_7__GPIO1_IO07		0x1b0b0 /* SMARC LID# */
+				MX6QDL_PAD_GPIO_6__GPIO1_IO06		0x1b0b0 /* SMARC POWER_BTN# */
+				MX6QDL_PAD_NANDF_D7__GPIO2_IO07		0x1b0b0 /* SMARC SLEEP# */
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x1b0b0 /* SMARC TEST# */
+			>;
+		};
+
+		pinctrl_hdmi_cec: hdmicecgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_A25__HDMI_TX_CEC_LINE	0x108b0
+			>;
+		};
+
+		pinctrl_hdmi_hdcp: hdmihdcpgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__HDMI_TX_DDC_SCL 0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__HDMI_TX_DDC_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
+				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_ipu1: ipu1grp {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK       0xf1
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15             0xf1
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02              0xf1
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03              0xf1
+				MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04        0x80000000
+				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00         0xf1
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01         0xf1
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02         0xf1
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03         0xf1
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04         0xf1
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05         0xf1
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06         0xf1
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07         0xf1
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08         0xf1
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09         0xf1
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10        0xf1
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11        0xf1
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12        0xf1
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13        0xf1
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14        0xf1
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15        0xf1
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16        0xf1
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17        0xf1
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18        0xf1
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19        0xf1
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20        0xf1
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21        0xf1
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22        0xf1
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23        0xf1
+			>;
+		};
+
+#ifdef CONFIG_PAR_CAMERA
+		pinctrl_ipu1_pcam: ipu1_pcamgrp {
+			fsl,pins = <	/* SMARC PCAM */
+				MX6QDL_PAD_CSI0_DAT10__IPU1_CSI0_DATA10    0x80000000
+				MX6QDL_PAD_CSI0_DAT11__IPU1_CSI0_DATA11    0x80000000
+				MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x80000000
+				MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13    0x80000000
+				MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14    0x80000000
+				MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15    0x80000000
+				MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16    0x80000000
+				MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17    0x80000000
+				MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18    0x80000000
+				MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19    0x80000000
+				MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK   0x80000000
+				MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC      0x80000000
+				MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC     0x80000000
+			>;
+		};
+#endif
+
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0 /* PCIE_RST_B */
+				MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x1b0b0 /* PCIE_WAKE_B */
+			>;
+		};
+
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_RB0__GPIO6_IO10     0x80000000 /* SMARC LCD_BKLT_EN */
+				MX6QDL_PAD_GPIO_9__PWM1_OUT		0x1b0b1 /* SMARC LCD_BKLT_PWM */
+			>;
+		};
+
+		pinctrl_spdif: spdifgrp {
+			fsl,pins = <	/* SMARC SPDIF_IN/OUT */
+				MX6QDL_PAD_GPIO_16__SPDIF_IN		0x1b0b0
+				MX6QDL_PAD_GPIO_19__SPDIF_OUT		0x1b0b0
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <	/* SMARC SER0 */
+				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
+				MX6QDL_PAD_EIM_D19__UART1_CTS_B		0x1b0b1
+				MX6QDL_PAD_EIM_D20__UART1_RTS_B		0x1b0b1
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <	/* SMARC SER1 */
+				MX6QDL_PAD_EIM_D26__UART2_TX_DATA	0x1b0b1
+				MX6QDL_PAD_EIM_D27__UART2_RX_DATA	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart4: uart4grp {
+			fsl,pins = <	/* SMARC SER3 */
+				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
+				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart5: uart5grp {
+			fsl,pins = <	/* SMARC SER2 */
+				MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
+				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
+				MX6QDL_PAD_KEY_COL4__UART5_RTS_B	0x1b0b1
+				MX6QDL_PAD_KEY_ROW4__UART5_CTS_B	0x1b0b1
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <	/* SMARC USB0 */
+				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <	/* on-module eMMC */
+				MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17059
+				MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10059
+				MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17059
+				MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17059
+				MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17059
+				MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17059
+				MX6QDL_PAD_NANDF_D0__SD1_DATA4		0x17059
+				MX6QDL_PAD_NANDF_D1__SD1_DATA5		0x17059
+				MX6QDL_PAD_NANDF_D2__SD1_DATA6		0x17059
+				MX6QDL_PAD_NANDF_D3__SD1_DATA7		0x17059
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <	/* SMARC SDIO */
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+				//MX6QDL_PAD_GPIO_4__SD2_CD_B	     0x80000000 /* controller internal CD doesn't work */
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04	     0x80000000 /* SD2_CD_B: mux as GPIO instead */
+				MX6QDL_PAD_GPIO_2__SD2_WP	     0x80000000
+			>;
+		};
+
+		pinctrl_usdhc4: usdhc4grp {
+			fsl,pins = <	/* SMARC SDMMC */
+				MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17059
+				MX6QDL_PAD_SD4_CLK__SD4_CLK		0x10059
+				MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
+				MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
+				MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
+				MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
+				MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
+				MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
+				MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
+				MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
+				MX6QDL_PAD_NANDF_ALE__SD4_RESET	     0x80000000
+			>;
+		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_1__WDOG2_B 0x80000000
+			>;
+		};
+	};
+};
+
+&ldb {		/* LVDS (see fb above) */
+	disp-power-on-supply = <&reg_smarc_lcd_vdd>; /* unsupported by driver */
+	status = "okay";
+
+	lvds-channel at 0 {
+		fsl,data-mapping = "spwg"; /* spwg or jeida (see chapter "Bit Mapping" in i.MX6 Reference Manual) */
+		fsl,data-width = <24>;
+		primary;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+			};
+		};
+	};
+};
+
+#ifdef CONFIG_SER_CAMERA
+&mipi_csi {
+	ipu_id = <0>;
+	csi_id = <1>;
+	v_channel = <0>;
+	lanes = <2>;
+	status = "okay";
+};
+#endif
+
+&mlb {		/* SMARC AFB_DIFF1-3 */
+	/* Driver doesn't seem to support differential (6-pin) mode. */
+	//status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>; /* PCIE_RST_B */
+	/* Next line has no effect: half-implemented in older kernels, Freescale
+	 * now removed code completely; gpio-key can serve as workaround. */
+	wake-up-gpio = <&gpio5 20 GPIO_ACTIVE_LOW>; /* PCIE_WAKE_B */
+	status = "okay";
+};
+
+&pwm1 {		/* SMARC LCD_BKLT_PWM */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&spdif {	/* SMARC SPDIF_IN/OUT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif>;
+	assigned-clocks = <&clks IMX6QDL_CLK_SPDIF_SEL>, <&clks IMX6QDL_CLK_SPDIF_PODF>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_PFD3_454M>;
+	assigned-clock-rates = <0>, <227368421>;
+	status = "okay";
+};
+
+#if CONFIG_I2S_AUDIO
+&ssi2 {		/* SMARC I2S0 (instead of SPI0) */
+	status = "okay";
+};
+#endif
+
+&uart1 {	/* SMARC SER0 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {	/* SMARC SER1 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart4 {	/* SMARC SER3 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&uart5 {	/* SMARC SER2 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&usbh1 {	/* SMARC USB1,2 */
+	vbus-supply = <&reg_smarc_usb2>; /* chained with usb1, see above */
+	disable-over-current; /* connects to SMARC USB2_EN_OC# but not USB1_ */
+	status = "okay";
+};
+
+&usbotg {	/* SMARC USB0 */
+	vbus-supply = <&reg_smarc_usb0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	//dr_mode = "peripheral"; /* default is "otg", override with "host" or "peripheral" to set fixed role */
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbphy1 {
+	tx-d-cal = <0x5>;
+};
+
+&usbphy2 {
+	tx-d-cal = <0x5>;
+};
+
+&usdhc1 {	/* on-module eMMC */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {	/* SMARC SDIO */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	//fsl,cd-controller; /* using controller internal CD doesn't work properly */
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>; /* need to treat it as GPIO instead */
+	fsl,wp-controller;
+	vmmc-supply = <&reg_smarc_sdio_pwr>;
+	vqmmc-supply = <&reg_smarc_sdio_pwr>;
+	no-1-8-v; /* LEC-Base carriers have pull-ups (3.3V) on data lines */
+	//keep-power-in-suspend;
+	//enable-sdio-wakeup;
+	status = "okay";
+};
+
+&usdhc4 {	/* SMARC SDMMC */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <8>;
+	//non-removable; /* eMMC: no polling saves power */
+	broken-cd; /* uSD slot on carrier: polling allows switching cards */
+	no-1-8-v; /* LEC-Base carriers have pull-ups (3.3V) on data lines */
+	status = "okay";
+};
+
+&wdog1 {
+	/* Contrary to other nodes Freescale's dtsi doesn't default to "disabled" here. */
+	status = "disabled";
+};
+
+&wdog2 {
+	/* This is the TrustZone watchdog, however pin mux leaves no other choice.
+	 * We don't need an SoC reset (wdog_rst_b), but WDOG2_B --> system wide POR. */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,wdog_b;
+	status = "okay";
+};
--- /dev/null
+++ b/arch/arm/boot/dts/lec-imx6q.dts
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2014-2016 LiPPERT ADLINK Technology GmbH
+ * Copyright 2012-2015 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "lec-imx6.dtsi"
+
+/ {
+	model = "ADLINK LEC-iMX6 (Quad/Dual) SMARC module";
+	compatible = "adlink,lec-imx6", "fsl,imx6q";
+};
+
+&ldb {		/* LVDS (see fb in lec-imx6.dtsi) */
+	lvds-channel at 0 {
+		crtc = "ipu2-di0";
+	};
+};
+
+&sata {
+	/* Freescale's defaults */
+	fsl,transmit-level-mV = <1025>;
+	fsl,transmit-boost-mdB = <3330>;
+	fsl,transmit-atten-16ths = <9>;
+	fsl,receive-eq-mdB = <3000>;
+	status = "okay";
+};
--- /dev/null
+++ b/arch/arm/boot/dts/lec-imx6s.dts
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2014-2016 LiPPERT ADLINK Technology GmbH
+ * Copyright (C) 2013-2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* The i.MX6 Solo/DualLite only has 1 IPU i.e. can only operate 2 of the 3
+ * display options at the same time. lec-imx6.dtsi assigns the IPU's 2 DIs such
+ * that HDMI always works, whereas parallel RGB and LVDS compete for the same
+ * DI. The following option leaves only one of them enabled. (The Quad/Dual DTS
+ * maps LVDS to the 2nd IPU, enabling all displays simultaneously.) */
+#define CONFIG_SOLO_LVDS	0
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "lec-imx6.dtsi"
+
+/ {
+	model = "ADLINK LEC-iMX6 (Solo/DualLite) SMARC module";
+	compatible = "adlink,lec-imx6", "fsl,imx6dl";
+};
+
+&ldb {		/* LVDS (see fb in lec-imx6.dtsi) */
+	lvds-channel at 0 {
+		crtc = "ipu1-di0";
+	};
+};
+
+#if CONFIG_SOLO_LVDS
+&mxcfb2 {	/* parallel RGB */
+#else
+&mxcfb3 {	/* LVDS */
+#endif
+	status = "disabled";
+};
+
+#if CONFIG_SOLO_LVDS
+&rgb {		/* parallel RGB */
+#else
+&ldb {		/* LVDS */
+#endif
+	status = "disabled";
+};
+
+&pxp {
+	status = "okay";
+};
--- /dev/null
+++ b/arch/arm/configs/lec-imx6_defconfig
@@ -0,0 +1,309 @@
+CONFIG_CROSS_COMPILE="arm-linux-gnueabihf-"
+CONFIG_LOCALVERSION="-imx6"
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_KERNEL_XZ=y
+CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
+# CONFIG_USELIB is not set
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_CGROUPS=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+# CONFIG_SYSFS_SYSCALL is not set
+CONFIG_PERF_EVENTS=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_JUMP_LABEL=y
+CONFIG_CC_STACKPROTECTOR_REGULAR=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_MXC=y
+CONFIG_SOC_IMX6Q=y
+# CONFIG_SWP_EMULATE is not set
+# CONFIG_ARM_ERRATA_643719 is not set
+CONFIG_PCI=y
+CONFIG_PCI_IMX6=y
+# CONFIG_PCIEAER is not set
+CONFIG_PCIEASPM_POWERSAVE=y
+CONFIG_SMP=y
+CONFIG_VMSPLIT_2G=y
+CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_CMA=y
+CONFIG_CMDLINE="console=ttymxc0,115200 rootwait"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=m
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_ARM_IMX6Q_CPUFREQ=y
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET6_XFRM_MODE_BEET is not set
+# CONFIG_IPV6_SIT is not set
+CONFIG_CAN=y
+# CONFIG_CAN_GW is not set
+CONFIG_CAN_FLEXCAN=y
+# CONFIG_WIRELESS is not set
+# CONFIG_UEVENT_HELPER is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=0
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_EEPROM_AT24=m
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+CONFIG_SCSI_SCAN_ASYNC=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+# CONFIG_ATA_VERBOSE_ERROR is not set
+# CONFIG_SATA_PMP is not set
+CONFIG_AHCI_IMX=y
+# CONFIG_ATA_SFF is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_AGERE is not set
+# CONFIG_NET_VENDOR_ALTEON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ATHEROS is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_CISCO is not set
+# CONFIG_NET_VENDOR_DEC is not set
+# CONFIG_NET_VENDOR_DLINK is not set
+# CONFIG_NET_VENDOR_EMULEX is not set
+# CONFIG_NET_VENDOR_EXAR is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_HISILICON is not set
+# CONFIG_NET_VENDOR_HP is not set
+CONFIG_IGB=m
+# CONFIG_IGB_HWMON is not set
+# CONFIG_NET_VENDOR_I825XX is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_MYRI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NVIDIA is not set
+# CONFIG_NET_VENDOR_OKI is not set
+# CONFIG_NET_PACKET_ENGINE is not set
+# CONFIG_NET_VENDOR_QLOGIC is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
+# CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SILAN is not set
+# CONFIG_NET_VENDOR_SIS is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SUN is not set
+# CONFIG_NET_VENDOR_TEHUTI is not set
+# CONFIG_NET_VENDOR_TI is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_AT803X_PHY=y
+# CONFIG_USB_NET_DRIVERS is not set
+# CONFIG_WLAN is not set
+CONFIG_INPUT_MOUSEDEV=m
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_EVDEV=m
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=m
+# CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_IMX=y
+CONFIG_SERIAL_IMX_CONSOLE=y
+CONFIG_FSL_OTP=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_IMX=y
+CONFIG_SPI=y
+CONFIG_SPI_IMX=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCA953X=y
+CONFIG_GPIO_PCA953X_IRQ=y
+CONFIG_GPIO_PCF857X=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
+# CONFIG_MXC_MMA8451 is not set
+CONFIG_THERMAL=y
+CONFIG_CPU_THERMAL=y
+CONFIG_IMX_THERMAL=y
+CONFIG_DEVICE_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_IMX2_WDT=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_ANATOP=y
+CONFIG_REGULATOR_PFUZE100=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_MXC_OUTPUT=y
+CONFIG_VIDEO_MXC_CAPTURE=m
+CONFIG_MXC_CAMERA_OV5640=m
+CONFIG_MXC_CAMERA_OV5642=m
+CONFIG_MXC_CAMERA_OV5640_MIPI=m
+CONFIG_MXC_IPU_DEVICE_QUEUE_SDC=m
+CONFIG_VIDEO_MXC_IPU_OUTPUT=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_CODA=m
+# CONFIG_VGA_ARB is not set
+CONFIG_DRM=y
+CONFIG_DRM_VGEM=m
+CONFIG_DRM_VIVANTE=y
+CONFIG_FB=y
+CONFIG_FB_MXC_SYNC_PANEL=y
+CONFIG_FB_MXC_LDB=y
+CONFIG_FB_MXC_HDMI=y
+CONFIG_FB_MXC_DCIC=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+# CONFIG_BACKLIGHT_GENERIC is not set
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_VERBOSE_PROCFS is not set
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_PCI is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_FSL_ASRC=y
+CONFIG_SND_IMX_SOC=y
+CONFIG_SND_SOC_EUKREA_TLV320=m
+CONFIG_SND_SOC_IMX_SGTL5000=m
+CONFIG_SND_SOC_IMX_SPDIF=y
+CONFIG_SND_SOC_IMX_HDMI=y
+CONFIG_HID_MULTITOUCH=m
+CONFIG_USB=y
+CONFIG_USB_OTG=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_ACM=m
+CONFIG_USB_STORAGE=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_UDC=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_MXS_PHY=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_MASS_STORAGE=m
+CONFIG_MMC=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
+CONFIG_MXC_IPU=y
+CONFIG_MXC_GPU_VIV=y
+CONFIG_MXC_MIPI_CSI2=y
+CONFIG_MXC_HDMI_CEC=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_RTC_CLASS=y
+# CONFIG_RTC_SYSTOHC is not set
+CONFIG_RTC_DRV_PCF8563=y
+CONFIG_RTC_DRV_SNVS=m
+CONFIG_DMADEVICES=y
+CONFIG_MXC_PXP_V2=y
+# CONFIG_MX3_IPU is not set
+CONFIG_IMX_SDMA=y
+CONFIG_MXS_DMA=y
+CONFIG_STAGING=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_PWM_IMX=y
+# CONFIG_RESET_GPIO is not set
+CONFIG_EXT4_FS=y
+CONFIG_FANOTIFY=y
+CONFIG_AUTOFS4_FS=m
+CONFIG_FUSE_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_VFAT_FS=y
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+# CONFIG_JFFS2_FS_WRITEBUFFER is not set
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V2 is not set
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_DEFAULT="utf8"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_15=y
+CONFIG_NLS_UTF8=y
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_RCU_CPU_STALL_INFO is not set
+# CONFIG_FTRACE is not set
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
+CONFIG_CRYPTO_DEV_FSL_CAAM_SM=y
+CONFIG_CRYPTO_DEV_FSL_CAAM_SECVIO=y
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_SPARC is not set
_
