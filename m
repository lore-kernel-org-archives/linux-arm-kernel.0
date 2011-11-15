From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 15 Nov 2011 10:58:56 +0900
Subject: [PATCH] ARM: exynos: remove exynos4_scu_enable()
In-Reply-To: <1321322048-24885-1-git-send-email-shawn.guo@linaro.org>
References: <1321322048-24885-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAH9JG2WAJ1=nNnfZ=2ANSLek4bB4d=erN-51kvBLYJ0Qu4du+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/11, Shawn Guo <shawn.guo@linaro.org> wrote:
> The exynos4_scu_enable() is a duplication of scu_enable().  Since
> commit '26a527e ARM: 7100/1: smp_scu: remove __init annotation from
> scu_enable()' makes scu_enable() available for non-init codes, exynos
> can directly call scu_enable() and save exynos4_scu_enable() now.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c |   23 +----------------------
>  1 files changed, 1 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 509a435..a4d67c7 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -213,27 +213,6 @@ static int exynos4_pm_add(struct sys_device *sysdev)
>  	return 0;
>  }
>
> -/* This function copy from linux/arch/arm/kernel/smp_scu.c */
> -
> -void exynos4_scu_enable(void __iomem *scu_base)
> -{
> -	u32 scu_ctrl;
> -
> -	scu_ctrl = __raw_readl(scu_base);
> -	/* already enabled? */
> -	if (scu_ctrl & 1)
> -		return;
> -
> -	scu_ctrl |= 1;
> -	__raw_writel(scu_ctrl, scu_base);
> -
> -	/*
> -	 * Ensure that the data accessed by CPU0 before the SCU was
> -	 * initialised is visible to the other CPUs.
> -	 */
> -	flush_cache_all();
> -}
> -
>  static unsigned long pll_base_rate;
>
>  static void exynos4_restore_pll(void)
> @@ -402,7 +381,7 @@ static void exynos4_pm_resume(void)
>
>  	exynos4_restore_pll();
>
> -	exynos4_scu_enable(S5P_VA_SCU);
> +	scu_enable(S5P_VA_SCU);
>
>  #ifdef CONFIG_CACHE_L2X0
>  	s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
