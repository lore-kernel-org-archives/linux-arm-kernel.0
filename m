From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 17 Dec 2015 11:11:41 +0100
Subject: [PATCH v2] ARM: at91/dt: Add Support for the L+G VInCo platform
In-Reply-To: <1450346406-11606-1-git-send-email-gregory.clement@free-electrons.com>
References: <1450346406-11606-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151217101141.GB13078@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/2015 at 11:00:06 +0100, Gregory CLEMENT wrote :
> The Versatile Industrial Communication platform is a community oriented
> board from Landis + Gyr. It comes with:
>       - an RS-485 port
>       - 2 Ethernet ports
>       - a wireless M-BUS
>       - a 4G modem
>       - a 4MB SPI flash
>       - a 4GB eMMC
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> 
> Changelog
> 
> v1 -> v2:
> - Fixed rtc compatible name from "rx8900" to "epson,rx8900" as pointed
> by Alexandre Belloni
> 
> arch/arm/boot/dts/Makefile       |   3 +-
>  arch/arm/boot/dts/at91-vinco.dts | 266 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 268 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/at91-vinco.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 30bbc37..75562ab 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -49,7 +49,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>  	sama5d35ek.dtb \
>  	sama5d36ek.dtb \
>  	at91-sama5d4_xplained.dtb \
> -	at91-sama5d4ek.dtb
> +	at91-sama5d4ek.dtb \
> +	at91-vinco.dtb
>  dtb-$(CONFIG_ARCH_ATLAS6) += \
>  	atlas6-evb.dtb
>  dtb-$(CONFIG_ARCH_ATLAS7) += \
> diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
> new file mode 100644
> index 0000000..951807c
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-vinco.dts
> @@ -0,0 +1,266 @@
> +/*
> + * Device Tree file for VInCo platform
> + *
> + *  Copyright (C) 2014 Atmel,
> + *                2014 Nicolas Ferre <nicolas.ferre@atmel.com>
> + *   2015 Gregory CLEMENT <gregory.clement@free-electrons.com>
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
> +/dts-v1/;
> +#include "sama5d4.dtsi"
> +
> +/ {
> +	model = "L+G VInCo platform";
> +	compatible = "l+g,vinco", "atmel,sama5d4", "atmel,sama5";
> +
> +	chosen {
> +		bootargs = "ignore_loglevel earlyprintk";

Are you sure about that? :)
See 1392f7c905e80361f57977e4c0f37f0a5d44e597

> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x4000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		main_clock: clock at 0 {
> +			compatible = "atmel,osc", "fixed-clock";
> +			clock-frequency = <12000000>;
> +		};
> +

This clock at 0 node is unnecessary, see
15f7e2537a164a9a19861b67aa4368297f8b00bb

> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <12000000>;
> +		};
> +	};
> +
-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
