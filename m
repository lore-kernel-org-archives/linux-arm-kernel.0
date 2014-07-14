From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 14 Jul 2014 11:54:48 +0200
Subject: [PATCH v2 5/6] ARM: EXYNOS: Fix suspend/resume sequences
In-Reply-To: <1403697175-13476-1-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403697175-13476-1-git-send-email-t.figa@samsung.com>
Message-ID: <53C3A8E8.4090009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 25.06.2014 13:52, Tomasz Figa wrote:
> Due to recent consolidation of Exynos suspend and cpuidle code, some
> parts of suspend and resume sequences are executed two times, once from
> exynos_pm_syscore_ops and then from exynos_cpu_pm_notifier() and thus it
> breaks suspend, at least on Exynos4-based boards.
> 
> This patch fixes the issue by removing exynos_pm_syscore_ops completely
> and making the code rely only on CPU PM notifier.
> 
> Tested on Exynos4210-based Trats board.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> Changes since v1:
>  - rebased onto Kukjin's fixes branch.
> 
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 202ca73..f23cc77 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -364,11 +364,6 @@ early_wakeup:
>  	return;
>  }
>  
> -static struct syscore_ops exynos_pm_syscore_ops = {
> -	.suspend	= exynos_pm_suspend,
> -	.resume		= exynos_pm_resume,
> -};
> -
>  /*
>   * Suspend Ops
>   */
> @@ -438,22 +433,13 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
>  
>  	switch (cmd) {
>  	case CPU_PM_ENTER:
> -		if (cpu == 0) {
> -			exynos_pm_central_suspend();
> -			if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> -				exynos_cpu_save_register();
> -		}
> +		if (cpu == 0)
> +			exynos_pm_suspend();
>  		break;
>  
>  	case CPU_PM_EXIT:
> -		if (cpu == 0) {
> -			if (read_cpuid_part_number() ==
> -					ARM_CPU_PART_CORTEX_A9) {
> -				scu_enable(S5P_VA_SCU);
> -				exynos_cpu_restore_register();
> -			}
> -			exynos_pm_central_resume();
> -		}
> +		if (cpu == 0)
> +			exynos_pm_resume();
>  		break;
>  	}
>  
> @@ -478,6 +464,5 @@ void __init exynos_pm_init(void)
>  	tmp |= ((0xFF << 8) | (0x1F << 1));
>  	__raw_writel(tmp, S5P_WAKEUP_MASK);
>  
> -	register_syscore_ops(&exynos_pm_syscore_ops);
>  	suspend_set_ops(&exynos_suspend_ops);
>  }
> 

Please consider this patch for next fixes pull request. Without it
suspend/resume is broken for Exynos4 and probably other SoCs. This patch
just restores the sequence from before the patch moving things to PM
notifier, so I don't think it should need any special treatment.

Best regards,
Tomasz
