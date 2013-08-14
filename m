From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 14 Aug 2013 18:44:08 +0900
Subject: [PATCH 1/2] ARM: dts: Move the common DMA controller nodes to
 exynos5.dtsi
In-Reply-To: <1373458449-19039-2-git-send-email-padma.v@samsung.com>
References: <1373458449-19039-1-git-send-email-padma.v@samsung.com>
 <1373458449-19039-2-git-send-email-padma.v@samsung.com>
Message-ID: <110401ce98d2$d304e2f0$790ea8d0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> exynos5250 and exynos5420 has 4 DMA controllers in common. So this patch
> moves these nodes to common file keeping the dma controllers clk info in
> the exynos5250 dtsi file.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |   44
> +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi |   30 -------------------------
>  2 files changed, 44 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5.dtsi
> b/arch/arm/boot/dts/exynos5.dtsi
> index f65e124..cac35c8 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -50,6 +50,50 @@
>  		interrupts = <1 9 0xf04>;
>  	};
> 
> +	amba {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "arm,amba-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		pdma0: pdma at 121A0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121A0000 0x1000>;
> +			interrupts = <0 34 0>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma at 121B0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121B0000 0x1000>;
> +			interrupts = <0 35 0>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma0: mdma at 10800000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x10800000 0x1000>;
> +			interrupts = <0 33 0>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +
> +		mdma1: mdma at 11C10000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x11C10000 0x1000>;
> +			interrupts = <0 124 0>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +	};
> +
>  	dwmmc_0: dwmmc0 at 12200000 {
>  		compatible = "samsung,exynos5250-dw-mshc";
>  		interrupts = <0 75 0>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index 41cd625..3a474c4 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -511,54 +511,24 @@
>  	};
> 
>  	amba {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "arm,amba-bus";
> -		interrupt-parent = <&gic>;
> -		ranges;
> -
>  		pdma0: pdma at 121A0000 {
> -			compatible = "arm,pl330", "arm,primecell";
> -			reg = <0x121A0000 0x1000>;
> -			interrupts = <0 34 0>;
>  			clocks = <&clock 275>;
>  			clock-names = "apb_pclk";
> -			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
>  		};
> 
>  		pdma1: pdma at 121B0000 {
> -			compatible = "arm,pl330", "arm,primecell";
> -			reg = <0x121B0000 0x1000>;
> -			interrupts = <0 35 0>;
>  			clocks = <&clock 276>;
>  			clock-names = "apb_pclk";
> -			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
>  		};
> 
>  		mdma0: mdma at 10800000 {
> -			compatible = "arm,pl330", "arm,primecell";
> -			reg = <0x10800000 0x1000>;
> -			interrupts = <0 33 0>;
>  			clocks = <&clock 271>;
>  			clock-names = "apb_pclk";
> -			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <1>;
>  		};
> 
>  		mdma1: mdma at 11C10000 {
> -			compatible = "arm,pl330", "arm,primecell";
> -			reg = <0x11C10000 0x1000>;
> -			interrupts = <0 124 0>;
>  			clocks = <&clock 271>;
>  			clock-names = "apb_pclk";
> -			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <1>;
>  		};
>  	};
> 
> --
> 1.7.4.4

NAK, because the dmac addresses are different on upcoming exynos5 and there
are 2-mdma and only one pdma. So this change can make more complicated.

- Kukjin
