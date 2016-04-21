From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Apr 2016 11:19:30 +0100
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20160421101930.GG6879@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 11:58:12AM +0800, Jianqun Xu wrote:
> +		cpu_l0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>; /* min followed by max */
> +			clocks = <&cru ARMCLKL>;
> +		};

> +		cpu_b0: cpu at 100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72", "arm,armv8";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>; /* min followed by max */
> +			clocks = <&cru ARMCLKB>;
> +		};

> +
> +	arm-pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};

This is wrong, and must go. There should be a separate node for the PMU
of each microarchitecture, with the appropriate compatible string to
represent that (see the juno dts).

In this case things are messier as the same PPI number is being used
across clusters. Marc (Cc'd) has been working on PPI partitions, which
should allow us to support that.

Thanks,
Mark.
