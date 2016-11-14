From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 13:27:35 +0800
Subject: [PATCH V4] ARM: dts: imx6: Add support for Logic PD SOM and
 Baseboard
In-Reply-To: <1478609017-2415-1-git-send-email-aford173@gmail.com>
References: <1478609017-2415-1-git-send-email-aford173@gmail.com>
Message-ID: <20161114052732.GD3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 06:43:37AM -0600, aford173 at gmail.com wrote:
> From: Adam Ford <aford173@gmail.com>
> 
> The system on module (SOM) specific portions are in the .dtsi
> while the baseboard specific portions are in the .dts file.
> 
> V4: Forgot to fix the Wlcore property list and child node
> V3: Forgot to remove push buttons in V2, and change the
>     enable-sdio-wakup to wakeup-source
> V2: Fix small bug and update style for 4.9 Kernel
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

<snip>

> +	leds {
> +		compatible = "gpio-leds";
> +
> +		gen_led0 {

Please use hyphen instead of underscore in node name.

> +			label = "cpu0";
> +			gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "cpu0";
> +		};
> +
> +		gen_led1 {
> +			label = "cpu1";
> +			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "cpu1";
> +		};
> +
> +		gen_led2 {
> +			label = "heartbeat";
> +			gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		gen_led3 {
> +			label = "Always On";
> +			gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +	};

<snip>

> +	backlight_lcd: backlight-lcd {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_backlight>;
> +		enable-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm3 0 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +	};
> +
> +

One newline is enough.

> +	lcd_display: display at di0 {
> +		compatible = "fsl,imx-parallel-display";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interface-pix-fmt = "rgb565";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd>;
> +		status = "okay";
> +
> +		display-timings {
> +			native-mode = <&type15_timing>;

Have a newline between property list and child node.

> +			type15_timing: type_15 {

Can we have a better node name for this?  Also hyphen should be used in
node name.

> +				clock-frequency = <9000000>;
> +				hactive = <480>;
> +				vactive = <272>;
> +				hfront-porch = <3>;
> +				hback-porch = <2>;
> +				hsync-len = <42>;
> +				vback-porch = <3>;
> +				vfront-porch = <2>;
> +				vsync-len = <11>;
> +				hsync-active = <1>;
> +				vsync-active = <1>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +
> +		port at 0 {
> +			reg = <0>;
> +			display_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		port at 1 {
> +			reg = <1>;
> +			display_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +
> +	panel: panel {
> +		compatible = "innolux,at043tn24", "simple-panel";
> +		enable-gpios = <&gpio4 17 GPIO_ACTIVE_HIGH>;
> +		backlight = <&backlight_lcd>;

Have a newline between property list and child node.

> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&display_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&display_in>;
> +};
> +
> +&pwm3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm3>;
> +	status = "okay";
> +};
> +
> +

Drop one newline.

> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh1>;
> +	vbus-supply = <&reg_usb_h1_vbus>;
> +	status = "okay";
> +};
> +
> +&usbh2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh2>;
> +	phy_type = "hsic";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&fec {

Please sort these labeled nodes alphabetically.  The iomuxc can be an
exception, and we usually put it at the end of file to make the rest
easy to read.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rmii";
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	touchscreen: tsc2004 at 48 {
> +		compatible = "ti,tsc2004";
> +		vio-supply = <&reg_3v3>;
> +		reg = <0x48>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touchscreen>;
> +		reset-gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
> +		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_RISING>;
> +		touchscreen-fuzz-x = <4>;
> +		touchscreen-fuzz-y = <7>;
> +		touchscreen-fuzz-pressure = <2>;
> +		touchscreen-size-x = <4096>;
> +		touchscreen-size-y = <4096>;
> +		touchscreen-max-pressure = <2048>;
> +		ti,x-plate-ohms = <280>;
> +		ti,esd-recovery-timeout-ms = <8000>;
> +	};
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D23__UART3_CTS_B	0x1b0b1
> +			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_EIM_EB3__UART3_RTS_B	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usbotg: usbotggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_1__USB_OTG_ID	0x17059
> +			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x130b0
> +			>;

Bad indentation.

> +	};
> +
> +	pinctrl_usbh1: usbh1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_usbh2: usbh2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_RGMII_TXC__USB_H2_DATA      0x13030
> +			MX6QDL_PAD_RGMII_TX_CTL__USB_H2_STROBE 0x17030
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD2_CMD__SD2_CMD	0x17059
> +			MX6QDL_PAD_SD2_CLK__SD2_CLK	0x10059
> +			MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
> +			MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
> +			MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
> +			MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
> +		>;
> +	};
> +
> +	pinctrl_enet: enetgrp {

Please sort these pinctrl entries alphabetically.

> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO	0x1b0b0
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC	0x1b0b0
> +			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
> +			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
> +			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
> +			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
> +			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
> +			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
> +			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
> +			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
> +			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpioledsgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x130b0
> +			MX6QDL_PAD_EIM_D20__GPIO3_IO20	0x130b0
> +			MX6QDL_PAD_EIM_D21__GPIO3_IO21	0x130b0
> +			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x130b0
> +		>;
> +	};
> +
> +	pinctrl_gpio_keys: gpio_keysgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D28__GPIO3_IO28 0x1b0b0
> +			MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1b0b0
> +			MX6QDL_PAD_EIM_D30__GPIO3_IO30 0x1b0b0
> +			MX6QDL_PAD_EIM_D31__GPIO3_IO31 0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_touchscreen: touchscreengrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL2__GPIO4_IO10 0x1b0b0
> +			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_pcie_reg: pciereggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_pcie: pciegrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_7__GPIO1_IO07	0x1b0b0
> +			MX6QDL_PAD_GPIO_8__GPIO1_IO08	0x1b0b0
> +			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_lcd: lcdgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
> +			MX6QDL_PAD_DI0_PIN15__GPIO4_IO17	0x100b0
> +			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02	0x10
> +			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03	0x10
> +			MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04	0x10
> +			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
> +			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
> +			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
> +			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
> +			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
> +			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
> +			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
> +			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
> +			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
> +			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
> +			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
> +			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
> +			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
> +			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
> +			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
> +			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
> +		>;
> +	};
> +
> +	pinctrl_backlight: backlightgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10		0x100b0
> +	    >;

Fix whitespace.

> +	};
> +
> +	pinctrl_pwm3: pwm3grp {
> +	    fsl,pins = <
> +		MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
> +	    >;
> +	};
> +};
> +
> +

Drop the end-of-file newlines.

> diff --git a/arch/arm/boot/dts/imx6qdl-logicpd.dtsi b/arch/arm/boot/dts/imx6qdl-logicpd.dtsi
> new file mode 100644
> index 0000000..ca266a3
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-logicpd.dtsi
> @@ -0,0 +1,331 @@
> +/*
> + * Copyright 2016 Logic PD
> + * This file is adapted from imx6qdl-sabresd.dtsi.
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */

Please consider to use GPL/X11 dual licence for all new dts files.

> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "imx6q.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x80000000>;
> +	};
> +
> +

Unneeded newlines.

> +};
> +
> +/* Reroute power feeding the CPU to come from the external PMIC */
> +&cpu0 {
> +	arm-supply = <&sw1a_reg>;
> +	soc-supply = <&sw1c_reg>;
> +};
> +
> +&reg_arm
> +{

&reg_arm {

> +	vin-supply = <&sw1a_reg>;
> +};
> +
> +&reg_soc
> +{

Ditto

> +	vin-supply = <&sw1c_reg>;
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> +			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> +	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
> +				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	pmic: pfuze100 at 08 {
> +		compatible = "fsl,pfuze100";
> +		reg = <0x08>;
> +
> +		regulators {
> +			sw1a_reg: sw1ab {
> +				regulator-min-microvolt = <725000>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-name = "vddcore";
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw1c_reg: sw1c {
> +				regulator-min-microvolt = <725000>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-name = "vddsoc";
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "gen_3v3";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3a_reg: sw3a {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-name = "sw3a_vddr";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3b_reg: sw3b {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-name = "sw3b_vddr";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw4_reg: sw4 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "gen_rgmii";
> +			};
> +
> +			swbst_reg: swbst {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +				regulator-name = "gen_5v0";
> +			};
> +
> +

Drop one newline.

> +			snvs_reg: vsnvs {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-name = "gen_vsns";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vref_reg: vrefddr {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vgen1_reg: vgen1 {
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-name = "gen_1v5";
> +			};
> +
> +			vgen2_reg: vgen2 {
> +				regulator-name = "vgen2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen3_reg: vgen3 {
> +				regulator-name = "gen_vadj_0";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +
> +			vgen4_reg: vgen4 {
> +				regulator-name = "gen_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen5_reg: vgen5 {
> +				regulator-name = "gen_adj_1";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen6_reg: vgen6 {
> +				regulator-name = "gen_2v5";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	temp_sense1: tmp102 at 49 {
> +		compatible = "ti,tmp102";
> +		reg = <0x49>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tempsense>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +
> +	temp_sense0: tmp102 at 4a {
> +		compatible = "ti,tmp102";
> +		reg = <0x4a>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +
> +	user_eeprom: at24 at 52 {
> +		compatible = "atmel,24c64";
> +		pagesize = <32>;
> +		reg = <0x52>;
> +	};
> +
> +	mfg_eeprom: at24 at 51 {
> +		compatible = "atmel,24c64";
> +		pagesize = <32>;
> +		read-only;
> +		reg = <0x51>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_gpmi_nand: gpminandgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0x0b0b1
> +			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0x0b0b1
> +			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0x0b0b1
> +			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0x0b000
> +			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0x0b0b1
> +			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0x0b0b1
> +			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0x0b0b1
> +			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0x0b0b1
> +			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0x0b0b1
> +			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0x0b0b1
> +			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0x0b0b1
> +			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0x0b0b1
> +			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0x0b0b1
> +			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0x0b0b1
> +			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0x0b0b1
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
> +			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_SD4_DAT5__UART2_RTS_B	0x1b0b1
> +			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
> +			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17071
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10071
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17071
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17071
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17071
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17071
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
> +			MX6QDL_PAD_SD3_RST__GPIO7_IO08	0x1f0b0
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
> +			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01	0x1f0b0
> +			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00	0x1f0b0
> +		>;
> +	};
> +
> +	pinctrl_tempsense: tempsensegrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x1b0b0
> +		>;
> +	};
> +};
> +
> +&snvs_poweroff {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	cd-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	non-removable;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	vmmc-supply = <&sw2_reg>;
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;

Have a newline between property list and child node.


> +	wlcore: wlcore at 0 {
> +		  compatible = "ti,wl1837";
> +		  reg = <0>;
> +		  interrupt-parent = <&gpio7>;
> +		  interrupts = <1 GPIO_ACTIVE_HIGH>;
> +	};
> +};

Shawn
