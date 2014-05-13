From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 13 May 2014 17:48:45 +0100
Subject: [PATCH v6 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <1399982324-27879-6-git-send-email-a.kesavan@samsung.com>
References: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
 <1399982324-27879-6-git-send-email-a.kesavan@samsung.com>
Message-ID: <20140513164845.GA10210@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 12:58:44PM +0100, Abhilash Kesavan wrote:

[...]

> +static int __init exynos_mcpm_init(void)
> +{
> +       struct device_node *node;
> +       int ret = 0;

There is no point in initializing it to 0.

> +
> +       node = of_find_compatible_node(NULL, NULL, "samsung,exynos5420");
> +       if (!node)
> +               return -ENODEV;
> +       of_node_put(node);
> +
> +       if (!cci_probed())
> +               return -ENODEV;
> +
> +       node = of_find_compatible_node(NULL, NULL,
> +                       "samsung,exynos4210-sysram-ns");
> +       if (!node)
> +               return -ENODEV;
> +
> +       ns_sram_base_addr = of_iomap(node, 0);
> +       of_node_put(node);
> +       if (!ns_sram_base_addr) {
> +               pr_err("failed to map non-secure iRAM base address\n");
> +               return -ENOMEM;
> +       }
> +
> +       /*
> +        * To increase the stability of KFC reset we need to program
> +        * the PMU SPARE3 register
> +        */
> +       __raw_writel(EXYNOS5420_SWRESET_KFC_SEL, S5P_PMU_SPARE3);
> +
> +       exynos_mcpm_usage_count_init();
> +
> +       ret = mcpm_platform_register(&exynos_power_ops);
> +       if (!ret)
> +               ret = mcpm_sync_init(exynos_pm_power_up_setup);
> +       if (ret) {
> +               iounmap(ns_sram_base_addr);
> +               return ret;
> +       }
> +
> +       mcpm_smp_set_ops();
> +
> +       pr_info("Exynos MCPM support installed\n");
> +
> +       /*
> +        * Future entries into the kernel can now go
> +        * through the cluster entry vectors.
> +        */
> +       __raw_writel(virt_to_phys(mcpm_entry_point),
> +                       ns_sram_base_addr + MCPM_BOOT_ADDR_OFFSET);
> +

ns_sram_base_addr must be unmapped, since it is unused after the write.

Lorenzo

> +       return ret;
> +}
> +
> +early_initcall(exynos_mcpm_init);
> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
> index f6b68a3..4179f6a 100644
> --- a/arch/arm/mach-exynos/regs-pmu.h
> +++ b/arch/arm/mach-exynos/regs-pmu.h
> @@ -38,6 +38,7 @@
>  #define S5P_INFORM5                            S5P_PMUREG(0x0814)
>  #define S5P_INFORM6                            S5P_PMUREG(0x0818)
>  #define S5P_INFORM7                            S5P_PMUREG(0x081C)
> +#define S5P_PMU_SPARE3                         S5P_PMUREG(0x090C)
> 
>  #define S5P_ARM_CORE0_LOWPWR                   S5P_PMUREG(0x1000)
>  #define S5P_DIS_IRQ_CORE0                      S5P_PMUREG(0x1004)
> @@ -322,4 +323,6 @@
> 
>  #define EXYNOS5_OPTION_USE_RETENTION                           (1 << 4)
> 
> +#define EXYNOS5420_SWRESET_KFC_SEL                             0x3
> +
>  #endif /* __ASM_ARCH_REGS_PMU_H */
> --
> 1.7.9.5
> 
> 
