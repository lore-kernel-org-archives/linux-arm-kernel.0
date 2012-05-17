From: robherring2@gmail.com (Rob Herring)
Date: Thu, 17 May 2012 18:32:10 -0500
Subject: [PATCH RESEND v3 2/2] ARM: LPC32xx: Make platform use key driver
In-Reply-To: <1337199955-26441-2-git-send-email-stigge@antcom.de>
References: <1337199955-26441-1-git-send-email-stigge@antcom.de>
 <1337199955-26441-2-git-send-email-stigge@antcom.de>
Message-ID: <4FB58A7A.4060606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2012 03:25 PM, Roland Stigge wrote:
> This patch connects the lpc32xx-key driver to the LPC32xx platform (via
> lpc32xx.dtsi), and more specifically to the reference board via its dts file.
> The clock.c file needs to be changed to match the automatic device name to its
> clock.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> 
> ---
> Applies to v3.4-rc7 + LPC32xx DT patches
> 
> Please pick this patch for the arm-soc subsystem.
> 
> Changes since v2:
> * DT: Use "keypad,num-rows", "keypad,num-columns" and "linux,keymap" properties
> 
>  arch/arm/boot/dts/lpc32xx.dtsi |    2 ++
>  arch/arm/boot/dts/phy3250.dts  |    9 +++++++++
>  arch/arm/mach-lpc32xx/clock.c  |    2 +-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
> +++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -249,6 +249,8 @@
>  			key at 40050000 {
>  				compatible = "nxp,lpc3220-key";
>  				reg = <0x40050000 0x1000>;
> +				interrupts = <54 0>;
> +				status = "disable";
>  			};
>  
>  		};
> --- linux-2.6.orig/arch/arm/boot/dts/phy3250.dts
> +++ linux-2.6/arch/arm/boot/dts/phy3250.dts
> @@ -135,6 +135,15 @@
>  			tsc at 40048000 {
>  				status = "okay";
>  			};
> +
> +			key at 40050000 {
> +				status = "okay";
> +				keypad,num-rows = <1>;
> +				keypad,num-columns = <1>;
> +				nxp,debounce-delay-ms = <3>;
> +				nxp,scan-delay-ms = <34>;
> +				linux,keymap = <0x00000002>;
> +			};
>  		};
>  	};
>  
> --- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
> +++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
> @@ -1134,7 +1134,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_INIT("31020300.i2c", NULL, &clk_i2c2),
>  	CLKDEV_INIT("dev:ssp0", NULL, &clk_ssp0),
>  	CLKDEV_INIT("dev:ssp1", NULL, &clk_ssp1),
> -	CLKDEV_INIT("lpc32xx_keys.0", NULL, &clk_kscan),
> +	CLKDEV_INIT("40050000.key", NULL, &clk_kscan),
>  	CLKDEV_INIT("20020000.flash", NULL, &clk_nand),
>  	CLKDEV_INIT("200a8000.flash", NULL, &clk_nand_mlc),
>  	CLKDEV_INIT("40048000.adc", NULL, &clk_adc),
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
