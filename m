From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 1 Jul 2018 10:35:19 +0800
Subject: [PATCH 1/2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL
 System-On-Module (SOM)
In-Reply-To: <1529393534-7827-2-git-send-email-alex.gonzalez@digi.com>
References: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
 <1529393534-7827-2-git-send-email-alex.gonzalez@digi.com>
Message-ID: <20180701023518.GB4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 09:32:13AM +0200, Alex Gonzalez wrote:
> The ConnectCore 6UL System-On-Module has the following hardware
> specification:
> 
> * Based on a NXP i.MX6UL SoC
> * Industrial temperature ranges (-40?C to +85?C)
> * Up to 1GB DDR3 memory
> * Up to 2GB NAND flash
> * Dual Ethernet
> * On module 802.11 WiFi and Bluetooth 4.2 (QCA6564)
> * On module NXP Kinetis KL03
> * On module Microchip ATECC508A crypto element
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 199 ++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> new file mode 100644
> index 000000000000..23484a48f6e0
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Digi International's ConnectCore 6UL System-On-Module device tree source
> + *
> + * Copyright 2018 Digi International, Inc.
> + *
> + */
> +
> +/ {
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x4000000>;
> +			linux,cma-default;
> +		};
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&vdda_adc_3v3>;
> +	max-channel = <9>;

Undocumented DT property?

> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic: pfuze3000 at 8 {

Node name should be generic, while label can be specific.

	pfuze3000: pmic at 8 {

> +		compatible = "fsl,pfuze3000";
> +		reg = <0x08>;
> +
> +		regulators {
> +			int_3v3: sw1a {
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-boot-on;
> +				regulator-always-on;

Please have a newline between property list and child node.

> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_arm_soc_in: sw1b {
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1475000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <925000>;
> +				};
> +			};
> +
> +			ext_3v3: sw2 {
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr3: sw3 {
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1650000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1300000>;
> +				};
> +			};
> +
> +			swbst_reg: swbst {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +			};
> +
> +			vdd_snvs_3v3: vsnvs {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vrefddr: vrefddr {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdda_adc_3v3: vldo1 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vref-adc-3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo2_ext: vldo2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vdda_wlan: vccsd {
> +				regulator-min-microvolt = <2850000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_high_in: v33 {
> +				regulator-min-microvolt = <2850000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_int: vldo3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo4_ext: vldo4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			vcoin_chg: vcoin {
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	imx6ul-ccimx6ul {

This container node can be dropped.

Shawn

> +		pinctrl_gpmi_nand: gpmigrp {
> +			fsl,pins = <
> +				MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
> +				MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
> +				MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
> +				MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
> +				MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
> +				MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
> +				MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
> +				MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
> +				MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
> +				MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
> +				MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
> +				MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
> +				MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
> +				MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
> +				MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb0b1
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
> +				MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
> +			>;
> +		};
> +	};
> +};
> +
> +&reg_arm {
> +	vin-supply = <&vdd_arm_soc_in>;
> +	regulator-allow-bypass;
> +};
> +
> +&reg_soc {
> +	vin-supply = <&vdd_arm_soc_in>;
> +	regulator-allow-bypass;
> +};
> +
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
