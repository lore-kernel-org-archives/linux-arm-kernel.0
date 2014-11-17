From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Nov 2014 11:14:50 +0000
Subject: [PATCH 07/11] arm: perf: document PMU affinity binding
In-Reply-To: <1415377536-12841-8-git-send-email-mark.rutland@arm.com>
References: <1415377536-12841-1-git-send-email-mark.rutland@arm.com>
 <1415377536-12841-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20141117111450.GD18061@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Nov 07, 2014 at 04:25:32PM +0000, Mark Rutland wrote:
> To describe the various ways CPU PMU interrupts might be wired up, we
> can refer to the topology information in the device tree.
> 
> This patch adds a new property to the PMU binding, interrupts-affinity,
> which describes the relationship between CPUs and interrupts. This
> information is necessary to handle systems with heterogeneous PMU
> implementations (e.g. big.LITTLE). Documentation is added describing the
> use of said property.

I'm not entirely comfortable with using interrupt affinity to convey
PMU affinity. It seems perfectly plausible for somebody to play the usual
trick of ORing all the irq lines together, despite having a big/little
PMU configuration.

Can you describe such a system with this binding?

> +Example 2 (Multiple clusters with single interrupts):
> +
> +cpus {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	CPU0: cpu at 0 {
> +		reg = <0x0>;
> +		compatible = "arm,cortex-a15-pmu";
> +	};
> +
> +	CPU1: cpu at 1 {
> +		reg = <0x1>;
> +		compatible = "arm,cotex-a15-pmu";

cortex

> +	};
> +
> +	CPU100: cpu at 100 {
> +		reg = <0x100>;
> +		compatible = "arm,cortex-a7-pmu";
> +	};
> +
> +	cpu-map {
> +		cluster0 {
> +			CORE_0_0: core0 {
> +				cpu = <&CPU0>;
> +			};
> +			CORE_0_1: core1 {
> +				cpu = <&CPU1>;
> +			};
> +		};
> +		cluster1 {
> +			CORE_1_0: core0 {
> +				cpu = <&CPU100>;
> +			};
> +		};
> +	};
> +};
> +
> +pmu_a15 {
> +	compatible = "arm,cortex-a15-pmu";
> +	interrupts = <100>, <101>;
> +	interrupts-affinity = <&CORE0>, <&CORE1>;
> +};
> +
> +pmu_a7 {
> +	compatible = "arm,cortex-a7-pmu";
> +	interrupts = <105>;
> +	interrupts-affinity = <&CORE_1_0>;
> +};
> +
> +Example 3 (Multiple clusters with per-cpu interrupts):
> +
> +cpus {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	CPU0: cpu at 0 {
> +		reg = <0x0>;
> +		compatible = "arm,cortex-a15-pmu";
> +	};
> +
> +	CPU1: cpu at 1 {
> +		reg = <0x1>;
> +		compatible = "arm,cotex-a15-pmu";

Same here.

Will
