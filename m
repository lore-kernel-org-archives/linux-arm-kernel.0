From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 16 Mar 2011 11:25:10 +0530
Subject: [RFC PATCHv2 14/20] ARM: omap4: dynamically register local
	timersetup function
In-Reply-To: <1300201983-26124-15-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
	<1300201983-26124-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <f77caa44aa0205d3687b0dcae796c42b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Marc Zyngier
> Sent: Tuesday, March 15, 2011 8:43 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Tony Lindgren
> Subject: [RFC PATCHv2 14/20] ARM: omap4: dynamically register local
> timersetup function
>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-omap2/Makefile    |    1 -
>  arch/arm/mach-omap2/timer-gp.c  |   13 ++++++++++++-
>  arch/arm/mach-omap2/timer-mpu.c |   36 ----------------------------
> --------
>  3 files changed, 12 insertions(+), 38 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/timer-mpu.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-
> omap2/Makefile
> index a45cd64..41f8b67 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -22,7 +22,6 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
>
>  # SMP support ONLY available for OMAP4
>  obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
> -obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
>
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-
> omap2/timer-gp.c
> index 3b9cf85..98d03c5 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -39,6 +39,7 @@
>  #include <asm/mach/time.h>
>  #include <plat/dmtimer.h>
>  #include <asm/localtimer.h>
> +#include <asm/smp_twd.h>
>  #include <asm/sched_clock.h>
>  #include <plat/common.h>
>  #include <plat/omap_hwmod.h>
> @@ -247,12 +248,22 @@ static void __init
> omap2_gp_clocksource_init(void)
>  }
>  #endif
>
> +#ifdef CONFIG_LOCAL_TIMERS
> +static int __cpuinit omap4_local_timer_setup(struct
> clock_event_device *evt)
> +{
> +	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
> +	return 0;
> +}
> +#endif
> +
>  static void __init omap2_gp_timer_init(void)
>  {
>  #ifdef CONFIG_LOCAL_TIMERS
> -	if (cpu_is_omap44xx()) {
> +	if (cpu_is_omap44xx() && omap_rev() != OMAP4430_REV_ES1_0)

I see one problem here. The reason we changed the signature of
local_timer_setup() is in case where the local timer isn't
available on a specific SOC versions, the kernel will switch
to broad-cast timers.

This way the kernel built with CONFIG_LOCAL_TIMERS can still work
on SoCs where twd isn't supported.

Looks like your patch breaks that unless and until I am missing
something.

Regards,
Santosh
