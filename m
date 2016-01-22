From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 22 Jan 2016 12:48:27 +0100
Subject: [PATCH] ARM: at91/dt: sama5d2 Xplained: add phy address and IRQ
 for macb0
In-Reply-To: <1453462174-27688-1-git-send-email-nicolas.ferre@atmel.com>
References: <1453462174-27688-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160122114827.GF3608@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/2016 at 12:29:34 +0100, Nicolas Ferre wrote :
> After 57a38effa598 (net: phy: micrel: disable broadcast for KSZ8081/KSZ8091)
> the macb0 interface have difficulties to come back from power saving mode if
has

> address not explicitely set up.

explicitly

> As the micrel phy on the board is actually configured to show up at address 1
> we use this explicitly.
> Adding the phy node and its real address fixes the issue.


Maybe you should add that this also add the proper pinmuxing for the
IRQ.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 77ddff036409..e683856c507c 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -114,9 +114,15 @@
>  
>  			macb0: ethernet at f8008000 {
>  				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_macb0_default>;
> +				pinctrl-0 = <&pinctrl_macb0_default &pinctrl_macb0_phy_irq>;
>  				phy-mode = "rmii";
>  				status = "okay";
> +
> +				ethernet-phy at 1 {
> +					reg = <0x1>;
> +					interrupt-parent = <&pioA>;
> +					interrupts = <73 IRQ_TYPE_LEVEL_LOW>;
> +				};
>  			};
>  
>  			pdmic at f8018000 {
> @@ -300,6 +306,10 @@
>  					bias-disable;
>  				};
>  
> +				pinctrl_macb0_phy_irq: macb0_phy_irq {
> +					pinmux = <PIN_PC9__GPIO>;
> +				};
> +
>  				pinctrl_pdmic_default: pdmic_default {
>  					pinmux = <PIN_PB26__PDMIC_DAT>,
>  						<PIN_PB27__PDMIC_CLK>;
> -- 
> 2.1.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
