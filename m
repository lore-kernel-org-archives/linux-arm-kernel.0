From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 09:32:49 +0800
Subject: [PATCH v3] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <1481025036-4912-1-git-send-email-harninder.rai@nxp.com>
References: <1481025036-4912-1-git-send-email-harninder.rai@nxp.com>
Message-ID: <20161230013247.GE6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 05:20:36PM +0530, Harninder Rai wrote:
> LS1012A features an advanced 64-bit ARM v8 CortexA53 processor
> with 32 KB of parity protected L1-I cache, 32 KB of ECC protected
> L1-D cache, as well as 256 KB of ECC protected L2 cache.
> 
> Features summary
>  One 64-bit ARM-v8 Cortex-A53 core with the following capabilities
>   - Arranged as a cluster of one core supporting a 256 KB L2 cache with ECC
>     protection
>   - Speed up to 800 MHz
>   - Parity-protected 32 KB L1 instruction cache and 32 KB L1 data cache
>   - Neon SIMD engine
>   - ARM v8 cryptography extensions
>  One 16-bit DDR3L SDRAM memory controller
>  ARM core-link CCI-400 cache coherent interconnect
>  Cryptography acceleration (SEC)
>  One Configurable x3 SerDes
>  One PCI Express Gen2 controller, supporting x1 operation
>  One serial ATA (SATA Gen 3.0) controller
>  One USB 3.0/2.0 controller with integrated PHY
> 
>  Following levels of DTSI/DTS files have been created for the LS1012A
>    SoC family:
> 
>            - fsl-ls1012a.dtsi:
>                    DTS-Include file for FSL LS1012A SoC.
> 
>            - fsl-ls1012a-frdm.dts:
>                    DTS file for FSL LS1012A FRDM board.
> 
>            - fsl-ls1012a-qds.dts:
>                    DTS file for FSL LS1012A QDS board.
> 
>            - fsl-ls1012a-rdb.dts:
>                     DTS file for FSL LS1012A RDB board.
> 
> Signed-off-by: Harninder Rai <harninder.rai@nxp.com>
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>

It looks good now, except a few minor things below.

<snip>

> +/ {
> +	model = "LS1012A Freedom Board";
> +	compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
> +
> +	sys_mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	regulator_1p8v: regulator {

The node name is too generic.  We generally suggest the following naming
scheme for fixed regulator.

	reg_xxx: regulator-xxx {
		...
	};

> +		compatible = "regulator-fixed";
> +		regulator-name = "1P8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};

<snip>

> +
> +/ {
> +	model = "LS1012A QDS Board";
> +	compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
> +
> +	sys_mclk: clock-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24576000>;
> +	};
> +
> +	regulator_3p3v: regulator {

Ditto

> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};

<snip>

> +/ {
> +	compatible = "fsl,ls1012a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			clocks = <&clockgen 1 0>;
> +			#cooling-cells = <2>;
> +		};
> +	};
> +
> +	sysclk: sysclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "sysclk";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +

This newline is unnecessary.

> +		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
> +			     <1 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-Secure PPI */
> +			     <1 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
> +			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
> +	};

<snip>

> +		duart0: serial at 21c0500 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x00 0x21c0500 0x0 0x100>;
> +			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 0>;
> +		};

status = "disabled";

> +
> +		duart1: serial at 21c0600 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x00 0x21c0600 0x0 0x100>;
> +			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 0>;
> +		};

Ditto

<snip>

> +		sata: sata at 3200000 {
> +			compatible = "fsl,ls1012a-ahci", "fsl,ls1043a-ahci";
> +			reg = <0x0 0x3200000 0x0 0x10000>;
> +			interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 0>;

Ditto

Shawn

> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
