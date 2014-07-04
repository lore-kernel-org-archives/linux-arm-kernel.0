From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Sat, 5 Jul 2014 02:51:56 +0530
Subject: [PATCH v7] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <alpine.LFD.2.11.1407041659330.22282@knanqh.ubzr>
References: <1404496024-7113-1-git-send-email-a.kesavan@samsung.com>
 <1404503133-19760-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1407041659330.22282@knanqh.ubzr>
Message-ID: <CAM4voa=13pvayq2d1Om9U5gCd6Nqf-T8OvuAQ6cbeerGK1fgrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 5, 2014 at 2:30 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sat, 5 Jul 2014, Abhilash Kesavan wrote:
>
>> Use the MCPM layer to handle core suspend/resume on Exynos5420.
>> Also, restore the entry address setup code post-resume.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
This is one of the last missing bits for exynos MCPM. Thanks for your
patient reviews of all the exynos mcpm back-end patches.

Regards,
Abhilash
>
>
>> ---
>> Changes in v2:
>>       - Made use of the MCPM suspend/powered_up call-backs
>> Changes in v3:
>>       - Used the residency value to indicate the entered state
>> Changes in v4:
>>       - Checked if MCPM has been enabled to prevent build error
>> Changes in v5:
>>       - Removed the MCPM flags and just used a local flag to
>>       indicate that we are suspending.
>> Changes in v6:
>>       - Read the SYS_PWR_REG value to decide if we are suspending
>>       the system.
>>       - Restore the SYS_PWR_REG value post-resume.
>>       - Modified the comments to reflect the first change.
>> Changes in v7:
>>       - Add the suspend check in exynos_cpu_power_down() rather
>>       than the MCPM back-end.
>>       - Clean-up unnecessary changes related to earlier versions.
>>
>> This has been tested both on an SMDK5420 and Peach Pit Chromebook on
>> next-20140704. Nicolas' boot cluster CCI enablement patches are in
>> linux-next now.
>>
>> Here are the dependencies (some of these patches did not apply cleanly):
>> 1) Cleanup patches for mach-exynos
>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/33772
>>
>> 2) PMU cleanup and refactoring for using DT
>> https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg671625.html
>>
>> 3) Exynos5420 PMU/S2R Series
>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/33898
>>
>> 4) Exynos5420 CPUIdle Series which populates MCPM suspend/powered_up
>> call-backs.
>> www.gossamer-threads.com/lists/linux/kernel/1945347
>> https://patchwork.kernel.org/patch/4357461/
>>
>> 5) Exynos5420 MCPM cluster power down support
>> http://www.spinics.net/lists/arm-kernel/msg339988.html
>>
>> 6) TPM reset mask patch
>> http://www.spinics.net/lists/arm-kernel/msg341884.html
>>
>>  arch/arm/mach-exynos/mcpm-exynos.c | 32 +++++++++++++++-------
>>  arch/arm/mach-exynos/pm.c          | 54 ++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 74 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
>> index 2dd51cc..74ad772 100644
>> --- a/arch/arm/mach-exynos/mcpm-exynos.c
>> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/io.h>
>>  #include <linux/of_address.h>
>> +#include <linux/syscore_ops.h>
>>
>>  #include <asm/cputype.h>
>>  #include <asm/cp15.h>
>> @@ -30,6 +31,8 @@
>>  #define EXYNOS5420_USE_ARM_CORE_DOWN_STATE   BIT(29)
>>  #define EXYNOS5420_USE_L2_COMMON_UP_STATE    BIT(30)
>>
>> +static void __iomem *ns_sram_base_addr;
>> +
>>  /*
>>   * The common v7_exit_coherency_flush API could not be used because of the
>>   * Erratum 799270 workaround. This macro is the same as the common one (in
>> @@ -319,10 +322,26 @@ static const struct of_device_id exynos_dt_mcpm_match[] = {
>>       {},
>>  };
>>
>> +static void exynos_mcpm_setup_entry_point(void)
>> +{
>> +     /*
>> +      * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
>> +      * as part of secondary_cpu_start().  Let's redirect it to the
>> +      * mcpm_entry_point(). This is done during both secondary boot-up as
>> +      * well as system resume.
>> +      */
>> +     __raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
>> +     __raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
>> +     __raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
>> +}
>> +
>> +static struct syscore_ops exynos_mcpm_syscore_ops = {
>> +     .resume = exynos_mcpm_setup_entry_point,
>> +};
>> +
>>  static int __init exynos_mcpm_init(void)
>>  {
>>       struct device_node *node;
>> -     void __iomem *ns_sram_base_addr;
>>       unsigned int value, i;
>>       int ret;
>>
>> @@ -389,16 +408,9 @@ static int __init exynos_mcpm_init(void)
>>               __raw_writel(value, pmu_base_addr + EXYNOS_COMMON_OPTION(i));
>>       }
>>
>> -     /*
>> -      * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
>> -      * as part of secondary_cpu_start().  Let's redirect it to the
>> -      * mcpm_entry_point().
>> -      */
>> -     __raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
>> -     __raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
>> -     __raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
>> +     exynos_mcpm_setup_entry_point();
>>
>> -     iounmap(ns_sram_base_addr);
>> +     register_syscore_ops(&exynos_mcpm_syscore_ops);
>>
>>       return ret;
>>  }
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index 69cf678..e2ba1e5 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -24,6 +24,7 @@
>>
>>  #include <asm/cacheflush.h>
>>  #include <asm/hardware/cache-l2x0.h>
>> +#include <asm/mcpm.h>
>>  #include <asm/smp_scu.h>
>>  #include <asm/suspend.h>
>>
>> @@ -123,6 +124,17 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
>>   */
>>  void exynos_cpu_power_down(int cpu)
>>  {
>> +     if (soc_is_exynos5420() && cpu == 0) {
>> +             /*
>> +              * Bypass power down for CPU0 during suspend. Check for
>> +              * the SYS_PWR_REG value to decide if we are suspending
>> +              * the system.
>> +              */
>> +             int val = __raw_readl(pmu_base_addr +
>> +                             EXYNOS5_ARM_CORE0_SYS_PWR_REG);
>> +             if (!(val & S5P_CORE_LOCAL_PWR_EN))
>> +                     return;
>> +     }
>>       pmu_raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>>  }
>>
>> @@ -318,7 +330,10 @@ static void exynos_pm_prepare(void)
>>
>>       /* ensure at least INFORM0 has the resume address */
>>
>> -     pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
>> +     if (soc_is_exynos5420() && IS_ENABLED(CONFIG_MCPM))
>> +             pmu_raw_writel(virt_to_phys(mcpm_entry_point), S5P_INFORM0);
>> +     else
>> +             pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
>>
>>       if (soc_is_exynos5420()) {
>>               tmp = __raw_readl(pmu_base_addr + EXYNOS5_ARM_L2_OPTION);
>> @@ -408,6 +423,12 @@ static void exynos_pm_resume(void)
>>       unsigned int tmp;
>>
>>       if (soc_is_exynos5420()) {
>> +             /* Restore the CPU0 low power state register */
>> +             tmp = __raw_readl(pmu_base_addr +
>> +                     EXYNOS5_ARM_CORE0_SYS_PWR_REG);
>> +             pmu_raw_writel(tmp | S5P_CORE_LOCAL_PWR_EN,
>> +                     EXYNOS5_ARM_CORE0_SYS_PWR_REG);
>> +
>>               /* Restore the sysram cpu state register */
>>               __raw_writel(exynos5420_cpu_state,
>>               sysram_base_addr + EXYNOS5420_CPU_STATE);
>> @@ -490,6 +511,28 @@ static struct syscore_ops exynos_pm_syscore_ops = {
>>       .resume         = exynos_pm_resume,
>>  };
>>
>> +static int notrace exynos_mcpm_cpu_suspend(unsigned long arg)
>> +{
>> +     /* MCPM works with HW CPU identifiers */
>> +     unsigned int mpidr = read_cpuid_mpidr();
>> +     unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +     unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +
>> +     __raw_writel(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
>> +
>> +     mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
>> +
>> +     /*
>> +      * Residency value passed to mcpm_cpu_suspend back-end
>> +      * has to be given clear semantics. Set to 0 as a
>> +      * temporary value.
>> +      */
>> +     mcpm_cpu_suspend(0);
>> +
>> +     /* return value != 0 means failure */
>> +     return 1;
>> +}
>> +
>>  /*
>>   * Suspend Ops
>>   */
>> @@ -517,10 +560,17 @@ static int exynos_suspend_enter(suspend_state_t state)
>>       flush_cache_all();
>>       s3c_pm_check_store();
>>
>> -     ret = cpu_suspend(0, exynos_cpu_suspend);
>> +     /* Use the MCPM layer to suspend 5420 which is a multi-cluster SoC */
>> +     if (soc_is_exynos5420() && IS_ENABLED(CONFIG_MCPM))
>> +             ret = cpu_suspend(0, exynos_mcpm_cpu_suspend);
>> +     else
>> +             ret = cpu_suspend(0, exynos_cpu_suspend);
>>       if (ret)
>>               return ret;
>>
>> +     if (soc_is_exynos5420() && IS_ENABLED(CONFIG_MCPM))
>> +             mcpm_cpu_powered_up();
>> +
>>       s3c_pm_restore_uarts();
>>
>>       S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
>> --
>> 2.0.0
>>
>>
