From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 8 Oct 2014 11:08:59 +0200
Subject: [PATCH v9] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <1412746892-12329-1-git-send-email-a.kesavan@samsung.com>
References: <1412746892-12329-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CABxcv=kh9F3nNDUFMv9CDCDch+A2wAE+bStegKGVbte9-Yu-wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On Wed, Oct 8, 2014 at 7:41 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> Use the MCPM layer to handle core suspend/resume on Exynos5420.
> Also, restore the entry address setup code post-resume.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---
> Changes in v2:
>         - Made use of the MCPM suspend/powered_up call-backs
> Changes in v3:
>         - Used the residency value to indicate the entered state
> Changes in v4:
>         - Checked if MCPM has been enabled to prevent build error
> Changes in v5:
>         - Removed the MCPM flags and just used a local flag to
>         indicate that we are suspending.
> Changes in v6:
>         - Read the SYS_PWR_REG value to decide if we are suspending
>         the system.
>         - Restore the SYS_PWR_REG value post-resume.
>         - Modified the comments to reflect the first change.
> Changes in v7:
>         - Add the suspend check in exynos_cpu_power_down() rather
>         than the MCPM back-end.
>         - Clean-up unnecessary changes related to earlier versions.
> Changes in v8:
>         - Rebased on the latest exynos PMU/PM support patches.
> Changes in v9:
>         - Fixed rebasing issues in v8
>         - Used pmu_raw_readl instead of __raw_readl
>
> This patch is based on kgene's for-next branch.
> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
>
> Here are the dependencies:
> 1) Decouple syscon interface from platform devices - v7
> http://lkml.org/lkml/2014/9/30/156
>
> 2) ARM: Exynos: Convert PMU implementation into a platform driver - v9
> https://lkml.org/lkml/2014/10/6/89
>
> 3) Exynos5420 PMU/S2R Series - v9
> http://www.spinics.net/lists/arm-kernel/msg368207.html
>
>  arch/arm/mach-exynos/mcpm-exynos.c |   32 +++++++++++++++--------
>  arch/arm/mach-exynos/platsmp.c     |   12 +++++++++
>  arch/arm/mach-exynos/suspend.c     |   49 ++++++++++++++++++++++++++++++++----
>  3 files changed, 78 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index dc9a764..b0d3c2e 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -15,6 +15,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/of_address.h>
> +#include <linux/syscore_ops.h>
>
>  #include <asm/cputype.h>
>  #include <asm/cp15.h>
> @@ -30,6 +31,8 @@
>  #define EXYNOS5420_USE_ARM_CORE_DOWN_STATE     BIT(29)
>  #define EXYNOS5420_USE_L2_COMMON_UP_STATE      BIT(30)
>
> +static void __iomem *ns_sram_base_addr;
> +
>  /*
>   * The common v7_exit_coherency_flush API could not be used because of the
>   * Erratum 799270 workaround. This macro is the same as the common one (in
> @@ -318,10 +321,26 @@ static const struct of_device_id exynos_dt_mcpm_match[] = {
>         {},
>  };
>
> +static void exynos_mcpm_setup_entry_point(void)
> +{
> +       /*
> +        * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
> +        * as part of secondary_cpu_start().  Let's redirect it to the
> +        * mcpm_entry_point(). This is done during both secondary boot-up as
> +        * well as system resume.
> +        */
> +       __raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
> +       __raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
> +       __raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
> +}
> +
> +static struct syscore_ops exynos_mcpm_syscore_ops = {
> +       .resume = exynos_mcpm_setup_entry_point,
> +};
> +
>  static int __init exynos_mcpm_init(void)
>  {
>         struct device_node *node;
> -       void __iomem *ns_sram_base_addr;
>         unsigned int value, i;
>         int ret;
>
> @@ -387,16 +406,9 @@ static int __init exynos_mcpm_init(void)
>                 pmu_raw_writel(value, EXYNOS_COMMON_OPTION(i));
>         }
>
> -       /*
> -        * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
> -        * as part of secondary_cpu_start().  Let's redirect it to the
> -        * mcpm_entry_point().
> -        */
> -       __raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
> -       __raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
> -       __raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
> +       exynos_mcpm_setup_entry_point();
>
> -       iounmap(ns_sram_base_addr);
> +       register_syscore_ops(&exynos_mcpm_syscore_ops);
>
>         return ret;
>  }
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index adb36a8..7a1ebfe 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -126,6 +126,18 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>   */
>  void exynos_cpu_power_down(int cpu)
>  {
> +       if (cpu == 0 && (of_machine_is_compatible("samsung,exynos5420") ||
> +               of_machine_is_compatible("samsung,exynos5800"))) {
> +               /*
> +                * Bypass power down for CPU0 during suspend. Check for
> +                * the SYS_PWR_REG value to decide if we are suspending
> +                * the system.
> +                */
> +               int val = pmu_raw_readl(EXYNOS5_ARM_CORE0_SYS_PWR_REG);
> +
> +               if (!(val & S5P_CORE_LOCAL_PWR_EN))
> +                       return;
> +       }
>         pmu_raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>  }
>
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index 8cef614..cc8d237 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -24,6 +24,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/firmware.h>
> +#include <asm/mcpm.h>
>  #include <asm/smp_scu.h>
>  #include <asm/suspend.h>
>
> @@ -72,6 +73,7 @@ struct exynos_pm_data {
>         unsigned int *release_ret_regs;
>
>         void (*pm_prepare)(void);
> +       void (*pm_resume_prepare)(void);
>         void (*pm_resume)(void);
>         int (*pm_suspend)(void);
>         int (*cpu_suspend)(unsigned long);
> @@ -172,9 +174,28 @@ static int exynos_cpu_suspend(unsigned long arg)
>
>  static int exynos5420_cpu_suspend(unsigned long arg)
>  {
> -       exynos_flush_cache_all();
> +       /* MCPM works with HW CPU identifiers */
> +       unsigned int mpidr = read_cpuid_mpidr();
> +       unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +       unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +
>         __raw_writel(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
> -       return exynos_cpu_do_idle();
> +
> +       if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM)) {
> +               mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
> +
> +               /*
> +                * Residency value passed to mcpm_cpu_suspend back-end
> +                * has to be given clear semantics. Set to 0 as a
> +                * temporary value.
> +                */
> +               mcpm_cpu_suspend(0);
> +       }
> +
> +       pr_info("Failed to suspend the system\n");
> +
> +       /* return value != 0 means failure */
> +       return 1;
>  }
>
>  static void exynos_pm_set_wakeup_mask(void)
> @@ -189,9 +210,6 @@ static void exynos_pm_enter_sleep_mode(void)
>         /* Set value of power down register for sleep mode */
>         exynos_sys_powerdown_conf(SYS_SLEEP);
>         pmu_raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
> -
> -       /* ensure at least INFORM0 has the resume address */
> -       pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
>  }
>
>  static void exynos_pm_prepare(void)
> @@ -206,6 +224,9 @@ static void exynos_pm_prepare(void)
>                                 pm_data->num_extra_save);
>
>         exynos_pm_enter_sleep_mode();
> +
> +       /* ensure at least INFORM0 has the resume address */
> +       pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
>  }
>
>  static void exynos5420_pm_prepare(void)
> @@ -230,6 +251,10 @@ static void exynos5420_pm_prepare(void)
>
>         exynos_pm_enter_sleep_mode();
>
> +       /* ensure at least INFORM0 has the resume address */
> +       if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM))
> +               pmu_raw_writel(virt_to_phys(mcpm_entry_point), S5P_INFORM0);
> +
>         tmp = pmu_raw_readl(EXYNOS5_ARM_L2_OPTION);
>         tmp &= ~EXYNOS5_USE_RETENTION;
>         pmu_raw_writel(tmp, EXYNOS5_ARM_L2_OPTION);
> @@ -318,10 +343,21 @@ early_wakeup:
>         pmu_raw_writel(0x0, S5P_INFORM1);
>  }
>
> +static void exynos5420_prepare_pm_resume(void)
> +{
> +       if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM))
> +               WARN_ON(mcpm_cpu_powered_up());
> +}
> +
>  static void exynos5420_pm_resume(void)
>  {
>         unsigned long tmp;
>
> +       /* Restore the CPU0 low power state register */
> +       tmp = pmu_raw_readl(EXYNOS5_ARM_CORE0_SYS_PWR_REG);
> +       pmu_raw_writel(tmp | S5P_CORE_LOCAL_PWR_EN,
> +               EXYNOS5_ARM_CORE0_SYS_PWR_REG);
> +
>         /* Restore the sysram cpu state register */
>         __raw_writel(exynos5420_cpu_state,
>                 sysram_base_addr + EXYNOS5420_CPU_STATE);
> @@ -391,6 +427,8 @@ static int exynos_suspend_enter(suspend_state_t state)
>         if (ret)
>                 return ret;
>
> +       if (pm_data->pm_resume_prepare)
> +               pm_data->pm_resume_prepare();
>         s3c_pm_restore_uarts();
>
>         S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
> @@ -448,6 +486,7 @@ static struct exynos_pm_data exynos5420_pm_data = {
>         .wkup_irq       = exynos5250_wkup_irq,
>         .wake_disable_mask = (0x7F << 7) | (0x1F << 1),
>         .release_ret_regs = exynos5420_release_ret_regs,
> +       .pm_resume_prepare = exynos5420_prepare_pm_resume,
>         .pm_resume      = exynos5420_pm_resume,
>         .pm_suspend     = exynos5420_pm_suspend,
>         .pm_prepare     = exynos5420_pm_prepare,
> --
> 1.7.9.5
>
> --

Patch looks good to me and also I tested on my Exynos5420 Peach Pit
and Suspend-to-Ram and resume is working correctly, so:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
