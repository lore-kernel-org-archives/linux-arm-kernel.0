From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Mar 2016 20:55:51 +0800
Subject: [PATCH] ARM: dts: ls102xa: Use new clock binding
In-Reply-To: <1456899082-29762-1-git-send-email-b18965@freescale.com>
References: <1456899082-29762-1-git-send-email-b18965@freescale.com>
Message-ID: <20160330125551.GI28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 02:11:22PM +0800, Alison Wang wrote:
> According to the current clock driver for Freescale QorIQ platform, new
> clock binding will be used for LS1021A.

Is this a simple clock binding updating/replacing, or does it actually
include some clock assignment changes?  I expect that it should be just
like the following direct replacement.

 <&cluster1_clk>   --> <&clockgen 1 0>
 <&platform_clk 1> --> <&clockgen 4 1>
 <&platform_clk 0> --> <&clockgen 4 0>
 
But the update to sata and watchdog nodes seem to be not the case.

Shawn

> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 97 +++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 726372d..5483728 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -74,14 +74,14 @@
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <0xf00>;
> -			clocks = <&cluster1_clk>;
> +			clocks = <&clockgen 1 0>;
>  		};
>  
>  		cpu at f01 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <0xf01>;
> -			clocks = <&cluster1_clk>;
> +			clocks = <&clockgen 1 0>;
>  		};
>  	};
>  
> @@ -99,6 +99,20 @@
>  			     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	sysclk: sysclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "sysclk";
> +	};
> +
> +	clk32k: clk32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "clk32k";
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> @@ -149,7 +163,7 @@
>  			      <0x0 0x20220520 0x0 0x4>;
>  			reg-names = "ahci", "sata-ecc";
>  			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 0>;
>  			dma-coherent;
>  			status = "disabled";
>  		};
> @@ -200,41 +214,10 @@
>  		};
>  
>  		clockgen: clocking at 1ee1000 {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0x0 0x0 0x1ee1000 0x10000>;
> -
> -			sysclk: sysclk {
> -				compatible = "fixed-clock";
> -				#clock-cells = <0>;
> -				clock-output-names = "sysclk";
> -			};
> -
> -			cga_pll1: pll at 800 {
> -				compatible = "fsl,qoriq-core-pll-2.0";
> -				#clock-cells = <1>;
> -				reg = <0x800 0x10>;
> -				clocks = <&sysclk>;
> -				clock-output-names = "cga-pll1", "cga-pll1-div2",
> -						     "cga-pll1-div4";
> -			};
> -
> -			platform_clk: pll at c00 {
> -				compatible = "fsl,qoriq-core-pll-2.0";
> -				#clock-cells = <1>;
> -				reg = <0xc00 0x10>;
> -				clocks = <&sysclk>;
> -				clock-output-names = "platform-clk", "platform-clk-div2";
> -			};
> -
> -			cluster1_clk: clk0c0 at 0 {
> -				compatible = "fsl,qoriq-core-mux-2.0";
> -				#clock-cells = <0>;
> -				reg = <0x0 0x10>;
> -				clock-names = "pll1cga", "pll1cga-div2", "pll1cga-div4";
> -				clocks = <&cga_pll1 0>, <&cga_pll1 1>, <&cga_pll1 2>;
> -				clock-output-names = "cluster1-clk";
> -			};
> +			compatible = "fsl,ls1021a-clockgen";
> +			reg = <0x0 0x1ee1000 0x0 0x1000>;
> +			#clock-cells = <2>;
> +			clocks = <&sysclk>;
>  		};
>  
>  		dspi0: dspi at 2100000 {
> @@ -244,7 +227,7 @@
>  			reg = <0x0 0x2100000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "dspi";
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			spi-num-chipselects = <5>;
>  			big-endian;
>  			status = "disabled";
> @@ -257,7 +240,7 @@
>  			reg = <0x0 0x2110000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "dspi";
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			spi-num-chipselects = <5>;
>  			big-endian;
>  			status = "disabled";
> @@ -270,7 +253,7 @@
>  			reg = <0x0 0x2180000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "i2c";
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			status = "disabled";
>  		};
>  
> @@ -281,7 +264,7 @@
>  			reg = <0x0 0x2190000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "i2c";
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			status = "disabled";
>  		};
>  
> @@ -292,7 +275,7 @@
>  			reg = <0x0 0x21a0000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "i2c";
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			status = "disabled";
>  		};
>  
> @@ -336,7 +319,7 @@
>  			compatible = "fsl,ls1021a-lpuart";
>  			reg = <0x0 0x2950000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&sysclk>;
> +			clocks = <&clockgen 4 1>;
>  			clock-names = "ipg";
>  			status = "disabled";
>  		};
> @@ -345,7 +328,7 @@
>  			compatible = "fsl,ls1021a-lpuart";
>  			reg = <0x0 0x2960000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			clock-names = "ipg";
>  			status = "disabled";
>  		};
> @@ -354,7 +337,7 @@
>  			compatible = "fsl,ls1021a-lpuart";
>  			reg = <0x0 0x2970000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			clock-names = "ipg";
>  			status = "disabled";
>  		};
> @@ -363,7 +346,7 @@
>  			compatible = "fsl,ls1021a-lpuart";
>  			reg = <0x0 0x2980000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			clock-names = "ipg";
>  			status = "disabled";
>  		};
> @@ -372,7 +355,7 @@
>  			compatible = "fsl,ls1021a-lpuart";
>  			reg = <0x0 0x2990000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			clock-names = "ipg";
>  			status = "disabled";
>  		};
> @@ -381,7 +364,7 @@
>  			compatible = "fsl,ls1021a-lpuart";
>  			reg = <0x0 0x29a0000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>;
>  			clock-names = "ipg";
>  			status = "disabled";
>  		};
> @@ -390,7 +373,7 @@
>  			compatible = "fsl,imx21-wdt";
>  			reg = <0x0 0x2ad0000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>;
> +			clocks = <&clk32k>;
>  			clock-names = "wdog-en";
>  			big-endian;
>  		};
> @@ -400,8 +383,8 @@
>  			compatible = "fsl,vf610-sai";
>  			reg = <0x0 0x2b50000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>, <&platform_clk 1>,
> -				 <&platform_clk 1>, <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&clockgen 4 1>, <&clockgen 4 1>;
>  			clock-names = "bus", "mclk1", "mclk2", "mclk3";
>  			dma-names = "tx", "rx";
>  			dmas = <&edma0 1 47>,
> @@ -414,8 +397,8 @@
>  			compatible = "fsl,vf610-sai";
>  			reg = <0x0 0x2b60000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 1>, <&platform_clk 1>,
> -				 <&platform_clk 1>, <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&clockgen 4 1>, <&clockgen 4 1>;
>  			clock-names = "bus", "mclk1", "mclk2", "mclk3";
>  			dma-names = "tx", "rx";
>  			dmas = <&edma0 1 45>,
> @@ -435,15 +418,15 @@
>  			dma-channels = <32>;
>  			big-endian;
>  			clock-names = "dmamux0", "dmamux1";
> -			clocks = <&platform_clk 1>,
> -				 <&platform_clk 1>;
> +			clocks = <&clockgen 4 1>,
> +				 <&clockgen 4 1>;
>  		};
>  
>  		dcu: dcu at 2ce0000 {
>  			compatible = "fsl,ls1021a-dcu";
>  			reg = <0x0 0x2ce0000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&platform_clk 0>;
> +			clocks = <&clockgen 4 0>;
>  			clock-names = "dcu";
>  			big-endian;
>  			status = "disabled";
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
