From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 6 Oct 2014 09:03:07 +0530
Subject: [PATCH v8 2/2] ARM: exynos5: Add Suspend-to-RAM support for 5420
In-Reply-To: <1412074969-12704-3-git-send-email-vikas.sajjan@samsung.com>
References: <1412074969-12704-1-git-send-email-vikas.sajjan@samsung.com>
 <1412074969-12704-3-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAM4voakE0nkTjdhqLdCgZ_T-MJ-Qs51FHwP1Y8_rNyZ5REZqKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

[...]

> +static void exynos5420_pm_resume(void)
> +{
> +       unsigned long tmp;
> +
> +       /* Restore the CPU0 low power state register */
> +       tmp = pmu_raw_readl(EXYNOS5_ARM_CORE0_SYS_PWR_REG);
> +       pmu_raw_writel(tmp | S5P_CORE_LOCAL_PWR_EN,
> +                       EXYNOS5_ARM_CORE0_SYS_PWR_REG);

I think these lines were accidentally added to this patch, please
remove them. I have a couple of changes to make in my s2r patch which
I will post once you send a new version.

Regards,
Abhilash
> +
> +       /* Restore the sysram cpu state register */
> +       __raw_writel(exynos5420_cpu_state,
> +               sysram_base_addr + EXYNOS5420_CPU_STATE);
> +
> +       pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
> +                       S5P_CENTRAL_SEQ_OPTION);
> +
> +       if (exynos_pm_central_resume())
> +               goto early_wakeup;
> +
> +       /* For release retention */
> +       exynos_pm_release_retention();
> +
> +       pmu_raw_writel(exynos_pmu_spare3, S5P_PMU_SPARE3);
> +
> +       s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
> +
> +early_wakeup:
> +
> +       tmp = pmu_raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
> +       tmp &= ~EXYNOS5420_UFS;
> +       pmu_raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
> +
> +       tmp = pmu_raw_readl(EXYNOS5420_FSYS2_OPTION);
> +       tmp &= ~EXYNOS5420_EMULATION;
> +       pmu_raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
> +
> +       tmp = pmu_raw_readl(EXYNOS5420_PSGEN_OPTION);
> +       tmp &= ~EXYNOS5420_EMULATION;
> +       pmu_raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
> +
> +       /* Clear SLEEP mode set in INFORM1 */
> +       pmu_raw_writel(0x0, S5P_INFORM1);
> +}
> +
>  /*
>   * Suspend Ops
>   */
> @@ -310,6 +449,16 @@ static const struct exynos_pm_data exynos5250_pm_data = {
>         .cpu_suspend    = exynos_cpu_suspend,
>  };
>
> +static struct exynos_pm_data exynos5420_pm_data = {
> +       .wkup_irq       = exynos5250_wkup_irq,
> +       .wake_disable_mask = (0x7F << 7) | (0x1F << 1),
> +       .release_ret_regs = exynos5420_release_ret_regs,
> +       .pm_resume      = exynos5420_pm_resume,
> +       .pm_suspend     = exynos5420_pm_suspend,
> +       .pm_prepare     = exynos5420_pm_prepare,
> +       .cpu_suspend    = exynos5420_cpu_suspend,
> +};
> +
>  static struct of_device_id exynos_pmu_of_device_ids[] = {
>         {
>                 .compatible = "samsung,exynos4210-pmu",
> @@ -323,6 +472,9 @@ static struct of_device_id exynos_pmu_of_device_ids[] = {
>         }, {
>                 .compatible = "samsung,exynos5250-pmu",
>                 .data = &exynos5250_pm_data,
> +       }, {
> +               .compatible = "samsung,exynos5420-pmu",
> +               .data = &exynos5420_pm_data,
>         },
>         { /*sentinel*/ },
>  };
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
