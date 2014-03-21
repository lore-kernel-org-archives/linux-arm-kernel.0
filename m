From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Mar 2014 11:47:10 +0000
Subject: [PATCH v3 1/3] arm64: dts: add initial dts for Samsung GH7 SoC
 and SSDK-GH7 board
In-Reply-To: <1395094477-8921-2-git-send-email-kgene.kim@samsung.com>
References: <1395094477-8921-1-git-send-email-kgene.kim@samsung.com>
 <1395094477-8921-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20140321114710.GO23372@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 17, 2014 at 10:14:35PM +0000, Kukjin Kim wrote:
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/boot/dts/samsung-gh7.dtsi     | 134 +++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/samsung-ssdk-gh7.dts |  26 ++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/samsung-gh7.dtsi
>  create mode 100644 arch/arm64/boot/dts/samsung-ssdk-gh7.dts
> 
> diff --git a/arch/arm64/boot/dts/samsung-gh7.dtsi b/arch/arm64/boot/dts/samsung-gh7.dtsi
> new file mode 100644
> index 0000000..d3ab914
> --- /dev/null
> +++ b/arch/arm64/boot/dts/samsung-gh7.dtsi
> @@ -0,0 +1,134 @@
> +/*
> + * SAMSUNG GH7 SoC device tree source
> + *
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/memreserve/ 0xFEC00000 0x1400000;	/* EL3 monitor, secure intepreter */

As I've mentioned, I'm concerned that this is even in the non-secure
address space that the kernel can access. Why is this not hidden from
the kernel entirely? Why is it expected to be mapped in and reserved?

Additionally, the memory the used by the spin-table (0x0 0x8000fff8) has
not been reserved, and thus the kernel is free to clobber it.

[...]

> +	gic: interrupt-controller at 1C000000 {
> +		compatible = "arm,cortex-a15-gic";

For targeting any future workarounds I would very much prefer a more
specific string.

[...]

> +	pmu {
> +		compatible = "samsung,gh7-pmu", "armv8-pmuv3";
> +		interrupts = <0 294 0>,
> +			     <0 295 0>,
> +			     <0 296 0>,
> +			     <0 297 0>,
> +			     <0 298 0>,
> +			     <0 299 0>,
> +			     <0 300 0>,
> +			     <0 301 0>;
> +	};

These are all missing a trigger type (thus making them unusable), and as
"GH7" is the SoC name rather than the CPU name, the compatible string is
somewhat bad.

> +
> +	amba {
> +		compatible = "arm,amba-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		serial at 12c00000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0 0x12c00000 0 0x10000>;
> +			interrupts = <0 418 0>;
> +		};
> +
> +		serial at 12c20000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0 0x12c20000 0 0x10000>;
> +			interrupts = <0 420 0>;
> +		};

While the primecell bindings and PL011 bindings state that clocks are
optional, the primecell bus code requires a clock named apb_pclk, and
the pl011 driver requires a clock (which it expects to be UARTCLK) to
acquire the frequency from. As neither are provided I do not see how
this DT could possibly be used to boot a usable system.

Additionally the interrupt trigger types are missing.

Given that these are the only IO devices described in the dtsi/dts
combination, and they do not appear to be usable, what is the point in
merging this?

Cheers,
Mark.
