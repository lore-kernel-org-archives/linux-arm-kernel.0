From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Feb 2018 00:44:42 -0200
Subject: [PATCH v3 2/2] ARM: dts: imx: Add basic dts support for imx6sll
 EVK board
In-Reply-To: <1517969481-13411-2-git-send-email-ping.bai@nxp.com>
References: <1517969481-13411-1-git-send-email-ping.bai@nxp.com>
 <1517969481-13411-2-git-send-email-ping.bai@nxp.com>
Message-ID: <CAOMZO5DEvVsGbbG_w116OX625DJos0GHsmjUUBkgwVk7NLONMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 7, 2018 at 12:11 AM, Bai Ping <ping.bai@nxp.com> wrote:

> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sll-evk.dts
> @@ -0,0 +1,374 @@
> +/*
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017-2018 NXP.
> + *
> + * SPDX-License-Identifier: (GPL-2.0 OR MIT)

The SPDX line should be the first one and it should start with //

> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "imx6sll.dtsi"
> +
> +/ {
> +       model = "Freescale i.MX6SLL EVK Board";
> +       compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
> +
> +       memory {

memory at 80000000

> +               reg = <0x80000000 0x80000000>;

> +       reg_aud4v: reg-aud4v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "wm8962-supply-4v2";
> +               regulator-min-microvolt = <4325000>;
> +               regulator-max-microvolt = <4325000>;
> +               regulator-boot-on;
> +       };
> +
> +       reg_lcd: reg-lcd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "lcd-pwr";
> +               gpio = <&gpio4 8 0>;

Please use GPIO_ACTIVE_HIGH here.


> +&i2c1 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       pmic: pfuze100 at 08 {

Please remove the leading 0, so this should be @8.

Please build it with W=1 and make sure it generates no warnings.

> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog0>, <&pinctrl_hog1>;
> +
> +       pinctrl_hog0: hog0grp {
> +               pinmux = <
> +                       MX6SLL_PAD_KEY_ROW7__GPIO4_IO07
> +                       MX6SLL_PAD_GPIO4_IO22__GPIO4_IO22
> +                       MX6SLL_PAD_KEY_COL3__GPIO3_IO30
> +                       MX6SLL_PAD_KEY_COL4__GPIO4_IO00
> +                       MX6SLL_PAD_REF_CLK_32K__GPIO3_IO22 /* SD3 CD */

I see no SD3 pinctrl entry. If this is related to SD3 card detection,
then it should be part of SD3 pinctrl instead of hog.


> +                       MX6SLL_PAD_KEY_COL6__GPIO4_IO04 /*SD3 RESET */

Same here.

> +                       MX6SLL_PAD_KEY_COL5__GPIO4_IO02
> +                       MX6SLL_PAD_GPIO4_IO24__GPIO4_IO24 /* HP DETECT */

Does HP mean head phone? If so, this should be part of audio pinctrl
instead of hog.


> +&usdhc1 {
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 = <&pinctrl_usdhc1_data>, <&pinctrl_usdhc1_clk>;
> +       pinctrl-1 = <&pinctrl_usdhc1_data_100mhz>, <&pinctrl_usdhc1_clk_100mhz>;
> +       pinctrl-2 = <&pinctrl_usdhc1_data_200mhz>, <&pinctrl_usdhc1_clk_200mhz>;
> +       cd-gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
> +       wp-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
> +       keep-power-in-suspend;
> +       enable-sdio-wakeup;

This property is deprecated as described in
Documentation/devicetree/bindings/mmc/mmc.txt.

Please use 'wakeup-source' instead.
