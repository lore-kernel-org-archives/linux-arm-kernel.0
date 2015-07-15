From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 15 Jul 2015 20:35:43 +0900
Subject: [RFC] ARM: EXYNOS: reset KFC cores when cpu is up
In-Reply-To: <1436924213-29732-1-git-send-email-parkch98@gmail.com>
References: <1436924213-29732-1-git-send-email-parkch98@gmail.com>
Message-ID: <CAJKOXPdcdREhwQZ22RcqbUSTpOn0XmqJ_3n5uUyzEgPihRYwNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-15 10:36 GMT+09:00 Chanho Park <parkch98@gmail.com>:
> The cpu booting of exynos5422 has been still broken since we discussed
> it in last year[1]. I found this resetting codes from odroid-xu3 kernel of
> hardkernel, it could help to boot 8 cores well. This patch need to have
> more test like STR and other SoC especially exynos5800 which is variant
> of exynos5422. If this patch is broken on exynos5800, I'll find another
> way to check exynos5422.
>
> This patch is top of my previous exynos5422 cpu ordering patch[2] and
> need to enable CONFIG_EXYNOS5420_MCPM=y
>
> [    0.047509] CPU0: update cpu_capacity 448
> [    0.047534] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
> [    0.047874] Setting up static identity map for 0x400082c0 -
> 0x40008318
> [    0.048340] ARM CCI driver probed
> [    0.048597] Exynos MCPM support installed
> [    0.065676] CPU1: update cpu_capacity 448
> [    0.065685] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
> [    0.070672] CPU2: update cpu_capacity 448
> [    0.070680] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
> [    0.075644] CPU3: update cpu_capacity 448
> [    0.075653] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
> [    0.080590] CPU4: update cpu_capacity 1535
> [    0.080600] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.085591] CPU5: update cpu_capacity 1535
> [    0.085599] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.090590] CPU6: update cpu_capacity 1535
> [    0.090598] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.095585] CPU7: update cpu_capacity 1535
> [    0.095593] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.095720] Brought up 8 CPUs
>
> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350632.html
> [2]:https://patchwork.kernel.org/patch/6782891/

Few questions/issues:
1. For the proper patch the commit message needs to be fixed a little.
The dmesg above is meaningless but instead you can put short dmesg (2
or 4 lines) with failed booting of CPUs.
2. Why only MCPM? Isn't this also needed without MCPM?

>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Heesub Shin <heesub.shin@samsung.com>
> Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
> Cc: Przemyslaw Marczak <p.marczak@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Chanho Park <parkch98@gmail.com>

I think both Chanho Parks are the same person :) so you may leave only
one (the one matching "From").

> ---
>  arch/arm/mach-exynos/mcpm-exynos.c | 13 ++++++++++++-
>  arch/arm/mach-exynos/regs-pmu.h    |  6 ++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index 9bdf547..a076dde 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -70,7 +70,18 @@ static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
>                 cluster >= EXYNOS5420_NR_CLUSTERS)
>                 return -EINVAL;
>
> -       exynos_cpu_power_up(cpunr);
> +       if (!exynos_cpu_power_state(cpunr)) {
> +               exynos_cpu_power_up(cpunr);

This second exynos_cpu_power_up() is needed? Do you know why?

> +
> +               if (soc_is_exynos5800() && cluster) {

If of_machine_is_compatible() can be used then please use it. Javier
also mentioned it and he pointed that this is not necessary on
Chromebooks.

> +                       while (!pmu_raw_readl(S5P_PMU_SPARE2))
> +                               udelay(10);
> +
> +                       pmu_raw_writel(EXYNOS5420_KFC_CORE_RESET(cpu),
> +                                       EXYNOS_SWRESET);

This is quite similar to existing exynos_core_restart(). Can you
extend it for this purpose? Or at least put it as separate function
near exynos_core_restart() so this would be grouped close to each
other?

Documenting this behaviour would be really nice (you can combine some
of my findings on SPARE2 from previous discussion, if they are useful
of course).

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
