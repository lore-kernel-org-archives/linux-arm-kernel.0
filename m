From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 28 Jan 2017 09:36:44 +0800
Subject: [PATCH 2/3] arm64: dts: ls1012a: Add coreclk
In-Reply-To: <1485332363-8434-2-git-send-email-oss@buserror.net>
References: <1485332363-8434-1-git-send-email-oss@buserror.net>
 <1485332363-8434-2-git-send-email-oss@buserror.net>
Message-ID: <20170128013642.GF5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 02:19:22AM -0600, Scott Wood wrote:
> ls1012a has separate input root clocks for core PLLs versus the platform
> PLL, with the latter described as sysclk in the hw docs.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
> Note that current versions of U-Boot are blindly updating the frequency
> of all fixed-clock nodes.  That needs to be fixed for the split input
> frequency to work properly, but until U-Boot is fixed this change doesn't
> make anything worse than it already was.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index cffebb4..515f8488 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -66,10 +66,17 @@
>  	sysclk: sysclk {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -		clock-frequency = <100000000>;
> +		clock-frequency = <125000000>;

Should we mention this change a bit in the commit log?

Shawn

>  		clock-output-names = "sysclk";
>  	};
>  
> +	coreclk: coreclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "coreclk";
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
> @@ -124,7 +131,8 @@
>  			compatible = "fsl,ls1012a-clockgen";
>  			reg = <0x0 0x1ee1000 0x0 0x1000>;
>  			#clock-cells = <2>;
> -			clocks = <&sysclk>;
> +			clocks = <&sysclk &coreclk>;
> +			clock-names = "sysclk", "coreclk";
>  		};
>  
>  		i2c0: i2c at 2180000 {
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
