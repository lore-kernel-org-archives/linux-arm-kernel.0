From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 28 Dec 2017 13:42:32 +0100
Subject: [PATCH] ARM: dts: sun8i: add support for Orange Pi R1
In-Reply-To: <20171112124129.15844-1-icenowy@aosc.io>
References: <20171112124129.15844-1-icenowy@aosc.io>
Message-ID: <bb59aa6e-29ca-a606-ea08-14bcea9c15b8@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I tried this device tree file with my Orange Pi R1 and then the Ethernet
chip connected to the USB controller is not working. When I set PAD 20
to high the device is found on the USB bus.



On 11/12/2017 01:41 PM, Icenowy Zheng wrote:
> Orange Pi R1 is a board design based on Orange Pi Zero, with XR819 Wi-Fi
> chip replaced by RTL8189ETV Wi-Fi module and the USB Type-A jack
> replaced by an onboard USB RTL8152B USB-Ethernet adapter.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts | 73 +++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9caf21..3c139c63098f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -949,6 +949,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-a83t-bananapi-m3.dtb \
>  	sun8i-a83t-cubietruck-plus.dtb \
>  	sun8i-a83t-tbs-a711.dtb \
> +	sun8i-h2-plus-orangepi-r1.dtb \
>  	sun8i-h2-plus-orangepi-zero.dtb \
>  	sun8i-h3-bananapi-m2-plus.dtb \
>  	sun8i-h3-beelink-x2.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
> new file mode 100644
> index 000000000000..32a6d312422e
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
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
> +/* Orange Pi R1 is based on Orange Pi Zero design */
> +#include "sun8i-h2-plus-orangepi-zero.dts"
> +
> +/ {
> +	model = "Xunlong Orange Pi R1";
> +	compatible = "xunlong,orangepi-r1", "allwinner,sun8i-h2-plus";
> +
> +	/delete-node/ reg_vcc_wifi;
I remove this line.

> +
> +	aliases {
> +		ethernet1 = &rtl8189etv;
> +	};
> +};
> +

I add this:
&reg_vcc_wifi {
	regulator-always-on;
};
This regulator should be connected to the USB device, but this is not in
device tree because it should be automatically probed.

> +&ohci1 {
> +	/*
> +	 * RTL8152B USB-Ethernet adapter is connected to USB1,
> +	 * and it's a USB 2.0 device. So the OHCI1 controller
> +	 * can be left disabled.
> +	 */
> +	status = "disabled";
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc3v3>;
> +
> +	rtl8189etv: sdio_wifi at 1 {
> +		reg = <1>;
> +	};
> +};
> 
