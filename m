From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 11 Jan 2013 19:35:04 -0800
Subject: [PATCH] arm: exynos4: Fix suspend/resume hang
In-Reply-To: <1357883278-26239-1-git-send-email-inderpal.singh@linaro.org>
References: <1357883278-26239-1-git-send-email-inderpal.singh@linaro.org>
Message-ID: <CAJuYYwQQuC4tgzy-umpyDHAUmLcROzq9ayZOico813Rssa+JvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 January 2013 21:47, Inderpal Singh <inderpal.singh@linaro.org> wrote:
> commit d0341c61a2 removed the l2 cache save/restore from pm.c and commit
> 7c6035b63b added the l2 cache restoration in sleep.s to early enable the
> cache in resume path.
>
> With these changes the system hangs while resuming when vdd_arm
> is turned off in suspended state. The cache needs to be invalidated
> before turning it on, as it was being done before mentioned commits.
>
> Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
> ---
>  arch/arm/mach-exynos/common.h     |    1 +
>  arch/arm/mach-exynos/pm.c         |    4 ++++
>  arch/arm/plat-samsung/s5p-sleep.S |   23 +++++++++++++++++++++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index af33872..056d9ce 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -78,6 +78,7 @@ enum sys_powerdown {
>  };
>
>  extern unsigned long l2x0_regs_phys;
> +extern unsigned long wake_reason_reg_phys;
>  struct exynos_pmu_conf {
>         void __iomem *reg;
>         unsigned int val[NUM_SYS_POWERDOWN];
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index f459afd..b10513c 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -220,6 +220,10 @@ static __init int exynos_pm_drvinit(void)
>
>         s3c_pm_init();
>
> +#ifdef CONFIG_CACHE_L2X0
> +       if (!soc_is_exynos5250() && !soc_is_exynos5440())
> +               wake_reason_reg_phys = virt_to_phys(S5P_INFORM1);
> +#endif
>         /* All wakeup disable */
>
>         tmp = __raw_readl(S5P_WAKEUP_MASK);
> diff --git a/arch/arm/plat-samsung/s5p-sleep.S b/arch/arm/plat-samsung/s5p-sleep.S
> index bdf6dad..74331e2 100644
> --- a/arch/arm/plat-samsung/s5p-sleep.S
> +++ b/arch/arm/plat-samsung/s5p-sleep.S
> @@ -24,6 +24,7 @@
>  #include <linux/linkage.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/hardware/cache-l2x0.h>
> +#include <mach/regs-pmu.h>
>
>  /*
>   *      The following code is located into the .data section. This is to
> @@ -67,6 +68,25 @@ ENTRY(s3c_cpu_resume)
>         str     r2, [r1, #L2X0_PREFETCH_CTRL]
>         ldr     r2, [r0, #L2X0_R_PWR_CTRL]
>         str     r2, [r1, #L2X0_POWER_CTRL]
> +
> +        /* check resume reason */
> +       adr     r0, wake_reason_reg_phys
> +       ldr     r0, [r0]
> +       ldr     r2, [r0]
> +       ldr     r0, =S5P_CHECK_SLEEP
> +       cmp     r0, r2
> +       bne     turn_cache_on
> +
> +       /* Invalidate the cache if resume from sleep */
> +       ldr     r2, =0xffff
> +       str     r2, [r1, #L2X0_INV_WAY]
> +wait:
> +       ldr     r2, [r1, #L2X0_INV_WAY]
> +       ldr     r0, =0xffff
> +       ands    r2, r2, r0
> +       bne     wait
> +
> +turn_cache_on:
>         mov     r2, #1
>         str     r2, [r1, #L2X0_CTRL]
>  resume_l2on:
> @@ -77,4 +97,7 @@ ENDPROC(s3c_cpu_resume)
>         .globl l2x0_regs_phys
>  l2x0_regs_phys:
>         .long   0
> +       .globl wake_reason_reg_phys
> +wake_reason_reg_phys:
> +       .long   0
>  #endif


Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
