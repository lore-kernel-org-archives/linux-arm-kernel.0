From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Sep 2015 11:55:11 +0100
Subject: [PATCH 2/2] arm64/apm: add dts for Gigabyte MP30-AR0 board
In-Reply-To: <1440948270-1991-3-git-send-email-j@jannau.net>
References: <1440948270-1991-1-git-send-email-j@jannau.net>
 <1440948270-1991-3-git-send-email-j@jannau.net>
Message-ID: <20150901105510.GB15900@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 30, 2015 at 04:24:30PM +0100, Janne Grunau wrote:
> Creates apm-storm-883408.dtsi which should be shareable with the HP
> Moonshot m400 cartridge.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm64/boot/dts/apm/Makefile              |  1 +
>  arch/arm64/boot/dts/apm/apm-storm-883408.dtsi | 98 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/apm/mp30ar0.dts           | 85 +++++++++++++++++++++++
>  3 files changed, 184 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apm/apm-storm-883408.dtsi
>  create mode 100644 arch/arm64/boot/dts/apm/mp30ar0.dts
> 
> diff --git a/arch/arm64/boot/dts/apm/Makefile b/arch/arm64/boot/dts/apm/Makefile
> index a2afabb..b0ec2b6 100644
> --- a/arch/arm64/boot/dts/apm/Makefile
> +++ b/arch/arm64/boot/dts/apm/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
> +dtb-$(CONFIG_ARCH_XGENE) += mp30ar0.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/apm/apm-storm-883408.dtsi b/arch/arm64/boot/dts/apm/apm-storm-883408.dtsi
> new file mode 100644
> index 0000000..83116df
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apm/apm-storm-883408.dtsi
> @@ -0,0 +1,98 @@
> +/*
> + * dts file for AppliedMicro (APM) X-Gene Storm SOC APM883408
> + *
> + * Copyright (C) 2013, Applied Micro Circuits Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +/ {
> +	compatible = "apm,xgene-storm";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu at 000 {
> +			device_type = "cpu";
> +			compatible = "apm,potenza", "arm,armv8";
> +			reg = <0x0 0x000>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x40 0x0000fff8>;
> +		};

This release address doesn't fall in the region described by the memory
node, and I don't see any /memreserve/. That worries me.

Does the bootlaoder override the memory node?

Does it add the requisite memreserve?

Does it override the cpu-release-addr?

[...]

> +	gic: interrupt-controller at 78090000 {
> +		compatible = "arm,cortex-a15-gic";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x0 0x78090000 0x0 0x10000>,	/* GIC Dist */
> +		      <0x0 0x780a0000 0x0 0x10000>,	/* GIC CPU */
> +		      <0x0 0x780c0000 0x0 0x20000>,	/* GIC VCPU Control */
> +		      <0x0 0x780e0000 0x0 0x20000>;	/* GIC VCPU */
> +		interrupts = <1 9 0xf04>;
> +	};

Nit: add a blank line here.

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 0 0xff04>,	/* Secure Phys IRQ */
> +			     <1 13 0xff04>,	/* Non-secure Phys IRQ */
> +			     <1 14 0xff04>,	/* Virt IRQ */
> +			     <1 15 0xff04>;	/* Hyp IRQ */
> +		clock-frequency = <50000000>;
> +	};

Surely the firmware is configuring CNTFRQ, and it's not necessary to
have a clock-frequency property?

> +};
> diff --git a/arch/arm64/boot/dts/apm/mp30ar0.dts b/arch/arm64/boot/dts/apm/mp30ar0.dts
> new file mode 100644
> index 0000000..f7a9dae5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apm/mp30ar0.dts
> @@ -0,0 +1,85 @@
> +/*
> + * dts file for Gigabyte MP30-AR0 board
> + *
> + * Copyright (C) 2013, Applied Micro Circuits Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/include/ "apm-storm-883408.dtsi"
> +/include/ "apm-storm-soc.dtsi"
> +
> +/ {
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <0x1 0xc 0xff04>;
> +	};
> +
> +	memory {
> +		#address-cells = <0x2>;
> +		#size-cells = <0x2>;

I don't see why these properties should be here.

> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x2000000>;

Is this overriden by the bootloader? It seems a tad small...

> +	};
> +
> +	poweroff_mbox: poweroff_mbox at 10548000 {
> +		compatible = "syscon";
> +		reg = <0x0 0x10548000 0x0 0x100>;
> +	};
> +
> +	poweroff at 10548010 {
> +		compatible = "syscon-poweroff";
> +		regmap = <&poweroff_mbox>;
> +		offset = <0x10>;
> +		mask = <0x1>;
> +	};
> +
> +	chosen {
> +		linux,stdout-path = "/soc/serial at 1c020000";

Please use stdout-path rather than linux,stdout-path.

No rate configuration?

This would look nicer with an alias.

Thanks,
Mark.
