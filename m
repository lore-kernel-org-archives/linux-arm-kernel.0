From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 13 May 2014 17:57:26 +0800
Subject: [PATCH v5 08/14] ARM: hisi: add hip04 SoC support
In-Reply-To: <alpine.LFD.2.11.1405121510130.980@knanqh.ubzr>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-9-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1405071259300.980@knanqh.ubzr>
 <CAD6h2NQU0NR1PO=x6pz62B4QWqkPz7F+Fp65YeQJ62vumF8_Aw@mail.gmail.com>
 <CAD6h2NTMJ5GNkUdcTvx_MoKnGSnmQ15vUWBoj7GcKdBTBf7MJw@mail.gmail.com>
 <alpine.LFD.2.11.1405121510130.980@knanqh.ubzr>
Message-ID: <CAD6h2NTz6h+GSM7BKr_Om3VHjKOXebO6hRD0BHCjzyT57qHeLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2014 03:39, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 12 May 2014, Haojian Zhuang wrote:
>
>> On 11 May 2014 16:02, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
>> >
>> >
>> > On 8 May 2014 01:44, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> >> On Wed, 7 May 2014, Haojian Zhuang wrote:
>> >>
>> >>> +
>> >>> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
>> >>> +{
>> >>> +     unsigned long data, mask;
>> >>> +
>> >>> +     if (!relocation || !sysctrl)
>> >>> +             return -ENODEV;
>> >>> +     if (cluster >= HIP04_MAX_CLUSTERS || cpu >=
>> >>> HIP04_MAX_CPUS_PER_CLUSTER)
>> >>> +             return -EINVAL;
>> >>> +
>> >>> +     spin_lock_irq(&boot_lock);
>> >>> +     writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
>> >>> +     writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
>> >>> +     writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
>> >>> +     writel_relaxed(0, relocation + 12);
>> >>> +
>> >>> +     if (hip04_cluster_down(cluster)) {
>> >>> +             data = CLUSTER_DEBUG_RESET_BIT;
>> >>> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>> >>> +             do {
>> >>> +                     mask = CLUSTER_DEBUG_RESET_STATUS;
>> >>> +                     data = readl_relaxed(sysctrl + \
>> >>> +                                          SC_CPU_RESET_STATUS(cluster));
>> >>> +             } while (data & mask);
>> >>> +             hip04_set_snoop_filter(cluster, 1);
>> >>> +     }
>> >>
>> >> Isn't this racy?  What if the new CPU starts executing code before
>> >> snoops are enabled for it?
>> >>
>> >> Normally we solve this race by letting the waking-up CPU turn on its
>> >> snoops by itself from an assembly code callback provided as argument to
>> >> mcpm_sync_init().  This is also the only way to eventually support deep
>> >> C-states with cpuidle.
>> >>
>> >
>> > There's no race. At here, I enable snoop without unreset new CPU.
>> >
>> >>> +
>> >>> +     hip04_cpu_table[cluster][cpu]++;
>> >>> +
>> >>> +     data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
>> >>> +            CORE_DEBUG_RESET_BIT(cpu);
>> >>> +     writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>> >
>> > At here, I make new CPU out of reset state.
>
> That's my point.  At least on systems with the CCI, you risk hanging the
> system if you enable snoops for a CPU that is not yet running.
>
> Yet you cannot enable the CPU and then turn on snoops as you have the
> opposite race in that case.
>
> So the only way to be absolutely safe is to let the waking-up CPU turn
> on snoops for itself _before_ it starts using the cache.  That is what
> the power_up_setup callback provided to mcpm_sync_init() is all about.
>
> It must be written all in assembly as there is no stack available yet
> when it is called.  See arch/arm/mach-vexpress/dcscb_setup.S for an
> example skeleton where cci_enable_port_for_self is called when the
> affinity level is 1 (cluster level) and nothing special is done when the
> affinity level is 0 (CPU level).  All the synchronization and race
> avoidance is all handled for you in arch/arm/common/mcpm_head.S already.
>

There's no CCI in HiP04. Their own fabric is used instead.

>> >
>> >
>> >>> +     spin_unlock_irq(&boot_lock);
>> >>> +     msleep(POLL_MSEC);
>> >>
>> >> What is that msleep() for?
>> >>
>> > Without this delay, I'll meet hang.
>> >
>> > Since I'm using reset to wakeup CPU from wfi/wfe status, I don't need
>> > IPI at here. If I remove the msleep() here, it seems that IPI caused my
>> > system hang. So it's a workaround in my system.
>
> Could you confirm that the IPI is actually what causes you trouble?
>
> If so maybe you should make sure that the CPU is actually masking out
> IRQs at all times before they're unmasked by the kernel.
>

I think so. But I don't have any hardware debugger to confirm it.

I think that unnecessary interrupt causes new CPU in interrupt mode,
then this CPU can't be online.

If I remove the code to send IPI, the new CPU could be online right.

>> >>> +     return 0;
>> >>> +}
>> >>> +
>> >>> +static void hip04_mcpm_power_down(void)
>> >>> +{
>> >>> +     unsigned int mpidr, cpu, cluster;
>> >>> +     bool skip_wfi = false;
>> >>> +
>> >>> +     mpidr = read_cpuid_mpidr();
>> >>> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> >>> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> >>> +
>> >>> +     __mcpm_cpu_going_down(cpu, cluster);
>> >>> +
>> >>> +     spin_lock(&boot_lock);
>> >>> +     BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>> >>> +     hip04_cpu_table[cluster][cpu]--;
>> >>> +     if (hip04_cpu_table[cluster][cpu] == 1) {
>> >>> +             /* A power_up request went ahead of us. */
>> >>> +             skip_wfi = true;
>> >>> +     } else if (hip04_cpu_table[cluster][cpu] > 1) {
>> >>> +             pr_err("Cluster %d CPU%d is still running\n", cluster,
>> >>> cpu);
>> >>> +             BUG();
>> >>> +     }
>> >>> +
>> >>> +     spin_unlock(&boot_lock);
>> >>> +
>> >>> +     v7_exit_coherency_flush(louis);
>> >>
>> >> Don't you have to turn off snoop filters in the case of a complete
>> >> cluster down as well?
>> >>
>> >
>> > I still have some issue on disabling a whole cluster. So making it
>> > completely
>> > will be finished later in additional patch.
>
> Most likely related to my commentabove.
>
Maybe it's not. In my original code, I call hip04_set_snoop_filter() at here.
But it doesn't help me.

Before I root cause this issue, I don't plan to add
hip04_set_snoop_filter() here.

>> >> You should be able to call mcpm_smp_set_ops() directly from
>> >> hip04_mcpm_init(), and only if there was no errors.
>> >>
>> > if (!mdesc->smp_init || !mdesc->smp_init()) {
>> >         if (psci_smp_available())
>> >                 smp_set_ops(&psci_smp_ops);
>> >         else if (mdesc->smp)
>> >                 smp_set_ops(mdesc->smp);
>> > }
>> >
>> > Since the above code checks the return value of mdesc->smp_init(),
>> > I think it's better to call mcpm_smp_set_ops() in mdesc->smp_init().
>> >
>> > Otherwise, my mdesc->smp_init() only return true without doing anything.
>> > It'll confuse others to understand the code.
>
> Simply don't provide a mdesc->smp_init at all.  If you have a default
> value for mdesc->smp then it'll be replaced when hip04_mcpm_init()
> completes successfully.
>
>
> Nicolas
