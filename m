From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 11:57:59 +0200
Subject: [PATCH v2 08/20] ARM: sun6i: DT: Rename PLL6 to PLL6x2 and add
 fixed-factor-clock for PLL6
In-Reply-To: <1403016777-15121-9-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-9-git-send-email-wens@csie.org>
Message-ID: <20140618095759.GL19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:45PM +0800, Chen-Yu Tsai wrote:
> The PLL6 clock driver actually manages the PLL6x2 output of PLL6, so
> rename the node accordingly, and add a halved fixed-factor-clock for
> normal PLL6 output used by most modules.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index a9dfa12..12d558b 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -94,11 +94,20 @@
>  			clock-output-names = "pll1";
>  		};
>  
> -		pll6: clk at 01c20028 {
> +		pll6x2: clk at 01c20028 {
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun6i-a31-pll6-clk";
>  			reg = <0x01c20028 0x4>;
>  			clocks = <&osc24M>;
> +			clock-output-names = "pll6x2";
> +		};
> +
> +		pll6: pll6_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-factor-clock";
> +			clock-div = <2>;
> +			clock-mult = <1>;
> +			clocks = <&pll6x2>;
>  			clock-output-names = "pll6";
>  		};

Hmm, nope. The output of PLL6 is 24M * N * K / 2, and this is what we
support in the driver.

This change is backward, and should be the other way around. Have PLL6
running at it's usual speed, and then have PLL62X be a fixed-factor.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/0125a387/attachment.sig>
