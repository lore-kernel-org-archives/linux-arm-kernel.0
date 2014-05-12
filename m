From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 12 May 2014 08:44:20 +0800
Subject: [PATCH v5 08/14] ARM: hisi: add hip04 SoC support
In-Reply-To: <CAD6h2NQU0NR1PO=x6pz62B4QWqkPz7F+Fp65YeQJ62vumF8_Aw@mail.gmail.com>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-9-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1405071259300.980@knanqh.ubzr>
 <CAD6h2NQU0NR1PO=x6pz62B4QWqkPz7F+Fp65YeQJ62vumF8_Aw@mail.gmail.com>
Message-ID: <CAD6h2NTMJ5GNkUdcTvx_MoKnGSnmQ15vUWBoj7GcKdBTBf7MJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2014 16:02, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
>
>
> On 8 May 2014 01:44, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> On Wed, 7 May 2014, Haojian Zhuang wrote:
>>
>>> +
>>> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
>>> +{
>>> +     unsigned long data, mask;
>>> +
>>> +     if (!relocation || !sysctrl)
>>> +             return -ENODEV;
>>> +     if (cluster >= HIP04_MAX_CLUSTERS || cpu >=
>>> HIP04_MAX_CPUS_PER_CLUSTER)
>>> +             return -EINVAL;
>>> +
>>> +     spin_lock_irq(&boot_lock);
>>> +     writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
>>> +     writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
>>> +     writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
>>> +     writel_relaxed(0, relocation + 12);
>>> +
>>> +     if (hip04_cluster_down(cluster)) {
>>> +             data = CLUSTER_DEBUG_RESET_BIT;
>>> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>>> +             do {
>>> +                     mask = CLUSTER_DEBUG_RESET_STATUS;
>>> +                     data = readl_relaxed(sysctrl + \
>>> +                                          SC_CPU_RESET_STATUS(cluster));
>>> +             } while (data & mask);
>>> +             hip04_set_snoop_filter(cluster, 1);
>>> +     }
>>
>> Isn't this racy?  What if the new CPU starts executing code before
>> snoops are enabled for it?
>>
>> Normally we solve this race by letting the waking-up CPU turn on its
>> snoops by itself from an assembly code callback provided as argument to
>> mcpm_sync_init().  This is also the only way to eventually support deep
>> C-states with cpuidle.
>>
>
> There's no race. At here, I enable snoop without unreset new CPU.
>
>>> +
>>> +     hip04_cpu_table[cluster][cpu]++;
>>> +
>>> +     data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
>>> +            CORE_DEBUG_RESET_BIT(cpu);
>>> +     writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>
> At here, I make new CPU out of reset state.
>
>
>>> +     spin_unlock_irq(&boot_lock);
>>> +     msleep(POLL_MSEC);
>>
>> What is that msleep() for?
>>
> Without this delay, I'll meet hang.
>
> Since I'm using reset to wakeup CPU from wfi/wfe status, I don't need
> IPI at here. If I remove the msleep() here, it seems that IPI caused my
> system hang. So it's a workaround in my system.
>

I'm sorry that it's not hang. It results that new CPU cannot be online.

>>> +     return 0;
>>> +}
>>> +
>>> +static void hip04_mcpm_power_down(void)
>>> +{
>>> +     unsigned int mpidr, cpu, cluster;
>>> +     bool skip_wfi = false;
>>> +
>>> +     mpidr = read_cpuid_mpidr();
>>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>>> +
>>> +     __mcpm_cpu_going_down(cpu, cluster);
>>> +
>>> +     spin_lock(&boot_lock);
>>> +     BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>>> +     hip04_cpu_table[cluster][cpu]--;
>>> +     if (hip04_cpu_table[cluster][cpu] == 1) {
>>> +             /* A power_up request went ahead of us. */
>>> +             skip_wfi = true;
>>> +     } else if (hip04_cpu_table[cluster][cpu] > 1) {
>>> +             pr_err("Cluster %d CPU%d is still running\n", cluster,
>>> cpu);
>>> +             BUG();
>>> +     }
>>> +
>>> +     spin_unlock(&boot_lock);
>>> +
>>> +     v7_exit_coherency_flush(louis);
>>
>> Don't you have to turn off snoop filters in the case of a complete
>> cluster down as well?
>>
>
> I still have some issue on disabling a whole cluster. So making it
> completely
> will be finished later in additional patch.
>
>
>>> +
>>> +     __mcpm_cpu_down(cpu, cluster);
>>> +
>>> +     isb();
>>> +     dsb();
>>
>> Those isb/dsb are redundant here.  They're implicit from
>> __mcpm_cpu_down().
>>
> OK. I'll remove it.
>
>
>>> +
>>> +     if (!skip_wfi)
>>> +             wfi();
>>> +}
>>> +
>>> +static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int
>>> cluster)
>>> +{
>>> +     unsigned int data, tries;
>>> +
>>> +     BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
>>> +            cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
>>> +
>>> +     for (tries = 0; tries < TIMEOUT_MSEC / POLL_MSEC; tries++) {
>>> +             data = readl_relaxed(sysctrl +
>>> SC_CPU_RESET_STATUS(cluster));
>>> +             if (!(data & CORE_WFI_STATUS(cpu))) {
>>> +                     msleep(POLL_MSEC);
>>> +                     continue;
>>> +             }
>>> +             data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
>>> +                    CORE_DEBUG_RESET_BIT(cpu);
>>> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
>>
>> You are not supposed to perform any changes here.  This method is there
>> only to wait for given CPU to be down.  It is not guaranteed it will be
>> called.  Furthermore this can race with the power_up method.
>>
>> Normally you should perform this reset business from
>> hip04_mcpm_power_down() while the lock is held.  Now... this assumes
>> that any power/reset would be effective only when the CPU executes a
>> WFI.  Is this the case on this hardware?  If not then we'll have to
>> think about a different strategy.
>>
> OK. I can move reset operation in hip04_mcpm_power_down().
>
>>> +             return 0;
>>> +     }
>>> +
>>> +     return -ETIMEDOUT;
>>> +}
>>> +
>>> +static void hip04_mcpm_powered_up(void)
>>> +{
>>> +     if (!relocation)
>>> +             return;
>>> +     spin_lock(&boot_lock);
>>> +     writel_relaxed(0, relocation);
>>> +     writel_relaxed(0, relocation + 4);
>>> +     writel_relaxed(0, relocation + 8);
>>> +     writel_relaxed(0, relocation + 12);
>>> +     spin_unlock(&boot_lock);
>>> +}
>>> +
>>> +static const struct mcpm_platform_ops hip04_mcpm_ops = {
>>> +     .power_up               = hip04_mcpm_power_up,
>>> +     .power_down             = hip04_mcpm_power_down,
>>> +     .wait_for_powerdown     = hip04_mcpm_wait_for_powerdown,
>>> +     .powered_up             = hip04_mcpm_powered_up,
>>> +};
>>> +
>>> +static bool __init hip04_cpu_table_init(void)
>>> +{
>>> +     unsigned int mpidr, cpu, cluster;
>>> +
>>> +     mpidr = read_cpuid_mpidr();
>>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>>> +
>>> +     if (cluster >= HIP04_MAX_CLUSTERS ||
>>> +         cpu >= HIP04_MAX_CPUS_PER_CLUSTER) {
>>> +             pr_err("%s: boot CPU is out of bound!\n", __func__);
>>> +             return false;
>>> +     }
>>> +     hip04_set_snoop_filter(cluster, 1);
>>> +     hip04_cpu_table[cluster][cpu] = 1;
>>> +     return true;
>>> +}
>>> +
>>> +static int __init hip04_mcpm_init(void)
>>> +{
>>> +     struct device_node *np, *np_fab;
>>> +     int ret = -ENODEV;
>>> +
>>> +     np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>>> +     if (!np)
>>> +             goto err;
>>> +     np_fab = of_find_compatible_node(NULL, NULL,
>>> "hisilicon,hip04-fabric");
>>> +     if (!np_fab)
>>> +             goto err;
>>> +
>>> +     if (of_property_read_u32(np, "bootwrapper-phys",
>>> +                              &hip04_boot.bootwrapper_phys)) {
>>> +             pr_err("failed to get bootwrapper-phys\n");
>>> +             ret = -EINVAL;
>>> +             goto err;
>>> +     }
>>> +     if (of_property_read_u32(np, "bootwrapper-size",
>>> +                              &hip04_boot.bootwrapper_size)) {
>>> +             pr_err("failed to get bootwrapper-size\n");
>>> +             ret = -EINVAL;
>>> +             goto err;
>>> +     }
>>> +     if (of_property_read_u32(np, "bootwrapper-magic",
>>> +                              &hip04_boot.bootwrapper_magic)) {
>>> +             pr_err("failed to get bootwrapper-magic\n");
>>> +             ret = -EINVAL;
>>> +             goto err;
>>> +     }
>>> +     if (of_property_read_u32(np, "relocation-entry",
>>> +                              &hip04_boot.relocation_entry)) {
>>> +             pr_err("failed to get relocation-entry\n");
>>> +             ret = -EINVAL;
>>> +             goto err;
>>> +     }
>>> +     if (of_property_read_u32(np, "relocation-size",
>>> +                              &hip04_boot.relocation_size)) {
>>> +             pr_err("failed to get relocation-size\n");
>>> +             ret = -EINVAL;
>>> +             goto err;
>>> +     }
>>> +
>>> +     relocation = ioremap(hip04_boot.relocation_entry,
>>> +                          hip04_boot.relocation_size);
>>> +     if (!relocation) {
>>> +             pr_err("failed to map relocation space\n");
>>> +             ret = -ENOMEM;
>>> +             goto err;
>>> +     }
>>> +     sysctrl = of_iomap(np, 0);
>>> +     if (!sysctrl) {
>>> +             pr_err("failed to get sysctrl base\n");
>>> +             ret = -ENOMEM;
>>> +             goto err_sysctrl;
>>> +     }
>>> +     fabric = of_iomap(np_fab, 0);
>>> +     if (!fabric) {
>>> +             pr_err("failed to get fabric base\n");
>>> +             ret = -ENOMEM;
>>> +             goto err_fabric;
>>> +     }
>>> +
>>> +     if (!hip04_cpu_table_init())
>>> +             return -EINVAL;
>>> +     ret = mcpm_platform_register(&hip04_mcpm_ops);
>>> +     if (!ret) {
>>> +             mcpm_sync_init(NULL);
>>> +             pr_info("HiP04 MCPM initialized\n");
>>> +     }
>>> +     return ret;
>>> +err_fabric:
>>> +     iounmap(sysctrl);
>>> +err_sysctrl:
>>> +     iounmap(relocation);
>>> +err:
>>> +     return ret;
>>> +}
>>> +early_initcall(hip04_mcpm_init);
>>> +
>>> +bool __init hip04_smp_init_ops(void)
>>> +{
>>> +     mcpm_smp_set_ops();
>>> +     return true;
>>> +}
>>
>> You should be able to call mcpm_smp_set_ops() directly from
>> hip04_mcpm_init(), and only if there was no errors.
>>
> if (!mdesc->smp_init || !mdesc->smp_init()) {
>         if (psci_smp_available())
>                 smp_set_ops(&psci_smp_ops);
>         else if (mdesc->smp)
>                 smp_set_ops(mdesc->smp);
> }
>
> Since the above code checks the return value of mdesc->smp_init(),
> I think it's better to call mcpm_smp_set_ops() in mdesc->smp_init().
>
> Otherwise, my mdesc->smp_init() only return true without doing anything.
> It'll confuse others to understand the code.
>
>>
>> Nicolas
