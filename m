From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Jan 2015 10:35:59 +0000
Subject: [PATCH v5 3/5] arm64: dts: Add support for Spreadtrum SC9836 SoC
 in dts and Makefile
In-Reply-To: <1421402411-3479-4-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836-v5>
 <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-4-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20150116103558.GD21809@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 10:00:09AM +0000, Chunyan Zhang wrote:
> From: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
> 
> Adds the device tree support for Spreadtrum SC9836 SoC which is based on
> Sharkl64 platform.
> 
> Sharkl64 platform contains the common nodes of Spreadtrum's arm64-based SoCs.
> 
> Signed-off-by: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  arch/arm64/boot/dts/Makefile                  |    1 +
>  arch/arm64/boot/dts/sprd/Makefile             |    5 ++
>  arch/arm64/boot/dts/sprd/sc9836-openphone.dts |   49 +++++++++++++++++
>  arch/arm64/boot/dts/sprd/sc9836.dtsi          |   73 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/sprd/sharkl64.dtsi        |   67 +++++++++++++++++++++++
>  5 files changed, 195 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/sprd/Makefile
>  create mode 100644 arch/arm64/boot/dts/sprd/sc9836-openphone.dts
>  create mode 100644 arch/arm64/boot/dts/sprd/sc9836.dtsi
>  create mode 100644 arch/arm64/boot/dts/sprd/sharkl64.dtsi

[...]

> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +	};

Just to check, all CPUs may be hotplugged off and on, yes?

Including CPU0?

How is your implementation tested?

You boot CPUs at EL2?

> +
> +	gic: interrupt-controller at 12001000 {
> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0 0x12001000 0 0x1000>,
> +		      <0 0x12002000 0 0x2000>,
> +		      <0 0x12004000 0 0x2000>,
> +		      <0 0x12006000 0 0x2000>;
> +	};

You're missing the maintenance interrupt here.

[...]

> diff --git a/arch/arm64/boot/dts/sprd/sharkl64.dtsi b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
> new file mode 100644
> index 0000000..b08989d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
> @@ -0,0 +1,67 @@
> +/*
> + * Spreadtrum Sharkl64 platform DTS file
> + *
> + * Copyright (C) 2014, Spreadtrum Communications Inc.
> + *
> + * This file is licensed under a dual GPLv2 or X11 license.
> + */
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	soc {
> +		compatible = "simple-bus";
> +		reg = <0x0 0x0 0x0 0x80000000>;

What is this reg for? It's not required by simple-bus.

If you want to encode that this covers a particular portion of the
address space, do so with the ranges proeprty.

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ap_apb: apb at 70000000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0x70000000 0x0 0x10000000>;

Likewise here.

Thanks,
Mark.
