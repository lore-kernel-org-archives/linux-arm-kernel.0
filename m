From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 31 Aug 2017 14:52:43 +0800
Subject: [PATCH 5/5] arm: dts: sun8i: Add the TBS A711 tablet devicetree
In-Reply-To: <20170825092617.32533-5-maxime.ripard@free-electrons.com>
References: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
 <20170825092617.32533-5-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65Y5E=jQo7MbpTKip8nAR4MMx5B+_8K1Wt_c7E+NXB+PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 5:26 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The TBS A711 is a tablet with an A83T, a modem, wifi/BT chip, an eMMC and a
> 1024x600 LVDS display.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 195 ++++++++++++++++++++++++++++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 212589532b2e..8fa36746d738 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -914,6 +914,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>         sun8i-a33-sinlinx-sina33.dtb \
>         sun8i-a83t-allwinner-h8homlet-v2.dtb \
>         sun8i-a83t-cubietruck-plus.dtb \
> +       sun8i-a83t-tbs-a711.dtb \
>         sun8i-h2-plus-orangepi-zero.dtb \
>         sun8i-h3-bananapi-m2-plus.dtb \
>         sun8i-h3-beelink-x2.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> new file mode 100644
> index 000000000000..743509fdc8f9
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -0,0 +1,195 @@
> +/*
> + * Copyright (C) 2017 Touchless Biometric Systems AG
> + * Tomas Novotny <tomas@novotny.cz>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +#include "sun8i-a83t.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +/ {
> +       model = "TBS A711 Tablet";
> +       compatible = "tbs-biometrics,a711", "allwinner,sun8i-a83t";
> +
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       reg_vbat: reg-vbat {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vbat";
> +               regulator-min-microvolt = <3700000>;
> +               regulator-max-microvolt = <3700000>;
> +       };
> +
> +       reg_vmain: reg-vmain {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vmain";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               vin-supply = <&reg_vbat>;
> +       };
> +
> +       wifi_pwrseq: wifi_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 WL-PMU-EN */
> +
> +               /*
> +                * This is actually Bluetooth's clock, but we have to
> +                * hook it up somewheere
> +                */
> +               clocks = <&ac100_rtc 1>;
> +               clock-names = "ext_clock";
> +       };
> +};
> +
> +/*
> + * An USB-2 hub is connected here, which also means we don't need to
> + * enable the OHCI controller.
> + */
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +/*
> + * There's a modem connected here that needs to be initialised before
> + * being able to be enumerated.
> + */
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&mmc0 {
> +       vmmc-supply = <&reg_vcc3v3>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc0_pins>;
> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&mmc1 {
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       bus-width = <4>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_pins>;
> +       vmmc-supply = <&reg_vcc3v3>;

vqmmc-supply should be provided. See below.

> +       non-removable;
> +       wakeup-source;
> +       status = "okay";
> +
> +       brcmf: wifi at 1 {
> +               reg = <1>;
> +               compatible = "brcm,bcm4329-fmac";
> +               interrupt-parent = <&r_pio>;
> +               interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 WL_WAKE_UP */
> +               interrupt-names = "host-wake";
> +       };
> +};
> +
> +&mmc2 {
> +       pinctrl-0 = <&mmc2_8bit_emmc_pins>;
> +       pinctrl-names = "default";
> +       vmmc-supply = <&reg_vcc3v3>;

emmc has separate vddq lines. vqmmc-supply should be provided even though it
may be the same as vmmc-supply. The two refer to different things at the board
level.

> +       bus-width = <8>;
> +       non-removable;
> +       cap-mmc-hw-reset;
> +       status = "okay";
> +};
> +
> +&r_rsb {
> +       status = "okay";
> +
> +       axp813: pmic at 3a3 {
> +               compatible = "x-powers,axp813";
> +               reg = <0x3a3>;
> +               interrupt-parent = <&r_intc>;
> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       ac100: codec at e89 {
> +               compatible = "x-powers,ac100";
> +               reg = <0xe89>;
> +
> +               ac100_codec: codec {
> +                       compatible = "x-powers,ac100-codec";
> +                       interrupt-parent = <&r_pio>;
> +                       interrupts = <0 12 IRQ_TYPE_LEVEL_LOW>; /* PL12 */
> +                       #clock-cells = <0>;
> +                       clock-output-names = "4M_adda";
> +               };
> +
> +               ac100_rtc: rtc {
> +                       compatible = "x-powers,ac100-rtc";
> +                       interrupt-parent = <&r_intc>;
> +                       interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&ac100_codec>;
> +                       #clock-cells = <1>;
> +                       clock-output-names = "cko1_rtc",
> +                                            "cko2_rtc",
> +                                            "cko3_rtc";
> +               };
> +       };
> +
> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pb_pins>;
> +       status = "okay";
> +};
> +
> +/* There's the BT part of the AP6210 connected to that UART */
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart1_pg_pins &uart1_rtscts_pins>;

Splitting it as separate phandles ( <&...> ) would make it more readable.
Also the rx/tx pingroup name should be changed

> +       status = "okay";
> +};
> +
> +&usbphy {

No VBUS?

Regards
ChenYu

> +       status = "okay";
> +};
> --
> 2.13.5
>
