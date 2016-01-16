From: naobsd@gmail.com (Naoki FUKAUMI)
Date: Sat, 16 Jan 2016 10:22:40 +0900
Subject: [PATCH 2/2] arm64: dts: rockchip: Add basic support for orion-r68
In-Reply-To: <1452863192-29231-2-git-send-email-matthias.bgg@gmail.com>
References: <1452863192-29231-1-git-send-email-matthias.bgg@gmail.com>
 <1452863192-29231-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CAFnsNoQ0Y11kQaTiQL-xEoTxAbZW4vzZDFrZC8ccS4egBx4NEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is not full review.

On Fri, Jan 15, 2016 at 10:06 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:

> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index 8e985dd..fa97d93 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -72,3 +72,7 @@ Rockchip platforms device tree bindings
>  - Rockchip R88 board:
>      Required root node properties:
>        - compatible = "rockchip,r88", "rockchip,rk3368";
> +
> +- Tronsmart Orion R68
> +    Required root node properties:
> +      - compatible = "tronsmart,orion-r68", "rockchip,rk3368";

> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68.dts
> new file mode 100644
> index 0000000..3f71d506
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68.dts
> @@ -0,0 +1,370 @@
> +/*
> + * Copyright (c) 2015 Matthias Brugger <mbrugger@suse.com>
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
> +#include "rk3368.dtsi"
> +
> +/ {
> +       model = "Rockchip Orion R68";
> +       compatible = "tronsmart,orion-r68", "rockchip,rk3368";
> +
> +       chosen {
> +               stdout-path = "serial2:115200n8";
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x40000000>;
> +       };

there are (at least) 4 models/revisions in Tronsmart Orion R68, Meta
or Pro, 100M or 1000M ethernet. probably there are more variants from
other vendors based on same board.
I don't say all variants need to be supported here now, but it may
need few more description.

I have Orion R68 Meta 1000M version. there is a label on the board,
"Netxeon RK68G V2.0 2G/16G/AP6335". it might be called
"netxeon,rk68g-v2.0" or something like that.

> +       leds: gpio-leds {
> +               compatible = "gpio-leds";
> +
> +               work {
> +                       gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
> +                       label = "orion:purple:led";
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&led_ctl>;
> +                       default-state = "on";
> +               };
> +       };

> +       leds {
> +               stby_pwren: stby-pwren {
> +                       rockchip,pins = <0 12 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               led_ctl: led-ctl {
> +                       rockchip,pins = <3 29 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };

on my board, there is no "purple" LED, <&gpio3 29 GPIO_ACTIVE_HIGH> is
red LED, <&gpio0 12 GPIO_ACTIVE_HIGH> is blue LED.

did you already confirm all GPIO connection written in your dts?

> +&uart2 {
> +       status = "okay";
> +};

uart4 is working for me. (as a console)

Regards,

--
FUKAUMI Naoki
