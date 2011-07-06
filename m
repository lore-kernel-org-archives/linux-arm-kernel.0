From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 6 Jul 2011 13:00:22 -0600
Subject: [RFC PATCH 3/5] OMAP3: Beagle: Update beagle board file to use DT
In-Reply-To: <1309426647-31587-4-git-send-email-manjugk@ti.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-4-git-send-email-manjugk@ti.com>
Message-ID: <20110706190022.GL4871@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 03:07:25PM +0500, G, Manjunath Kondaiah wrote:
> 
> The beagle board file is updated to use i2c nodes from device
> tree data structures.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |   24 ++++++++++++++++++++----
>  1 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 213c4cd..db494aa 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -20,6 +20,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_address.h>
>  #include <linux/leds.h>
>  #include <linux/gpio.h>
>  #include <linux/input.h>
> @@ -33,6 +34,7 @@
>  
>  #include <linux/regulator/machine.h>
>  #include <linux/i2c/twl.h>
> +#include <linux/irq.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -421,8 +423,8 @@ static int __init omap3_beagle_i2c_init(void)
>  	omap3_pmic_init("twl4030", &beagle_twldata);
>  	/* Bus 3 is attached to the DVI port where devices like the pico DLP
>  	 * projector don't work reliably with 400kHz */
> +#if !defined(CONFIG_OF)
>  	omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
> -#ifdef CONFIG_OF
>  	omap_register_i2c_bus(2, 100, NULL, 0);
>  #endif /* CONFIG_OF */
>  	return 0;
> @@ -565,11 +567,24 @@ static void __init beagle_opp_init(void)
>  	return;
>  }
>  
> +static struct of_device_id omap_dt_gic_match[] __initdata = {
> +	{ .compatible = "ti,omap-gic", },
> +	{}
> +};
> +
> +static struct of_device_id omap_dt_match_table[] __initdata = {
> +	{ .compatible = "ti,omap3-beagle", },
> +	{}
> +};
> +
>  static void __init omap3_beagle_init(void)
>  {
> -#ifdef CONFIG_OF
> -	of_platform_prepare(NULL, NULL);
> -#endif /* CONFIG_OF */
> +	struct device_node *node;
> +
> +	node = of_find_matching_node_by_address(NULL, omap_dt_gic_match,
> +						OMAP34XX_IC_BASE);
> +	if (node)
> +		irq_domain_add_simple(node, 0);
>  
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap3_beagle_init_rev();
> @@ -597,6 +612,7 @@ static void __init omap3_beagle_init(void)
>  
>  	beagle_display_init();
>  	beagle_opp_init();
> +	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);

This is probably a loosing approach.  Until the DT stuff is stable on
omap, you should avoid doing anything that might break existing board
ports.  Instead, I recommend creating an board-omap3-dt.c board file,
and pull in only the static beagle device registrations that you need
to get up and running, then you can pull them back out as the beagle
DT board support matures.

g.

>  }
>  
>  static const char *omap3_beagle_dt_match[] __initdata = {
> -- 
> 1.7.4.1
> 
