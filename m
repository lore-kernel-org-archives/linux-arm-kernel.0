From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jan 2018 09:01:58 -0200
Subject: [PATCH] ARM: dts: mxs: add imx28 DNET01 board
In-Reply-To: <325f427c-352b-e3d0-fa2f-3055f02d8c3f@gmail.com>
References: <325f427c-352b-e3d0-fa2f-3055f02d8c3f@gmail.com>
Message-ID: <CAOMZO5CbA4qdr+x2C6CijaFcfidkVDoZrQzM7WrMRXB73EYhuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ga?tan,

On Thu, Jan 18, 2018 at 7:26 AM, Ga?tan Carlier <gcembed@gmail.com> wrote:
> Hi,

This should not be part of the commit log.

> The patch adds support of imx28 DNET01 board

Here it would be nice to explain a little bit about the board and its features.

If you have a URL for the board, you can add it too.

>
> Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
> ---
>  arch/arm/boot/dts/imx28-dnet01.dts | 184 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-dnet01.dts
>
> diff --git a/arch/arm/boot/dts/imx28-dnet01.dts b/arch/arm/boot/dts/imx28-dnet01.dts
> new file mode 100644
> index 0000000..c502ca7
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-dnet01.dts
> @@ -0,0 +1,184 @@
> +/*
> + * Copyright (C) 2018 Gaetan Carlier <gcembed@gmail.com>
> + *
> + * based on imx28-m28evk.dts
> + * Copyright (C) 2012 Marek Vasut <marex@denx.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:

Please use SPDX identifier instead.

> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx28.dtsi"
> +
> +/ {
> +       model = "Domintell DNET01";
> +       compatible = "domintell,dnet01", "fsl,imx28";


Please add 'domintel' entry into
Documentation/devicetree/bindings/vendor-prefixes.txt in a separate
patch.


> +
> +       memory {
> +               reg = <0x40000000 0x08000000>;
> +       };
> +
> +       apb at 80000000 {
> +               apbh at 80000000 {
> +
> +                       dcp: dcp at 80028000 {
> +                               /*
> +                                * Driver is not fully implemented.
> +                                * [PATCH] crypto: mxs-dcp - Initialize .statesize fields
> +                                * https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg17078.html
> +                                */
> +                               status = "disable";
> +                       };
> +
> +                       ssp0: ssp at 80010000 {
> +                               compatible = "fsl,imx28-mmc";
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&mmc0_8bit_pins_a
> +                                            &mmc0_sck_cfg>;
> +                               bus-width = <8>;
> +                               vmmc-supply = <&reg_3p3v>;
> +                               broken-cd;
> +                               disable-wp;
> +                               cap-mmc-highspeed;
> +                               non-removable;
> +                               status = "okay";


Please follow the style from arch/arm/boot/dts/imx28-tx28.dts, where
&ssp0 is used.


> +               apbx at 80040000 {
> +                       mxs_rtc: rtc at 80056000 {
> +                               /*
> +                                * Overrides default state from imx28.dtsi
> +                                * Internal RTC must be disable as a high
> +                                * precision I2C is connected.
> +                                */
> +                               status = "disabled";
> +                       };
> +
> +                       i2c0: i2c at 80058000 {
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&i2c0_pins_a>;
> +                               status = "okay";
> +
> +                               eeprom: eeprom at 57 {
> +                                       compatible = "atmel,24c01";
> +                                       reg = <0x57>;
> +                                       pagesize = <8>;
> +                                       readonly = <1>;
> +                               };
> +
> +                               mcp7941x_rtc: rtc at 6f {
> +                                       compatible = "dallas,mcp7941x";

This compatible string is not documented.

Do you mean "microchip,mcp7941x" instead?


> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg_3p3v: regulator at 0 {
> +                       compatible = "regulator-fixed";
> +                       reg = <0>;
> +                       regulator-name = "3P3V";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-always-on;

regulators should not be placed under simple-bus.
