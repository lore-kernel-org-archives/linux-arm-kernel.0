From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 1 May 2014 15:09:46 +0530
Subject: [PATCH v3 5/6] arm: exynos: Add MCPM call-back functions
In-Reply-To: <20140430145911.GA32671@e102568-lin.cambridge.arm.com>
References: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
 <1398528348-21214-6-git-send-email-a.kesavan@samsung.com>
 <20140430145911.GA32671@e102568-lin.cambridge.arm.com>
Message-ID: <CAM4voanN3qxa+VB3h39L5MbPQOAtF5_D=zssfJM2qV+Xkt0pCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Wed, Apr 30, 2014 at 8:29 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Sat, Apr 26, 2014 at 05:05:47PM +0100, Abhilash Kesavan wrote:
>
> [...]
>
>> +       if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
>> +               arch_spin_unlock(&exynos_mcpm_lock);
>> +
>
> I missed it on first review, but you do need to disable L2 prefetching
> on A15 here as we do in TC2 (tc2_pm.c), this power down procedure is not
> compliant otherwise.
OK, I see this as being part of the power down sequence described in
A15 TRM, will add.

Regards,
Abhilash
>
> Thanks,
> Lorenzo
>
>> +               /* Flush all cache levels for this cluster. */
>> +               exynos_v7_exit_coherency_flush(all);
>> +
>> +               /*
>> +                * Disable cluster-level coherency by masking
>> +                * incoming snoops and DVM messages:
>> +                */
>> +               cci_disable_port_by_cpu(mpidr);
>> +
>> +               __mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
>> +       } else {
>> +               arch_spin_unlock(&exynos_mcpm_lock);
>> +
>> +               /* Disable and flush the local CPU cache. */
>> +               exynos_v7_exit_coherency_flush(louis);
>> +       }
>> +
>> +       __mcpm_cpu_down(cpu, cluster);
>> +
>> +       /* Now we are prepared for power-down, do it: */
>> +       if (!skip_wfi)
>> +               wfi();
>> +
>> +       /* Not dead at this point?  Let our caller cope. */
>> +}
>> +
>> +static int exynos_power_down_finish(unsigned int cpu, unsigned int cluster)
>> +{
>> +       unsigned int tries = 100;
>> +       unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
>> +
>> +       pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +       BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
>> +                       cluster >= EXYNOS5420_NR_CLUSTERS);
>> +
>> +       /* Wait for the core state to be OFF */
>> +       while (tries--) {
>> +               if (ACCESS_ONCE(cpu_use_count[cpu][cluster]) == 0) {
>> +                       if ((exynos_cpu_power_state(cpunr) == 0))
>> +                               return 0; /* success: the CPU is halted */
>> +               }
>> +
>> +               /* Otherwise, wait and retry: */
>> +               msleep(1);
>> +       }
>> +
>> +       return -ETIMEDOUT; /* timeout */
>> +}
>> +
>> +static const struct mcpm_platform_ops exynos_power_ops = {
>> +       .power_up               = exynos_power_up,
>> +       .power_down             = exynos_power_down,
>> +       .power_down_finish      = exynos_power_down_finish,
>> +};
>> +
>> +static void __init exynos_mcpm_usage_count_init(void)
>> +{
>> +       unsigned int mpidr, cpu, cluster;
>> +
>> +       mpidr = read_cpuid_mpidr();
>> +       cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +       cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +
>> +       pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +       BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER  ||
>> +                       cluster >= EXYNOS5420_NR_CLUSTERS);
>> +
>> +       cpu_use_count[cpu][cluster] = 1;
>> +}
>> +
>> +/*
>> + * Enable cluster-level coherency, in preparation for turning on the MMU.
>> + */
>> +static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
>> +{
>> +       asm volatile ("\n"
>> +       "cmp    r0, #1\n"
>> +       "bxne   lr\n"
>> +       "b      cci_enable_port_for_self");
>> +}
>> +
>> +static int __init exynos_mcpm_init(void)
>> +{
>> +       int ret = 0;
>> +
>> +       if (!soc_is_exynos5420())
>> +               return -ENODEV;
>> +
>> +       if (!cci_probed())
>> +               return -ENODEV;
>> +
>> +       /*
>> +        * To increase the stability of KFC reset we need to program
>> +        * the PMU SPARE3 register
>> +        */
>> +       __raw_writel(EXYNOS5420_SWRESET_KFC_SEL, S5P_PMU_SPARE3);
>> +
>> +       exynos_mcpm_usage_count_init();
>> +
>> +       ret = mcpm_platform_register(&exynos_power_ops);
>> +       if (!ret)
>> +               ret = mcpm_sync_init(exynos_pm_power_up_setup);
>> +       if (ret)
>> +               return ret;
>> +
>> +       mcpm_smp_set_ops();
>> +
>> +       pr_info("Exynos MCPM support installed\n");
>> +
>> +       /*
>> +        * Future entries into the kernel can now go
>> +        * through the cluster entry vectors.
>> +        */
>> +       __raw_writel(virt_to_phys(mcpm_entry_point),
>> +               REG_ENTRY_ADDR);
>> +
>> +       return ret;
>> +}
>> +
>> +early_initcall(exynos_mcpm_init);
>> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
>> index 6685ebf..f44d318 100644
>> --- a/arch/arm/mach-exynos/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/regs-pmu.h
>> @@ -38,6 +38,7 @@
>>  #define S5P_INFORM5                            S5P_PMUREG(0x0814)
>>  #define S5P_INFORM6                            S5P_PMUREG(0x0818)
>>  #define S5P_INFORM7                            S5P_PMUREG(0x081C)
>> +#define S5P_PMU_SPARE3                         S5P_PMUREG(0x090C)
>>
>>  #define S5P_ARM_CORE0_LOWPWR                   S5P_PMUREG(0x1000)
>>  #define S5P_DIS_IRQ_CORE0                      S5P_PMUREG(0x1004)
>> @@ -325,4 +326,6 @@
>>
>>  #define EXYNOS5_OPTION_USE_RETENTION                           (1 << 4)
>>
>> +#define EXYNOS5420_SWRESET_KFC_SEL                             0x3
>> +
>>  #endif /* __ASM_ARCH_REGS_PMU_H */
>> --
>> 1.8.3.2
>>
>>
>
