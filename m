From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 16 Jan 2014 12:15:28 -0600
Subject: [PATCH 2/4] ARM: sun6i: dt: Add PLL6 and SPI module clocks
In-Reply-To: <1389892285-11745-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
 <1389892285-11745-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140116181528.GY8153@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 06:11:23PM +0100, Maxime Ripard wrote:
> The module clocks in the A31 are still compatible with the A10 one. Add the SPI
> module clocks and the PLL6 in the device tree to allow their use by the SPI
> controllers.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 48 +++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 5256ad9..ae058eb 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -73,16 +73,12 @@
>  			clocks = <&osc24M>;
>  		};
>  
> -		/*
> -		 * This is a dummy clock, to be used as placeholder on
> -		 * other mux clocks when a specific parent clock is not
> -		 * yet implemented. It should be dropped when the driver
> -		 * is complete.
> -		 */
> -		pll6: pll6 {
> -			#clock-cells = <0>;
> -			compatible = "fixed-clock";
> -			clock-frequency = <0>;
> +		pll6: clk at 01c20028 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> +			reg = <0x01c20028 0x4>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "pll6";
>  		};
>  
>  		cpu: cpu at 01c20050 {
> @@ -182,6 +178,38 @@
>  					"apb2_uart1", "apb2_uart2", "apb2_uart3",
>  					"apb2_uart4", "apb2_uart5";
>  		};
> +
> +		spi0_clk: clk at 01c200a0 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-mod0-clk";
> +			reg = <0x01c200a0 0x4>;
> +			clocks = <&osc24M>, <&pll6>;

This looks weird.  You've set the pll6 #clock-cells = <1>, but you
aren't using a specifier here.  Same below, as well.  The binding
documentation indicates that #clock-cells should be 0 for the pll6 node.

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
