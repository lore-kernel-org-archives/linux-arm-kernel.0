From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Aug 2016 14:59:26 +0800
Subject: [PATCH v2 2/2] ARM: dts: imx53: add support for USB armory board
In-Reply-To: <20160628125444.16531-3-andrej@inversepath.com>
References: <20160628125444.16531-1-andrej@inversepath.com>
 <20160628125444.16531-3-andrej@inversepath.com>
Message-ID: <20160808065926.GA4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 02:54:44PM +0200, andrej at inversepath.com wrote:
> +&iomuxc {
> +	pinctrl_esdhc1: esdhc1grp {
> +		fsl,pins = <
> +			MX53_PAD_SD1_DATA0__ESDHC1_DAT0		0x1d5
> +			MX53_PAD_SD1_DATA1__ESDHC1_DAT1		0x1d5
> +			MX53_PAD_SD1_DATA2__ESDHC1_DAT2		0x1d5
> +			MX53_PAD_SD1_DATA3__ESDHC1_DAT3		0x1d5
> +			MX53_PAD_SD1_CMD__ESDHC1_CMD		0x1d5
> +			MX53_PAD_SD1_CLK__ESDHC1_CLK		0x1d5
> +		>;
> +	};
> +
> +	pinctrl_i2c1_pmic: i2c1grp_pmic {

I think the following naming is good enough.

	pinctrl_i2c1: i2c1grp {

> +		fsl,pins = <
> +			MX53_PAD_EIM_D21__I2C1_SCL	0x0
> +			MX53_PAD_EIM_D28__I2C1_SDA	0x0
> +		>;
> +	};
> +
> +	pinctrl_led: led {

For naming consistency, "ledgrp" should be a better node name.

> +		fsl,pins = <
> +			MX53_PAD_DISP0_DAT6__GPIO4_27 0x0
> +		>;
> +	};
> +
> +	/*
> +	 * UART mode pin header configration
> +	 * 3 - GPIO5[26], pull-down 100K
> +	 * 4 - GPIO5[27], pull-down 100K
> +	 * 5 - TX, pull-up 100K
> +	 * 6 - RX, pull-up 100K
> +	 * 7 - GPIO5[30], pull-down 100K
> +	 */
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX53_PAD_CSI0_DAT8__GPIO5_26		0xc0
> +			MX53_PAD_CSI0_DAT9__GPIO5_27		0xc0
> +			MX53_PAD_CSI0_DAT10__UART1_TXD_MUX	0x1e4
> +			MX53_PAD_CSI0_DAT11__UART1_RXD_MUX	0x1e4
> +			MX53_PAD_CSI0_DAT12__GPIO5_30		0xc0
> +		>;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-0 = <&pinctrl_i2c1_pmic>;
> +	status = "okay";
> +
> +	ltc3589: pmic at 34 {
> +		compatible = "lltc,ltc3589-2";
> +		reg = <0x34>;
> +
> +		regulators {
> +			sw1_reg: sw1 {
> +				regulator-min-microvolt = <591930>;
> +				regulator-max-microvolt = <1224671>;
> +				lltc,fb-voltage-divider = <100000 158000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-min-microvolt = <704123>;
> +				regulator-max-microvolt = <1456803>;
> +				lltc,fb-voltage-divider = <180000 191000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3_reg: sw3 {
> +				regulator-min-microvolt = <1341250>;
> +				regulator-max-microvolt = <2775000>;
> +				lltc,fb-voltage-divider = <270000 100000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			bb_out_reg: bb-out {
> +				regulator-min-microvolt = <3387341>;
> +				regulator-max-microvolt = <3387341>;
> +				lltc,fb-voltage-divider = <511000 158000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};

Have a new line between nodes.

Shawn

> +			ldo1_reg: ldo1 {
> +				regulator-min-microvolt = <1306329>;
> +				regulator-max-microvolt = <1306329>;
> +				lltc,fb-voltage-divider = <100000 158000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-min-microvolt = <704123>;
> +				regulator-max-microvolt = <1456806>;
> +				lltc,fb-voltage-divider = <180000 191000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: ldo3 {
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-boot-on;
> +			};
> +
> +			ldo4_reg: ldo4 {
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3200000>;
> +			};
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> -- 
> 2.9.0
> 
