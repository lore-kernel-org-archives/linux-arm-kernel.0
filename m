From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Feb 2017 11:14:58 +0100
Subject: [PATCH 5/8] arm64: dts: allwinner: add R_PIO node
In-Reply-To: <20170208100009.29362-5-icenowy@aosc.xyz>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
 <20170208100009.29362-5-icenowy@aosc.xyz>
Message-ID: <20170208101458.du6ybqsw52ypzhzw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 06:00:06PM +0800, Icenowy Zheng wrote:
> Allwinner A64 SoC has a R_PIO node like the one in H3.
> 
> Add the node as well as needed clocks and resets.
> 
> As there's no document for apb0_gates, I only added the R_PIO bit here.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 1c64ea2d23f9..4b0baa79554c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -98,6 +98,15 @@
>  		clock-output-names = "osc32k";
>  	};
>  
> +	apb0: apb0_clk {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clock-div = <1>;
> +		clock-mult = <1>;
> +		clocks = <&osc24M>;
> +		clock-output-names = "apb0";
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-0.2";
>  		method = "smc";
> @@ -392,5 +401,36 @@
>  			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		apb0_gates: clk at 1f01428 {
> +			compatible = "allwinner,sun50i-a64-apb0-gates-clk",
> +				     "allwinner,sun4i-a10-gates-clk";
> +			reg = <0x01f01428 0x4>;
> +			#clock-cells = <1>;
> +			clocks = <&apb0>;
> +			clock-indices = <0>;
> +			clock-output-names = "apb0_pio";
> +		};
> +
> +		apb0_rst: reset at 1f014b0 {
> +			reg = <0x01f014b0 0x4>;
> +			compatible = "allwinner,sun6i-a31-clock-reset";
> +			#reset-cells = <1>;
> +		};

Please make a sunxi-ng driver for those clocks.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/e36b0c47/attachment-0001.sig>
