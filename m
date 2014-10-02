From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 02 Oct 2014 18:16:32 +0900
Subject: [GIT PULL 1/3] 3rd Round for Samsung-cleanup-2 for v3.18
In-Reply-To: <201410011754.26880.arnd@arndb.de>
References: <542448A9.4000702@samsung.com> <201410011754.26880.arnd@arndb.de>
Message-ID: <026901cfde21$8e72d0d0$ab587270$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Thursday 25 September 2014, Kukjin Kim wrote:
> > The following changes since commit f6361c6b3880063c2248d4e453331e3dc1efbf83:
> >
> >    ARM: S3C24XX: remove separate restart code (2014-09-14 02:43:09 +0900)
> >
> > are available in the git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-cleanup-2
> >
> > for you to fetch changes up to 5a1f0c6d3161a37da3a651f80b18febc2e5d7b75:
> >
> >    ARM: EXYNOS: Fix CPU idle clock down after CPU off (2014-09-14
> > 02:49:32 +0900)
> >
> > ----------------------------------------------------------------
> > Samsung 2nd cleanup for v3.18
> >
> > - Cleanup SMP/hotplug codes from hotplug.c to platsmp.c
> >
> > - Remove unneeded __ref annotation for exynos_cpu_die()
> >
> > - Fix the way to power down CPU on exynos4 and CPUidle
> >    clock down after power down some CPU
> 
> Pulled into next/late with a fixup, see below. Your original changen broke
> allmodconfig.
> 
+ Russell, Krzysztof

Arnd, as I informed about that before its fixup has been applied into rmk tree.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8177/1

But I'm not sure we need to keep the your fixup in arm-soc, in case of landing
of the fixup in rmk tree for upcoming merge window.

Sorry for the noise anyway.

- Kukjin

> 	Arnd
> 
> From 9bbebfb41db4109b23d330f14ce41e4ebc825716 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 26 Sep 2014 23:09:38 +0200
> Subject: [PATCH] ARM: EXYNOS: fix build error in platsmp.c
> 
> /tmp/ccYeWL3V.s: Assembler messages:
> /tmp/ccYeWL3V.s:659: Error: selected processor does not support ARM mode `isb '
> /tmp/ccYeWL3V.s:664: Error: selected processor does not support ARM mode `isb '
> /tmp/ccYeWL3V.s:665: Error: selected processor does not support ARM mode `dsb '
> make[3]: *** [arch/arm/mach-exynos/platsmp.o] Error 1
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 17342534e1d932 ("ARM: EXYNOS: Move code from hotplug.c to platsmp.c")
> 
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 0095de99d703..5d336b43cb10 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
> 
>  obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> +CFLAGS_platsmp.o		:= -march=armv7-a
> 
>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>  AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
