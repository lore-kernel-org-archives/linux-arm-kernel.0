From: andrey.gusakov@cogentembedded.com (Andrey Gusakov)
Date: Mon, 2 Jul 2018 11:21:36 +0300
Subject: [PATCH 1/3] ARM: dts: imx51-zii-common: create common include dtsi
In-Reply-To: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
 <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
Message-ID: <CAFmnZc0a=90fmXQ3qzZTkkJ08=pQuSoqp4xUX34fhZ_vOiRyYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'll rework this patchset without dtsi and resend.

Thanks for comments.

On Thu, Jun 21, 2018 at 8:44 PM, Andrey Gusakov
<andrey.gusakov@cogentembedded.com> wrote:
> Make shared include file. Move common stuff from rdu1 dts file to
> dtsi for future reuse by other imx51 based boards from ZII.
>
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> ---
>  arch/arm/boot/dts/imx51-zii-common.dtsi | 317 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx51-zii-rdu1.dts    | 330 +++-----------------------------
>  2 files changed, 347 insertions(+), 300 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx51-zii-common.dtsi
>
> diff --git a/arch/arm/boot/dts/imx51-zii-common.dtsi b/arch/arm/boot/dts/imx51-zii-common.dtsi
> new file mode 100644
> index 0000000..b0f0643
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx51-zii-common.dtsi
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright (C) 2018 Zodiac Inflight Innovations
> +
> +#include "imx51.dtsi"
> +
> +/ {
> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
> +       /* Will be filled by the bootloader */
> +       memory at 90000000 {
> +               reg = <0x90000000 0>;
> +       };
> +
> +       i2c_gpio: i2c-gpio {
> +               compatible = "i2c-gpio";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_swi2c>;
> +               i2c-gpio,delay-us = <50>;
> +               status = "okay";
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
> +
> +       usb_vbus: regulator-usb-vbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +};
> +
> +&cpu {
> +       cpu-supply = <&sw1_reg>;
> +};
> +
> +&ecspi1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
> +                  <&gpio4 25 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +
> +       pmic at 0 {
> +               compatible = "fsl,mc13892";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_pmic>;
> +               spi-max-frequency = <6000000>;
> +               spi-cs-high;
> +               reg = <0>;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
> +               fsl,mc13xxx-uses-adc;
> +
> +               regulators {
> +                       sw1_reg: sw1 {
> +                               regulator-min-microvolt = <600000>;
> +                               regulator-max-microvolt = <1375000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       sw2_reg: sw2 {
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <1850000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       sw3_reg: sw3 {
> +                               regulator-min-microvolt = <1100000>;
> +                               regulator-max-microvolt = <1850000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       sw4_reg: sw4 {
> +                               regulator-min-microvolt = <1100000>;
> +                               regulator-max-microvolt = <1850000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       vpll_reg: vpll {
> +                               regulator-min-microvolt = <1050000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       vdig_reg: vdig {
> +                               regulator-min-microvolt = <1650000>;
> +                               regulator-max-microvolt = <1650000>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       vsd_reg: vsd {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3150000>;
> +                       };
> +
> +                       vusb_reg: vusb {
> +                               regulator-always-on;
> +                       };
> +
> +                       vusb2_reg: vusb2 {
> +                               regulator-min-microvolt = <2400000>;
> +                               regulator-max-microvolt = <2775000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       vvideo_reg: vvideo {
> +                               regulator-min-microvolt = <2775000>;
> +                               regulator-max-microvolt = <2775000>;
> +                       };
> +
> +                       vaudio_reg: vaudio {
> +                               regulator-min-microvolt = <2300000>;
> +                               regulator-max-microvolt = <3000000>;
> +                       };
> +
> +                       vcam_reg: vcam {
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <3000000>;
> +                       };
> +
> +                       vgen1_reg: vgen1 {
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                       };
> +
> +                       vgen2_reg: vgen2 {
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3150000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen3_reg: vgen3 {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2900000>;
> +                               regulator-always-on;
> +                       };
> +               };
> +
> +               leds {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       led-control = <0x0 0x0 0x3f83f8 0x0>;
> +
> +                       sysled3: led3 at 3 {
> +                               reg = <3>;
> +                               label = "system:red:power";
> +                               linux,default-trigger = "default-on";
> +                       };
> +
> +                       sysled4: led4 at 4 {
> +                               reg = <4>;
> +                               label = "system:green:act";
> +                               linux,default-trigger = "heartbeat";
> +                       };
> +               };
> +       };
> +
> +       flash at 1 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "atmel,at45", "atmel,dataflash";
> +               spi-max-frequency = <25000000>;
> +               reg = <1>;
> +       };
> +};
> +
> +&ecspi2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi2>;
> +       cs-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>,
> +                  <&gpio3 28 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&esdhc1 {
> +       non-removable;
> +       no-1-8-v;
> +       no-sdio;
> +       no-sd;
> +       status = "okay";
> +};
> +
> +&esdhc4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_esdhc4>;
> +       bus-width = <4>;
> +       no-1-8-v;
> +       no-sdio;
> +       cd-gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&fec {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_fec>;
> +       phy-mode = "mii";
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c2>;
> +       status = "okay";
> +
> +       eeprom at 50 {
> +               compatible = "atmel,24c04";
> +               pagesize = <16>;
> +               reg = <0x50>;
> +       };
> +};
> +
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart1>;
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart2>;
> +       status = "okay";
> +};
> +
> +&uart3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart3>;
> +       status = "okay";
> +};
> +
> +&usbotg {
> +       dr_mode = "host";
> +       disable-over-current;
> +       phy_type = "utmi_wide";
> +       vbus-supply = <&usb_vbus>;
> +       status = "okay";
> +};
> +
> +&usbphy0 {
> +       vcc-supply = <&vusb2_reg>;
> +};
> +
> +&iomuxc {
> +       pinctrl_ecspi1: ecspi1grp {
> +               fsl,pins = <
> +                       MX51_PAD_CSPI1_MISO__ECSPI1_MISO        0x185
> +                       MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI        0x185
> +                       MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK        0x185
> +                       MX51_PAD_CSPI1_SS0__GPIO4_24            0x85
> +                       MX51_PAD_CSPI1_SS1__GPIO4_25            0x85
> +               >;
> +       };
> +
> +       pinctrl_ecspi2: ecspi2grp {
> +               fsl,pins = <
> +                       MX51_PAD_NANDF_RB2__ECSPI2_SCLK         0x185
> +                       MX51_PAD_NANDF_RB3__ECSPI2_MISO         0x185
> +                       MX51_PAD_NANDF_D15__ECSPI2_MOSI         0x185
> +                       MX51_PAD_NANDF_RDY_INT__GPIO3_24        0x85
> +                       MX51_PAD_NANDF_D12__GPIO3_28            0x85
> +               >;
> +       };
> +
> +       pinctrl_esdhc1_4bit: esdhc1grp_4bit {
> +               fsl,pins = <
> +                       MX51_PAD_SD1_CMD__SD1_CMD               0x400020d5
> +                       MX51_PAD_SD1_CLK__SD1_CLK               0x20d5
> +                       MX51_PAD_SD1_DATA0__SD1_DATA0           0x20d5
> +                       MX51_PAD_SD1_DATA1__SD1_DATA1           0x20d5
> +                       MX51_PAD_SD1_DATA2__SD1_DATA2           0x20d5
> +                       MX51_PAD_SD1_DATA3__SD1_DATA3           0x20d5
> +               >;
> +       };
> +
> +       pinctrl_esdhc1_8bit: esdhc1grp_8bit {
> +               fsl,pins = <
> +                       MX51_PAD_SD2_DATA0__SD1_DAT4            0x20d5
> +                       MX51_PAD_SD2_DATA1__SD1_DAT5            0x20d5
> +                       MX51_PAD_SD2_DATA2__SD1_DAT6            0x20d5
> +                       MX51_PAD_SD2_DATA3__SD1_DAT7            0x20d5
> +               >;
> +       };
> +
> +       pinctrl_esdhc4: esdhc4grp {
> +               fsl,pins = <
> +                       MX51_PAD_NANDF_RB1__SD4_CMD             0x400020d5
> +                       MX51_PAD_NANDF_CS2__SD4_CLK             0x20d5
> +                       MX51_PAD_NANDF_CS3__SD4_DAT0            0x20d5
> +                       MX51_PAD_NANDF_CS4__SD4_DAT1            0x20d5
> +                       MX51_PAD_NANDF_CS5__SD4_DAT2            0x20d5
> +                       MX51_PAD_NANDF_CS6__SD4_DAT3            0x20d5
> +                       MX51_PAD_NANDF_D0__GPIO4_8              0x100
> +               >;
> +       };
> +
> +       pinctrl_i2c2: i2c2grp {
> +               fsl,pins = <
> +                       MX51_PAD_KEY_COL4__I2C2_SCL             0x400001ed
> +                       MX51_PAD_KEY_COL5__I2C2_SDA             0x400001ed
> +               >;
> +       };
> +
> +       pinctrl_pmic: pmicgrp {
> +               fsl,pins = <
> +                       MX51_PAD_GPIO1_4__GPIO1_4               0x85
> +                       MX51_PAD_GPIO1_8__GPIO1_8               0xe5
> +               >;
> +       };
> +};
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index df9eca9..59a80da 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -1,61 +1,14 @@
> -/*
> - * Copyright (C) 2017 Zodiac Inflight Innovations
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> - */
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright (C) 2018 Zodiac Inflight Innovations
>
>  /dts-v1/;
> -#include "imx51.dtsi"
> +#include "imx51-zii-common.dtsi"
>  #include <dt-bindings/sound/fsl-imx-audmux.h>
>
>  / {
>         model = "ZII RDU1 Board";
>         compatible = "zii,imx51-rdu1", "fsl,imx51";
>
> -       chosen {
> -               stdout-path = &uart1;
> -       };
> -
> -       /* Will be filled by the bootloader */
> -       memory at 90000000 {
> -               reg = <0x90000000 0>;
> -       };
> -
>         aliases {
>                 mdio-gpio0 = &mdio_gpio;
>                 rtc0 = &ds1341;
> @@ -94,14 +47,6 @@
>                 enable-gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
>         };
>
> -       reg_5p0v_main: regulator-5p0v-main {
> -               compatible = "regulator-fixed";
> -               regulator-name = "5V_MAIN";
> -               regulator-min-microvolt = <5000000>;
> -               regulator-max-microvolt = <5000000>;
> -               regulator-always-on;
> -       };
> -
>         reg_3p3v: regulator-3p3v {
>                 compatible = "regulator-fixed";
>                 regulator-name = "3.3V";
> @@ -150,28 +95,6 @@
>                 };
>         };
>
> -       i2c_gpio: i2c-gpio {
> -               compatible = "i2c-gpio";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_swi2c>;
> -               gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>, /* sda */
> -                       <&gpio3 4 GPIO_ACTIVE_HIGH>; /* scl */
> -               i2c-gpio,delay-us = <50>;
> -               status = "okay";
> -
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               sgtl5000: codec at a {
> -                       compatible = "fsl,sgtl5000";
> -                       reg = <0x0a>;
> -                       clocks = <&clk_26M_snd>;
> -                       VDDA-supply = <&vdig_reg>;
> -                       VDDIO-supply = <&vvideo_reg>;
> -                       #sound-dai-cells = <0>;
> -               };
> -       };
> -
>         spi_gpio: spi-gpio {
>                 compatible = "spi-gpio";
>                 #address-cells = <1>;
> @@ -315,178 +238,30 @@
>         };
>  };
>
> -&cpu {
> -       cpu-supply = <&sw1_reg>;
> +&usb_vbus {
> +       regulator-always-on;
>  };
>
> -&ecspi1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_ecspi1>;
> -       cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
> -                  <&gpio4 25 GPIO_ACTIVE_LOW>;
> -       status = "okay";
> -
> -       pmic at 0 {
> -               compatible = "fsl,mc13892";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_pmic>;
> -               spi-max-frequency = <6000000>;
> -               spi-cs-high;
> -               reg = <0>;
> -               interrupt-parent = <&gpio1>;
> -               interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
> -               fsl,mc13xxx-uses-adc;
> -
> -               regulators {
> -                       sw1_reg: sw1 {
> -                               regulator-min-microvolt = <600000>;
> -                               regulator-max-microvolt = <1375000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       sw2_reg: sw2 {
> -                               regulator-min-microvolt = <900000>;
> -                               regulator-max-microvolt = <1850000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       sw3_reg: sw3 {
> -                               regulator-min-microvolt = <1100000>;
> -                               regulator-max-microvolt = <1850000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       sw4_reg: sw4 {
> -                               regulator-min-microvolt = <1100000>;
> -                               regulator-max-microvolt = <1850000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       vpll_reg: vpll {
> -                               regulator-min-microvolt = <1050000>;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       vdig_reg: vdig {
> -                               regulator-min-microvolt = <1650000>;
> -                               regulator-max-microvolt = <1650000>;
> -                               regulator-boot-on;
> -                       };
> -
> -                       vsd_reg: vsd {
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-max-microvolt = <3150000>;
> -                       };
> -
> -                       vusb_reg: vusb {
> -                               regulator-always-on;
> -                       };
> -
> -                       vusb2_reg: vusb2 {
> -                               regulator-min-microvolt = <2400000>;
> -                               regulator-max-microvolt = <2775000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       vvideo_reg: vvideo {
> -                               regulator-min-microvolt = <2775000>;
> -                               regulator-max-microvolt = <2775000>;
> -                       };
> -
> -                       vaudio_reg: vaudio {
> -                               regulator-min-microvolt = <2300000>;
> -                               regulator-max-microvolt = <3000000>;
> -                       };
> -
> -                       vcam_reg: vcam {
> -                               regulator-min-microvolt = <2500000>;
> -                               regulator-max-microvolt = <3000000>;
> -                       };
> -
> -                       vgen1_reg: vgen1 {
> -                               regulator-min-microvolt = <1200000>;
> -                               regulator-max-microvolt = <1200000>;
> -                       };
> -
> -                       vgen2_reg: vgen2 {
> -                               regulator-min-microvolt = <1200000>;
> -                               regulator-max-microvolt = <3150000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vgen3_reg: vgen3 {
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-max-microvolt = <2900000>;
> -                               regulator-always-on;
> -                       };
> -               };
> -
> -               leds {
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       led-control = <0x0 0x0 0x3f83f8 0x0>;
> -
> -                       sysled0 at 3 {
> -                               reg = <3>;
> -                               label = "system:green:status";
> -                               linux,default-trigger = "default-on";
> -                       };
> -
> -                       sysled1 at 4 {
> -                               reg = <4>;
> -                               label = "system:green:act";
> -                               linux,default-trigger = "heartbeat";
> -                       };
> -               };
> -       };
> -
> -       flash at 1 {
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               compatible = "atmel,at45db642d", "atmel,at45", "atmel,dataflash";
> -               spi-max-frequency = <25000000>;
> -               reg = <1>;
> -       };
> +&ecspi2 {
> +       status = "disabled";
>  };
>
>  &esdhc1 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_esdhc1>;
> +       pinctrl-0 = <&pinctrl_esdhc1_4bit>;
>         bus-width = <4>;
> -       no-1-8-v;
> -       non-removable;
> -       no-sdio;
> -       no-sd;
> -       status = "okay";
> +};
> +
> +&esdhc4 {
> +       status = "disabled";
>  };
>
>  &fec {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_fec>;
> -       phy-mode = "mii";
>         phy-reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
>         phy-supply = <&vgen3_reg>;
> -       status = "okay";
>  };
>
>  &i2c2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c2>;
> -       status = "okay";
> -
> -       eeprom at 50 {
> -               compatible = "atmel,24c04";
> -               pagesize = <16>;
> -               reg = <0x50>;
> -       };
> -
>         hpa1: amp at 60 {
>                 compatible = "ti,tpa6130a2";
>                 reg = <0x60>;
> @@ -550,31 +325,29 @@
>
>  };
>
> -&ipu_di0_disp1 {
> -       remote-endpoint = <&display_in>;
> -};
> +&i2c_gpio {
> +       gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>, /* sda */
> +               <&gpio3 4 GPIO_ACTIVE_HIGH>; /* scl */
>
> -&ssi2 {
> -       status = "okay";
> +       sgtl5000: codec at a {
> +               compatible = "fsl,sgtl5000";
> +               reg = <0x0a>;
> +               clocks = <&clk_26M_snd>;
> +               VDDA-supply = <&vdig_reg>;
> +               VDDIO-supply = <&vvideo_reg>;
> +               #sound-dai-cells = <0>;
> +       };
>  };
>
> -&uart1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart1>;
> -       status = "okay";
> +&ipu_di0_disp1 {
> +       remote-endpoint = <&display_in>;
>  };
>
> -&uart2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart2>;
> +&ssi2 {
>         status = "okay";
>  };
>
>  &uart3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart3>;
> -       status = "okay";
> -
>         rave-sp {
>                 compatible = "zii,rave-sp-rdu1";
>                 current-speed = <38400>;
> @@ -593,7 +366,7 @@
>         fsl,usbphy = <&usbh1phy>;
>         disable-over-current;
>         maximum-speed = "full-speed";
> -       vbus-supply = <&reg_5p0v_main>;
> +       vbus-supply = <&usb_vbus>;
>         status = "okay";
>  };
>
> @@ -604,20 +377,12 @@
>         phy_type = "ulpi";
>         fsl,usbphy = <&usbh2phy>;
>         disable-over-current;
> -       vbus-supply = <&reg_5p0v_main>;
> +       vbus-supply = <&usb_vbus>;
>         status = "okay";
>  };
>
> -&usbphy0 {
> -       vcc-supply = <&vusb_reg>;
> -};
> -
> -&usbotg {
> -       dr_mode = "host";
> -       disable-over-current;
> -       phy_type = "utmi_wide";
> -       vbus-supply = <&reg_5p0v_main>;
> -       status = "okay";
> +&sysled3 {
> +       label = "system:green:status";
>  };
>
>  &iomuxc {
> @@ -642,27 +407,6 @@
>                 >;
>         };
>
> -       pinctrl_ecspi1: ecspi1grp {
> -               fsl,pins = <
> -                       MX51_PAD_CSPI1_MISO__ECSPI1_MISO        0x185
> -                       MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI        0x185
> -                       MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK        0x185
> -                       MX51_PAD_CSPI1_SS0__GPIO4_24            0x85
> -                       MX51_PAD_CSPI1_SS1__GPIO4_25            0x85
> -               >;
> -       };
> -
> -       pinctrl_esdhc1: esdhc1grp {
> -               fsl,pins = <
> -                       MX51_PAD_SD1_CMD__SD1_CMD               0x400020d5
> -                       MX51_PAD_SD1_CLK__SD1_CLK               0x20d5
> -                       MX51_PAD_SD1_DATA0__SD1_DATA0           0x20d5
> -                       MX51_PAD_SD1_DATA1__SD1_DATA1           0x20d5
> -                       MX51_PAD_SD1_DATA2__SD1_DATA2           0x20d5
> -                       MX51_PAD_SD1_DATA3__SD1_DATA3           0x20d5
> -               >;
> -       };
> -
>         pinctrl_fec: fecgrp {
>                 fsl,pins = <
>                         MX51_PAD_EIM_EB2__FEC_MDIO              0x1f5
> @@ -696,13 +440,6 @@
>                 >;
>         };
>
> -       pinctrl_i2c2: i2c2grp {
> -               fsl,pins = <
> -                       MX51_PAD_KEY_COL4__I2C2_SCL             0x400001ed
> -                       MX51_PAD_KEY_COL5__I2C2_SDA             0x400001ed
> -               >;
> -       };
> -
>         pinctrl_ipu_disp1: ipudisp1grp {
>                 fsl,pins = <
>                         MX51_PAD_DISP1_DAT0__DISP1_DAT0         0x5
> @@ -741,13 +478,6 @@
>                 >;
>         };
>
> -       pinctrl_pmic: pmicgrp {
> -               fsl,pins = <
> -                       MX51_PAD_GPIO1_4__GPIO1_4               0x1e0
> -                       MX51_PAD_GPIO1_8__GPIO1_8               0x21e2
> -               >;
> -       };
> -
>         pinctrl_sndgate26mhz: sndgate26mhzgrp {
>                 fsl,pins = <
>                         MX51_PAD_CSPI1_RDY__GPIO4_26            0x85
> --
> 1.9.1
>
