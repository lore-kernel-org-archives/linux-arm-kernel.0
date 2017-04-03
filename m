From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 11:27:08 -0500
Subject: [PATCH 2/2] ARM: dts: keystone: Add minimum support for K2G ICE
 evm
In-Reply-To: <20170330152907.12595-3-fcooper@ti.com>
References: <20170330152907.12595-1-fcooper@ti.com>
 <20170330152907.12595-3-fcooper@ti.com>
Message-ID: <20170403162708.sf4ovwu3wm2tlyqh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 10:29:07AM -0500, Franklin S Cooper Jr wrote:
> Add barebones dts support for TI's K2G Industrial Communication Engine evm.
> This dts allows the board to boot using a ram based filesystem.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  arch/arm/boot/dts/Makefile             |  3 ++-
>  arch/arm/boot/dts/keystone-k2g-ice.dts | 42 ++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/keystone-k2g-ice.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0118084..01a98f1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -193,7 +193,8 @@ dtb-$(CONFIG_ARCH_KEYSTONE) += \
>  	keystone-k2hk-evm.dtb \
>  	keystone-k2l-evm.dtb \
>  	keystone-k2e-evm.dtb \
> -	keystone-k2g-evm.dtb
> +	keystone-k2g-evm.dtb \
> +	keystone-k2g-ice.dtb
>  dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-b3.dtb \
>  	kirkwood-blackarmor-nas220.dtb \
> diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
> new file mode 100644
> index 0000000..9ab5f42
> --- /dev/null
> +++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
> @@ -0,0 +1,42 @@
> +/*
> + * Device Tree Source for K2G Industrial Communication Engine EVM
> + *
> + * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

You can Use SPDX tags here.

> + */
> +/dts-v1/;
> +
> +#include "keystone-k2g.dtsi"
> +
> +/ {
> +	compatible = "ti,k2g-ice", "ti,k2g", "ti,keystone";
> +	model = "Texas Instruments K2G Industrial Communication EVM";
> +
> +	memory {

memory at 800000000

unless that gives you bootloader(s) problems.

> +		device_type = "memory";
> +		reg = <0x00000008 0x00000000 0x00000000 0x20000000>;
> +	};
> +};
> +
> +&k2g_pinctrl {
> +	uart0_pins: pinmux_uart0_pins {
> +		pinctrl-single,pins = <
> +			K2G_CORE_IOPAD(0x11cc) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
> +			K2G_CORE_IOPAD(0x11d0) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
> +		>;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +	status = "okay";
> +};
> -- 
> 2.10.0
> 
