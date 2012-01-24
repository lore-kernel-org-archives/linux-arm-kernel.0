From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 24 Jan 2012 08:53:29 +0000
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <87mx9ej8fp.fsf@ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8317B0971@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 05:08:50, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > OMAP device has 32k-sync timer which is currently used as a
> > clocksource in the kernel (omap2plus_defconfig).
> > The current implementation uses compile time selection between
> > gp-timer and 32k-sync timer, which breaks multi-omap build for
> > the devices like AM33xx, where 32k-sync timer is not available.
> >
> > So use hwmod database lookup mechanism, through which at run-time
> > we can identify availability of 32k-sync timer on the device,
> > else fall back to gp-timer.
> 
> With the runtime detection & fallback, I suggest also removing the
> Kconfig choice between the two as well.
> 
Kevin,

Actually I thought of cleaning whole 32KTIMER related code,
but then realized that, it would be major cleanup, since
it is being used in lot of places.

So let's not block this patch-series for this further cleanup.
I will work on cleaning up the complete 32KTIMER macro and 
submit the patches.


Simple grep command gives -
===========================
psplinux060:/datalocal/omap-kernel>grep -r OMAP_32K_TIMER *
arch/arm/mach-omap1/Makefile:obj-$(CONFIG_OMAP_32K_TIMER)       += timer32k.o
arch/arm/mach-omap1/time.c:#ifdef CONFIG_OMAP_32K_TIMER
arch/arm/mach-omap1/pm.c:#ifdef CONFIG_OMAP_32K_TIMER
arch/arm/mach-omap1/pm.c:#ifdef CONFIG_OMAP_32K_TIMER
arch/arm/mach-omap1/pm.c:#ifdef CONFIG_OMAP_32K_TIMER
arch/arm/mach-omap1/timer32k.c:#define OMAP_32K_TIMER_TICK_PERIOD       ((OMAP_32K_TICKS_PER_SEC / HZ) - 1)
arch/arm/mach-omap1/timer32k.c:         omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
arch/arm/mach-omap2/timer.c:#ifdef CONFIG_OMAP_32K_TIMER
arch/arm/configs/omap1_defconfig:CONFIG_OMAP_32K_TIMER=y
arch/arm/plat-omap/include/plat/timex.h:#ifdef CONFIG_OMAP_32K_TIMER
arch/arm/plat-omap/include/plat/timex.h:#define CLOCK_TICK_RATE         (CONFIG_OMAP_32K_TIMER_HZ)
arch/arm/plat-omap/include/plat/param.h:#ifdef CONFIG_OMAP_32K_TIMER_HZ
arch/arm/plat-omap/include/plat/param.h:#define HZ      CONFIG_OMAP_32K_TIMER_HZ
arch/arm/plat-omap/Kconfig:config OMAP_32K_TIMER
arch/arm/plat-omap/Kconfig:config OMAP_32K_TIMER_HZ
arch/arm/plat-omap/Kconfig:     depends on OMAP_32K_TIMER
arch/arm/Kconfig:       default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER



Thanks,
Vaibhav

> Kevin
> 
