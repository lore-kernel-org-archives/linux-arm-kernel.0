From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Nov 2017 10:51:09 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: initial V3MSK board device tree
In-Reply-To: <20171124210313.219761525@cogentembedded.com>
References: <20171124210313.219761525@cogentembedded.com>
Message-ID: <20171129095109.d2uan35eui4kzav6@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 11:59:44PM +0300, Sergei Shtylyov wrote:
> Add the initial device  tree for the V3M Starter Kit board.
> The board has 1 debug serial port (SCIF0); include support for it,
> so that the serial console can work.
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm64/boot/dts/renesas/Makefile           |    2 -
>  arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts |   44 +++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/Makefile
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/Makefile
> +++ renesas/arch/arm64/boot/dts/renesas/Makefile
> @@ -7,7 +7,7 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es
>  dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
>  dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
>  dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
> -dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb
> +dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
>  dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
>  
>  always		:= $(dtb-y)
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
> @@ -0,0 +1,44 @@
> +/*
> + * Device Tree Source for the V3M Starter Kit board
> + *
> + * Copyright (C) 2017 Renesas Electronics Corp.
> + * Copyright (C) 2017 Cogent Embedded, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "r8a77970.dtsi"
> +
> +/ {
> +	model = "Renesas V3M Starter Kit board";
> +	compatible = "renesas,v3msk", "renesas,r8a77970";
> +
> +	aliases {
> +		serial0 = &scif0;
> +	};
> +
> +	chosen {

For consistency with other Renesas boards I would like to request the
following be added here:

		bootargs = "ignore_loglevel rw";

> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory at 48000000 {
> +		device_type = "memory";
> +		/* first 128MB is reserved for secure area. */
> +		reg = <0x0 0x48000000 0x0 0x38000000>;
> +	};
> +};
> +
> +&extal_clk {
> +	clock-frequency = <16666666>;
> +};
> +
> +&extalr_clk {
> +	clock-frequency = <32768>;
> +};
> +
> +&scif0 {
> +	status = "okay";
> +};
> 
