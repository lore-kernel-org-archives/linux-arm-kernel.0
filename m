From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 May 2015 22:34:22 +0800
Subject: [PATCH V8 5/6] arm: dts: add imx7d-sdb support
In-Reply-To: <1431020158-13789-6-git-send-email-Frank.Li@freescale.com>
References: <1431020158-13789-1-git-send-email-Frank.Li@freescale.com>
 <1431020158-13789-6-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150511143420.GN9347@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 01:35:57AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> add imx7d sdb board support
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Use "ARM: dts: ..." for sake of consistency.

> ---
>  arch/arm/boot/dts/Makefile      |   2 +
>  arch/arm/boot/dts/imx7d-sdb.dts | 420 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 422 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-sdb.dts

[...]

> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_usb_otg1_vbus: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "usb_otg1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +		};
> +
> +		reg_usb_otg2_vbus: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "usb_otg2_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +		};
> +
> +		reg_can2_3v3: regulator at 2 {
> +			compatible = "regulator-fixed";
> +			reg = <2>;
> +			regulator-name = "can2-3v3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		reg_vref_1v8: regulator at 3 {
> +			compatible = "regulator-fixed";

reg= <3>;

> +			regulator-name = "vref-1v8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		wlreg_on: fixedregulator at 100 {

fixedregulator? @100?

> +			compatible = "regulator-fixed";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-name = "wlreg_on";
> +			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	arm-supply = <&sw1a_reg>;
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;

This is the default case, so it can just be saved.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
[...]
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;

Ditto

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;

Ditto

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	clock-frequency = <100000>;

Ditto

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	codec: wm8960 at 1a {
> +		compatible = "wlf,wm8960";
> +		reg = <0x1a>;
> +		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
> +		clock-names = "mclk";
> +		wlf,shared-lrclk;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog_1>;

The suffix "_1" makes no sense.

> +
> +	imx7d-sdb {
> +		pinctrl_hog_1: hoggrp-1 {

pinctrl_hog: hoggrp

> +			fsl,pins = <
> +				MX7D_PAD_UART3_CTS_B__GPIO4_IO7	0x14
> +				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23	 0x34  /* bt reg on */
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX7D_PAD_I2C1_SDA__I2C1_SDA	0x4000007f
> +				MX7D_PAD_I2C1_SCL__I2C1_SCL	0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX7D_PAD_I2C2_SDA__I2C2_SDA	0x4000007f
> +				MX7D_PAD_I2C2_SCL__I2C2_SCL	0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX7D_PAD_I2C3_SDA__I2C3_SDA          0x4000007f
> +				MX7D_PAD_I2C3_SCL__I2C3_SCL          0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c4: i2c4grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
> +				MX7D_PAD_SAI1_RX_SYNC__I2C4_SCL		0x4000007f

Please make the indentation of pad config value better aligned with
other nodes.

> +			>;
> +		};
> +
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX 0x79
> +				MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX 0x79
> +			>;
> +		};
> +
> +		pinctrl_uart5: uart5grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_TX_BCLK__UART5_DCE_TX 0x79
> +				MX7D_PAD_SAI1_RX_DATA__UART5_DCE_RX 0x79
> +				MX7D_PAD_SAI1_TX_SYNC__UART5_DCE_CTS 0x79
> +				MX7D_PAD_SAI1_TX_DATA__UART5_DCE_RTS 0x79
> +			>;
> +		};
> +
> +		pinctrl_uart6: uart6grp {
> +			fsl,pins = <
> +				MX7D_PAD_ECSPI1_MOSI__UART6_DCE_TX 0x79
> +				MX7D_PAD_ECSPI1_SCLK__UART6_DCE_RX 0x79
> +				MX7D_PAD_ECSPI1_SS0__UART6_DCE_CTS 0x79
> +				MX7D_PAD_ECSPI1_MISO__UART6_DCE_RTS 0x79
> +			>;
> +		};
> +
> +		pinctrl_usdhc1: usdhc1grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CMD__SD1_CMD	0x59
> +				MX7D_PAD_SD1_CLK__SD1_CLK	0x19
> +				MX7D_PAD_SD1_DATA0__SD1_DATA0	0x59
> +				MX7D_PAD_SD1_DATA1__SD1_DATA1	0x59
> +				MX7D_PAD_SD1_DATA2__SD1_DATA2	0x59
> +				MX7D_PAD_SD1_DATA3__SD1_DATA3	0x59
> +				MX7D_PAD_SD1_CD_B__GPIO5_IO0	0x59 /* CD */
> +				MX7D_PAD_SD1_WP__GPIO5_IO1	0x59 /* WP */
> +				MX7D_PAD_SD1_RESET_B__GPIO5_IO2	0x59 /* vmmc */
> +			>;
> +		};
> +
> +		pinctrl_usdhc2: usdhc2grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD2_CMD__SD2_CMD       0x59
> +				MX7D_PAD_SD2_CLK__SD2_CLK       0x19
> +				MX7D_PAD_SD2_DATA0__SD2_DATA0   0x59
> +				MX7D_PAD_SD2_DATA1__SD2_DATA1   0x59
> +				MX7D_PAD_SD2_DATA2__SD2_DATA2   0x59
> +				MX7D_PAD_SD2_DATA3__SD2_DATA3   0x59
> +				MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x59 /* WL_REG_ON */
> +			>;
> +		};
> +
> +		pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
> +			fsl,pins = <
> +				MX7D_PAD_SD2_CMD__SD2_CMD       0x5a
> +				MX7D_PAD_SD2_CLK__SD2_CLK       0x1a
> +				MX7D_PAD_SD2_DATA0__SD2_DATA0   0x5a
> +				MX7D_PAD_SD2_DATA1__SD2_DATA1   0x5a
> +				MX7D_PAD_SD2_DATA2__SD2_DATA2   0x5a
> +				MX7D_PAD_SD2_DATA3__SD2_DATA3   0x5a
> +			>;
> +		};
> +
> +		pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
> +			fsl,pins = <
> +				MX7D_PAD_SD2_CMD__SD2_CMD       0x5b
> +				MX7D_PAD_SD2_CLK__SD2_CLK       0x1b
> +				MX7D_PAD_SD2_DATA0__SD2_DATA0   0x5b
> +				MX7D_PAD_SD2_DATA1__SD2_DATA1   0x5b
> +				MX7D_PAD_SD2_DATA2__SD2_DATA2   0x5b
> +				MX7D_PAD_SD2_DATA3__SD2_DATA3   0x5b
> +			>;
> +		};
> +
> +
> +		pinctrl_usdhc3: usdhc3grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD3_CMD__SD3_CMD	0x59
> +				MX7D_PAD_SD3_CLK__SD3_CLK	0x19
> +				MX7D_PAD_SD3_DATA0__SD3_DATA0	0x59
> +				MX7D_PAD_SD3_DATA1__SD3_DATA1	0x59
> +				MX7D_PAD_SD3_DATA2__SD3_DATA2	0x59
> +				MX7D_PAD_SD3_DATA3__SD3_DATA3	0x59
> +				MX7D_PAD_SD3_DATA4__SD3_DATA4	0x59
> +				MX7D_PAD_SD3_DATA5__SD3_DATA5	0x59
> +				MX7D_PAD_SD3_DATA6__SD3_DATA6	0x59
> +				MX7D_PAD_SD3_DATA7__SD3_DATA7	0x59
> +				MX7D_PAD_SD3_STROBE__SD3_STROBE	0x19
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
> +			fsl,pins = <
> +				MX7D_PAD_SD3_CMD__SD3_CMD	0x5a
> +				MX7D_PAD_SD3_CLK__SD3_CLK	0x1a
> +				MX7D_PAD_SD3_DATA0__SD3_DATA0	0x5a
> +				MX7D_PAD_SD3_DATA1__SD3_DATA1	0x5a
> +				MX7D_PAD_SD3_DATA2__SD3_DATA2	0x5a
> +				MX7D_PAD_SD3_DATA3__SD3_DATA3	0x5a
> +				MX7D_PAD_SD3_DATA4__SD3_DATA4	0x5a
> +				MX7D_PAD_SD3_DATA5__SD3_DATA5	0x5a
> +				MX7D_PAD_SD3_DATA6__SD3_DATA6	0x5a
> +				MX7D_PAD_SD3_DATA7__SD3_DATA7	0x5a
> +				MX7D_PAD_SD3_STROBE__SD3_STROBE	0x1a
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
> +			fsl,pins = <
> +				MX7D_PAD_SD3_CMD__SD3_CMD	0x5b
> +				MX7D_PAD_SD3_CLK__SD3_CLK	0x1b
> +				MX7D_PAD_SD3_DATA0__SD3_DATA0	0x5b
> +				MX7D_PAD_SD3_DATA1__SD3_DATA1	0x5b
> +				MX7D_PAD_SD3_DATA2__SD3_DATA2	0x5b
> +				MX7D_PAD_SD3_DATA3__SD3_DATA3	0x5b
> +				MX7D_PAD_SD3_DATA4__SD3_DATA4	0x5b
> +				MX7D_PAD_SD3_DATA5__SD3_DATA5	0x5b
> +				MX7D_PAD_SD3_DATA6__SD3_DATA6	0x5b
> +				MX7D_PAD_SD3_DATA7__SD3_DATA7	0x5b
> +				MX7D_PAD_SD3_STROBE__SD3_STROBE	0x1b
> +			>;
> +		};
> +
> +	};
> +};

I suggest to put iomuxc at the bottom of the file to make it easier to
read, as iomuxc node will have quite a lot of pin configuration data,
which makes searching of particular device data a bit harder.

Shawn

> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	cd-gpios = <&gpio5 0 0>;
> +	wp-gpios = <&gpio5 1 0>;
> +	enable-sdio-wakeup;
> +	keep-power-in-suspend;
> +	status = "okay";
> +};
> -- 
> 1.9.1
> 
