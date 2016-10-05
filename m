From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 5 Oct 2016 05:08:23 +0300
Subject: [PATCH] ARM: dts: lpc32xx: set pwm1 & pwm2 default clock rate
In-Reply-To: <1474916056-11336-1-git-send-email-slemieux.tyco@gmail.com>
References: <1474916056-11336-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1443ec62-4936-c70a-b323-6980a9240a1e@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 26.09.2016 21:54, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> Probably most of NXP LPC32xx boards have 13MHz main oscillator
> and therefore for HCLK PLL and ARM core clock rate default
> hardware setting of 16 * 13MHz = 208MHz and the AHB bus clock
> rate of 208MHz / 2 = 104MHz.
> 
> The change explicitly defines the peripheral PWM1/PWM2 default
> clock output rate of 104MHz. If needed it can be redefined
> in a board DTS file.
> 
> Signed-off-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
> ---
> Note:
> * There is a dependency on the following patch:
>   "ARM: dts: lpc32xx: set default parent clock for pwm1 & pwm2"
>   http://www.spinics.net/lists/arm-kernel/msg530277.html
> * This patch should be apply after
>   "ARM: dts: lpc32xx: add pwm-cells to base dts file"
>   http://www.spinics.net/lists/arm-kernel/msg534050.html
>   - There is no dependency between the patches.
> 
>  arch/arm/boot/dts/lpc32xx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index c031c94..d669200 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -471,6 +471,7 @@
>  				clocks = <&clk LPC32XX_CLK_PWM1>;
>  				assigned-clocks = <&clk LPC32XX_CLK_PWM1>;
>  				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
> +				assigned-clock-rates = <104000000>;

PWM controller clock source can be 32KHz or CLK_PERIPH, the latter is
equal either to SYSCLK or HCLK PLL divided by HCLKDIV_CTRL[6:2].

Do you set the divider to 1? If yes, then I would say

1) this is very specific to your board, generally CLK_PERIPH
   is set to be about 10-13MHz,
2) HCLKDIV or PERIPH clock configuration shall not be done in pwm device node.

104MHz is too high value to be set by default for PWM clock.

>  				status = "disabled";
>  				#pwm-cells = <2>;
>  			};
> @@ -481,6 +482,7 @@
>  				clocks = <&clk LPC32XX_CLK_PWM2>;
>  				assigned-clocks = <&clk LPC32XX_CLK_PWM2>;
>  				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
> +				assigned-clock-rates = <104000000>;
>  				status = "disabled";
>  				#pwm-cells = <2>;
>  			};
> 

--
With best wishes,
Vladimir
