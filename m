From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 02 Oct 2015 17:10:26 +0100
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
In-Reply-To: <560EAA7C.3070302@free.fr> (Mason's message of "Fri, 2 Oct 2015
 18:02:04 +0200")
References: <560EAA7C.3070302@free.fr>
Message-ID: <yw1xoaghl099.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> diff --git a/arch/arm/boot/dts/tango4.dtsi b/arch/arm/boot/dts/tango4.dtsi
> new file mode 100644
> index 000000000000..7336fcc3ac1d
> --- /dev/null
> +++ b/arch/arm/boot/dts/tango4.dtsi
> @@ -0,0 +1,117 @@
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "sigma,tango4-soc";
> +
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
> +		sysclk: sysclk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <396000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		cpuclk: cpuclk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <999000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		periphclk: periphclk {
> +			compatible = "fixed-factor-clock";
> +			clocks = <&cpuclk>;
> +			clock-mult = <1>;
> +			clock-div  = <2>;
> +			#clock-cells = <0>;
> +		};
> +	};

Once more with feeling, why don't you want to use the fine clock driver
I wrote?

> +	gic: gic at 20001000 {
> +		compatible = "arm,cortex-a9-gic";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		reg = <0x20001000 0x1000>,
> +		      <0x20000100 0x0100>;
> +	};
> +
> +	twd-timer at 20000600 {
> +		compatible = "arm,cortex-a9-twd-timer";
> +		reg = <0x20000600 0x10>;
> +		interrupts = <1 13 0xf01>;
> +		interrupt-parent = <&gic>;
> +		clocks = <&periphclk>;
> +		twd_never_stops;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		xtal_in_cnt {
> +			compatible = "sigma,xtal_in_cnt";
> +			reg = <0x10048 0x4>;
> +			clocks = <&xtal>;
> +		};
> +
> +		uart0 {
> +			compatible = "ralink,rt2880-uart";
> +			reg = <0x10700 0x100>;
> +			clock-frequency = <7372800>;
> +			reg-shift = <2>;
> +/*			fifo-size = <16>; BROKEN */

Either fix whatever is broken or drop that line.

> +		};
> +
> +		eth0: eth0 {
> +			compatible = "sigma,smp8640-emac";
> +			reg = <0x26000 0x800>;
> +			interrupts = <38 4>;
> +			interrupt-parent = <&irq0>;
> +			mac-address = [ 00 16 e8 02 08 42 ];

mac-address should not be hardcoded here or anywhere else.

> +			clocks = <&sysclk>;
> +		};
> +
> +		intc: intc at e000 {
> +			compatible = "sigma,tango-intc";

Why do you insist on using other names than the ones I've been using for
months?  Just want to leave your own mark on the code?

> diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
> new file mode 100644
> index 000000000000..152cdd487056
> --- /dev/null
> +++ b/arch/arm/mach-tangox/Kconfig
> @@ -0,0 +1,12 @@
> +# Tango3 was based on MIPS 74kf. Tango4 is based on ARM Cortex A9 MPCore.

This comment isn't relevant to the contents of the file.

-- 
M?ns Rullg?rd
mans at mansr.com
