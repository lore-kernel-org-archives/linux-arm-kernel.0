From: jenskuske@gmail.com (Jens Kuske)
Date: Fri, 29 Jan 2016 11:02:46 +0100
Subject: [PATCH v3 2/2] clk: sunxi: Refactor A31 PLL6 so that it can be
 reused
In-Reply-To: <1454008958-12655-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454008958-12655-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <56AB38C6.2010909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28/01/16 20:22, Maxime Ripard wrote:
> Remove the fixed dividers from the PLL6 driver to be able to have a
> reusable driver that can be used across several SoCs that share the same
> controller, but don't have the same set of dividers for this clock, and to
> also be reused multiple times in the same SoC, since we're droping the
> clock name.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Changes from v2
>   - Rebased and converted over to the new factors refactoring. Fixed the
>     retrieved rate
> 
>  arch/arm/boot/dts/sun6i-a31.dtsi     | 36 ++++++++++++++++++------------------
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 25 +++++++++++++++++--------
>  arch/arm/boot/dts/sun8i-a23.dtsi     |  2 +-
>  arch/arm/boot/dts/sun8i-a33.dtsi     |  4 ++--
>  arch/arm/boot/dts/sun8i-h3.dtsi      | 36 ++++++++++++++++++------------------
>  drivers/clk/sunxi/clk-sunxi.c        | 32 ++++++++++++++++----------------
>  6 files changed, 72 insertions(+), 63 deletions(-)
> 
[...]
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 1524130e43c9..19aadf47027d 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -121,27 +121,27 @@
>  		};
>  
>  		pll6: clk at 01c20028 {
> -			#clock-cells = <1>;
> +			#clock-cells = <0>;
>  			compatible = "allwinner,sun6i-a31-pll6-clk";
>  			reg = <0x01c20028 0x4>;
>  			clocks = <&osc24M>;
> -			clock-output-names = "pll6", "pll6x2";
> +			clock-output-names = "pll6";
>  		};
>  
> -		pll6d2: pll6d2_clk {
> +		pll6x2: pll6x2_clk {
>  			#clock-cells = <0>;
>  			compatible = "fixed-factor-clock";
> -			clock-div = <2>;
> -			clock-mult = <1>;
> -			clocks = <&pll6 0>;
> -			clock-output-names = "pll6d2";
> +			clock-div = <1>;
> +			clock-mult = <2>;
> +			clocks = <&pll6>;
> +			clock-output-names = "pll6-2x";
>  		};
>  
> -		/* dummy clock until pll6 can be reused */
> -		pll8: pll8_clk {
> +		pll8: clk at 01c20044 {
>  			#clock-cells = <0>;
> -			compatible = "fixed-clock";
> -			clock-frequency = <1>;
> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> +			reg = <0x01c20044 0x4>;
> +			clocks = <&osc24M>;
>  			clock-output-names = "pll8";
>  		};
>  
> @@ -165,7 +165,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun6i-a31-ahb1-clk";
>  			reg = <0x01c20054 0x4>;
> -			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
> +			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
>  			clock-output-names = "ahb1";
>  		};
>  
> @@ -173,7 +173,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun8i-h3-ahb2-clk";
>  			reg = <0x01c2005c 0x4>;
> -			clocks = <&ahb1>, <&pll6d2>;
> +			clocks = <&ahb1>, <&pll6>;

According to the datasheet AHB2 really has PLL6 / 2 as parent, not PLL6
directly.

Jens
