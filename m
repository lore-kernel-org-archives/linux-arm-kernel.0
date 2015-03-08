From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Mar 2015 18:28:58 +0100
Subject: [PATCH 1/2] ARM: dts: add cubietech cubieboard4
In-Reply-To: <1425684905-23652-2-git-send-email-tyler.baker@linaro.org>
References: <1425684905-23652-1-git-send-email-tyler.baker@linaro.org>
 <1425684905-23652-2-git-send-email-tyler.baker@linaro.org>
Message-ID: <20150308172858.GI5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On Fri, Mar 06, 2015 at 03:35:04PM -0800, tyler.baker at linaro.org wrote:
> From: Tyler Baker <tyler.baker@linaro.org>
> 
> Add a Cubietech Cubieboard4 device tree and instruct make to build it. This
> device tree has been derived from the sun9i-a80-optimus.dts as they are very
> similar in design[1]. Notably, I2C3 is not used on Cubieboard4 and the LED/PWM
> definitions will need to be updated in the future.
> 
> [1] http://dl.cubieboard.org/model/cc-a80/Hardware/CC-A80-HW-V1.1.pdf
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                  |   3 +-
>  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 100 ++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4837044..0f67dab 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -553,7 +553,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-a23-ippo-q8h-v5.dtb \
>  	sun8i-a23-ippo-q8h-v1.2.dtb
>  dtb-$(CONFIG_MACH_SUN9I) += \
> -	sun9i-a80-optimus.dtb
> +	sun9i-a80-optimus.dtb \
> +	sun9i-a80-cubieboard4.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
>  	tegra20-harmony.dtb \
>  	tegra20-iris-512.dtb \
> diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> new file mode 100644
> index 0000000..b239b39
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> @@ -0,0 +1,100 @@
> +/*
> + * Copyright 2015 Tyler Baker
> + *
> + * Tyler Baker <tyler.baker@linaro.org>
> + * Chen-Yu Tsai <wens@csie.org>
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
> +#include "sun9i-a80.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
> +/ {
> +	model = "Cubietech Cubieboard4";
> +	compatible = "cubietech,a80-cubietruck", "allwinner,sun9i-a80";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200";

It would be great not to use earlyprintk, just in case we have a
kernel compiled with earlyprintk support, but for another SoC.

And while we're at it, using stdout-path would allow use to get rid of
the bootargs entirely.

> +	};
> +
> +};
> +
> +&pio {
> +

This new line is not needed.

> +	mmc0_cd_pin_cubieboard4: mmc0_cd_pin at 0 {
> +		allwinner,pins = "PH18";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_cubieboard4>;
> +	vmmc-supply = <&reg_vcc3v0>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 7 18 GPIO_ACTIVE_HIGH>; /* PH18 */
> +	cd-inverted;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_8bit_pins>;
> +	vmmc-supply = <&reg_vcc3v0>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};

Looks good otherwise, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/f2a2eb90/attachment.sig>
