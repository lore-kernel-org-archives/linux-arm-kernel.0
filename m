From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Nov 2017 16:57:36 +0100
Subject: [PATCH] ARM: sun7i: Add Cubietech Einstein A20 board device-tree
In-Reply-To: <20171102143534.19353-1-mailinglists@kunz-im-inter.net>
References: <20171102143534.19353-1-mailinglists@kunz-im-inter.net>
Message-ID: <20171102155736.qab746tkaspfe47n@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

Thanks for your patch.

On Thu, Nov 02, 2017 at 03:35:34PM +0100, Frank Kunz wrote:
> From: Frank Kunz <xxxxxmichl@googlemail.com>
> 
> The Einstein A20 board is a Allwinner A20 based board with a credit card
> form factor.
> 
> Features:
> - Allwinner A20 SoC
> - DDR3 1GB RAM
> - 8GiB eMMC
> - AP6210 wifi/Bluetooth
> - RTC
> - Micro USB-OTG connector
> - UART0 debugging port
> - 200 pins stamp hole package
> 
> Signed-off-by: Frank Kunz <xxxxxmichl@googlemail.com>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/sun7i-a20-einstein.dts | 200 +++++++++++++++++++++++++++++++
>  2 files changed, 201 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-einstein.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index faf46abaa4a2..f9158400ea0f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -878,6 +878,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-bananapro.dtb \
>  	sun7i-a20-cubieboard2.dtb \
>  	sun7i-a20-cubietruck.dtb \
> +	sun7i-a20-einstein.dtb \

I guess it's not that obvious from what company that board is coming
from. Could you turn it into cubietech-einstein please?

>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-itead-ibox.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-einstein.dts b/arch/arm/boot/dts/sun7i-a20-einstein.dts
> new file mode 100644
> index 000000000000..59d46b08f21c
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-einstein.dts
> @@ -0,0 +1,200 @@
> +/*
> + * Copyright 2017 Frank Kunz
> + *
> + * Frank Kunz <xxxxxmichl@googlemail.com>
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
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "Cubietech Einstein A20";
> +	compatible = "cubietech,einstein-a20", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	mmc3_pwrseq: mmc3_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mmc3_pwrseq_pin_ea20>;

You don't need those GPIO pinctrl nodes, you can remove all of them.

> +		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI-SHDN */
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins_a>;
> +	status = "okay";
> +
> +	axp209: pmic at 34 {
> +		reg = <0x34>;
> +		interrupt-parent = <&nmi_intc>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;

What regulator is this connected to on the PMIC?

> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&mmc3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc3_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;

Same question here.

Looks good otherwise, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171102/aca9b288/attachment.sig>
