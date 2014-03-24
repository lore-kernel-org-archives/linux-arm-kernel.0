From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Mar 2014 10:25:12 +0000
Subject: [PATCH v2 2/3] arm64: dts: Add initial dts for Cavium Thunder SoC
In-Reply-To: <1395652179-9216-3-git-send-email-mohun106@gmail.com>
References: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
 <1395652179-9216-3-git-send-email-mohun106@gmail.com>
Message-ID: <20140324102512.GC10341@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 24, 2014 at 09:09:38AM +0000, mohun106 at gmail.com wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> ---
>  arch/arm64/boot/dts/Makefile    |    1 +
>  arch/arm64/boot/dts/thunder.dts |  160 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index c52bdb0..9cc8740 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,3 +1,4 @@
> +dtb-$(CONFIG_ARCH_THUNDER) += thunder.dtb
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>  
> diff --git a/arch/arm64/boot/dts/thunder.dts b/arch/arm64/boot/dts/thunder.dts
> new file mode 100644
> index 0000000..190e01a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/thunder.dts
> @@ -0,0 +1,160 @@
> +/*
> + * Cavium Thunder DTS file
> + *
> + * Copyright (C) 2013, Cavium Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +/dts-v1/;
> +
> +/memreserve/ 0x80000000 0x00010000;

Please add a comment as to what this is protecting (from the looks of
it, the spinning CPUs and the cpu release address). We are admittedly
lacking these on existing DTs (and I'll fix that up), but it would be
good to get into the habit now given it has been a source of confusion
for some.

> +
> +/ {
> +	model = "Cavium Thunder";
> +	compatible = "cavium,thunder";
> +	interrupt-parent = <&gic0>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uaa0;
> +		serial1 = &uaa1;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder", "arm,armv8";

This is the same as the compatible string for the SoC, which isn't a
good idea. Compatible strings should be globally unique.

As far as I am aware, "Thunder" is the name of the SoC, not the CPU in
the SoC. Is there a name for the CPU in the Thunder SoC?

Whatever name you have should be documented.

[...]

> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	gic0: interrupt-controller at 801000000000 {

Please break the 32-bit halves of the unit-address with a comma (e.g.
8010,00000000); it makes it easier to read the address. If you could
also do this on other unit-addresses it would be helpful.

> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0x8010 0x0 0x0 0x10000>,         /* GICD */
> +		      <0x8010 0x80000000 0x0 0x100000>; /* GICR */

For legibility it would be nice for list entries to be consistently
padded to the same length.

> +		interrupts = <1 9 0xf04>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 0xff01>,
> +		             <1 14 0xff01>,
> +		             <1 11 0xff01>,
> +		             <1 10 0xff01>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clocks {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			refclk50mhz: refclk50mhz {
> +				compatible = "fixed-clock";
> +				#clock-cells = <0>;
> +				clock-frequency = <50000000>;
> +				clock-output-names = "refclk50mhz";
> +			};
> +		};

I don't think the clocks node adds anything here. It's missing a
compatible string list, and as clocks isn't a special reserved node
name, it and its children aren't supposed to be probed.

Why not just put the refclk50mhz directly under the parent node (the soc
simple-bus)?

[...]

> +		uaa0: uart at 87e024000000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x87e0 0x24000000 0x0 0x1000>;
> +			interrupts = <1 21 4>;
> +			clocks = <&refclk50mhz>;
> +			clock-names = "apb_pclk";

Is this also feeding the UARTCLK?

> +		};
> +
> +		uaa1: uart at 87e025000000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x87e0 0x25000000 0x0 0x1000>;
> +			interrupts = <1 22 4>;
> +			clocks = <&refclk50mhz>;
> +			clock-names = "apb_pclk";

Likewise?

Cheers,
Mark.
