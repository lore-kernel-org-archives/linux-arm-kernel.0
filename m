From: j@jannau.net (Janne Grunau)
Date: Sun, 30 Aug 2015 19:26:32 +0200
Subject: [PATCH 2/2] arm64/apm: add dts for Gigabyte MP30-AR0 board
In-Reply-To: <1440948270-1991-3-git-send-email-j@jannau.net>
References: <1440948270-1991-1-git-send-email-j@jannau.net>
 <1440948270-1991-3-git-send-email-j@jannau.net>
Message-ID: <20150830172632.GH17056@jannau.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-08-30 17:24:30 +0200, Janne Grunau wrote:
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

/include/ "apm-storm.dtsi"

I split the soc node first into its own file but then decided that 
keeping the larger part in the same file introduces less merge 
conflicts.

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
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x2000000>;
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

This doesn't seem to work, even with the poweroff/reset patches for 
mustang.

Janne
