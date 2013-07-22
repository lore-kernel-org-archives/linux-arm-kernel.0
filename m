From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon, 22 Jul 2013 17:11:04 -0500
Subject: [PATCH v2 1/2] ARM: dts: mx6: Add support for mx6q nitrogen board
In-Reply-To: <1374530056-31335-1-git-send-email-festevam@gmail.com>
References: <1374530056-31335-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOCHtYhB3b4PeYMYqsErUunF=Tbk=WY4tP=Lq9K15Cr98M0zpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen.dtsi
> new file mode 100644
> index 0000000..948063e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen.dtsi
> @@ -0,0 +1,161 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/ {
> +       regulators {
> +               compatible = "simple-bus";
> +
> +               reg_2p5v: 2p5v {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "2P5V";
> +                       regulator-min-microvolt = <2500000>;
> +                       regulator-max-microvolt = <2500000>;
> +                       regulator-always-on;
> +               };
> +
> +               reg_3p3v: 3p3v {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "3P3V";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-always-on;
> +               };
> +
> +               reg_usb_otg_vbus: usb_otg_vbus {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "usb_otg_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       gpio = <&gpio3 22 0>;
> +                       enable-active-high;
> +               };
> +       };
> +
> +       sound {
> +               compatible = "fsl,imx6q-sabrelite-sgtl5000",
> +                            "fsl,imx-audio-sgtl5000";
> +               model = "imx6q-sabrelite-sgtl5000";
> +               ssi-controller = <&ssi1>;
> +               audio-codec = <&codec>;
> +               audio-routing =
> +                       "MIC_IN", "Mic Jack",
> +                       "Mic Jack", "Mic Bias",
> +                       "Headphone Jack", "HP_OUT";
> +               mux-int-port = <1>;
> +               mux-ext-port = <4>;
> +       };
> +};
> +
> +&audmux {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_audmux_1>;
> +};
> +
> +&ecspi1 {
> +       fsl,spi-num-chipselects = <1>;
> +       cs-gpios = <&gpio3 19 0>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1_1>;
> +       status = "okay";
> +
> +       flash: m25p80 at 0 {
> +               compatible = "sst,sst25vf016b";
> +               spi-max-frequency = <20000000>;
> +               reg = <0>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1_1>;
> +
> +       codec: sgtl5000 at 0a {
> +               compatible = "fsl,sgtl5000";
> +               reg = <0x0a>;
> +               clocks = <&clks 169>;
> +               VDDA-supply = <&reg_2p5v>;
> +               VDDIO-supply = <&reg_3p3v>;
> +       };
> +};
> +
> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog>;
> +
> +       hog {
> +               pinctrl_hog: hoggrp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x80000000
> +                               MX6QDL_PAD_NANDF_D7__GPIO2_IO07 0x80000000
> +                               MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
> +                               MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
> +                               MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
> +                               MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000
> +                               MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0
> +                               MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
> +                       >;
> +               };
> +       };
> +};
> +
> +&fec {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet_1>;
> +       phy-mode = "rgmii";
> +       phy-reset-gpios = <&gpio3 23 0>;

This reset gpio is only good for the sabrelite, the Nitrogen use a
different gpio..

"phy-reset-gpios = <&gpio1 27 0>;"...

https://github.com/boundarydevices/u-boot-2009-08/commit/965c16903f3b15c24634b95feff85b8f14a31c66#L0R704
http://boundarydevices.com/differences-sabre-lite-nitrogen6x-and-som/

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
