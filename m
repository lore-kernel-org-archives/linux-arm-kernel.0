From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 18 Jan 2012 13:58:28 -0700
Subject: [PATCH 1/2] arm:omap2:board-generic: Add DT support for AM33xx
 devices
In-Reply-To: <1326870839-19951-1-git-send-email-hvaibhav@ti.com>
References: <1326870839-19951-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20120118205828.GM4223@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 12:43:58PM +0530, Vaibhav Hiremath wrote:
> Although we consider am33xx device under omap34xx family of devices,
> there is indeed difference between them, for example,
> 
>       - Initial required mapping (->map_io)
>       - Early init (->init_early)
> 	Here, the whole sequence/data is different than omap3,
> 	For example, clock/hwmod/power/voltage data.
>       - clock event/source timer (name and instances)
> 
> So, this patch adds seperate machine descriptor for AM33XX family
> of devices in board-generic.c file.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> CC: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> Tested it on AM335x-EVM, AM37xEVM and AM3517EVM.
> 
>  arch/arm/mach-omap2/board-generic.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index f7b4b24..2faecc8 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -106,6 +106,25 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
>  MACHINE_END
>  #endif
> 
> +#if defined(CONFIG_SOC_OMAPAM33XX)
> +static const char *am33xx_boards_compat[] __initdata = {
> +	"ti,am33xx",

Don't forget to add the new compatible values to
Documentation/device-tree/bindings.

> +	NULL,
> +};
> +
> +DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
> +	.atag_offset	= 0x100,

Unneeded for DT booting.

Otherwise, you can add:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> +	.reserve	= omap_reserve,
> +	.map_io		= am33xx_map_io,
> +	.init_early	= am33xx_init_early,
> +	.init_irq	= omap_init_irq,
> +	.handle_irq	= omap3_intc_handle_irq,
> +	.init_machine	= omap_generic_init,
> +	.timer		= &omap3_am33xx_timer,
> +	.dt_compat	= am33xx_boards_compat,
> +MACHINE_END
> +#endif
> +
>  #if defined(CONFIG_ARCH_OMAP4)
>  static const char *omap4_boards_compat[] __initdata = {
>  	"ti,omap4",
> --
> 1.7.0.4
> 
