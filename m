From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Feb 2015 13:40:51 +0000
Subject: [PATCH v3 5/5] ARM: dts: Alpine platform devicetree
In-Reply-To: <54cf5d8c.sl7aclyeuuh66jXt%tsahee@annapurnalabs.com>
References: <54cf5d8c.sl7aclyeuuh66jXt%tsahee@annapurnalabs.com>
Message-ID: <20150202134051.GB21175@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 11:20:44AM +0000, Tsahee Zidenberg wrote:
> This patch introduces devicetree for the Alpine platform, and
> for a development board based on the same platform.
> 
> Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
> Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> ---
>  arch/arm/boot/dts/Makefile      |   4 ++
>  arch/arm/boot/dts/alpine-db.dts |  35 ++++++++++
>  arch/arm/boot/dts/alpine.dtsi   | 141 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 180 insertions(+)
>  create mode 100644 arch/arm/boot/dts/alpine-db.dts
>  create mode 100644 arch/arm/boot/dts/alpine.dtsi

[...]

> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		arch-timer {
> +			compatible = "arm,cortex-a15-timer",
> +				     "arm,armv7-timer";
> +			interrupts =
> +				<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +			clock-frequency = <0>; /* Filled by loader */

Your loader doesn't configure CNTFRQ?

> +		};
> +
> +		/* Interrupt Controller */
> +		gic: gic at fb001000 {
> +			compatible = "arm,cortex-a15-gic";
> +			#interrupt-cells = <3>;
> +			#size-cells = <0>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xfb001000 0x0 0x1000>,
> +			      <0x0 0xfb002000 0x0 0x2000>,
> +			      <0x0 0xfb004000 0x0 0x1000>,
> +			      <0x0 0xfb006000 0x0 0x2000>;
> +			interrupts =
> +				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		/* CPU Resume registers */
> +		cpu-resume at fbff5ec0 {
> +			compatible = "al,alpine-cpu-resume";
> +			reg = <0x0 0xfbff5ec0 0x0 0x30>;
> +		};
> +
> +		/* North Bridge Service Registers */
> +		sysfabric-service at fb070000 {
> +			compatible = "al,alpine-sysfabric-service", "syscon", "simple-bus";
> +			reg = <0x0 0xfb070000 0x0 0x10000>;
> +		};

That compatible list makes no sense whatsoever.

Why is "simple-bus" on the end?

Mark.
