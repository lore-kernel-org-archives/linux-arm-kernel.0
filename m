From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 May 2017 10:17:26 +0200
Subject: [PATCH] ARM: dts: sun5i: a13: Add Olimex SOM board dts support
In-Reply-To: <1495544437-32463-1-git-send-email-jteki@openedev.com>
References: <1495544437-32463-1-git-send-email-jteki@openedev.com>
Message-ID: <20170529081726.4bqitk6hmpuibh7p@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

On Tue, May 23, 2017 at 06:30:37PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@openedev.com>
> 
> Add support for Olimex A13-512-SOM board, and this particular
> design is like A13-SOM-WIFI can mount on-top of A13-SOM.
> 
> https://www.olimex.com/Products/SOM/A13/A13-SOM-512/
> https://www.olimex.com/Products/SOM/A13/A13-SOM-WIFI/open-source-hardware

In general (and this is true in the A64 boards patches you sent too),
I'm not a big fan of putting the URLs in the commit log. They tend to
get outdated / broken very fast, and we can't fix them in the history.

Please remove them and/or put them in the "comment" part (after the
---).

> Features:
> - A13 Cortex A8 processor at 1GHz, 3D Mali400 GPU
> - 512MB DDR3 memory
> - MicroSD card connector
> - UART console connector
> - Status LEDs
> - BL-8188-8M WiFi wireless module with Realtek RTL8188CUS chip
> - USB-OTG with mini USB connector
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Jagan Teki <jagan@openedev.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts | 174 ++++++++++++++++++++++++++
>  2 files changed, 175 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c5e1d9..45c6e65 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -830,6 +830,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
>  	sun5i-a13-licheepi-one.dtb \
>  	sun5i-a13-olinuxino.dtb \
>  	sun5i-a13-olinuxino-micro.dtb \
> +	sun5i-a13-olinuxino-som.dtb \
>  	sun5i-a13-q8-tablet.dtb \
>  	sun5i-a13-utoo-p66.dtb \
>  	sun5i-gr8-chip-pro.dtb \
> diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts
> new file mode 100644
> index 0000000..3bb3b7d
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts
> @@ -0,0 +1,174 @@
> +/*
> + * Copyright 2012 Maxime Ripard <maxime.ripard@free-electrons.com>
> + * Copyright 2013 Hans de Goede <hdegoede@redhat.com>
> + * Copyright 2017 Jagan Teki <jagan@openedev.com>
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
> +#include "sun5i-a13.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
> +/ {
> +	model = "Olimex A13-Olinuxino SOM";
> +	compatible = "olimex,a13-olinuxino-som", "allwinner,sun5i-a13";
> +
> +	aliases {
> +		serial0 = &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_olinuxinom>;

We do not put GPIO pinctrl nodes in the DT anymore. Our GPIO/pinctrl
is currently broken, and fixing it properly would require removing all
those nodes and would break the existing DT. Until we make that
switch, we'd better not introduce more DT we'll break.

The rest looks good, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/0f0dd2fc/attachment.sig>
