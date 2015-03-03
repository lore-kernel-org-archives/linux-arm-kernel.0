From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 03 Mar 2015 17:23:52 +0100
Subject: [GIT PULL 1/2] Samsung fixes-1 for v4.0
In-Reply-To: <1651242.NSDETIvUSP@amdc1032>
References: <54F4B250.5080200@kernel.org> <1651242.NSDETIvUSP@amdc1032>
Message-ID: <5506858.hZnoOahndE@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 03, 2015 04:48:39 PM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, March 03, 2015 03:56:16 AM Kukjin Kim wrote:
> > The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> > 
> >   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-fixes-1
> > 
> > for you to fetch changes up to 8a68de64e984cfc49ecc22ac18155a7fe6dbbfaf:
> > 
> >   ARM: EXYNOS: fix exynos randconfig build error (2015-03-03 03:37:57 +0900)
> > 
> > ----------------------------------------------------------------
> > Samsung fixes for v4.0
> > 
> > - fix exynos randconfig build error with SMP=n
> > - fix wrong hwirq of RTC interrupt for exynos3250
> > - fix usage of LDREX and STREX after disabling cache coherency
> > 
> > ----------------------------------------------------------------
> > Chanwoo Choi (1):
> >       ARM: EXYNOS: Fix wrong hwirq of RTC interrupt for Exynos3250 SoC
> > 
> > Krzysztof Kozlowski (1):
> >       ARM: EXYNOS: Don't use LDREX and STREX after disabling cache coherency
> > 
> > Russell King (1):
> >       ARM: EXYNOS: fix exynos randconfig build error
> 
> Has anyone actually tested this patch with SMP=n && PM_SLEEP=y
> or SMP=n && CONFIG_ARM_EXYNOS_CPUIDLE=y?
> 
> The patch is just insufficient as it prevents build of

By insufficient here I mean compeltely bogus.  I don't mean to be rude
howeover since the wrong patch was picked please let me explain it in
more technical details.

What the patch does is adding an SMP dependency to EXYNOS_CPU_SUSPEND
option in order to "fix" SMP=n build:

--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -131,6 +131,7 @@ config EXYNOS5420_MCPM
 
 config EXYNOS_CPU_SUSPEND
        bool
+       depends on SMP
        select ARM_CPU_SUSPEND
        default PM_SLEEP || ARM_EXYNOS_CPUIDLE
 
Please note that the EXYNOS_CPU_SUSPEND option itself will be
selected only if PM_SLEEP=y or ARM_EXYNOS_CPUIDLE=y.

Now lets look at arch/arm/mach-exynos/Makefile:

...
obj-$(CONFIG_ARCH_EXYNOS)       += exynos.o pmu.o exynos-smc.o firmware.o

obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
obj-$(CONFIG_PM_SLEEP)          += suspend.o
...

Code in suspend.c references code from from pm.c and sleep.S.
It will fail to link for PM_SLEEP=y as seen below:

> arch/arm/mach-exynos/pm.o and arch/arm/mach-exynos/sleep.o
> for SMP=n.  Both files are needed for PM_SLEEP=y code that
> resides in arch/arm/mach-exynos/suspend.c:
> 
>   LD      init/built-in.o
> arch/arm/mach-exynos/built-in.o: In function `exynos_save_cp15':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/firmware.c:36: undefined reference to `exynos_cpu_resume_ns'
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/firmware.c:36: undefined reference to `cp15_save_power'
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/firmware.c:36: undefined reference to `cp15_save_diag'
> arch/arm/mach-exynos/built-in.o: In function `exynos5420_pm_resume':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:435: undefined reference to `exynos_pm_central_resume'
> arch/arm/mach-exynos/built-in.o: In function `__virt_to_phys':
> /home/bzolnier/sam/linux-sprc/./arch/arm/include/asm/memory.h:228: undefined reference to `exynos_cpu_resume'
> /home/bzolnier/sam/linux-sprc/./arch/arm/include/asm/memory.h:228: undefined reference to `exynos_cpu_resume'
> arch/arm/mach-exynos/built-in.o: In function `exynos3250_pm_resume':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:395: undefined reference to `exynos_pm_central_resume'
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:405: undefined reference to `exynos_cpu_restore_register'
> arch/arm/mach-exynos/built-in.o: In function `exynos_pm_resume':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:365: undefined reference to `exynos_pm_central_resume'
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:382: undefined reference to `exynos_cpu_restore_register'
> arch/arm/mach-exynos/built-in.o: In function `exynos_pm_prepare':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:253: undefined reference to `exynos_cpu_resume'
> arch/arm/mach-exynos/built-in.o: In function `exynos_pm_suspend':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:322: undefined reference to `exynos_pm_central_suspend'
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:329: undefined reference to `exynos_cpu_save_register'
> arch/arm/mach-exynos/built-in.o: In function `exynos5420_pm_suspend':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/suspend.c:338: undefined reference to `exynos_pm_central_suspend'
> arch/arm/mach-exynos/built-in.o: In function `exynos_dt_machine_init':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/exynos.c:284: undefined reference to `cpuidle_coupled_exynos_data'
> arch/arm/mach-exynos/built-in.o:(.data+0x70): undefined reference to `exynos_enter_aftr'
> make: *** [vmlinux] Error 1
> 
> Moreover it still allows to select Exynos cpuidle support
> (CONFIG_ARM_EXYNOS_CPUIDLE=y) with SMP=n which results in:

Code in exynos.c that is covered with CONFIG_ARM_EXYNOS_CPUIDLE
ifdefs references code from pm.c for case when ARM_EXYNOS_CPUIDLE=y
and will also fail to link:

>   LD      init/built-in.o
> arch/arm/mach-exynos/built-in.o: In function `exynos_dt_machine_init':
> /home/bzolnier/sam/linux-sprc/arch/arm/mach-exynos/exynos.c:284: undefined reference to `cpuidle_coupled_exynos_data'
> arch/arm/mach-exynos/built-in.o:(.data+0x70): undefined reference to `exynos_enter_aftr'
> make: *** [vmlinux] Error 1

So the SMP=n kernel won't link when PM_SLEEP=y or ARM_EXYNOS_CPUIDLE=y
is selected.  Now please take look at the config EXYNOS_CPU_SUSPEND
option again and recall that it is selected only if PM_SLEEP=y or
ARM_EXYNOS_CPUIDLE=y is set.  Yes..  the patch doesn't actually fix
anything...

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> The full solution for issue that "ARM: EXYNOS: fix exynos randconfig
> build error" patch attempted to fix has been posted by me on 4th of
> February (https://lkml.org/lkml/2015/2/4/521) and for completness is
> also included below.  It fixes a v4.0-rc1 regression caused by
> a recent addition of cpuidle coupled support for Exynos4210 SoC.
> It makes only the new Exynos4210 coupled cpuidle support to be
> dependent on SMP.  On UP cpuidle will use the old non-coupled code
> for Exynos4210 which is an expected behavior (as it was in v3.19).
> The patch has been tested on Exynos4210 Origen board with both SMP
> and UP kernels and in both cases it worked fine.
> 
> 
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Subject: [PATCH] ARM: EXYNOS: cpuidle: Fix build breakage on !SMP
> 
> The Exynos cpuidle driver has coupled cpuidle built-in so it cannot be
> built without SMP:
> 
> arch/arm/mach-exynos/pm.c: In function ?exynos_cpu0_enter_aftr?:
> arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of function ?arch_send_wakeup_ipi_mask? [-Werror=implicit-function-declaration]
> arch/arm/mach-exynos/built-in.o: In function `exynos_pre_enter_aftr':
> ../arch/arm/mach-exynos/pm.c:300: undefined reference to `cpu_boot_reg_base'
> arch/arm/mach-exynos/built-in.o: In function `exynos_cpu1_powerdown':
> ../arch/arm/mach-exynos/pm.c:282: undefined reference to `exynos_cpu_power_down'
> 
> Fix it by adding missing checks for SMP.
> 
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c    |    2 +-
>  arch/arm/mach-exynos/pm.c        |    2 ++
>  drivers/cpuidle/cpuidle-exynos.c |    3 ++-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> Index: b/arch/arm/mach-exynos/exynos.c
> ===================================================================
> --- a/arch/arm/mach-exynos/exynos.c	2015-02-04 18:30:23.555819717 +0100
> +++ b/arch/arm/mach-exynos/exynos.c	2015-02-04 18:43:23.539807815 +0100
> @@ -211,7 +211,7 @@ static void __init exynos_dt_machine_ini
>  	if (!IS_ENABLED(CONFIG_SMP))
>  		exynos_sysram_init();
>  
> -#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
> +#if defined(CONFIG_SMP) && defined(CONFIG_ARM_EXYNOS_CPUIDLE)
>  	if (of_machine_is_compatible("samsung,exynos4210"))
>  		exynos_cpuidle.dev.platform_data = &cpuidle_coupled_exynos_data;
>  #endif
> Index: b/arch/arm/mach-exynos/pm.c
> ===================================================================
> --- a/arch/arm/mach-exynos/pm.c	2015-02-04 18:30:23.563819719 +0100
> +++ b/arch/arm/mach-exynos/pm.c	2015-02-04 18:47:32.951804008 +0100
> @@ -181,6 +181,7 @@ void exynos_enter_aftr(void)
>  	cpu_pm_exit();
>  }
>  
> +#if defined(CONFIG_SMP) && defined(CONFIG_ARM_EXYNOS_CPUIDLE)
>  static atomic_t cpu1_wakeup = ATOMIC_INIT(0);
>  
>  static int exynos_cpu0_enter_aftr(void)
> @@ -302,3 +303,4 @@ struct cpuidle_exynos_data cpuidle_coupl
>  	.pre_enter_aftr		= exynos_pre_enter_aftr,
>  	.post_enter_aftr		= exynos_post_enter_aftr,
>  };
> +#endif /* CONFIG_SMP && CONFIG_ARM_EXYNOS_CPUIDLE */
> Index: b/drivers/cpuidle/cpuidle-exynos.c
> ===================================================================
> --- a/drivers/cpuidle/cpuidle-exynos.c	2015-02-04 18:30:32.935819577 +0100
> +++ b/drivers/cpuidle/cpuidle-exynos.c	2015-02-04 18:46:01.619805400 +0100
> @@ -117,7 +117,8 @@ static int exynos_cpuidle_probe(struct p
>  {
>  	int ret;
>  
> -	if (of_machine_is_compatible("samsung,exynos4210")) {
> +	if (IS_ENABLED(CONFIG_SMP) &&
> +	    of_machine_is_compatible("samsung,exynos4210")) {
>  		exynos_cpuidle_pdata = pdev->dev.platform_data;
>  
>  		ret = cpuidle_register(&exynos_coupled_idle_driver,
