From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Aug 2017 22:28:33 +0200
Subject: [PATCH 2/3] ARM: dts: sun7i: Add dts file for
 A20-OLinuXino-MICRO-exGB
In-Reply-To: <20170822114313.9038-3-stefan@olimex.com>
References: <20170822114313.9038-1-stefan@olimex.com>
 <20170822114313.9038-3-stefan@olimex.com>
Message-ID: <20170822202833.3amv4wx3gbtc6kz3@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 02:43:12PM +0300, Stefan Mavrodiev wrote:
> A20-OLinuXino-MICRO has option with onboard eMMC chip. For
> now it's only shipped with 4BG chip, but in the future this
> may change.
> 
> Currently the board is called "A20-OLinuXino-MICRO-e4GB".
> The dts is named "-exGB" to represent all eMMC configurations -
> e4GB, e8GB, etc.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  arch/arm/boot/dts/Makefile                         |  1 +
>  .../boot/dts/sun7i-a20-olinuxino-micro-exgb.dts    | 81 ++++++++++++++++++++++
>  2 files changed, 82 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-micro-exgb.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4b17f35dc9a7..90cbfc57948e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -880,6 +880,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-olinuxino-lime2.dtb \
>  	sun7i-a20-olinuxino-lime2-emmc.dtb \
>  	sun7i-a20-olinuxino-micro.dtb \
> +	sun7i-a20-olinuxino-micro-exgb.dtb \

Apart from the discussion that happened on the 3rd patch, I'm really
not fond of that name. I'd rather have an emmc suffix. It's trivial
enough so that everyone can understand it, and it covers pretty much
everything that is covered by exgb (ie, it's an emmc of various
capacities).

>  	sun7i-a20-orangepi.dtb \
>  	sun7i-a20-orangepi-mini.dtb \
>  	sun7i-a20-pcduino3.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-exgb.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-exgb.dts
> new file mode 100644
> index 000000000000..2c592748e474
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-exgb.dts

> @@ -0,0 +1,81 @@
> +/*
> + * Copyright 2017 Olimex Ltd.
> + *
> + * Stefan Mavrodiev <stefan@olimex.com>
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
> +#include "sun7i-a20-olinuxino-micro.dts"
> +
> +/ {
> +	model = "Olimex A20-OLinuXino-MICRO-exGB";
> +	compatible = "olimex,a20-olinuxino-micro-exgb", "allwinner,sun7i-a20";
> +
> +	mmc2_pwrseq: pwrseq {
> +		pinctrl-0 = <&mmc2_pins_nrst>;
> +		pinctrl-names = "default";

You don't need the pinctrl node for a gpio, and we're trying to remove
them from our DTs. A huge number of them are still here, but let's not
add more of them :)

> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&pio 2 16 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pio {
> +	mmc2_pins_nrst: mmc2-rst-pin {
> +		pins = "PC16";
> +		function = "gpio_out";
> +	};
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc3v3>;

You don't need both vmmc and vqmmc set to the same regulator.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/64e11b96/attachment.sig>
