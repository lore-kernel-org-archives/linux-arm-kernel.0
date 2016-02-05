From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 5 Feb 2016 17:59:23 +0000
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <56B4E2FB.3050703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

just found this while looking at your current git branch, so sorry for
the late reply.

CC:ing DT people, since you touch both existing DTs(!) and the binding doc.

On 01/02/16 20:20, Maxime Ripard wrote:
> Remove the fixed dividers from the PLL6 driver to be able to have a
> reusable driver that can be used across several SoCs that share the same
> controller, but don't have the same set of dividers for this clock, and to
> also be reused multiple times in the same SoC, since we're droping the
> clock name.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> 
> Changes from v3:
>   - Fixed the documentation
>   - Added pll6d2 back
> 
> Changes from v2:
>   - Rebased and converted over to the new factors refactoring. Fixed the
>     retrieved rate
> 
>  Documentation/devicetree/bindings/clock/sunxi.txt |  2 +-
>  arch/arm/boot/dts/sun6i-a31.dtsi                  | 36 +++++++++++-----------
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi              | 25 ++++++++++-----
>  arch/arm/boot/dts/sun8i-a23.dtsi                  |  2 +-
>  arch/arm/boot/dts/sun8i-a33.dtsi                  |  4 +--
>  arch/arm/boot/dts/sun8i-h3.dtsi                   | 37 ++++++++++++++---------

So are you really breaking all those systems by changing the DT and the
driver in an incompatible way?
Please correct me if this assessment is wrong, but to me it looks like
any user out there is either stuck with 4.5 at best _or_ will only be
able to run 4.6 and later (depending on which version of the DT she is
using)? And no, switching DTs along with the kernel is _not_ an option.
That is not how I understand DT.
Also this totally ignores any other DT user (U-Boot, FreeBSD, you name it).

I actually appreciate this rework, it's more flexible now and looks
better, but you really can't do this in a way to breaks compatibility
with existing DTs.

Jean-Francois came up with another solution for the pll8 clock [1], so
could this be considered at least?
I think changing the H3 PLL8 clock from dummy to something real is a
different story in terms of compatibility (since it never really worked
before and this wouldn't change for any old-DT user).

Cheers,
Andre.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/405104.html

>  drivers/clk/sunxi/clk-sunxi.c                     | 32 ++++++++++----------
>  7 files changed, 78 insertions(+), 60 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index e59f57b24777..f82850c0f6a5 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -86,7 +86,7 @@ Required properties for all clocks:
>  - #clock-cells : from common clock binding; shall be set to 0 except for
>  	the following compatibles where it shall be set to 1:
>  	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
> -	"allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk",
> +	"allwinner,sun4i-pll6-clk",
>  	"allwinner,*-usb-clk", "allwinner,*-mmc-clk",
>  	"allwinner,*-mmc-config-clk"
>  - clock-output-names : shall be the corresponding names of the outputs.
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index b6ad7850fac6..05fe3d1aa328 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -65,7 +65,7 @@
>  			compatible = "allwinner,simple-framebuffer",
>  				     "simple-framebuffer";
>  			allwinner,pipeline = "de_be0-lcd0-hdmi";
> -			clocks = <&pll6 0>;
> +			clocks = <&pll6>;
>  			status = "disabled";
>  		};
>  
> @@ -73,7 +73,7 @@
>  			compatible = "allwinner,simple-framebuffer",
>  				     "simple-framebuffer";
>  			allwinner,pipeline = "de_be0-lcd0";
> -			clocks = <&pll6 0>;
> +			clocks = <&pll6>;
>  			status = "disabled";
>  		};
>  	};
> @@ -201,11 +201,11 @@
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
>  		cpu: cpu at 01c20050 {
> @@ -235,7 +235,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun6i-a31-ahb1-clk";
>  			reg = <0x01c20054 0x4>;
> -			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
> +			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
>  			clock-output-names = "ahb1";
>  
>  			/*
> @@ -244,7 +244,7 @@
>  			 * controller requires AHB1 clocked from PLL6.
>  			 */
>  			assigned-clocks = <&ahb1>;
> -			assigned-clock-parents = <&pll6 0>;
> +			assigned-clock-parents = <&pll6>;
>  		};
>  
>  		ahb1_gates: clk at 01c20060 {
> @@ -307,7 +307,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-apb1-clk";
>  			reg = <0x01c20058 0x4>;
> -			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
> +			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
>  			clock-output-names = "apb2";
>  		};
>  
> @@ -331,7 +331,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c20088 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "mmc0",
>  					     "mmc0_output",
>  					     "mmc0_sample";
> @@ -341,7 +341,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c2008c 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "mmc1",
>  					     "mmc1_output",
>  					     "mmc1_sample";
> @@ -351,7 +351,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c20090 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "mmc2",
>  					     "mmc2_output",
>  					     "mmc2_sample";
> @@ -361,7 +361,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c20094 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "mmc3",
>  					     "mmc3_output",
>  					     "mmc3_sample";
> @@ -371,7 +371,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-mod0-clk";
>  			reg = <0x01c2009c 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "ss";
>  		};
>  
> @@ -379,7 +379,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-mod0-clk";
>  			reg = <0x01c200a0 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "spi0";
>  		};
>  
> @@ -387,7 +387,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-mod0-clk";
>  			reg = <0x01c200a4 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "spi1";
>  		};
>  
> @@ -395,7 +395,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-mod0-clk";
>  			reg = <0x01c200a8 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "spi2";
>  		};
>  
> @@ -403,7 +403,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-mod0-clk";
>  			reg = <0x01c200ac 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "spi3";
>  		};
>  
> @@ -1042,8 +1042,8 @@
>  			ar100: ar100_clk {
>  				compatible = "allwinner,sun6i-a31-ar100-clk";
>  				#clock-cells = <0>;
> -				clocks = <&osc32k>, <&osc24M>, <&pll6 0>,
> -					 <&pll6 0>;
> +				clocks = <&osc32k>, <&osc24M>, <&pll6>,
> +					 <&pll6>;
>  				clock-output-names = "ar100";
>  			};
>  
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index 6f88fb0ddbc7..edc85eeaf365 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -60,7 +60,7 @@
>  			compatible = "allwinner,simple-framebuffer",
>  				     "simple-framebuffer";
>  			allwinner,pipeline = "de_be0-lcd0";
> -			clocks = <&pll6 0>;
> +			clocks = <&pll6>;
>  			status = "disabled";
>  		};
>  	};
> @@ -129,11 +129,20 @@
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
> +		};
> +
> +                pll6x2: pll6x2_clk {
> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +			clock-div = <1>;
> +			clock-mult = <2>;
> +			clocks = <&pll6>;
> +			clock-output-names = "pll6-2x";
>  		};
>  
>  		cpu: cpu_clk at 01c20050 {
> @@ -163,7 +172,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun6i-a31-ahb1-clk";
>  			reg = <0x01c20054 0x4>;
> -			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
> +			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
>  			clock-output-names = "ahb1";
>  		};
>  
> @@ -190,7 +199,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-apb1-clk";
>  			reg = <0x01c20058 0x4>;
> -			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
> +			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
>  			clock-output-names = "apb2";
>  		};
>  
> @@ -213,7 +222,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c20088 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "mmc0",
>  					     "mmc0_output",
>  					     "mmc0_sample";
> @@ -223,7 +232,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c2008c 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "mmc1",
>  					     "mmc1_output",
>  					     "mmc1_sample";
> @@ -233,7 +242,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c20090 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "mmc2",
>  					     "mmc2_output",
>  					     "mmc2_sample";
> diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
> index 92e6616979ea..5e589c1ddda9 100644
> --- a/arch/arm/boot/dts/sun8i-a23.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23.dtsi
> @@ -79,7 +79,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun8i-a23-mbus-clk";
>  			reg = <0x01c2015c 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
> +			clocks = <&osc24M>, <&pll6x2>, <&pll5>;
>  			clock-output-names = "mbus";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 001d8402ca18..f3eb618bcfa7 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -103,7 +103,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-mod0-clk";
>  			reg = <0x01c2009c 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>;
> +			clocks = <&osc24M>, <&pll6>;
>  			clock-output-names = "ss";
>  		};
>  
> @@ -111,7 +111,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun8i-a23-mbus-clk";
>  			reg = <0x01c2015c 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5>, <&pll11>;
> +			clocks = <&osc24M>, <&pll6x2>, <&pll5>, <&pll11>;
>  			clock-output-names = "mbus";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 1524130e43c9..6f6b4e469ac9 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -121,11 +121,11 @@
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
>  		pll6d2: pll6d2_clk {
> @@ -133,15 +133,24 @@
>  			compatible = "fixed-factor-clock";
>  			clock-div = <2>;
>  			clock-mult = <1>;
> -			clocks = <&pll6 0>;
> -			clock-output-names = "pll6d2";
> +			clocks = <&pll6>;
> +			clock-output-names = "pll6-d2";
>  		};
>  
> -		/* dummy clock until pll6 can be reused */
> -		pll8: pll8_clk {
> +		pll6x2: pll6x2_clk {
>  			#clock-cells = <0>;
> -			compatible = "fixed-clock";
> -			clock-frequency = <1>;
> +			compatible = "fixed-factor-clock";
> +			clock-div = <1>;
> +			clock-mult = <2>;
> +			clocks = <&pll6>;
> +			clock-output-names = "pll6-2x";
> +		};
> +
> +		pll8: clk at 01c20044 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> +			reg = <0x01c20044 0x4>;
> +			clocks = <&osc24M>;
>  			clock-output-names = "pll8";
>  		};
>  
> @@ -165,7 +174,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun6i-a31-ahb1-clk";
>  			reg = <0x01c20054 0x4>;
> -			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
> +			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
>  			clock-output-names = "ahb1";
>  		};
>  
> @@ -189,7 +198,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-a10-apb1-clk";
>  			reg = <0x01c20058 0x4>;
> -			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
> +			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
>  			clock-output-names = "apb2";
>  		};
>  
> @@ -243,7 +252,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c20088 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
> +			clocks = <&osc24M>, <&pll6>, <&pll8>;
>  			clock-output-names = "mmc0",
>  					     "mmc0_output",
>  					     "mmc0_sample";
> @@ -253,7 +262,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c2008c 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
> +			clocks = <&osc24M>, <&pll6>, <&pll8>;
>  			clock-output-names = "mmc1",
>  					     "mmc1_output",
>  					     "mmc1_sample";
> @@ -263,7 +272,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
>  			reg = <0x01c20090 0x4>;
> -			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
> +			clocks = <&osc24M>, <&pll6>, <&pll8>;
>  			clock-output-names = "mmc2",
>  					     "mmc2_output",
>  					     "mmc2_sample";
> @@ -273,7 +282,7 @@
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun8i-a23-mbus-clk";
>  			reg = <0x01c2015c 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
> +			clocks = <&osc24M>, <&pll6x2>, <&pll5>;
>  			clock-output-names = "mbus";
>  		};
>  	};
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index da15f2b12ab2..4de800e379d3 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -227,9 +227,9 @@ static void sun4i_get_pll5_factors(struct factors_request *req)
>  }
>  
>  /**
> - * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6x2
> - * PLL6x2 rate is calculated as follows
> - * rate = parent_rate * (n + 1) * (k + 1)
> + * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6
> + * PLL6 rate is calculated as follows
> + * rate = parent_rate * (n + 1) * (k + 1) / 2
>   * parent_rate is always 24Mhz
>   */
>  
> @@ -238,8 +238,8 @@ static void sun6i_a31_get_pll6_factors(struct factors_request *req)
>  	u8 div;
>  
>  	/* Normalize value to a parent_rate multiple (24M) */
> -	div = req->rate / req->parent_rate;
> -	req->rate = req->parent_rate * div;
> +	div = req->rate / (req->parent_rate / 2);
> +	req->rate = (req->parent_rate / 2) * div;
>  
>  	req->k = div / 32;
>  	if (req->k > 3)
> @@ -248,6 +248,15 @@ static void sun6i_a31_get_pll6_factors(struct factors_request *req)
>  	req->n = DIV_ROUND_UP(div, (req->k + 1)) - 1;
>  }
>  
> +static void sun6i_a31_pll6_recalc(struct factors_request *req)
> +{
> +	req->rate = req->parent_rate;
> +
> +	req->rate *= req->n + 1;
> +	req->rate *= req->k + 1;
> +	req->rate /= 2;
> +}
> +
>  /**
>   * sun5i_a13_get_ahb_factors() - calculates m, p factors for AHB
>   * AHB rate is calculated as follows
> @@ -537,7 +546,7 @@ static const struct factors_data sun6i_a31_pll6_data __initconst = {
>  	.enable = 31,
>  	.table = &sun6i_a31_pll6_config,
>  	.getter = sun6i_a31_get_pll6_factors,
> -	.name = "pll6x2",
> +	.recalc = sun6i_a31_pll6_recalc,
>  };
>  
>  static const struct factors_data sun5i_a13_ahb_data __initconst = {
> @@ -788,15 +797,6 @@ static const struct divs_data pll6_divs_data __initconst = {
>  	}
>  };
>  
> -static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
> -	.factors = &sun6i_a31_pll6_data,
> -	.ndivs = 2,
> -	.div = {
> -		{ .fixed = 2 }, /* normal output */
> -		{ .self = 1 }, /* base factor clock, 2x */
> -	}
> -};
> -
>  /**
>   * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
>   *
> @@ -938,6 +938,7 @@ free_clkdata:
>  static const struct of_device_id clk_factors_match[] __initconst = {
>  	{.compatible = "allwinner,sun4i-a10-pll1-clk", .data = &sun4i_pll1_data,},
>  	{.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
> +	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
>  	{.compatible = "allwinner,sun8i-a23-pll1-clk", .data = &sun8i_a23_pll1_data,},
>  	{.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
>  	{.compatible = "allwinner,sun5i-a13-ahb-clk", .data = &sun5i_a13_ahb_data,},
> @@ -959,7 +960,6 @@ static const struct of_device_id clk_div_match[] __initconst = {
>  static const struct of_device_id clk_divs_match[] __initconst = {
>  	{.compatible = "allwinner,sun4i-a10-pll5-clk", .data = &pll5_divs_data,},
>  	{.compatible = "allwinner,sun4i-a10-pll6-clk", .data = &pll6_divs_data,},
> -	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_divs_data,},
>  	{}
>  };
>  
> 
