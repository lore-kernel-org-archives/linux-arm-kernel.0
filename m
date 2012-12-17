From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 17 Dec 2012 17:00:04 +0000
Subject: [PATCH v2 6/7] ARM: mackerel: support booting with or without DT
In-Reply-To: <Pine.LNX.4.64.1212171332520.24007@axis700.grange>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-7-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1212171332520.24007@axis700.grange>
Message-ID: <20121217170004.7F6C23E0BDD@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Dec 2012 13:40:45 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> This patch adds dynamic switching to booting either with or without DT.
> So far only a part of the board initialisation can be done via DT. Devices,
> that still need platform data are kept that way. Devices, that can be
> initialised from DT will not be supplied from the platform data, if a DT
> image is detected.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  
>  static const char *mackerel_boards_compat_dt[] __initdata = {
> @@ -1659,10 +1715,20 @@ static const char *mackerel_boards_compat_dt[] __initdata = {
>  DT_MACHINE_START(MACKEREL_DT, "mackerel")
>  	.map_io		= sh7372_map_io,
>  	.init_early	= sh7372_add_early_devices,
> +	.init_irq	= sh7372_init_irq_of,
> +	.handle_irq	= shmobile_handle_irq_intc,
> +	.init_machine	= mackerel_init,
> +	.init_late	= sh7372_pm_init_late,
> +	.timer		= &shmobile_timer,
> +	.dt_compat	= mackerel_boards_compat_dt,
> +MACHINE_END
> +
> +MACHINE_START(MACKEREL, "mackerel")
> +	.map_io		= sh7372_map_io,
> +	.init_early	= sh7372_add_early_devices,
>  	.init_irq	= sh7372_init_irq,
>  	.handle_irq	= shmobile_handle_irq_intc,
>  	.init_machine	= mackerel_init,
>  	.init_late	= sh7372_pm_init_late,
>  	.timer		= &shmobile_timer,
> -	.dt_compat  = mackerel_boards_compat_dt,
>  MACHINE_END

MACHINE_START() handle's the DT case just fine. You shouldn't need
separate MACHINE_START() and DT_MACHINE_START() stanzas. Please merge. I
see that there was some discussion around sh7372_init_irq_of(), but I
it is better to have the single function handle the OF/non-OF case
gracefully rather than duplicating MACHINE definitions.

g.
