From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Jul 2014 23:02:33 +0900
Subject: [PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies
In-Reply-To: <1403618235-19353-6-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403618235-19353-6-git-send-email-t.figa@samsung.com>
Message-ID: <036c01cf9ab5$43c5d370$cb517a50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Due to recent consolidation of Exynos suspend and cpuidle code, some
> parts of suspend and resume sequences are executed two times, once from
> exynos_pm_syscore_ops and then from exynos_cpu_pm_notifier() and thus it
> breaks suspend, at least on Exynos4-based boards.
> 
+ Jonghwan Choi

Yes, right. We moved the functionality into cpu_pm notifier in the commit ID
0ebc13e2 ("ARM: EXYNOS: Move the power sequence call in the cpu_pm notifier"),
so this should be fixed as you pointed out. But I talked to my colleague
Jonghwan about this and we need more time to have a look in detail for every
exynos SoCs. Will be back soon.

Thanks,
Kukjin

> This patch fixes the issue by removing exynos_pm_syscore_ops completely
> and making the code rely only on CPU PM notifier.
> 
> Tested on Exynos4210-based Trats board.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 87c0d34..98d4926 100644
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
> @@ -438,19 +433,13 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
> 
>  	switch (cmd) {
>  	case CPU_PM_ENTER:
> -		if (cpu == 0) {
> -			exynos_pm_central_suspend();
> -			exynos_cpu_save_register();
> -		}
> +		if (cpu == 0)
> +			exynos_pm_suspend();
>  		break;
> 
>  	case CPU_PM_EXIT:
> -		if (cpu == 0) {
> -			if (!soc_is_exynos5250())
> -				scu_enable(S5P_VA_SCU);
> -			exynos_cpu_restore_register();
> -			exynos_pm_central_resume();
> -		}
> +		if (cpu == 0)
> +			exynos_pm_resume();
>  		break;
>  	}
> 
> @@ -475,6 +464,5 @@ void __init exynos_pm_init(void)
>  	tmp |= ((0xFF << 8) | (0x1F << 1));
>  	__raw_writel(tmp, S5P_WAKEUP_MASK);
> 
> -	register_syscore_ops(&exynos_pm_syscore_ops);
>  	suspend_set_ops(&exynos_suspend_ops);
>  }
> --
> 1.9.3
