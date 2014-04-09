From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 14:29:02 +0200
Subject: [PATCH V3 16/17] ARM: exynos: cpuidle: Pass the AFTR callback to
 the platform_data
In-Reply-To: <1396959579-18268-17-git-send-email-daniel.lezcano@linaro.org>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
 <1396959579-18268-17-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <53453D0E.40904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 08.04.2014 14:19, Daniel Lezcano wrote:
> No more dependency on the arch code. The platform_data field is used to set the
> PM callback as the other cpuidle drivers.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   arch/arm/mach-exynos/common.h  |    1 +
>   arch/arm/mach-exynos/cpuidle.c |    6 ++++--
>   arch/arm/mach-exynos/exynos.c  |    5 +++--
>   arch/arm/mach-exynos/pmu.c     |    6 ++++++
>   4 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 9ef3f83..7d9432e 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -62,5 +62,6 @@ struct exynos_pmu_conf {
>   };
>
>   extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
> +extern void exynos_sys_powerdown_aftr(void);
>
>   #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index a1f111e..25d2fad 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -16,12 +16,12 @@
>   #include <asm/suspend.h>
>   #include <asm/cpuidle.h>
>
> -#include "common.h"
> +static void (*exynos_aftr)(void);
>
>   static int idle_finisher(unsigned long flags)
>   {
>   	/* Set value of power down register for aftr mode */
> -	exynos_sys_powerdown_conf(SYS_AFTR);
> +	exynos_aftr();
>   	cpu_do_idle();
>   	return 1;
>   }
> @@ -75,6 +75,8 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
>   {
>   	int ret;
>
> +	exynos_aftr = (void *)(pdev->dev.platform_data);
> +
>   	ret = cpuidle_register(&exynos_idle_driver, NULL);
>   	if (ret) {
>   		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index fe8dac8..a7ab561 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -221,8 +221,9 @@ void exynos_restart(enum reboot_mode mode, const char *cmd)
>   }
>
>   static struct platform_device exynos_cpuidle = {
> -	.name		= "exynos_cpuidle",
> -	.id		= -1,
> +	.name              = "exynos_cpuidle",
> +	.dev.platform_data = exynos_sys_powerdown_aftr,
> +	.id                = -1,
>   };
>
>   void __init exynos_cpuidle_init(void)
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index 05c7ce1..fd1ae22 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -389,6 +389,12 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>   	}
>   }
>
> +/* Set value of power down register for aftr mode */
> +void exynos_sys_powerdown_aftr(void)
> +{
> +	exynos_sys_powerdown_conf(SYS_AFTR);

I wonder if this callback wouldn't be more appropriate for setting idle 
mode specific things like wake-up mask and boot flag.

Best regards,
Tomasz
