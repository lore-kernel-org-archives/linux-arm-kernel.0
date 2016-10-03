From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 3 Oct 2016 11:24:24 +0100
Subject: [PATCH v3 9/9] arm64: dts: add Pine64 support
In-Reply-To: <20161003080913.24197-10-maxime.ripard@free-electrons.com>
References: <20161003080913.24197-1-maxime.ripard@free-electrons.com>
 <20161003080913.24197-10-maxime.ripard@free-electrons.com>
Message-ID: <7483f6ea-3b59-46ca-fb31-f26af6ec8423@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

thanks for the respin!

On 03/10/16 09:09, Maxime Ripard wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> 
> The Pine64 is a cost-efficient development board based on the
> Allwinner A64 SoC.
> There are three models: the basic version with Fast Ethernet and
> 512 MB of DRAM (Pine64) and two Pine64+ versions, which both
> feature Gigabit Ethernet and additional connectors for touchscreens
> and a camera. Or as my son put it: "Those are smaller and these are
> missing." ;-)
> The two Pine64+ models just differ in the amount of DRAM
> (1GB vs. 2GB). Since U-Boot will figure out the right size for us and
> patches the DT accordingly we just need to provide one DT for the
> Pine64+.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> [Maxime: Removed the common DTSI and include directly the pine64 DTS]
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm64/boot/dts/Makefile                       |  1 +
>  arch/arm64/boot/dts/allwinner/Makefile             |  5 ++
>  .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  | 50 +++++++++++
>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 74 +++++++++++++++++
>  include/dt-bindings/reset/sun50i-a64-ccu.h         | 97 +++++++++++-----------

Shouldn't the changes in this file be merged into patch 6/9?

...

>  5 files changed, 179 insertions(+), 48 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 6e199c903676..ddcbf5a2c17e 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  dts-dirs += al
> +dts-dirs += allwinner
>  dts-dirs += altera
>  dts-dirs += amd
>  dts-dirs += amlogic
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> new file mode 100644
> index 000000000000..1e29a5ae8282
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
> +
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
> new file mode 100644
> index 000000000000..790d14daaa6a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright (c) 2016 ARM Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +#include "sun50i-a64-pine64.dts"
> +
> +/ {
> +	model = "Pine64+";
> +	compatible = "pine64,pine64-plus", "allwinner,sun50i-a64";
> +
> +	/* TODO: Camera, Ethernet PHY, touchscreen, etc. */
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> new file mode 100644
> index 000000000000..9f127b3d0e33
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright (c) 2016 ARM Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +
> +#include "sun50i-a64.dtsi"
> +
> +/ {
> +	model = "Pine64";
> +	compatible = "pine64,pine64", "allwinner,sun50i-a64";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	status = "okay";
> +};
> +
> +&i2c1_pins {
> +	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +};
> diff --git a/include/dt-bindings/reset/sun50i-a64-ccu.h b/include/dt-bindings/reset/sun50i-a64-ccu.h
> index e61fac294d73..db60b29ddb11 100644
> --- a/include/dt-bindings/reset/sun50i-a64-ccu.h
> +++ b/include/dt-bindings/reset/sun50i-a64-ccu.h
> @@ -46,52 +46,53 @@
>  #define RST_USB_PHY0		0
>  #define RST_USB_PHY1		1
>  #define RST_USB_HSIC		2
> -#define RST_MBUS		3
....
> +#define RST_DRAM		3
> +#define RST_MBUS		4

So I take it that this kind of changes will not happen anymore once the
DT has been merged?
And this numbering is arbitrary and not connected to some hardware
bits/register addresses at all?
And in case we find some missing bits later we will just queue them at
the end?

Cheers,
Andre.
