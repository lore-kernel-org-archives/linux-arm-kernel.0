From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Nov 2012 09:33:43 -0800
Subject: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <20121107173343.GF6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [121107 06:44]:
> CONFIG_OMAP_32K_TIMER is kind of standing on the single zImage way.
> Make OMAP2+ timer code independant from the CONFIG_OMAP_32K_TIMER
> setting.
> To remove the dependancy, several conversions/additions had to be done:
> 1) Timer structures and initialization functions are named by the platform
>    name and the clock source in use. The decision which timer is
>    used is done statically from the machine_desc structure. In the
>    future it should come from DT.
> 2) Settings under the CONFIG_OMAP_32K_TIMER option are expanded into
>    separate timer structures along with the timer init functions.
>    This removes the CONFIG_OMAP_32K_TIMER on OMAP2+ timer code.

I think this should be the default for the timers as that counter
does not stop during deeper idle states.

> 3) Since we have all the timers defined inside machine_desc structure
>    and we no longer need the fallback to gp_timer clock source in case
>    32k_timer clock source is unavailable (namely on AM33xx), we no
>    longer need the #ifdef around __omap2_sync32k_clocksource_init()
>    function. Remove the #ifdef CONFIG_OMAP_32K_TIMER around the
>    __omap2_sync32k_clocksource_init() function.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> Finally I'm sending this out...
> I've lost following Tony's branches and deciding which one to base on,
> so I used linux-omap/master as a base for the patch.
> Tony, tell me if you want it based on some other branch.
> This has been compile tested on omap1|2plus_defconfig only.

Yes sorry it's been a bit crazy with branches to get this
header clean up done.. If it applies to master it should
be easy to apply on others.

> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -284,6 +284,6 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
>  	.handle_irq	= omap2_intc_handle_irq,
>  	.init_machine	= omap_2430sdp_init,
>  	.init_late	= omap2430_init_late,
> -	.timer		= &omap2_timer,
> +	.timer		= &omap2_sync32k_timer,
>  	.restart	= omap_prcm_restart,
>  MACHINE_END
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -596,6 +596,6 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
>  	.handle_irq	= omap3_intc_handle_irq,
>  	.init_machine	= omap_3430sdp_init,
>  	.init_late	= omap3430_init_late,
> -	.timer		= &omap3_timer,
> +	.timer		= &omap3_sync32k_timer,
>  	.restart	= omap_prcm_restart,
>  MACHINE_END
...

Can't we assume that the default timer is omap[234]_sync32k_timer to
avoid renaming the timer entries in all the board files?

Then we just need a new timer entries for the hardware that does
not have the sycn32k_timer available?

Regards,

Tony
