From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Apr 2016 08:30:07 -0300
Subject: [PATCH v2] ARM: dts: imx6: Add dts for Embest MarS Board
In-Reply-To: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
References: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <CAOMZO5Atp7okpmC8ir20BNrthh=M8ENp3ewx-Xqyt1HR_CNjNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 9:25 PM, Sergio Prado
<sergio.prado@e-labworks.com> wrote:

> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model = "Embest MarS Board i.MX6Dual";
> +       compatible = "embest,imx6q-marsboard", "fsl,imx6dl";

This should be "fsl,imx6q".

> +
> +       memory {
> +               reg = <0x10000000 0x40000000>;
> +       };
> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;

Please remove the "simple-bus". Please check this commit:
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/arch/arm/boot/dts/imx6q-tbs2910.dts?h=for-next&id=ddcc6cad715319fff53968db7110a287dbc4a77e

> +
> +               reg_3p3v: regulator at 1 {
> +                       compatible = "regulator-fixed";
> +                       reg = <1>;
> +                       regulator-name = "3P3V";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +               };
> +
> +               reg_usb_otg_vbus: regulator at 2 {
> +                       compatible = "regulator-fixed";
> +                       reg = <2>;
> +                       regulator-name = "usb_otg_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;

You missed the 'enable-active-high' property.


> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_led>;
> +
> +               led at 1 {

There is no need for @1.


> +                       label = "imx6:green:user1";
> +                       gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
> +                       default-state = "off";
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               led at 2 {

There is no need for @2.

> +
> +&iomuxc {
> +       imx6-riotboard {
> +               pinctrl_uart1: uart1grp {

You can simplify the iomuxc node by doing like this:
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/arch/arm/boot/dts/imx6q-tbs2910.dts?h=for-next&id=aa7871b53bc3c36b4adefe67f728143e2deeec93
