From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 16:21:48 +0000
Subject: reboot not working on linux-2.6.37 for ARMv7
In-Reply-To: <AANLkTikvBRJyDJb4=puFzbTCXNYGSEXDRkAZ=1PZuneD@mail.gmail.com>
References: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
	<20110211120305.GD23404@n2100.arm.linux.org.uk>
	<AANLkTikvBRJyDJb4=puFzbTCXNYGSEXDRkAZ=1PZuneD@mail.gmail.com>
Message-ID: <20110212162148.GA22402@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 09:45:45PM +0530, viresh kumar wrote:
> On 2/11/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Fri, Feb 11, 2011 at 05:01:06PM +0530, shiraz hashim wrote:
> >> I am using linux-2.6.37 on our ARM Cortex A9 (dual core) SMP platform
> >> with PL310 as Level 2 cache. We observe that on reboot the control
> >> is not able to reach to the arch_reset.
> >>
> >> The problem happens when L1 cache is disabled in
> >> arm_machine_restart, through cpu_proc_fin() and L2 cache is flushed.
> >
> > Where's the L2 cache flush?  The sequence is:
> >
> >         /* Clean and invalidate caches */
> >         flush_cache_all();
> >         /* Turn off caching */
> >         cpu_proc_fin();
> >         /* Push out any further dirty data, and ensure cache is empty */
> >         flush_cache_all();
> >
> > and flush_cache_all() calls v7_flush_kern_cache_all() in
> > arch/arm/mm/cache-v7.S.
> >
> > I do hope you're not modifying flush_cache_all() to also call the L2
> > cache functions because that's wrong.
> >
> 
> Russell,
> 
> We are not modifying flush_cache_all. L2 cache is not flushed from there.
> Actually as soon as L1 Cache is flushed and disabled, spin_lock is taken from
> some other thread. This creates problem for our platform, as we do not have
> monitors support at L2 thus failing strex instruction.
> 
> If we disable L2 then reboot works fine, as expected.

Again, this should not be happening:

void smp_send_stop(void)
{
        unsigned long timeout;

        if (num_online_cpus() > 1) {
                cpumask_t mask = cpu_online_map;
                cpu_clear(smp_processor_id(), mask);

                smp_cross_call(&mask, IPI_CPU_STOP);
        }

        /* Wait up to one second for other CPUs to stop */
        timeout = USEC_PER_SEC;
        while (num_online_cpus() > 1 && timeout--)
                udelay(1);

        if (num_online_cpus() > 1)
                pr_warning("SMP: failed to stop secondary CPUs\n");
}

void machine_shutdown(void)
{
#ifdef CONFIG_SMP
        smp_send_stop();
#endif
}

void machine_restart(char *cmd)
{
        machine_shutdown();
        arm_pm_restart(reboot_mode, cmd);
}

smp_send_stop() brings the other CPUs down to a quiescent state, waits for
up to one second for that to happen, and then starts flushing caches etc.
No other CPU should be active at the point where arm_pm_restart() is
called.  There should be no other threads active on either this or any
other CPU.
