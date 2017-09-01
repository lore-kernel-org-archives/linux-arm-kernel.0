From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 1 Sep 2017 09:17:14 -0300
Subject: [PATCH] ARM: dts: imx6sx: add vining-2000 board support
In-Reply-To: <1504195599.1918.17.camel@googlemail.com>
References: <1504195599.1918.17.camel@googlemail.com>
Message-ID: <CAOMZO5BSvyJCSGVF_7EOqia=ufX77JTkQwDCeey8kEaqDB_PBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Thu, Aug 31, 2017 at 1:06 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
> @@ -0,0 +1,575 @@
> +/*
> + * Copyright (C) 2016 Christoph Fritz
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

Please consider using dual license GPL/X11 license.

> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "imx6sx.dtsi"
> +
> +/ {
> +       model = "Softing VIN|ING 2000";
> +       compatible = "softing,imx6sx-vining-2000", "fsl,imx6sx";

I see the following entry in
Documentation/devicetree/bindings/vendor-prefixes.txt:

samtec Samtec/Softing company

Could you use "samtec,imx6sx-vining-2000" instead?

> +
> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
> +       memory {
> +               reg = <0x80000000 0x40000000>;
> +       };
> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;

No need to have this 'regulators' node.

> +
> +               reg_usb_otg1_vbus: regulator at 0 {

Please use the same regulator pattern as in
arch/arm/boot/dts/imx6q-tbs2910.dts, for example.

> +&fec2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet2>;
> +       phy-supply = <&reg_peri_3v3>;
> +       phy-reset-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
> +       phy-reset-duration = <5>;
> +       phy-mode = "rmii";
> +       phy-handle = <&ethphy1>;
> +       status = "okay";
> +
> +       mdio {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy1: ethernet1-phy at 0 {
> +                       reg = <0>;
> +                       max-speed = <100>;
> +                       interrupts-parent = <&gpio2>;
> +                       interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +               };
> +       };
> +};
> +
> +&i2c3 {

Keep the nodes in alphabetical order.

> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_gpios>;
> +
> +       pinctrl_gpios: gpiosgrp {
> +               fsl,pins = <
> +                       /* reset external uC */
> +                       MX6SX_PAD_QSPI1A_DATA3__GPIO4_IO_19     0x80000000
> +                       /* IRQ from external uC */
> +                       MX6SX_PAD_KEY_ROW0__GPIO2_IO_15         0x80000000
> +                       /* overcurrent detection */
> +                       MX6SX_PAD_GPIO1_IO08__GPIO1_IO_8        0x80000000

Do not use 0x80000000. Better use the real IOMUX value instead. Same
applies to other IOMUX instances.

> +&cpu0 {
> +       operating-points = <
> +               /* kHz    uV */
> +               996000  1250000
> +               792000  1175000
> +               396000  1175000
> +               198000  1175000
> +               >;
> +       fsl,soc-operating-points = <
> +               /* ARM kHz  SOC uV */
> +               996000  1250000
> +               792000  1175000
> +               396000  1175000
> +               198000  1175000
> +       >;

It would be nice to add a comment as to why the operating points from
imx6sx.dtsi can't be used.

> +&ecspi4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi4>;
> +       fsl,spi-num-chipselects = <1>;

This property has been deprecated, so remove it.

> +       cs-gpios = <&gpio7 4 0>;

Is this really active high? Please double check and use proper GPIO
flags GPIO_ACTIVE_HIGH/LOW.
