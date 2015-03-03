From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 03 Mar 2015 13:35:04 +0100
Subject: [PATCH 9/9] ARM: EXYNOS: make exynos 4210 cpuidle build without
 SMP
In-Reply-To: <2875270.gE4YDsjeJe@wuerfel>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
 <2875270.gE4YDsjeJe@wuerfel>
Message-ID: <5040084.lEIUokD8Gn@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Have you seen my patch from 4th February?

	https://lkml.org/lkml/2015/2/4/521

I think that it is cleaner as it doesn't add new ifdefs,
results in less code being compiled for UP and doesn't
open-code cpu_boot_reg_base().  It has also been tested
on Exynos4210 Origen board.

PS Please cc: me and Daniel on Exynos cpuidle changes
(MAINTAINERS file contains a relevant entry).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

On Monday, March 02, 2015 10:29:42 PM Arnd Bergmann wrote:
> arch/arm/mach-exynos/pm.c: In function 'exynos_cpu0_enter_aftr':
> arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of function 'arch_send_wakeup_ipi_mask' [-Werror=implicit-function-declaration]
>     arch_send_wakeup_ipi_mask(cpumask_of(1));
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-exynos/pm.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index e6209dadc00d..a91aefaee31d 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -187,6 +187,7 @@ static int exynos_cpu0_enter_aftr(void)
>  {
>  	int ret = -1;
>  
> +#ifdef CONFIG_SMP
>  	/*
>  	 * If the other cpu is powered on, we have to power it off, because
>  	 * the AFTR state won't work otherwise
> @@ -216,10 +217,12 @@ static int exynos_cpu0_enter_aftr(void)
>  			cpu_relax();
>  		}
>  	}
> +#endif
>  
>  	exynos_enter_aftr();
>  	ret = 0;
>  
> +#ifdef CONFIG_SMP
>  abort:
>  	if (cpu_online(1)) {
>  		/*
> @@ -246,11 +249,12 @@ abort:
>  			arch_send_wakeup_ipi_mask(cpumask_of(1));
>  		}
>  	}
> +#endif
>  
>  	return ret;
>  }
>  
> -static int exynos_wfi_finisher(unsigned long flags)
> +static int __maybe_unused exynos_wfi_finisher(unsigned long flags)
>  {
>  	cpu_do_idle();
>  
> @@ -260,7 +264,7 @@ static int exynos_wfi_finisher(unsigned long flags)
>  static int exynos_cpu1_powerdown(void)
>  {
>  	int ret = -1;
> -
> +#ifdef CONFIG_SMP
>  	/*
>  	 * Idle sequence for cpu1
>  	 */
> @@ -282,13 +286,20 @@ cpu1_aborted:
>  	 * Notify cpu 0 that cpu 1 is awake
>  	 */
>  	atomic_set(&cpu1_wakeup, 1);
> -
> +#endif
>  	return ret;
>  }
>  
>  static void exynos_pre_enter_aftr(void)
>  {
> -	__raw_writel(virt_to_phys(exynos_cpu_resume), cpu_boot_reg_base());
> +	void *reg_base;
> +
> +	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
> +		reg_base = pmu_base_addr + S5P_INFORM5;
> +	else
> +		reg_base = sysram_base_addr;
> +
> +	__raw_writel(virt_to_phys(exynos_cpu_resume), reg_base);
>  }
>  
>  static void exynos_post_enter_aftr(void)
> 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
