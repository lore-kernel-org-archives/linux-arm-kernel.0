From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Sep 2012 18:41:58 +0000
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <201209011841.58977.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 September 2012, Linus Walleij wrote:

> diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
> new file mode 100644
> index 0000000..8fad5a1
> --- /dev/null
> +++ b/arch/arm/boot/dts/integratorcp.dts
> @@ -0,0 +1,69 @@
> +/*
> + * Device Tree for the ARM Integrator/CP platform
> + */
> +
> +/dts-v1/;
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "ARM Integrator/CP";
> +	compatible = "arm,integrator-cp";
> +	ranges;
> +
> +	aliases {
> +		arm,integrator-clocksource = &timer2;
> +		arm,integrator-clockevent = &timer1;
> +	};

It looks like this file is almost a direct superset of the integratorap.dts
file. How about including the other file from here and just adding the
extra nodes and overriding the few bits that are actually different?

>  
> +#ifdef CONFIG_OF
> +
...
> +DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
> +	.reserve	= integrator_reserve,
> +	.map_io		= ap_map_io,
> +	.nr_irqs	= NR_IRQS_INTEGRATOR_AP,
> +	.init_early	= ap_init_early,
> +	.init_irq	= ap_init_irq_of,
> +	.handle_irq	= fpga_handle_irq,
> +	.timer		= &ap_of_timer,
> +	.init_machine	= ap_init,
> +	.restart	= integrator_restart,
> +	.dt_compat      = ap_dt_board_compat,
> +MACHINE_END
> +
> +#else
> +
...
>  MACHINE_START(INTEGRATOR, "ARM-Integrator")
>  	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
>  	.atag_offset	= 0x100,
> @@ -486,3 +571,5 @@ MACHINE_START(INTEGRATOR, "ARM-Integrator")
>  	.init_machine	= ap_init,
>  	.restart	= integrator_restart,
>  MACHINE_END
> +
> +#endif

I think we discussed this before. It would be nice to replace the #if/#else
with 

#ifdef CONFIG_OF
...
#endif
#ifdef CONFIG_ATAG
...
#endif

so you can actually support both in the same binary. The other alternative
would be to remove the ATAG boot capability right away, as some other
platforms have done when they moved to DT.

	Arnd
