From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 6 Oct 2014 09:10:32 +0530
Subject: [PATCH v8] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <1412089142-12056-1-git-send-email-a.kesavan@samsung.com>
References: <1412089142-12056-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAM4voa=oZmqCf5=nD54cbi_fa4iHYh1nvOC0nt9hE=mQmhb3yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

[...]

> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index adb36a8..222aa3c 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -137,6 +137,18 @@ void exynos_cpu_power_down(int cpu)
>   */
>  void exynos_cpu_power_up(int cpu)
>  {
> +       if (cpu == 0 && (of_machine_is_compatible("samsung,exynos5420") ||
> +               of_machine_is_compatible("samsung,exynos5800"))) {
> +               /*
> +                * Bypass power down for CPU0 during suspend. Check for
> +                * the SYS_PWR_REG value to decide if we are suspending
> +                * the system.
> +                */
> +               int val = __raw_readl(pmu_base_addr +
> +                               EXYNOS5_ARM_CORE0_SYS_PWR_REG);
> +               if (!(val & S5P_CORE_LOCAL_PWR_EN))
> +                       return;
> +       }
>         pmu_raw_writel(S5P_CORE_LOCAL_PWR_EN,
>                         EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>  }

The above block of code should be in exynos_cpu_power_down(). Can you
re-test s2r after modifying it ? I have to convert a __raw_readl to
pmu_raw_readl in this patch as well. Once Vikas re-works the base s2r
patch I will re-post a v9.

Regards,
Abhilash
