From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 27 Nov 2014 12:18:36 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141126200806.GO2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <201411261957.08860@pali>
 <20141126191027.GM2817@atomide.com> <201411262022.03338@pali>
 <20141126200806.GO2817@atomide.com>
Message-ID: <20141127111836.GA20159@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 8< ------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 26 Nov 2014 11:55:29 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix n900 board name for legacy user space
> 
> N900 legacy user space apps need the board name in
> /proc/cpuinfo to work properly for the Hardware entry.
> 
> For other boards this should not be an issues and they
> can use the generic Hardware entry.
> 
> Let's fix the issue by adding a custom DT_MACHINE_START
> for n900.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks!
								Pavel

> 
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -118,6 +118,24 @@ MACHINE_END
>  #endif
>  
>  #ifdef CONFIG_ARCH_OMAP3
> +/* Some boards need board name for legacy userspace in /proc/cpuinfo */
> +static const char *const n900_boards_compat[] __initconst = {
> +	"nokia,omap3-n900",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= omap3430_init_early,
> +	.init_machine	= omap_generic_init,
> +	.init_late	= omap3_init_late,
> +	.init_time	= omap3_sync32k_timer_init,
> +	.dt_compat	= n900_boards_compat,
> +	.restart	= omap3xxx_restart,
> +MACHINE_END
> +
> +/* Generic omap3 boards, most boards can use these */
>  static const char *const omap3_boards_compat[] __initconst = {
>  	"ti,omap3430",
>  	"ti,omap3",

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
