From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 10 Jun 2012 12:48:55 -0400
Subject: [PATCH 1/9] ARM: Kirkwood: Add interrupt controller support
 for DT boards
In-Reply-To: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
Message-ID: <20120610164855.GU14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 12:31:53PM +0200, Andrew Lunn wrote:
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/arm/mrvl/intc.txt          |   20 ++++++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |    9 ++++++++
>  arch/arm/mach-kirkwood/board-dt.c                  |   22 +++++++++++++++++++-
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> index 80b9a94..612536e 100644
> --- a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> +++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> @@ -38,3 +38,23 @@ Example:
>  		reg-names = "mux status", "mux mask";
>  		mrvl,intc-nr-irqs = <2>;
>  	};
> +
> +* Marvell Orion Interrupt controller
> +
> +Required properties
> +- compatible :  Should be "marvell,orion-intc"
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. Supported value is <1>
> +- interrupt-controller : So that its clear its an interrupt controller.

nit.  "Declare this node to be an interrupt controller."  If you end up
doing a v2 for other reasons, go ahead and add this.  Otherwise, don't
worry about it.

> +Optional properties
> +- reg : Not used yet, but will contain the interrupt mask address
> +
> +Example:
> +
> +	intc: interrupt-controller {
> +        	compatible = "marvell,orion-intc", "marvell,intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +                reg = <0xfed20204 0x04>,
> +		      <0xfed20214 0x04>;
> +        };
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 926528b..8eab7c4 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -2,6 +2,15 @@
>  
>  / {
>  	compatible = "mrvl,kirkwood";
> +	interrupt-parent = <&intc>;
> +
> +	intc: interrupt-controller {
> +        	compatible = "marvell,orion-intc", "marvell,intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +                reg = <0xfed20204 0x04>,
> +		      <0xfed20214 0x04>;
> +        };
>  
>  	ocp at f1000000 {
>  		compatible = "simple-bus";
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index edc3f8a..fa51586 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_irq.h>
>  #include <linux/kexec.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -80,11 +81,30 @@ static const char *kirkwood_dt_board_compat[] = {
>  	NULL
>  };
>  
> +static int __init kirkwood_add_irq_domain(struct device_node *np,
> +					  struct device_node *interrupt_parent)
> +{
> +	kirkwood_init_irq();
> +	irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
> +	return 0;
> +}
> +
> +static const struct of_device_id kirkwood_irq_match[] = {
> +	{ .compatible = "marvell,orion-intc",
> +	  .data = kirkwood_add_irq_domain, },
> +	{},
> +};
> +
> +static void __init kirkwood_dt_init_irq(void)
> +{
> +	of_irq_init(kirkwood_irq_match);
> +}
> +
>  DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
>  	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
> -	.init_irq	= kirkwood_init_irq,
> +	.init_irq	= kirkwood_dt_init_irq,
>  	.timer		= &kirkwood_timer,
>  	.init_machine	= kirkwood_dt_init,
>  	.restart	= kirkwood_restart,
> -- 
> 1.7.10
> 

Looks good.

Acked-by: Jason Cooper <jason@lakedaemon.net>

I'll add Tested-by: once I get a chance.

thx,

Jason.
