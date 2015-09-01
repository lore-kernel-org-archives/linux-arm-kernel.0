From: linux.amoon@gmail.com (Anand Moon)
Date: Tue, 1 Sep 2015 20:17:18 +0530
Subject: [PATCHv2] ARM: EXYNOS: reset Little cores when cpu is up
In-Reply-To: <1441117023-25478-1-git-send-email-parkch98@gmail.com>
References: <1441117023-25478-1-git-send-email-parkch98@gmail.com>
Message-ID: <CANAwSgSgXjsxrvvs=WNJ1aF+VQ9j-K23=CHMErRzKj1+owS+DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On 1 September 2015 at 19:47, Chanho Park <parkch98@gmail.com> wrote:
>
> The cpu booting of exynos5422 has been still broken since we discussed
> it in last year[1]. This patch is inspired from Odroid XU3
> code (Actually, it was from samsung exynos vendor kernel)[2]. This weird
> reset code was founded exynos5420 octa cores series SoCs and only
> required for the first boot core is the Little core (Cortex A7).
> Some of the exynos5420 boards and all of the exynos5422 boards will require
> this code.
>
> There is two ways to check the little core is the first cpu. One is
> checking GPG2CON[1] GPIO value and the other is checking the cluster
> number of the first cpu. I selected the latter because it's more easier
> than the former.
>
> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350632.html
> [2]:https://patchwork.kernel.org/patch/6782891/
>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Chanho Park <parkch98@gmail.com>
> ---
> Changes from v1:
>  .kfc to Little (Cortex A7) and eagle to big (Cortex A15)
>  .append comments about waiting SPARE2 register
>
> Changes since RFC:
>  .drop checking soc_is_exynos5800 to extend this codes to
> exynos5420/5422 boards.
>  .kfc cores will be reset only if the cpu0 is kfc core.
>  .Rebase top of the kukjin's for-next branch
>
>  arch/arm/mach-exynos/mcpm-exynos.c | 25 ++++++++++++++++++++++++-
>  arch/arm/mach-exynos/regs-pmu.h    |  6 ++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index 9bdf547..8926621 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -20,6 +20,7 @@
>  #include <asm/cputype.h>
>  #include <asm/cp15.h>
>  #include <asm/mcpm.h>
> +#include <asm/smp_plat.h>
>
>  #include "regs-pmu.h"
>  #include "common.h"
> @@ -70,7 +71,29 @@ static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
>                 cluster >= EXYNOS5420_NR_CLUSTERS)
>                 return -EINVAL;
>
> -       exynos_cpu_power_up(cpunr);
> +       if (!exynos_cpu_power_state(cpunr)) {
> +               exynos_cpu_power_up(cpunr);
> +
> +               /* This assumes the cluster number of the big cores(Cortex A15)
> +                * is 0 and the Little cores(Cortex A7) is 1.
> +                * When the system was booted from the Little core,
> +                * they should be reset during power up cpu.
> +                */
> +               if (cluster &&
> +                   cluster == MPIDR_AFFINITY_LEVEL(cpu_logical_map(0), 1)) {
> +                       /* Before we reset the Little cores, we should wait
> +                        * the SPARE2 register is set to 1 because the init
> +                        * codes of the iROM will set the register after
> +                        * initialization.
> +                        */
> +                       while (!pmu_raw_readl(S5P_PMU_SPARE2))
> +                               udelay(10);
> +
> +                       pmu_raw_writel(EXYNOS5420_KFC_CORE_RESET(cpu),
> +                                       EXYNOS_SWRESET);
> +               }
> +       }
> +
>         return 0;
>  }
>
> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
> index b761433..fba9068 100644
> --- a/arch/arm/mach-exynos/regs-pmu.h
> +++ b/arch/arm/mach-exynos/regs-pmu.h
> @@ -513,6 +513,12 @@ static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
>  #define SPREAD_ENABLE                                          0xF
>  #define SPREAD_USE_STANDWFI                                    0xF
>
> +#define EXYNOS5420_KFC_CORE_RESET0                             BIT(8)
> +#define EXYNOS5420_KFC_ETM_RESET0                              BIT(20)
> +
> +#define EXYNOS5420_KFC_CORE_RESET(_nr)                         \
> +       ((EXYNOS5420_KFC_CORE_RESET0 | EXYNOS5420_KFC_ETM_RESET0) << (_nr))
> +
>  #define EXYNOS5420_BB_CON1                                     0x0784
>  #define EXYNOS5420_BB_SEL_EN                                   BIT(31)
>  #define EXYNOS5420_BB_PMOS_EN                                  BIT(7)
> --
> 2.1.0
>

Looking at the following patch

https://github.com/tobiasjakobi/linux-odroid/commit/c25aae8a02c0e3132df581d1d12be1d6738a08d6

You should also consider some similar logic for platform_do_lowpower
and exynos_boot_secondary.
In that same way to address CPUIdle issue.

I am just trying to put my observation. I may be wrong.

-Anand Moon

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
