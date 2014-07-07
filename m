From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Jul 2014 10:58:58 +0200
Subject: [PATCH v3 8/9] ARM: sun8i: Add PRCM clock and reset controller
 nodes to the DTSI
In-Reply-To: <1404399349-20237-9-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-9-git-send-email-wens@csie.org>
Message-ID: <20140707085858.GG16262@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

It looks mostly fine but...

On Thu, Jul 03, 2014 at 10:55:48PM +0800, Chen-Yu Tsai wrote:
> With sun8i PRCM support available, we can add the PRCM clock and
> reset controller nodes to the DTSI. Also update R_UART's clock
> phandle and add it's reset control phandle.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-a23.dtsi | 48 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
> index 79c4083..e10c708 100644
> --- a/arch/arm/boot/dts/sun8i-a23.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23.dtsi
> @@ -262,13 +262,59 @@
>  			interrupts = <1 9 0xf04>;
>  		};
>  
> +		prcm at 01f01400 {
> +			compatible = "allwinner,sun8i-a23-prcm";
> +			reg = <0x01f01400 0x200>;
> +
> +			ar100: ar100_clk {
> +				compatible = "fixed-factor-clock";
> +				#clock-cells = <0>;
> +				clock-div = <1>;
> +				clock-mult = <1>;
> +				clocks = <&osc24M>;
> +				clock-output-names = "ar100";
> +			};
> +
> +			ahb0: ahb0_clk {
> +				compatible = "fixed-factor-clock";
> +				#clock-cells = <0>;
> +				clock-div = <1>;
> +				clock-mult = <1>;
> +				clocks = <&ar100>;
> +				clock-output-names = "ahb0";
> +			};
> +
> +			apb0: apb0_clk {
> +				compatible = "allwinner,sun8i-a23-apb0-clk";
> +				#clock-cells = <0>;
> +				clocks = <&ahb0>;
> +				clock-output-names = "apb0";
> +			};
> +
> +			apb0_gates: apb0_gates_clk {
> +				compatible = "allwinner,sun8i-a23-apb0-gates-clk";
> +				#clock-cells = <1>;
> +				clocks = <&apb0>;
> +				clock-indices = <0>, <2>, <3>, <4>, <6>;

I realise you're just using the A31 code, but it's actually the only
clock so far that uses clock-indices, while all the other clocks
relies on a bitmask.

I'd prefer to remain consistent and use a bitmask here as well (that
would also mean removing the clock-indices related code in the A31
driver)

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/ddae5b36/attachment.sig>
