From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 10 Aug 2017 14:14:17 +0200
Subject: [PATCH] ARM: dts: rockchip: set PLLs and core clocks rates for
 RK3188
In-Reply-To: <20170810114625.28823-1-romain.perier@collabora.com>
References: <20170810114625.28823-1-romain.perier@collabora.com>
Message-ID: <3341507.2YdTYPf41E@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,

Am Donnerstag, 10. August 2017, 13:46:25 CEST schrieb Romain Perier:
> Currently, rates for PLLs or core peri clocks are not set to a specific
> rate when booting the kernel. Depending on the previously used
> bootloader the state of the clk tree can be good or not.
> 
> This commits set PLLs and core clocks rates by using the
> assigned-clocks property in CRU (like for RK3288)
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  arch/arm/boot/dts/rk3188.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> index 1399bc04ea77..de6bde651cc2 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -160,6 +160,17 @@
>  
>  		#clock-cells = <1>;
>  		#reset-cells = <1>;
> +		assigned-clocks = <&cru PLL_GPLL>, <&cru PLL_DPLL>,

you should in general not touch the DPLL. This is the dedicated DDR
pll and changing the DDR frequency involves a lot more than just
changing the pll. So if for some reason the dpll is not at 300MHz coming
from the bootloader, this will hang the system.


> +				  <&cru PLL_CPLL>, <&cru PLL_APLL>,

Same for the APLL - we have cpufreq for that and changing the cpu
frequency also involves adapting the voltage in most cases.


> +				  <&cru ACLK_CPU>, <&cru HCLK_CPU>,
> +				  <&cru PCLK_CPU>, <&cru ACLK_PERI>,
> +				  <&cru HCLK_PERI>, <&cru PCLK_PERI>;
> +
> +		assigned-clock-rates = <891000000>, <300000000>,
> +				       <132000000>, <312000000>,
> +				       <148500000>, <148500000>,
> +				       <74250000>, <127285715>,
> +				       <127285715>, <63642858>;

where do these completely unround number come from? They don't correspond
to any of your pll settings and look way out of place.

You might want to target similar values as on rk3066 and rk3288 for core
clocks [aclk 300MHz, hclk 150MHz, pclk 75MHz]?

This puts them nicely into the recommended operating conditions from
the rk3188 datasheet. Similarly you might want cpll, gpll at 400MHz / 594 MHz
to provide a base to derive needed rates from.
[Again see rk3066a.dtsi please]

Heiko
