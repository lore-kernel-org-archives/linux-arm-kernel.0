From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Jul 2014 01:54:45 -0700
Subject: [PATCH] ARM: OMAP: generic: add call to of_clk_init()
In-Reply-To: <1405162508-9835-1-git-send-email-zonque@gmail.com>
References: <1405162508-9835-1-git-send-email-zonque@gmail.com>
Message-ID: <20140723085444.GC22006@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Mack <zonque@gmail.com> [140712 03:57]:
> This is needed to instanciate fixed clocks in the DT.

Makes sense to me. Does this fix some regression or hang
that's needed for the -rc series?

Also would like to get an ack from Tero on this as the other
clocks are initialized elsewhere.

Regards,

Tony
 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 5606fa2..39f154a 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/irqdomain.h>
> +#include <linux/clk-provider.h>
>  
>  #include <asm/mach/arch.h>
>  
> @@ -33,6 +34,11 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
>  	{ }
>  };
>  
> +static struct of_device_id clk_match[] __initdata = {
> +	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
> +	{ }
> +};
> +
>  static void __init omap_generic_init(void)
>  {
>  	omapdss_early_init_of();
> @@ -40,6 +46,8 @@ static void __init omap_generic_init(void)
>  	pdata_quirks_init(omap_dt_match_table);
>  
>  	omapdss_init_of();
> +
> +	of_clk_init(clk_match);
>  }
>  
>  #ifdef CONFIG_SOC_OMAP2420
> -- 
> 1.9.3
> 
