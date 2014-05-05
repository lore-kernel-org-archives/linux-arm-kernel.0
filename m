From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 5 May 2014 21:55:24 +0530
Subject: [PATCH v4 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <alpine.LFD.2.11.1405021347500.980@knanqh.ubzr>
References: <1398528348-21214-6-git-send-email-a.kesavan@samsung.com>
 <1399044359-15784-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1405021347500.980@knanqh.ubzr>
Message-ID: <CAM4voannHDvT_dAKd_-mofLS=7_CmEVF6S+z0CccFjXG8ZuxVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, May 2, 2014 at 11:46 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 2 May 2014, Abhilash Kesavan wrote:
>
>> Add machine-dependent MCPM call-backs for Exynos5420. These are used
>> to power up/down the secondary CPUs during boot, shutdown, s2r and
>> switching.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>
> OK.... There is still a detail wrong.  At least we are converging.
>
>> ---
>>  arch/arm/mach-exynos/Kconfig       |    8 +
>>  arch/arm/mach-exynos/Makefile      |    2 +
>>  arch/arm/mach-exynos/mcpm-exynos.c |  345 ++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-exynos/regs-pmu.h    |    3 +
>>  4 files changed, 358 insertions(+)
>>  create mode 100644 arch/arm/mach-exynos/mcpm-exynos.c
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index 5c34dc2..138070e 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -73,4 +73,12 @@ config SOC_EXYNOS5440
>>
>>  endmenu
>>
>> +config EXYNOS5420_MCPM
>> +     bool "Exynos5420 Multi-Cluster PM support"
>> +     depends on MCPM && SOC_EXYNOS5420
>> +     select ARM_CCI
>> +     help
>> +       This is needed to provide CPU and cluster power management
>> +       on Exynos5420 implementing big.LITTLE.
>> +
>>  endif
>> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
>> index a656dbe..01bc9b9 100644
>> --- a/arch/arm/mach-exynos/Makefile
>> +++ b/arch/arm/mach-exynos/Makefile
>> @@ -29,3 +29,5 @@ obj-$(CONFIG_ARCH_EXYNOS)   += firmware.o
>>
>>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>>  AFLAGS_exynos-smc.o          :=-Wa,-march=armv7-a$(plus_sec)
>> +
>> +obj-$(CONFIG_EXYNOS5420_MCPM)        += mcpm-exynos.o
>> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
>> new file mode 100644
>> index 0000000..d0f7461
>> --- /dev/null
>> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
>> @@ -0,0 +1,345 @@
>> +/*
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * arch/arm/mach-exynos/mcpm-exynos.c
>> + *
>> + * Based on arch/arm/mach-vexpress/dcscb.c
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/arm-cci.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/of_address.h>
>> +
>> +#include <asm/cputype.h>
>> +#include <asm/cp15.h>
>> +#include <asm/mcpm.h>
>> +
>> +#include "regs-pmu.h"
>> +#include "common.h"
>> +
>> +#define EXYNOS5420_CPUS_PER_CLUSTER  4
>> +#define EXYNOS5420_NR_CLUSTERS               2
>> +
>> +/* Non-secure iRAM base address */
>> +static void __iomem *ns_sram_base_addr;
>> +
>> +/*
>> + * The common v7_exit_coherency_flush API could not be used because of the
>> + * Erratum 799270 workaround. This macro is the same as the common one (in
>> + * arch/arm/include/asm/cacheflush.h) except for the erratum handling.
>> + */
>> +#define exynos_v7_exit_coherency_flush(level) \
>> +     asm volatile( \
>> +     "stmfd  sp!, {fp, ip}\n\t"\
>> +     "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR\n\t" \
>> +     "bic    r0, r0, #"__stringify(CR_C)"\n\t" \
>> +     "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR\n\t" \
>> +     "isb\n\t"\
>> +     "bl     v7_flush_dcache_"__stringify(level)"\n\t" \
>> +     "clrex\n\t"\
>> +     "mrc    p15, 0, r0, c1, c0, 1   @ get ACTLR\n\t" \
>> +     "bic    r0, r0, #(1 << 6)       @ disable local coherency\n\t" \
>> +     /* Dummy Load of a device register to avoid Erratum 799270 */ \
>> +     "ldr    r4, [%0]\n\t" \
>> +     "and    r4, r4, #0\n\t" \
>> +     "orr    r0, r0, r4\n\t" \
>> +     "mcr    p15, 0, r0, c1, c0, 1   @ set ACTLR\n\t" \
>> +     "isb\n\t" \
>> +     "dsb\n\t" \
>> +     "ldmfd  sp!, {fp, ip}" \
>> +     : \
>> +     : "Ir" (S5P_INFORM0) \
>> +     : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", \
>> +       "r9", "r10", "lr", "memory")
>> +
>> +/*
>> + * We can't use regular spinlocks. In the switcher case, it is possible
>> + * for an outbound CPU to call power_down() after its inbound counterpart
>> + * is already live using the same logical CPU number which trips lockdep
>> + * debugging.
>> + */
>> +static arch_spinlock_t exynos_mcpm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
>> +static int
>> +cpu_use_count[EXYNOS5420_CPUS_PER_CLUSTER][EXYNOS5420_NR_CLUSTERS];
>> +
>> +#define exynos_cluster_unused(cluster) \
>> +     (!cpu_use_count[0][cluster] && \
>> +      !cpu_use_count[1][cluster] && \
>> +      !cpu_use_count[2][cluster] && \
>> +      !cpu_use_count[3][cluster])
>> +
>> +static int exynos_cluster_power_control(unsigned int cluster, int enable)
>> +{
>> +     unsigned int tries = 100;
>> +     unsigned int val;
>> +
>> +     if (enable) {
>> +             exynos_cluster_powerup(cluster);
>> +             val = S5P_CORE_LOCAL_PWR_EN;
>> +     } else {
>> +             exynos_cluster_powerdown(cluster);
>> +             val = 0;
>> +     }
>> +
>> +     /* Wait until cluster power control is applied */
>> +     while (tries--) {
>> +             if (exynos_cluster_power_state(cluster) == val)
>> +                     return 0;
>> +
>> +             cpu_relax();
>> +     }
>> +     pr_warn("timed out waiting for cluster %u to power %s\n", cluster,
>> +             enable ? "on" : "off");
>> +
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static int exynos_power_up(unsigned int cpu, unsigned int cluster)
>> +{
>> +     unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
>> +     int err = 0;
>> +
>> +     pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +     if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
>> +             cluster >= EXYNOS5420_NR_CLUSTERS)
>> +             return -EINVAL;
>> +
>> +     /*
>> +      * Since this is called with IRQs enabled, and no arch_spin_lock_irq
>> +      * variant exists, we need to disable IRQs manually here.
>> +      */
>> +     local_irq_disable();
>> +     arch_spin_lock(&exynos_mcpm_lock);
>> +
>> +     cpu_use_count[cpu][cluster]++;
>> +     if (cpu_use_count[cpu][cluster] == 1) {
>> +             bool was_cluster_down =
>> +                     __mcpm_cluster_state(cluster) == CLUSTER_DOWN;
>
> This is racy.  I probably made this comment already.  The MCPM cluster
> state may change in mcpm-head.S where concurrency protection is achieved
> with a different mechanism.
>
> What you should do instead is to redefine exynos_cluster_unused() into
> exynos_cluster_usecnt() and simply add all counts together.  You could
> even have:
>
> #define exynos_cluster_unused(cluster) !exynos_cluster_usecnt(cluster)
>
> Yet, here you should use:
>
>         bool was_cluster_down = (exynos_cluster_usecnt(cluster) == 1);
Fixed as per suggestion.
>
>> +
>> +             /*
>> +              * Turn on the cluster (L2/COMMON) and then power on the
>> +              * cores.
>> +              */
>> +             if (was_cluster_down)
>> +                     err = exynos_cluster_power_control(cluster, 1);
>> +
>> +             if (!err)
>> +                     exynos_cpu_powerup(cpunr);
>> +             else
>> +                     exynos_cluster_power_control(cluster, 0);
>> +     } else if (cpu_use_count[cpu][cluster] != 2) {
>> +             /*
>> +              * The only possible values are:
>> +              * 0 = CPU down
>> +              * 1 = CPU (still) up
>> +              * 2 = CPU requested to be up before it had a chance
>> +              *     to actually make itself down.
>> +              * Any other value is a bug.
>> +              */
>> +             BUG();
>> +     }
>> +
>> +     arch_spin_unlock(&exynos_mcpm_lock);
>> +     local_irq_enable();
>> +
>> +     return err;
>> +}
>> +
>> +static void exynos_power_down(void)
>> +{
>> +     unsigned int mpidr, cpu, cluster;
>> +     bool last_man = false, skip_wfi = false;
>> +     unsigned int cpunr;
>> +
>> +     mpidr = read_cpuid_mpidr();
>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +     cpunr =  cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
>> +
>> +     pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +     BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
>> +                     cluster >= EXYNOS5420_NR_CLUSTERS);
>> +
>> +     __mcpm_cpu_going_down(cpu, cluster);
>> +
>> +     arch_spin_lock(&exynos_mcpm_lock);
>> +     BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>> +     cpu_use_count[cpu][cluster]--;
>> +     if (cpu_use_count[cpu][cluster] == 0) {
>> +             exynos_cpu_powerdown(cpunr);
>> +
>> +             if (exynos_cluster_unused(cluster))
>> +                     last_man = true;
>> +     } else if (cpu_use_count[cpu][cluster] == 1) {
>> +             /*
>> +              * A power_up request went ahead of us.
>> +              * Even if we do not want to shut this CPU down,
>> +              * the caller expects a certain state as if the WFI
>> +              * was aborted.  So let's continue with cache cleaning.
>> +              */
>> +             skip_wfi = true;
>> +     } else {
>> +             BUG();
>> +     }
>> +
>> +     /*
>> +      * TODO: Turn off the clusters when all cores in the cluster
>> +      * are down to achieve significant power savings.
>> +      */
>
> This comment should actually be located right after the
> "if (exynos_cluster_unused(cluster))" above.  That is where the cluster
> control should be applied, assuming it'll be effective only when WFI is
> executed.
OK.
>
>
>> +     if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
>> +             arch_spin_unlock(&exynos_mcpm_lock);
>> +
>> +             /* Flush all cache levels for this cluster. */
>> +             exynos_v7_exit_coherency_flush(all);
>> +
>> +             /*
>> +              * Disable cluster-level coherency by masking
>> +              * incoming snoops and DVM messages:
>> +              */
>> +             cci_disable_port_by_cpu(mpidr);
>> +
>> +             __mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
>> +     } else {
>> +             arch_spin_unlock(&exynos_mcpm_lock);
>> +
>> +             if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
>> +                     /*
>> +                      * On the Cortex-A15 we need to disable
>> +                      * L2 prefetching before flushing the cache.
>> +                      */
>> +                     asm volatile(
>> +                     "mcr    p15, 1, %0, c15, c0, 3\n\t"
>> +                     "isb\n\t"
>> +                     "dsb"
>> +                     : : "r" (0x400));
>> +             }
>
> This doesn't belong here.  That is for the last_man only to do, right
> before the "Flush all cache levels for this cluster" comment.
This was a bad miss on my part. Will fix.
>
> The rest looks fine to me.
Will post v5 soon.

Regards,
Abhilash
>
>
> Nicolas
