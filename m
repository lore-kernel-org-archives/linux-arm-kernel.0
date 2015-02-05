From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 Feb 2015 08:12:20 +0100
Subject: [PATCH] ARM: EXYNOS: cpuidle: Fix build breakage on !SMP
In-Reply-To: <8043345.BDfdhXvZOx@amdc1032>
References: <1423045646-20592-1-git-send-email-k.kozlowski@samsung.com>
 <8043345.BDfdhXvZOx@amdc1032>
Message-ID: <1423120340.29408.0.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2015-02-04 at 19:07 +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Wednesday, February 04, 2015 11:27:26 AM Krzysztof Kozlowski wrote:
> > The Exynos cpuidle driver has coupled cpuidle built-in so it cannot be
> > built without SMP:
> > 
> > arch/arm/mach-exynos/pm.c: In function ?exynos_cpu0_enter_aftr?:
> > arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of function ?arch_send_wakeup_ipi_mask? [-Werror=implicit-function-declaration]
> > arch/arm/mach-exynos/built-in.o: In function `exynos_pre_enter_aftr':
> > ../arch/arm/mach-exynos/pm.c:300: undefined reference to `cpu_boot_reg_base'
> > arch/arm/mach-exynos/built-in.o: In function `exynos_cpu1_powerdown':
> > ../arch/arm/mach-exynos/pm.c:282: undefined reference to `exynos_cpu_power_down'
> > 
> > Make the cpuidle driver depending on SMP because this will be the
> > fastest way to fix build break without adding a bunch of ifdefs in few
> > places.
> 
> There shouldn't be a lot of new ifdefs (please see below) and I would
> very much prefer for cpuidle to stay supported also on UP kernels.

Sure, I'm fine with your patch.

Best regards,
Krzysztof

> 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/mach-exynos/pm.c   | 2 ++
> >  drivers/cpuidle/Kconfig.arm | 3 ++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> > index e6209dadc00d..17db00ff7f3a 100644
> > --- a/arch/arm/mach-exynos/pm.c
> > +++ b/arch/arm/mach-exynos/pm.c
> > @@ -181,6 +181,7 @@ void exynos_enter_aftr(void)
> >  	cpu_pm_exit();
> >  }
> >  
> > +#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
> >  static atomic_t cpu1_wakeup = ATOMIC_INIT(0);
> >  
> >  static int exynos_cpu0_enter_aftr(void)
> > @@ -302,3 +303,4 @@ struct cpuidle_exynos_data cpuidle_coupled_exynos_data = {
> >  	.pre_enter_aftr		= exynos_pre_enter_aftr,
> >  	.post_enter_aftr		= exynos_post_enter_aftr,
> >  };
> > +#endif /* CONFIG_ARM_EXYNOS_CPUIDLE */
> > diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> > index 8e07c9419153..5eb86a4f74d9 100644
> > --- a/drivers/cpuidle/Kconfig.arm
> > +++ b/drivers/cpuidle/Kconfig.arm
> > @@ -55,7 +55,8 @@ config ARM_AT91_CPUIDLE
> >  config ARM_EXYNOS_CPUIDLE
> >  	bool "Cpu Idle Driver for the Exynos processors"
> >  	depends on ARCH_EXYNOS
> > -	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> > +	depends on SMP
> > +	select ARCH_NEEDS_CPU_IDLE_COUPLED
> >  	help
> >  	  Select this to enable cpuidle for Exynos processors
> 
> How's about the patch below instead?  It builds fine for UP and SMP.
> I will do more testing tomorrow (unfortunately it seems that something
> else broke Origen4210 in -next).
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
