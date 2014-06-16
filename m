From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 16 Jun 2014 09:37:14 +0530
Subject: [PATCH] arm: exynos: Modify pm code to check for cortex A9 rather
 than the SoC
In-Reply-To: <1400814061-12813-1-git-send-email-a.kesavan@samsung.com>
References: <1400814061-12813-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAM4voa=3zzo-2KbjDtBOca+uJeSxT2OYpi+rJuSGsDg-vo7GYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Fri, May 23, 2014 at 8:31 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> We have an soc check to ensure that the scu and certain A9 specific
> registers are not accessed on Exynos5250 (which is A15 based).
> Rather than adding another soc specific check for 5420 let us test
> for the Cortex A9 primary part number.
>
> This resolves the below crash seen on exynos5420 during core switching
> after the CPUIdle consolidation series was merged.
>
> [  155.975589] [<c0013174>] (scu_enable) from [<c001b0dc>] (exynos_cpu_pm_notifier+0x80/0xc4)
> [  155.983833] [<c001b0dc>] (exynos_cpu_pm_notifier) from [<c003c1b0>] (notifier_call_chain+0x44/0x84)
> [  155.992851] [<c003c1b0>] (notifier_call_chain) from [<c007a49c>] (cpu_pm_notify+0x20/0x3c)
> [  156.001089] [<c007a49c>] (cpu_pm_notify) from [<c007a564>] (cpu_pm_exit+0x20/0x38)
> [  156.008635] [<c007a564>] (cpu_pm_exit) from [<c0019e98>] (bL_switcher_thread+0x298/0x40c)
> [  156.016788] [<c0019e98>] (bL_switcher_thread) from [<c003842c>] (kthread+0xcc/0xe8)
> [  156.024426] [<c003842c>] (kthread) from [<c000e438>] (ret_from_fork+0x14/0x3c)
> [  156.031621] Code: ea017fec c0530a00 c052e3f8 c0012dcc (e5903000
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

Do you have any comments on this patch ?

Regards,
Abhilash
> ---
>  arch/arm/mach-exynos/pm.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index d10c351..6dd4a11 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -300,7 +300,7 @@ static int exynos_pm_suspend(void)
>         tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>         __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>
> -       if (!soc_is_exynos5250())
> +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>                 exynos_cpu_save_register();
>
>         return 0;
> @@ -334,7 +334,7 @@ static void exynos_pm_resume(void)
>         if (exynos_pm_central_resume())
>                 goto early_wakeup;
>
> -       if (!soc_is_exynos5250())
> +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>                 exynos_cpu_restore_register();
>
>         /* For release retention */
> @@ -353,7 +353,7 @@ static void exynos_pm_resume(void)
>
>         s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>
> -       if (!soc_is_exynos5250())
> +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>                 scu_enable(S5P_VA_SCU);
>
>  early_wakeup:
> @@ -440,15 +440,18 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
>         case CPU_PM_ENTER:
>                 if (cpu == 0) {
>                         exynos_pm_central_suspend();
> -                       exynos_cpu_save_register();
> +                       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> +                               exynos_cpu_save_register();
>                 }
>                 break;
>
>         case CPU_PM_EXIT:
>                 if (cpu == 0) {
> -                       if (!soc_is_exynos5250())
> +                       if (read_cpuid_part_number() ==
> +                                       ARM_CPU_PART_CORTEX_A9) {
>                                 scu_enable(S5P_VA_SCU);
> -                       exynos_cpu_restore_register();
> +                               exynos_cpu_restore_register();
> +                       }
>                         exynos_pm_central_resume();
>                 }
>                 break;
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
