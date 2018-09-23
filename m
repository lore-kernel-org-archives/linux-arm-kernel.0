From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 23 Sep 2018 11:32:17 -0300
Subject: [PATCH] ARM: dts: Add support for Liebherr's BK4 device (vf610
 based)
In-Reply-To: <20180921152726.31742-1-lukma@denx.de>
References: <20180921152726.31742-1-lukma@denx.de>
Message-ID: <CAOMZO5DPnWNJ_UVdE9Lvh05R84seP8VPP=35eEUaor4-pppXGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 12:27 PM, Lukasz Majewski <lukma@denx.de> wrote:
> This commit adds DTS support for BK4 device from Liebherr. It
> uses vf610 SoC from NXP.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/Makefile      |   1 +
>  arch/arm/boot/dts/vf610-bk4.dts | 504 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 505 insertions(+)
>  create mode 100644 arch/arm/boot/dts/vf610-bk4.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..e6f159895fa9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -577,6 +577,7 @@ dtb-$(CONFIG_SOC_LS1021A) += \
>         ls1021a-twr.dtb
>  dtb-$(CONFIG_SOC_VF610) += \
>         vf500-colibri-eval-v3.dtb \
> +       vf610-bk4.dtb \
>         vf610-colibri-eval-v3.dtb \
>         vf610m4-colibri.dtb \
>         vf610-cosmic.dtb \
> diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
> new file mode 100644
> index 000000000000..4ad7e739a0ad
> --- /dev/null
> +++ b/arch/arm/boot/dts/vf610-bk4.dts
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
> + */
> +
> +/dts-v1/;
> +#include "vf610.dtsi"
> +
> +/ {
> +       model = "Liebherr BK4 controller";
> +       compatible = "lwn,bk4", "fsl,vf610";
> +
> +       chosen {
> +               bootargs = "console=ttyLP1,115200";

You could pass stdout-path instead.

> +       };
> +
> +       memory at 80000000 {
> +               reg = <0x80000000 0x8000000>;
> +       };
> +
> +       audio_ext: mclk_osc {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <24576000>;
> +       };

This seems to be unused.

> +
> +       enet_ext: eth_osc {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <50000000>;
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +               /* LED D5 */
> +               led0: heartbeat {
> +                       label = "heartbeat";
> +                       gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +                       default-state = "on";
> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg_3p3v: regulator at 0 {

Please move all regulators outside of the simple-bus container and use
this naming convention:

reg_3p3v: regulator-3p3v {

> +&dspi3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_dspi3>;
> +       bus-num = <3>;
> +       status = "okay";
> +
> +       spidev3 at 0 {
> +               compatible = "fsl,vf610-dspi";
> +               spi-max-frequency = <30000000>;
> +               reg = <0>;
> +               fsl,spi-slave-mode;

Such property does not exist.

I also thought that spidev nodes in dt were not recommended.

> +&iomuxc {

Like Stefan mentioned it is common practice on imx dts files to place
the iomuxc node as the last one.


> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_bk4_common>;

This seems to be not called from any driver.

We usually use a hog group for such purpose.

> +
> +       pinctrl_bk4_common: commongrp {
> +               fsl,pins = <
> +                       /* One_Wire_PSU_EN */
> +                       VF610_PAD_PTC29__GPIO_102               0x1183
> +                       /* SPI */
> +                       VF610_PAD_PTB26__GPIO_96                0x1183
> +                       VF610_PAD_PTE14__GPIO_119               0x1183
> +                       VF610_PAD_PTE4__GPIO_109                0x1181
> +                       /* Feedback_Lines */
> +                       VF610_PAD_PTC31__GPIO_104               0x1181
> +                       VF610_PAD_PTA7__GPIO_134                0x1181
> +                       VF610_PAD_PTD9__GPIO_88         0x1181
> +                       VF610_PAD_PTE1__GPIO_106                0x1183
> +                       VF610_PAD_PTB2__GPIO_24         0x1181
> +                       VF610_PAD_PTB3__GPIO_25         0x1181
> +                       VF610_PAD_PTB1__GPIO_23         0x1181
> +                       /* SDHC */
> +                       VF610_PAD_PTE19__GPIO_124               0x1183
> +                       VF610_PAD_PTB23__GPIO_93                0x1181

If they are related to SDHC they should be better placed under the sdhc nodes.


> +                       /* GPI */
> +                       VF610_PAD_PTE2__GPIO_107                0x1181
> +                       VF610_PAD_PTE3__GPIO_108                0x1181
> +                       VF610_PAD_PTE5__GPIO_110                0x1181
> +                       VF610_PAD_PTE6__GPIO_111                0x1181
> +                       /* GPO */
> +                       VF610_PAD_PTE0__GPIO_105                0x1183
> +                       VF610_PAD_PTE7__GPIO_112                0x1183
> +                       /* RS485 */
> +                       VF610_PAD_PTB8__GPIO_30         0x1183
> +                       VF610_PAD_PTB9__GPIO_31         0x1183
> +                       VF610_PAD_PTE8__GPIO_113                0x1183
> +                       /* MPBUS MPB_EN */
> +                       VF610_PAD_PTE28__GPIO_133               0x1183
> +                       /* LEDS */
> +                       VF610_PAD_PTE15__GPIO_120               0x1183
> +                       VF610_PAD_PTA12__GPIO_5         0x1183
> +                       VF610_PAD_PTA16__GPIO_6         0x1183
> +                       VF610_PAD_PTE9__GPIO_114                0x1183
> +                       VF610_PAD_PTE20__GPIO_125               0x1183
> +                       VF610_PAD_PTE23__GPIO_128               0x1183
> +                       VF610_PAD_PTE16__GPIO_121               0x1183
> +                       /* MISC */
> +                       VF610_PAD_PTE10__GPIO_115               0x1183
> +                       VF610_PAD_PTE11__GPIO_116               0x1183
> +                       VF610_PAD_PTE17__GPIO_122               0x1183
> +                       VF610_PAD_PTC30__GPIO_103               0x1183
> +                       VF610_PAD_PTB0__GPIO_22         0x1181
> +                       /* RESETINFO */
> +                       VF610_PAD_PTE26__GPIO_131               0x1183
> +                       VF610_PAD_PTD6__GPIO_85         0x1181
> +                       VF610_PAD_PTE27__GPIO_132               0x1181
> +                       VF610_PAD_PTE13__GPIO_118               0x1181
> +                       VF610_PAD_PTE21__GPIO_126               0x1181
> +                       VF610_PAD_PTE22__GPIO_127               0x1181
> +                       /* EE_5V_EN */
> +                       VF610_PAD_PTE18__GPIO_123               0x1183
> +                       /* EE_5V_OC_N */
> +                       VF610_PAD_PTE25__GPIO_130               0x1181

Seems like a long list of pins without any driver associated.

Please review such list carefully and assign to nodes that have a
driver associated, such as rs485,LEDS, etc.

> +
> +&usbphy0 {
> +       status = "okay";
> +};
> +
> +&usbphy1 {
> +       status = "okay";
> +};
> +
> +&qspi0 {

This is not placed in alphabetical order.
