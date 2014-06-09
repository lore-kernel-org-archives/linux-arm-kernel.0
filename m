From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 09 Jun 2014 21:30:38 +0100
Subject: [PATCH] ARM: STi: DT: Properly define sti-ethclk & stmmaceth
 for stih415/6
In-Reply-To: <1402345355-5682-1-git-send-email-peter.griffin@linaro.org>
References: <1402345355-5682-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <5396196E.1070507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Pete for the patch.
Patch looks good for me.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


On 09/06/14 21:22, Peter Griffin wrote:
> This patch fixes two problems: -
>
> 1) The device tree isn't currently providing sti-ethclk which is
> required by the dwmac glue code to correctly configure the ethernet
> PHY clock speed.
>
> This means depending on what the bootloader/jtag has
> configured this clock to, and what switch/hub the board is plugged
> into you most likely will NOT successfully negotiate a ethernet link.
>
> 2) The stmmaceth clock was associated with the wrong clock. It was
> referencing the PHY clock rather than the interconnect clock which
> clocks the IP.
>
> This patch also brings us closer to not having to boot the upstream
> kernel with the clk_ignore_unused parameter.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/boot/dts/stih415.dtsi           | 8 ++++----
>   arch/arm/boot/dts/stih416.dtsi           | 8 ++++----
>   include/dt-bindings/clock/stih415-clks.h | 1 +
>   include/dt-bindings/clock/stih416-clks.h | 1 +
>   4 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
> index c81dce4..768bf27 100644
> --- a/arch/arm/boot/dts/stih415.dtsi
> +++ b/arch/arm/boot/dts/stih415.dtsi
> @@ -169,8 +169,8 @@
>
>   			pinctrl-names 	= "default";
>   			pinctrl-0	= <&pinctrl_mii0>;
> -			clock-names	= "stmmaceth";
> -			clocks		= <&clk_s_a1_ls CLK_GMAC0_PHY>;
> +			clock-names	= "stmmaceth", "sti-ethclk";
> +			clocks		= <&clk_s_a1_ls CLK_ICN_IF_2>, <&clk_s_a1_ls CLK_GMAC0_PHY>;
>   		};
>
>   		ethernet1: dwmac at fef08000 {
> @@ -189,11 +189,11 @@
>   			st,syscon		= <&syscfg_sbc>;
>
>   			resets			= <&softreset STIH415_ETH1_SOFTRESET>;
> -			reset-names		= "stmmaceth";
> +			reset-names		= "stmmaceth", "sti-ethclk";
>   			pinctrl-names 	= "default";
>   			pinctrl-0	= <&pinctrl_mii1>;
>   			clock-names	= "stmmaceth";
> -			clocks		= <&clk_s_a0_ls CLK_ETH1_PHY>;
> +			clocks		= <&clk_s_a0_ls CLK_ICN_REG>, <&clk_s_a0_ls CLK_ETH1_PHY>;
>   		};
>
>   		rc: rc at fe518000 {
> diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
> index 6473287..98c43cc 100644
> --- a/arch/arm/boot/dts/stih416.dtsi
> +++ b/arch/arm/boot/dts/stih416.dtsi
> @@ -175,8 +175,8 @@
>   			reset-names		= "stmmaceth";
>   			pinctrl-names 	= "default";
>   			pinctrl-0	= <&pinctrl_mii0>;
> -			clock-names	= "stmmaceth";
> -			clocks		= <&clk_s_a1_ls CLK_GMAC0_PHY>;
> +			clock-names	= "stmmaceth", "sti-ethclk";
> +			clocks		= <&clk_s_a1_ls CLK_ICN_IF_2>, <&clk_s_a1_ls CLK_GMAC0_PHY>;
>   		};
>
>   		ethernet1: dwmac at fef08000 {
> @@ -197,8 +197,8 @@
>   			reset-names	= "stmmaceth";
>   			pinctrl-names 	= "default";
>   			pinctrl-0	= <&pinctrl_mii1>;
> -			clock-names	= "stmmaceth";
> -			clocks		= <&clk_s_a0_ls CLK_ETH1_PHY>;
> +			clock-names	= "stmmaceth", "sti-ethclk";
> +			clocks		= <&clk_s_a0_ls CLK_ICN_REG>, <&clk_s_a0_ls CLK_ETH1_PHY>;
>   		};
>
>   		rc: rc at fe518000 {
> diff --git a/include/dt-bindings/clock/stih415-clks.h b/include/dt-bindings/clock/stih415-clks.h
> index 0d2c739..d80caa6 100644
> --- a/include/dt-bindings/clock/stih415-clks.h
> +++ b/include/dt-bindings/clock/stih415-clks.h
> @@ -10,6 +10,7 @@
>   #define CLK_ETH1_PHY		4
>
>   /* CLOCKGEN A1 */
> +#define CLK_ICN_IF_2		0
>   #define CLK_GMAC0_PHY		3
>
>   #endif
> diff --git a/include/dt-bindings/clock/stih416-clks.h b/include/dt-bindings/clock/stih416-clks.h
> index 552c779..f9bdbd1 100644
> --- a/include/dt-bindings/clock/stih416-clks.h
> +++ b/include/dt-bindings/clock/stih416-clks.h
> @@ -10,6 +10,7 @@
>   #define CLK_ETH1_PHY		4
>
>   /* CLOCKGEN A1 */
> +#define CLK_ICN_IF_2		0
>   #define CLK_GMAC0_PHY		3
>
>   #endif
>
