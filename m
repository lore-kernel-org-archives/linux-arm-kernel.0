From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 20 May 2014 22:06:10 -0400 (EDT)
Subject: [PATCH v9 05/14] ARM: hisi: enable MCPM implementation
In-Reply-To: <CAD6h2NRwuxN=yPzPWSJYiOa_jkwNvKCdxQm4S_k_MHKKU1B5NQ@mail.gmail.com>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-6-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1405201744461.17310@knanqh.ubzr>
 <CAD6h2NRwuxN=yPzPWSJYiOa_jkwNvKCdxQm4S_k_MHKKU1B5NQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405202157530.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 May 2014, Haojian Zhuang wrote:

> On 21 May 2014 09:29, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 20 May 2014, Haojian Zhuang wrote:
> >
> >> Multiple CPU clusters are used in Hisilicon HiP04 SoC. Now use MCPM
> >> framework to manage power on HiP04 SoC.
> >
> > There are still unresolved issues with this patch.
> >
> > [...]
> >> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
> >> +{
> >> +     unsigned long data, mask;
> >> +
> >> +     if (!relocation || !sysctrl)
> >> +             return -ENODEV;
> >> +     if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
> >> +             return -EINVAL;
> >> +
> >> +     spin_lock_irq(&boot_lock);
> >> +
> >> +     if (hip04_cpu_table[cluster][cpu]) {
> >> +             hip04_cpu_table[cluster][cpu]++;
> >> +             spin_unlock_irq(&boot_lock);
> >> +             return 0;
> >> +     }
> >> +
> >> +     writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
> >> +     writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
> >> +     writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
> >> +     writel_relaxed(0, relocation + 12);
> >> +
> >> +     if (hip04_cluster_down(cluster)) {
> >> +             data = CLUSTER_DEBUG_RESET_BIT;
> >> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
> >> +             do {
> >> +                     mask = CLUSTER_DEBUG_RESET_STATUS;
> >> +                     data = readl_relaxed(sysctrl + \
> >> +                                          SC_CPU_RESET_STATUS(cluster));
> >> +             } while (data & mask);
> >> +             hip04_set_snoop_filter(cluster, 1);
> >> +     }
> >
> > Sorry to insist, but I want to repeat the question I asked during the
> > previous review as I consider this is important, especially if you want
> > to support deep C-States with cpuidle later.  This also has implications
> > if you ever want to turn off snoops in hip04_mcpm_power_down() when all
> > CPUs in a cluster are down.
> >
> > You said:
> >
> > | But it fails on my platform if I execute snooping setup on the new
> > | CPU.
> >
> > I then asked:
> >
> > | It fails how?  I want to make sure if the problem is with the hardware
> > | design or the code.
> > |
> > | The assembly code could be wrong.  Are you sure this is not theactual
> > | reason?
> > |
> > | Is there some documentation for this stuff?
> >
> > I also see that the snoop filter is enabled from hip04_cpu_table_init()
> > for the CPU that is actually executing that code.  So that must work
> > somehow...
> >
> 
> Cluster0 is very special. If I didn't enable snoop filter of cluster0, it also
> works. I'll check with Hisilicon guys why it's different. The configuration
> of snoop filter is a black box to me.

If you could get more info or some documentation about it that would be 
great.

> >> +static void hip04_mcpm_power_down(void)
> >> +{
> >> +     unsigned int mpidr, cpu, cluster, data = 0;
> >> +     bool skip_reset = false;
> >> +
> >> +     mpidr = read_cpuid_mpidr();
> >> +     cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> >> +     cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> >> +
> >> +     __mcpm_cpu_going_down(cpu, cluster);
> >> +
> >> +     spin_lock(&boot_lock);
> >> +     BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> >> +     hip04_cpu_table[cluster][cpu]--;
> >> +     if (hip04_cpu_table[cluster][cpu] == 1) {
> >> +             /* A power_up request went ahead of us. */
> >> +             skip_reset = true;
> >> +     } else if (hip04_cpu_table[cluster][cpu] > 1) {
> >> +             pr_err("Cluster %d CPU%d boots multiple times\n", cluster, cpu);
> >> +             BUG();
> >> +     }
> >> +     spin_unlock(&boot_lock);
> >> +
> >> +     v7_exit_coherency_flush(louis);
> >> +
> >> +     __mcpm_cpu_down(cpu, cluster);
> >> +
> >> +     if (!skip_reset) {
> >> +             data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> >> +                    CORE_DEBUG_RESET_BIT(cpu);
> >> +             writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
> >> +     }
> >> +}
> >
> > As I mentioned already this is going to race with the power_up() method.
> > Let me illustrate the problem:
> >
> >         * CPU 0         * CPU 1
> >         -------         -------
> >         * mcpm_cpu_power_down()
> >         * hip04_mcpm_power_down()
> >         * spin_lock(&boot_lock); [lock acquired]
> >                         * mcpm_cpu_power_up(cpu = 0)
> >                         * spin_lock(&boot_lock); [blocked]
> >         * hip04_cpu_table[cluster][cpu]--; [value down to 0]
> >         * skip_reset = false
> >         * spin_unlock(&boot_lock);
> >                         * spin_lock(&boot_lock); [now succeeds]
> >         * v7_exit_coherency_flush(louis); [takes a while to complete]
> >                         * hip04_cpu_table[cluster][cpu]++; [value back to 1]
> >                         * bring CPU0 out of reset
> >         * put CPU0 into reset
> >                         * spin_unlock(&boot_lock);
> >
> > Here you end up with CPU0 in reset while hip04_cpu_table[cluster][cpu]
> > for CPU0 is equal to 1.  The CPU will therefore never start again as
> > further calls to power_up() won't see hip04_cpu_table equal to 0
> > anymore.
> >
> > So... I'm asking again: are you absolutely certain that the CPU reset is
> > applied at the very moment the corresponding bit is set?  Isn't it
> > applied only when the CPU does execute a WFI like most other platforms?
> >
> 
> If I put CPU0 into reset mode in wait_for_powerdown() that is executed
> in CPU1 or other CPU, this issue doesn't exist. Is it right?

Only if:

1) the lock is taken,

2) hip04_cpu_table[cluster][cpu] is verified to still be 0, and

3) wait_for_powerdown() is actually called.

Here (3) is optional.  It is there only to satisfy the requirements for 
kexec to work properly.  In the case of cpuidle or the switcher this 
method is not used.

I also would like to remind you that you still didn't answer my 
question.  :-)


Nicolas
