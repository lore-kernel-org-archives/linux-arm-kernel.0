From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 02 Nov 2015 16:01:04 +0000
Subject: [PATCH v8 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <56377ED5.4070203@sigmadesigns.com> (Marc Gonzalez's message of
 "Mon, 2 Nov 2015 16:18:45 +0100")
References: <56377E76.2080209@sigmadesigns.com>
 <56377ED5.4070203@sigmadesigns.com>
Message-ID: <yw1xk2q09yrj.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> This device tree was tested on a Sigma Designs SMP8758 Vantage-1172
> development board.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  arch/arm/boot/dts/Makefile                |   2 +
>  arch/arm/boot/dts/tango4-common.dtsi      | 121 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/tango4-smp8758.dtsi     |  30 ++++++++
>  arch/arm/boot/dts/tango4-vantage-1172.dts |  24 ++++++
>  4 files changed, 177 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tango4-common.dtsi
>  create mode 100644 arch/arm/boot/dts/tango4-smp8758.dtsi
>  create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 246473a244f6..2499295051d5 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -605,6 +605,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb \
>  	sun9i-a80-cubieboard4.dtb
> +dtb-$(CONFIG_ARCH_TANGOX) += \
> +	tango4-vantage-1172.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
>  	tegra20-harmony.dtb \
>  	tegra20-iris-512.dtb \
> diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
> new file mode 100644
> index 000000000000..90e9a6e736ae
> --- /dev/null
> +++ b/arch/arm/boot/dts/tango4-common.dtsi
> @@ -0,0 +1,121 @@
> +/*
> + * Derived from Mans Rullgard's Tango3 DT
> + * https://github.com/mansr/linux-tangox
> + */

Why don't you take the tango4 one from the same repo?

> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	clocks {
> +		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		xtal: xtal {
> +			compatible = "fixed-clock";
> +			clock-frequency = <27000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		clkgen: clkgen at 10000 {
> +			compatible = "sigma,tango4-clkgen";
> +			reg = <0x10000 0x40>;
> +			clocks = <&xtal>;
> +			clock-output-names = "cpuclk", "sysclk";
> +			#clock-cells = <1>;
> +		};

There are about a dozen more clocks that will be needed eventually.  Do
you have a plan for how to add them?  (My driver already has support for
most of them.)

> +	};
> +
> +	gic: interrupt-controller at 20001000 {
> +		compatible = "arm,cortex-a9-gic";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		reg = <0x20001000 0x1000>, <0x20000100 0x0100>;
> +	};
> +
> +	l2cc: l2-cache-controller at 20100000 {
> +		compatible = "arm,pl310-cache";
> +		reg = <0x20100000 0x1000>;
> +		cache-level = <2>;
> +		cache-unified;
> +	};
> +
> +	periphclk: periphclk {

Why is this not in the clocks block above?

> +		compatible = "fixed-factor-clock";
> +		clocks = <&clkgen 0>;
> +		clock-mult = <1>;
> +		clock-div  = <2>;

Some Sigma source code I found on the Internet uses a divisor of 3.
Which is correct?

> +		#clock-cells = <0>;
> +	};
> +
> +	twd-timer at 20000600 {
> +		compatible = "arm,cortex-a9-twd-timer";
> +		reg = <0x20000600 0x10>;
> +		interrupts = <GIC_PPI 13 0xf04>;
> +		interrupt-parent = <&gic>;
> +		clocks = <&periphclk>;
> +		always-on;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

Put interrupt-parent = <&irq0> here and save repeating it for each device.

> +		tick-counter at 10048 {
> +			compatible = "sigma,tick-counter";

This compatible name is too vague.  What if the next Sigma chip has a
completely different counter?

> +			reg = <0x10048 0x4>;
> +			clocks = <&xtal>;
> +		};
> +
> +		uart: serial at 10700 {
> +			compatible = "ralink,rt2880-uart";
> +			reg = <0x10700 0x30>;
> +			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent = <&irq0>;
> +			clock-frequency = <7372800>;
> +			reg-shift = <2>;
> +		};
> +
> +		eth0: ethernet at 26000 {
> +			reg = <0x26000 0x800>;
> +			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent = <&irq0>;
> +			clocks = <&clkgen 1>;
> +		};

Missing compatible string.

> +		intc: interrupt-controller at 6e000 {
> +			reg = <0x6e000 0x400>;
> +			ranges = <0 0x6e000 0x400>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			#address-cells = <1>;
> +			#size-cells = <1>;

Missing compatible string.

> +			irq0: irq0 at 6e000 {

The node name should be interrupt-controller at 000, similarly below.

> +				reg = <0x000 0x100>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			irq1: irq1 at 6e100 {
> +				reg = <0x100 0x100>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			irq2: irq2 at 6e300 {
> +				reg = <0x300 0x100>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
> new file mode 100644
> index 000000000000..4eb23a12e27f
> --- /dev/null
> +++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
> @@ -0,0 +1,30 @@
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		enable-method = "sigma,tango4-smp";

This enable-method is too vague.  The next chip might be different.

> +		cpu0: cpu at 0 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			reg = <0>;
> +		};
> +
> +		cpu1: cpu at 1 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			reg = <1>;
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupt-affinity = <&cpu0>, <&cpu1>;
> +		interrupt-parent = <&gic>;
> +		interrupts =
> +			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +};

The device tree should mention the SCU.

> diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
> new file mode 100644
> index 000000000000..22de3624ed97
> --- /dev/null
> +++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
> @@ -0,0 +1,24 @@
> +/dts-v1/;
> +
> +#include "tango4-smp8758.dtsi"
> +#include "tango4-common.dtsi"
> +
> +/ {
> +	model = "Sigma Designs SMP8758 Vantage-1172 dev board";
> +	compatible = "sigma,vantage-1172", "sigma,smp8758", "sigma,tango4";
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>; /* 2 GB */
> +	};
> +};
> +
> +&eth0 {
> +	compatible = "sigma,smp8758-ethernet", "sigma,smp8734-ethernet", "sigma,smp8642-ethernet", "aurora,nb8800";

It's odd to specify the compatible string here.  It certainly won't
change between different boards using the same chip.  Also, in the
latest version of my driver, tango3 and tango4 are unfortunately not
compatible.  The incompatibility only showed up once I enabled the L2
cache.  I don't know quite what's going on.

> +	phy-connection-type = "rgmii";
> +	max-speed = <1000>;

You should have a node for the PHY here.

> +};
> +
> +&intc {
> +	compatible = "sigma,smp8758-intc", "sigma,smp8642-intc";

Wrong place for the compatible string.

> +};

-- 
M?ns Rullg?rd
mans at mansr.com
