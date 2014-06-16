From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Jun 2014 10:01:46 +0100
Subject: [PATCH] ARM: STi: DT: Properly define sti-ethclk & stmmaceth for
 stih415/6
In-Reply-To: <1402345355-5682-1-git-send-email-peter.griffin@linaro.org>
References: <1402345355-5682-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140616090146.GI14323@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
>  arch/arm/boot/dts/stih415.dtsi           | 8 ++++----
>  arch/arm/boot/dts/stih416.dtsi           | 8 ++++----
>  include/dt-bindings/clock/stih415-clks.h | 1 +
>  include/dt-bindings/clock/stih416-clks.h | 1 +
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
> index c81dce4..768bf27 100644
> --- a/arch/arm/boot/dts/stih415.dtsi
> +++ b/arch/arm/boot/dts/stih415.dtsi

[...]

>  		ethernet1: dwmac at fef08000 {
> @@ -189,11 +189,11 @@
>  			st,syscon		= <&syscfg_sbc>;
>  
>  			resets			= <&softreset STIH415_ETH1_SOFTRESET>;
> -			reset-names		= "stmmaceth";
> +			reset-names		= "stmmaceth", "sti-ethclk";
>  			pinctrl-names 	= "default";
>  			pinctrl-0	= <&pinctrl_mii1>;
>  			clock-names	= "stmmaceth";
> -			clocks		= <&clk_s_a0_ls CLK_ETH1_PHY>;
> +			clocks		= <&clk_s_a0_ls CLK_ICN_REG>, <&clk_s_a0_ls CLK_ETH1_PHY>;

This looks wrong to me.  You appear to have changed the reset-names
instead of the clock-names here.

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
