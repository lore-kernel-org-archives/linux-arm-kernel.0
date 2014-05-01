From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 1 May 2014 15:09:39 +0530
Subject: [PATCH v3 5/6] arm: exynos: Add MCPM call-back functions
In-Reply-To: <alpine.LFD.2.11.1404301021270.980@knanqh.ubzr>
References: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
 <1398528348-21214-6-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1404301021270.980@knanqh.ubzr>
Message-ID: <CAM4voa=X9yPoXdyJP-qcS4+fez9U1CGRWmxjOmAdiyYvs9naew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Apr 30, 2014 at 8:13 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sat, 26 Apr 2014, Abhilash Kesavan wrote:
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
> Small comments below.
>
>> +static int exynos_cluster_power_control(unsigned int cluster, int enable)
>> +{
>> +     unsigned int tries = 100;
>> +     unsigned int val = 0;
>> +
>> +     if (enable) {
>> +             exynos_cluster_powerup(cluster);
>> +             val = S5P_CORE_LOCAL_PWR_EN;
>> +     } else {
>> +             exynos_cluster_powerdown(cluster);
>
> It would be clearer if you have "val = 0" here instead so it looks
> symetric.
OK.
>
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
>> +     unsigned int err;
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
>> +
>> +             /*
>> +              * Turn on the cluster (L2/COMMON) and then power on the cores.
>> +              * TODO: Turn off the clusters when all cores in the cluster
>> +              * are down to achieve significant power savings.
>> +              */
>
> This TODO comment should be moved in exynos_power_down() were last_man
> is determined to be true.
Will move the comment.
>
>> +             if (was_cluster_down) {
>> +                     err = exynos_cluster_power_control(cluster, 1);
>> +                     if (err) {
>> +                             exynos_cluster_power_control(cluster, 0);
>> +                             return err;
>
> The lock is still held.
>
> To make the code clearer, you should do:
>
>                         if (!err)
>                                 exynos_cpu_powerup(cpunr);
>
> and return err at the end.
OK.
>
>> +                     }
>> +             }
>> +
>> +             exynos_cpu_powerup(cpunr);
>> +
>> +             /* CPU should be powered up there */
>> +             /* Also setup Cluster Power Sequence here */
>
> Both comments are wrong.  The CPU is not necessarily powered up yet at
> this point, and "Cluster Power Sequence" (whatever that is) should not
> happen here but in the callback provided to mcpm_sync_init().
Have removed these.
>
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
>> +     return 0;
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
>> +             int cnt = 0, i;
>> +
>> +             exynos_cpu_powerdown(cpunr);
>> +             for (i = 0; i < EXYNOS5420_CPUS_PER_CLUSTER; i++)
>> +                     cnt += cpu_use_count[i][cluster];
>> +             if (cnt == 0)
>> +                     last_man = true;
>
> I think Lorenzo commented on this code block already.
>
> Otherwise it is almost there.
>
Thanks,
Abhilash
>
> Nicolas
