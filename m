From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 05 Jan 2015 10:30:38 +0200
Subject: [PATCH/RFC] ARM: shmobile: r8a7794: Add Audio DMAC,
 PWM and Thermal clocks to device tree
In-Reply-To: <1418949573-24211-1-git-send-email-horms+renesas@verge.net.au>
References: <1418949573-24211-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <8183635.VD1oYub01I@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Friday 19 December 2014 09:39:33 Simon Horman wrote:
> This is based on the MSTP5 clocks in the r8a7791 device tree.
> The main difference being that the r8a7794 does not have an Audio DMAC1
> clock.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> Based on the renesas-devel-20141217-v3.18 tag of my renesas tree.
> 
> N.B: The R-Car Gen2 v1.8.0 BSP uses zs_clk whereas this patch uses hp_clk
>      as the parent clock for the Audio DMAC clock.
> 
>      In that regard this patch follows the pattern used in mainline for the
>      r8a7790 and r8a7791 SoCs.
> 
>      The BSP's parent clock is consistent for the r8a7790, r8a7791, r8a7793
>      and r8a7794 SoCs.

Does this mean the BSP uses hp_clk for all Gen2 SoCs while mainline uses 
zs_clk ? Can't we find out which one is correct ?

>      Support for the r8a7793 SoC is not present in mainline.
> ---
>  arch/arm/boot/dts/r8a7794.dtsi            | 11 +++++++++++
>  include/dt-bindings/clock/r8a7794-clock.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index 063bf56..7a03166 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -530,6 +530,17 @@
>  			        "sdhi2", "sdhi1", "sdhi0",
>  				"mmcif0", "cmt1", "usbdmac0", "usbdmac1";
>  		};
> +		mstp5_clks: mstp5_clks at e6150144 {
> +			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-
clocks";
> +			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
> +			clocks = <&hp_clk>, <&extal_clk>, <&p_clk>;
> +			#clock-cells = <1>;
> +			clock-indices = <
> +				R8A7794_CLK_AUDIO_DMAC0
> +				R8A7794_CLK_THERMAL R8A7794_CLK_PWM
> +			>;
> +			clock-output-names = "audmac0", "thermal", "pwm";
> +		};
>  		mstp7_clks: mstp7_clks at e615014c {
>  			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-
clocks";
>  			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> diff --git a/include/dt-bindings/clock/r8a7794-clock.h
> b/include/dt-bindings/clock/r8a7794-clock.h index d5cfe62..58fa44d 100644
> --- a/include/dt-bindings/clock/r8a7794-clock.h
> +++ b/include/dt-bindings/clock/r8a7794-clock.h
> @@ -61,6 +61,7 @@
>  #define R8A7794_CLK_USBDMAC1		31
> 
>  /* MSTP5 */
> +#define R8A7794_CLK_AUDIO_DMAC0		2
>  #define R8A7794_CLK_THERMAL		22
>  #define R8A7794_CLK_PWM			23

-- 
Regards,

Laurent Pinchart
