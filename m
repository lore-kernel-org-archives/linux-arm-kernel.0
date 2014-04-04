From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:32:10 +0530
Subject: [PATCH 11/17] ARM: exynos: cpuidle: Move the power sequence call
 in the cpu_pm notifier
In-Reply-To: <1396597683-6969-12-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-12-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpomk-DjOafPJCJ1Zc=K42G8uF4vpTSNzwtsdZ6iOJ4WDVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> The code to initiate and exit the powerdown sequence is the same in pm.c and
> cpuidle.c.
>
> Let's split the common part in the pm.c and reuse it from the cpu_pm notifier.
>
> That is one more step forward to make the cpuidle driver arch indenpendant.

s/indenpendant/independent

>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |   21 ---------------------
>  arch/arm/mach-exynos/pm.c      |   22 ++++++++++++++++++----
>  2 files changed, 18 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index 7014654..635b09c 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -77,31 +77,10 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
>                                 struct cpuidle_driver *drv,
>                                 int index)
>  {
> -       unsigned long tmp;
> -
> -       /* Setting Central Sequence Register for power down mode */
> -       tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> -       tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
> -       __raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> -
>         cpu_pm_enter();
>         cpu_suspend(0, idle_finisher);
>         cpu_pm_exit();
>
> -       /*
> -        * If PMU failed while entering sleep mode, WFI will be
> -        * ignored by PMU and then exiting cpu_do_idle().
> -        * S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
> -        * in this situation.
> -        */
> -       tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> -       if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
> -               tmp |= S5P_CENTRAL_LOWPWR_CFG;
> -               __raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> -               /* Clear wakeup state register */
> -               __raw_writel(0x0, S5P_WAKEUP_STAT);
> -       }
> -
>         return index;
>  }
>
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 3f2ddef..b364212 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -301,15 +301,19 @@ static __init int exynos_pm_drvinit(void)
>  }
>  arch_initcall(exynos_pm_drvinit);
>
> -static int exynos_pm_suspend(void)
> +static void exynos_pm_central_suspend(void)
>  {
>         unsigned long tmp;
>
>         /* Setting Central Sequence Register for power down mode */
> -
>         tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
>         tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
>         __raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> +}
> +
> +static int exynos_pm_suspend(void)
> +{
> +       unsigned long tmp;
>
>         /* Setting SEQ_OPTION register */
>
> @@ -322,7 +326,7 @@ static int exynos_pm_suspend(void)
>         return 0;
>  }
>
> -static void exynos_pm_resume(void)
> +static int exynos_pm_central_resume(void)
>  {
>         unsigned long tmp;
>
> @@ -339,9 +343,17 @@ static void exynos_pm_resume(void)
>                 /* clear the wakeup state register */
>                 __raw_writel(0x0, S5P_WAKEUP_STAT);
>                 /* No need to perform below restore code */
> -               goto early_wakeup;
> +               return -1;
>         }
>
> +       return 0;
> +}
> +
> +static void exynos_pm_resume(void)
> +{
> +       if (exynos_pm_central_resume())
> +               goto early_wakeup;
> +
>         if (!soc_is_exynos5250())
>                 exynos_cpu_restore_register();
>
> @@ -385,6 +397,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
>  {
>         switch (cmd) {
>         case CPU_PM_ENTER:
> +               exynos_pm_central_suspend();
>                 exynos_cpu_save_register();
>                 exynos_set_wakeupmask();
>                 break;
> @@ -392,6 +405,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
>         case CPU_PM_EXIT:
>                 scu_enable(S5P_VA_SCU);
>                 exynos_cpu_restore_register();
> +               exynos_pm_central_resume();
>                 break;

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
