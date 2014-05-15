From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 15 May 2014 16:01:37 -0400 (EDT)
Subject: [PATCH v7 06/15] ARM: hisi: enable MCPM implementation
In-Reply-To: <CAD6h2NRMzgsZWkP8MYbCHqo4JkojbJxjj-kZwSj65A1SNBNRyw@mail.gmail.com>
References: <1399795571-17231-7-git-send-email-haojian.zhuang@linaro.org>
 <1399981484-31628-1-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1405131449270.980@knanqh.ubzr>
 <CAD6h2NRMzgsZWkP8MYbCHqo4JkojbJxjj-kZwSj65A1SNBNRyw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405151549330.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 May 2014, Haojian Zhuang wrote:

> On 14 May 2014 03:43, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 13 May 2014, Haojian Zhuang wrote:
> >
> >> +     data = readl_relaxed(fabric + FAB_SF_MODE);
> >> +     if (on)
> >> +             data |= 1 << cluster;
> >> +     else
> >> +             data &= ~(1 << cluster);
> >> +     writel_relaxed(data, fabric + FAB_SF_MODE);
> >> +     while (1) {
> >> +             if (data == readl_relaxed(fabric + FAB_SF_MODE))
> >> +                     break;
> >> +     }
> >> +}
> >
> > The above could be easily coded in assembly for the power_up_setup
> > callback thusly:
> >
> > hip04_power_up_setup:
> >
> >         cmp     r0, #0                  @ check affinity level
> >         bxeq    lr                      @ nothing to do at CPU level
> >
> >         mrc     p15, 0, r0, c0, c0, 5   @ get MPIDR
> >         ubfx    r0, r0, #8, #8          @ extract cluster number
> >
> >         adr     r1, .LC0
> >         ldmia   r1, {r2, r3}
> >         sub     r2, r2, r1              @ virt_addr - phys_addr
> >         ldr     r1, [r2, r3]            @ get fabric_phys_addr
> >         mov     r2, #1
> >         ldr     r3, [r1, #FAB_SF_MODE]  @ read "data"
> >         orr     r3, r3, r2, lsl r0      @ set cluster bit
> >         str     r3, [r1, #FAB_SF_MODE]  @ write it back
> >
> > 1:      ldr     r2, [r1, #FAB_SF_MODE]  @ read register content
> >         cmp     r2, r3                  @ make sure it matches
> >         bne     1b                      @ otherwise retry
> >
> >         bx      lr
> >
> > :LC0:   .word   .
> >         .word   fabric_phys_addr - .LC0
> >
> > That should be it.
> >
> 
> No. These code should be executed before new CPU on. If I transfer
> them to assembler code, it means that code will be executed after
> new CPU on.

Exact.

> Then it results me failing to make new CPU online.

The assembly code could be wrong as well.  Are you sure this is not the 
actual reason?

Is there some documentation for this stuff?

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
> >> +     writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
> >> +     writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
> >> +     writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
> >> +     writel_relaxed(0, relocation + 12);
> >
> > Shouldn't you do the above writes only when
> > hip04_cpu_table[cluster][cpu] is zero?  Please see the comment in
> > mcpm_cpu_power_down() about unordered calls.
> >
> OK. I can add the check.
> 
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
> >> +
> >> +     hip04_cpu_table[cluster][cpu]++;
> >> +
> >> +     data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> >> +            CORE_DEBUG_RESET_BIT(cpu);
> >> +     writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
> >> +     spin_unlock_irq(&boot_lock);
> >> +     msleep(POLL_MSEC);
> >> +
> >> +     return 0;
> >> +}
> >> +
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
> >> +             pr_err("Cluster %d CPU%d is still running\n", cluster, cpu);
> >
> > This message is misleading.  If execution gets here, that means
> > mcpm_cpu_power_up() was called more than twice in a row for the same CPU
> > which should never happen.
> >
> OK. I'll replace the comments.
> 
> >> +             BUG();
> >> +     }
> >> +
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
> >
> > You should not perform this outside the lock protected region as this
> > could race with hip04_mcpm_power_up().  Instead, this should be done
> > above when hip04_cpu_table[cluster][cpu] == 0 after being decremented.
> >
> 
> No. power_down() is executed on the specified CPU. If spin_unlock() is 
> placed after reset operation, it means that there's no chance to 
> execute the spin_unlock(). Because CPU is already in reset mode at 
> this time.

Normally, reset is effective only when WFI is later executed.  Are you 
sure this is not the case on hip04 as well?


Nicolas
