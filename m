From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 29 Apr 2014 09:02:35 +0530
Subject: [PATCH v3 5/6] arm: exynos: Add MCPM call-back functions
In-Reply-To: <20140428174456.GE31782@e102568-lin.cambridge.arm.com>
References: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
 <1398528348-21214-6-git-send-email-a.kesavan@samsung.com>
 <20140428174456.GE31782@e102568-lin.cambridge.arm.com>
Message-ID: <CAM4voa=mhcZO9v7nDdrcz+T8RVN-Av3eERVErCX52k1ftUcKcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Thanks for the review.

[...]

>> +#include <linux/kernel.h>
>> +#include <linux/io.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/fs.h>
>> +#include <linux/delay.h>
>> +#include <linux/arm-cci.h>
>
> Alphabetical order please.
Will fix.

[...]
>> +#define exynos_v7_exit_coherency_flush(level) \
>> +       asm volatile( \
>> +       "stmfd  sp!, {fp, ip}\n\t"\
>> +       "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR\n\t" \
>> +       "bic    r0, r0, #"__stringify(CR_C)"\n\t" \
>> +       "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR\n\t" \
>> +       "isb\n\t"\
>> +       "bl     v7_flush_dcache_"__stringify(level)"\n\t" \
>> +       "clrex\n\t"\
>> +       "mrc    p15, 0, r0, c1, c0, 1   @ get ACTLR\n\t" \
>> +       "bic    r0, r0, #(1 << 6)       @ disable local coherency\n\t" \
>> +       /* Dummy Load of a device register to avoid Erratum 799270 */ \
>> +       "ldr    r4, [%0]\n\t" \
>> +       "and    r4, r4, #0\n\t" \
>> +       "orr    r0, r0, r4\n\t" \
>> +       "mcr    p15, 0, r0, c1, c0, 1   @ set ACTLR\n\t" \
>> +       "isb\n\t" \
>> +       "dsb\n\t" \
>> +       "ldmfd  sp!, {fp, ip}" \
>> +       : \
>> +       : "Ir" (S5P_INFORM0) \
>> +       : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", \
>> +         "r9", "r10", "lr", "memory")
>> +
>
> Still investigating to see if can work around errata 799270 in a
> different fashion, will keep you posted.
Thanks.
>
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
>> +static int exynos_cluster_power_control(unsigned int cluster, int enable)
>> +{
>> +       unsigned int tries = 100;
>> +       unsigned int val = 0;
>> +
>> +       if (enable) {
>> +               exynos_cluster_powerup(cluster);
>> +               val = S5P_CORE_LOCAL_PWR_EN;
>> +       } else {
>> +               exynos_cluster_powerdown(cluster);
>> +       }
>> +
>> +       /* Wait until cluster power control is applied */
>> +       while (tries--) {
>> +               if (exynos_cluster_power_state(cluster) == val)
>
> Do you really need val ?
Yes, val can be 0x0 or 0x3 depending on whether we want to enable or
disable the cluster.
>
>> +                       return 0;
>> +
>> +               cpu_relax();
>> +       }
>> +       pr_warn("timed out waiting for cluster %u to power %s\n", cluster,
>> +               enable ? "on" : "off");
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +
>> +static int exynos_power_up(unsigned int cpu, unsigned int cluster)
>> +{
>> +       unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
>> +       unsigned int err;
>> +
>> +       pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +       if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
>> +               cluster >= EXYNOS5420_NR_CLUSTERS)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Since this is called with IRQs enabled, and no arch_spin_lock_irq
>> +        * variant exists, we need to disable IRQs manually here.
>> +        */
>> +       local_irq_disable();
>> +       arch_spin_lock(&exynos_mcpm_lock);
>> +
>> +       cpu_use_count[cpu][cluster]++;
>> +       if (cpu_use_count[cpu][cluster] == 1) {
>> +               bool was_cluster_down =
>> +                       __mcpm_cluster_state(cluster) == CLUSTER_DOWN;
>> +
>> +               /*
>> +                * Turn on the cluster (L2/COMMON) and then power on the cores.
>> +                * TODO: Turn off the clusters when all cores in the cluster
>> +                * are down to achieve significant power savings.
>> +                */
>> +               if (was_cluster_down) {
>> +                       err = exynos_cluster_power_control(cluster, 1);
>> +                       if (err) {
>> +                               exynos_cluster_power_control(cluster, 0);
>> +                               return err;
>
> You must not return without undoing what you should (irqs and locking).
Will do so.
>
>> +                       }
>> +               }
>> +
>> +               exynos_cpu_powerup(cpunr);
>> +
>> +               /* CPU should be powered up there */
>> +               /* Also setup Cluster Power Sequence here */
>
> Stale comment ?
Will remove.
>
>> +       } else if (cpu_use_count[cpu][cluster] != 2) {
>> +               /*
>> +                * The only possible values are:
>> +                * 0 = CPU down
>> +                * 1 = CPU (still) up
>> +                * 2 = CPU requested to be up before it had a chance
>> +                *     to actually make itself down.
>> +                * Any other value is a bug.
>> +                */
>> +               BUG();
>> +       }
>> +
>> +       arch_spin_unlock(&exynos_mcpm_lock);
>> +       local_irq_enable();
>> +
>> +       return 0;
>> +}
>> +
>> +static void exynos_power_down(void)
>> +{
>> +       unsigned int mpidr, cpu, cluster;
>> +       bool last_man = false, skip_wfi = false;
>> +       unsigned int cpunr;
>> +
>> +       mpidr = read_cpuid_mpidr();
>> +       cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +       cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +       cpunr =  cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
>> +
>> +       pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> +       BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
>> +                       cluster >= EXYNOS5420_NR_CLUSTERS);
>> +
>> +       __mcpm_cpu_going_down(cpu, cluster);
>> +
>> +       arch_spin_lock(&exynos_mcpm_lock);
>> +       BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>> +       cpu_use_count[cpu][cluster]--;
>> +       if (cpu_use_count[cpu][cluster] == 0) {
>> +               int cnt = 0, i;
>> +
>> +               exynos_cpu_powerdown(cpunr);
>> +               for (i = 0; i < EXYNOS5420_CPUS_PER_CLUSTER; i++)
>> +                       cnt += cpu_use_count[i][cluster];
>> +               if (cnt == 0)
>> +                       last_man = true;
>
>                 for (i = 0; i < EXYNOS5420_CPUS_PER_CLUSTER; i++)
>                         if (cpu_use_count[i][cluster])
>                                 break;
>                 last_man = i == EXYNOS5420_CPUS_PER_CLUSTER;
>
> and get rid of cnt.
OK.
>
>> +       } else if (cpu_use_count[cpu][cluster] == 1) {
>> +               /*
>> +                * A power_up request went ahead of us.
>> +                * Even if we do not want to shut this CPU down,
>> +                * the caller expects a certain state as if the WFI
>> +                * was aborted.  So let's continue with cache cleaning.
>> +                */
>> +               skip_wfi = true;
>> +       } else {
>> +               BUG();
>> +       }
>> +
>> +       if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
>> +               arch_spin_unlock(&exynos_mcpm_lock);
>> +
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
>
> How many times are we going to duplicate this function before we decide
> to move it to a common header ?
I see this being used in arch/arm/mach-vexpress/tc2_pm.c (where I
copied it from for exynos) and arch/arm/mach-vexpress/dcscb.c. A
common function named "mcpm_default_power_up_setup" in the mcpm header
would be acceptable ?
>
>> +static int __init exynos_mcpm_init(void)
>> +{
>> +       int ret = 0;
>> +
>> +       if (!soc_is_exynos5420())
>> +               return -ENODEV;
>
> I do not particularly like these soc_is* stubs, but it is just a matter
> of taste.
Would you prefer a of_find_compatible_node check for exynos5420 ?

Will wait a day or two for more comments and then re-post.

Regards,
Abhilash
>
> Thanks,
> Lorenzo
>
