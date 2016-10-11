From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 11 Oct 2016 11:19:27 +0200
Subject: [PATCH] ARM: dts: rockchip: initialize rk3066 PLL clock rate
In-Reply-To: <20161006194221.GA4895@vaio-ubuntu>
References: <20161006194221.GA4895@vaio-ubuntu>
Message-ID: <12104842.0Sv0KpAWIA@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 6. Oktober 2016, 21:42:21 CEST schrieb Pawe? Jarosz:
> Initialize PLL rate while kernel init. No other module does than.
> Clock rates are taken from rk3066 TRM. Assigned values are for 125 degrees
> celcius operating point.
> This gives us performance boost observable for example in mmc transfers.
> 
> Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
> ---
>  arch/arm/boot/dts/rk3066a.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index 0d0dae3..cf215e8 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -151,6 +151,10 @@
> 
>  		#clock-cells = <1>;
>  		#reset-cells = <1>;
> +		assigned-clocks = <&cru PLL_DPLL>, <&cru PLL_APLL>,

we shouldn't touch the DPLL and APLL at all in this context. They are quite 
reliant on the underlying voltages and the bootloader might've set other 
values. Also changing the DDR frequency through the DPLL requires special 
handling on the DDR side.

> +				  <&cru PLL_CPLL>, <&cru PLL_GPLL>;

please also initialize the PERI and BUS clocks (similar to what the rk3288 clk 
settings do), so that they stay sane, even if we change CPLL and GPLL 
frequencies.

> +		assigned-clock-rates = <533000000>, <600000000>,
> +				       <600000000>, <600000000>;

Also setting both CPLL and GPLL to the same value might be unhelpful to 
achieve special divided frequencies? Again see rk3288.dtsi where we have a 594 
/ 400 MHz division. Especially the downstream clocks normally can select 
between CPLL and GPLL.


Heiko
