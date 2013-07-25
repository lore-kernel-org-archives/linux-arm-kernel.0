From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 25 Jul 2013 16:20:47 -0400 (EDT)
Subject: [PATCH 03/13] ARM: b.L: core switcher code
In-Reply-To: <51F15D1E.20309@arm.com>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-4-git-send-email-nicolas.pitre@linaro.org>
 <51F15D1E.20309@arm.com>
Message-ID: <alpine.LFD.2.03.1307251523040.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Jul 2013, Jonathan Austin wrote:

> Hi Nico,
> 
> I've got a few more questions here...
> 
> On 23/07/13 04:31, Nicolas Pitre wrote:
> > This is the core code implementing big.LITTLE switcher functionality.
> > Rational for this code is available here:
> > 
> > http://lwn.net/Articles/481055/
> > 
> > The main entry point for a switch request is:
> > 
> > void bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
> > 
> > If the calling CPU is not the wanted one, this wrapper takes care of
> > sending the request to the appropriate CPU with schedule_work_on().
> > 
> > At the moment the core switch operation is handled by bL_switch_to()
> > which must be called on the CPU for which a switch is requested.
> > 
> > What this code does:
> > 
> >    * Return early if the current cluster is the wanted one.
> > 
> >    * Close the gate in the kernel entry vector for both the inbound
> >      and outbound CPUs.
> > 
> >    * Wake up the inbound CPU so it can perform its reset sequence in
> >      parallel up to the kernel entry vector gate.
> > 
> >    * Migrate all interrupts in the GIC targeting the outbound CPU
> >      interface to the inbound CPU interface, including SGIs. This is
> >      performed by gic_migrate_target() in drivers/irqchip/irq-gic.c.
> > 
> >    * Call cpu_pm_enter() which takes care of flushing the VFP state to
> >      RAM and save the CPU interface config from the GIC to RAM.
> > 
> >    * Modify the cpu_logical_map to refer to the inbound physical CPU.
> > 
> >    * Call cpu_suspend() which saves the CPU state (general purpose
> >      registers, page table address) onto the stack and store the
> >      resulting stack pointer in an array indexed by the updated
> >      cpu_logical_map, then call the provided shutdown function.
> >      This happens in arch/arm/kernel/sleep.S.
> > 
> > At this point, the provided shutdown function executed by the outbound
> > CPU ungates the inbound CPU. Therefore the inbound CPU:
> > 
> >    * Picks up the saved stack pointer in the array indexed by its MPIDR
> >      in arch/arm/kernel/sleep.S.
> > 
> >    * The MMU and caches are re-enabled using the saved state on the
> >      provided stack, just like if this was a resume operation from a
> >      suspended state.
> > 
> >    * Then cpu_suspend() returns, although this is on the inbound CPU
> >      rather than the outbound CPU which called it initially.
> > 
> >    * The function cpu_pm_exit() is called which effect is to restore the
> >      CPU interface state in the GIC using the state previously saved by
> >      the outbound CPU.
> > 
> >    * Exit of bL_switch_to() to resume normal kernel execution on the
> >      new CPU.
> > 
> > However, the outbound CPU is potentially still running in parallel while
> > the inbound CPU is resuming normal kernel execution, hence we need
> > per CPU stack isolation to execute bL_do_switch().  After the outbound
> > CPU has ungated the inbound CPU, it calls mcpm_cpu_power_down() to:
> > 
> >    * Clean its L1 cache.
> > 
> >    * If it is the last CPU still alive in its cluster (last man standing),
> >      it also cleans its L2 cache and disables cache snooping from the other
> >      cluster.
> > 
> >    * Power down the CPU (or whole cluster).
> > 
> > Code called from bL_do_switch() might end up referencing 'current' for
> > some reasons.  However, 'current' is derived from the stack pointer.
> > With any arbitrary stack, the returned value for 'current' and any
> > dereferenced values through it are just random garbage which may lead to
> > segmentation faults.
> > 
> > The active page table during the execution of bL_do_switch() is also a
> > problem.  There is no guarantee that the inbound CPU won't destroy the
> > corresponding task which would free the attached page table while the
> > outbound CPU is still running and relying on it.
> > 
> > To solve both issues, we borrow some of the task space belonging to
> > the init/idle task which, by its nature, is lightly used and therefore
> > is unlikely to clash with our usage.  The init task is also never going
> > away.
> 
> I had written a comment here about this looking hairy, and asking whether
> you'd considered using dedicated threads for this.
> 
> As I hit the later patches in the series I see that's exactly what you've
> done. Is it really worth keeping the historical solution in here?

I think so.  First, because it is much less code if this is introduced 
without kernel threads while still being fully functional.  Next, even 
with dedicated threads, we do have to play some games with the stack 
nevertheless, although to a lesser extent.  And I'm sure some people 
would have argued that this would have been better without kernel 
threads if they didn't see how it was without them.

> Could build/bisectability be maintained by moving the Kconfig options 
> later in the series, but without requiring the weird init/idle hack to 
> be kept around?

I don't follow you here.

> > Right now the logical CPU number is assumed to be equivalent to the
> > physical CPU number within each cluster. The kernel should also be
> > booted with only one cluster active.  These limitations will be lifted
> > eventually.
> > 
> 
> I just read this aloud in the office and Dave Martin mentioned that the MPIDR
> hashing schemes make this obselete now?

Only in the suspend /resume code path, not in the switcher proper yet. 
That's yet another level of complexity that I prefer to see introduced 
later.

> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >   arch/arm/Kconfig                   |  17 +++
> >   arch/arm/common/Makefile           |   1 +
> >   arch/arm/common/bL_switcher.c      | 247
> > +++++++++++++++++++++++++++++++++++++
> >   arch/arm/include/asm/bL_switcher.h |  17 +++
> >   4 files changed, 282 insertions(+)
> >   create mode 100644 arch/arm/common/bL_switcher.c
> >   create mode 100644 arch/arm/include/asm/bL_switcher.h
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index ba412e02ec..2c9e5bf734 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1538,6 +1538,23 @@ config MCPM
> >            for (multi-)cluster based systems, such as big.LITTLE based
> >            systems.
> > 
> > +config BIG_LITTLE
> > +       bool "big.LITTLE support (Experimental)"
> > +       depends on CPU_V7 && SMP
> > +       select MCPM
> > +       help
> > +         This option enables support for the big.LITTLE architecture.
> 
> I'm not sure we should describe this as an architecture?
> 
> "This option enables support for big.LITTLE processing"?

Well, maybe "system architecture".  I've certainly seen that somewhere 
in the literature from ARM.

What about:

	  This option enables support selections for the big.LITTLE
	  system architecture.

> What are the plans for/implications of having CONFIG_BIG_LITTLE and
> !CONFIG_BL_SWITCHER?

There is a whole set of config options that should depend on 
CONFIG_BIG_LITTLE, such as the b.L cpufreq driver, or the b.L cpuidle 
driver just posted by Lorenzo (which is now depending on a TC2 config 
but that ought not to stay that way).  So you may decide to have 
big.LITTLE goodies like that but not the switcher.  The switcher is 
always optional, and it might become even more so when proper support 
for HMP scheduling is integrated into the scheduler. Hence the slightly 
different wording for the CONFIG_BIG_LITTLE option I,m suggesting above.

> > +config BL_SWITCHER
> > +       bool "big.LITTLE switcher support"
> > +       depends on BIG_LITTLE && MCPM && HOTPLUG_CPU
> > +       select CPU_PM
> > +       select ARM_CPU_SUSPEND
> > +       help
> > +         The big.LITTLE "switcher" provides the core functionality to
> > +         transparently handle transition between a cluster of A15's
> > +         and a cluster of A7's in a big.LITTLE system.
> > +
> >   choice
> >          prompt "Memory split"
> >          default VMSPLIT_3G
> > diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> > index 8c60f473e9..2586240d5a 100644
> > --- a/arch/arm/common/Makefile
> > +++ b/arch/arm/common/Makefile
> > @@ -17,3 +17,4 @@ obj-$(CONFIG_MCPM)            += mcpm_head.o mcpm_entry.o
> > mcpm_platsmp.o vlock.o
> >   AFLAGS_mcpm_head.o             := -march=armv7-a
> >   AFLAGS_vlock.o                 := -march=armv7-a
> >   obj-$(CONFIG_TI_PRIV_EDMA)     += edma.o
> > +obj-$(CONFIG_BL_SWITCHER)      += bL_switcher.o
> > diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> > new file mode 100644
> > index 0000000000..e63881b430
> > --- /dev/null
> > +++ b/arch/arm/common/bL_switcher.c
> > @@ -0,0 +1,247 @@
> > +/*
> > + * arch/arm/common/bL_switcher.c -- big.LITTLE cluster switcher core driver
> > + *
> > + * Created by: Nicolas Pitre, March 2012
> > + * Copyright:  (C) 2012-2013  Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/mm.h>
> > +#include <linux/string.h>
> > +#include <linux/irqchip/arm-gic.h>
> > +
> > +#include <asm/smp_plat.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/suspend.h>
> > +#include <asm/mcpm.h>
> > +#include <asm/bL_switcher.h>
> > +
> > +
> > +/*
> > + * Use our own MPIDR accessors as the generic ones in asm/cputype.h have
> > + * __attribute_const__ and we don't want the compiler to assume any
> > + * constness here as the value _does_ change along some code paths.
> > + */
> > +
> > +static int read_mpidr(void)
> > +{
> > +       unsigned int id;
> > +       asm volatile ("mrc\tp15, 0, %0, c0, c0, 5" : "=r" (id));
> 
> Is the \t in here an artefact of our mail servers? I notice that in other
> places, for example arch/arm/include/asm/cp15.h, we don't have that
> formatting.

Well, if you have the inline asm statement on a single line, the 
traditional tab between the mnemonic and its argument might not fit well 
with its actual alignment on the screen.  You can find this "style" in 
arch/arm/include/barrier.h or arch/arm/include/bitops.h.

But I agree it is a little ugly.  I've replaced it with a simple space.

> > +       return id & MPIDR_HWID_BITMASK;
> > +}
> > +
> > +/*
> > + * bL switcher core code.
> > + */
> > +
> > +static void bL_do_switch(void *_unused)
> > +{
> > +       unsigned mpidr, cpuid, clusterid, ob_cluster, ib_cluster;
> > +
> > +       /*
> > +        * We now have a piece of stack borrowed from the init task's.
> > +        * Let's also switch to init_mm right away to match it.
> > +        */
> > +       cpu_switch_mm(init_mm.pgd, &init_mm);
> > +
> > +       pr_debug("%s\n", __func__);
> 
> This looks like fairly uninformative debug - is it left here intentionally? If
> so, isn't there a better message to print than just the function name?

My friend, when this function was only called for the first time, I was 
a happy camper.  So simply knowing that this is being called at all is 
already highly valuable debugging information.

> > +       mpidr = read_mpidr();
> > +       cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > +       clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > +       ob_cluster = clusterid;
> > +       ib_cluster = clusterid ^ 1;
> > +
> > +       /*
> > +        * Our state has been saved at this point.  Let's release our
> > +        * inbound CPU.
> > +        */
> > +       mcpm_set_entry_vector(cpuid, ib_cluster, cpu_resume);
> > +       sev();
> > +
> > +       /*
> > +        * From this point, we must assume that our counterpart CPU might
> > +        * have taken over in its parallel world already, as if execution
> > +        * just returned from cpu_suspend().  It is therefore important to
> > +        * be very careful not to make any change the other guy is not
> > +        * expecting.  This is why we need stack isolation.
> > +        *
> > +        * Fancy under cover tasks could be performed here.  For now
> > +        * we have none.
> > +        */
> > +
> > +       /* Let's put ourself down. */
> > +       mcpm_cpu_power_down();
> > +
> > +       /* should never get here */
> > +       BUG();
> > +}
> > +
> > +/*
> > + * Stack isolation.  To ensure 'current' remains valid, we just borrow
> > + * a slice of the init/idle task which should be fairly lightly used.
> > + * The borrowed area starts just above the thread_info structure located
> > + * at the very bottom of the stack, aligned to a cache line.
> > + */
> > +#define STACK_SIZE 256
> > +extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
> > +static int bL_switchpoint(unsigned long _arg)
> > +{
> > +       unsigned int mpidr = read_mpidr();
> > +       unsigned int cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > +       unsigned int clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > +       unsigned int cpu_index = cpuid + clusterid * MAX_CPUS_PER_CLUSTER;
> > +       void *stack = &init_thread_info + 1;
> > +       stack = PTR_ALIGN(stack, L1_CACHE_BYTES);
> 
> Are there any implications if there were big.LITTLE cores with different cache
> line sizes? The LWN article that you reference mentions different cache
> topologies...

This should always be the largest of all L1 cache line sizes in the 
system.  So that is fine here.

> > +       stack += cpu_index * STACK_SIZE + STACK_SIZE;
> > +       call_with_stack(bL_do_switch, (void *)_arg, stack);
> > +       BUG();
> > +}
> > +
> > +/*
> > + * Generic switcher interface
> > + */
> > +
> > +/*
> > + * bL_switch_to - Switch to a specific cluster for the current CPU
> > + * @new_cluster_id: the ID of the cluster to switch to.
> > + *
> > + * This function must be called on the CPU to be switched.
> > + * Returns 0 on success, else a negative status code.
> > + */
> > +static int bL_switch_to(unsigned int new_cluster_id)
> > +{
> > +       unsigned int mpidr, cpuid, clusterid, ob_cluster, ib_cluster,
> > this_cpu;
> > +       int ret;
> > +
> > +       mpidr = read_mpidr();
> > +       cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > +       clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > +       ob_cluster = clusterid;
> > +       ib_cluster = clusterid ^ 1;
> > +
> > +       if (new_cluster_id == clusterid)
> > +               return 0;
> > +
> > +       pr_debug("before switch: CPU %d in cluster %d\n", cpuid, clusterid);
> > +
> > +       /* Close the gate for our entry vectors */
> > +       mcpm_set_entry_vector(cpuid, ob_cluster, NULL);
> > +       mcpm_set_entry_vector(cpuid, ib_cluster, NULL);
> > +
> > +       /*
> > +        * Let's wake up the inbound CPU now in case it requires some delay
> > +        * to come online, but leave it gated in our entry vector code.
> > +        */
> > +       ret = mcpm_cpu_power_up(cpuid, ib_cluster);
> > +       if (ret) {
> > +               pr_err("%s: mcpm_cpu_power_up() returned %d\n", __func__,
> > ret);
> > +               return ret;
> > +       }
> > +
> > +       /*
> > +        * From this point we are entering the switch critical zone
> > +        * and can't sleep/schedule anymore.
> > +        */
> 
> Will this function ever be called from anywhere other than bL_switch_request?
> As far as I could see, bl_switch_request uses two different methods of
> ensuring that we will still be on the same CPU throughout this function (if
> called directly the get_cpu and put_cpu dis/enbale pre-emption and via the
> work queue we're guaranteed the same logical cpu). The different approaches
> somewhat obfuscate the need for something to have been done even before this
> point to stop us getting migrated to another CPU, I think...

True.  This comment is especially valid when moving to dedicated kernel 
threads but has no sense here..  It probably migrated to this patch by 
mistake during one of the cleanups.  Right here in this patch it should 
read "... and can't take any interrupts anymore."

> > +       local_irq_disable();
> > +       local_fiq_disable();
> > +
> > +       this_cpu = smp_processor_id();
> > +
> > +       /* redirect GIC's SGIs to our counterpart */
> > +       gic_migrate_target(cpuid + ib_cluster*4);
> > +
> > +       /*
> > +        * Raise a SGI on the inbound CPU to make sure it doesn't stall
> > +        * in a possible WFI, such as in mcpm_power_down().
> > +        */
> > +       arch_send_wakeup_ipi_mask(cpumask_of(this_cpu));
> > +
> > +       ret = cpu_pm_enter();
> > +
> > +       /* we can not tolerate errors at this point */
> > +       if (ret)
> > +               panic("%s: cpu_pm_enter() returned %d\n", __func__, ret);
> > +
> > +       /*
> > +        * Flip the cluster in the CPU logical map for this CPU.
> > +        * This must be flushed to RAM as the resume code
> > +        * needs to access it while the caches are still disabled.
> > +        */
> > +       cpu_logical_map(this_cpu) ^= (1 << 8);
> > +       sync_cache_w(&cpu_logical_map(this_cpu));
> > +
> > +       /* Let's do the actual CPU switch. */
> > +       ret = cpu_suspend(0, bL_switchpoint);
> > +       if (ret > 0)
> > +               panic("%s: cpu_suspend() returned %d\n", __func__, ret);
> > +
> > +       /* We are executing on the inbound CPU at this point */
> 
> Very cool :)
> 
> > +       mpidr = read_mpidr();
> > +       cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > +       clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > +       pr_debug("after switch: CPU %d in cluster %d\n", cpuid, clusterid);
> 
> Do we want a 'switcher' prefix on these? "bL_switcher: after switch..." etc?

I don't think busting the 80 column limit for this is worth it.
And when you turn on debugging you certainly know exactly what messages 
you're looking for.

> > +       BUG_ON(clusterid != ib_cluster);
> > +
> > +       mcpm_cpu_powered_up();
> > +
> > +       ret = cpu_pm_exit();
> > +
> > +       local_fiq_enable();
> > +       local_irq_enable();
> > +
> > +       if (ret)
> > +               pr_err("%s exiting with error %d\n", __func__, ret);
> > +       return ret;
> > +}
> > +
> > +struct switch_args {
> > +       unsigned int cluster;
> > +       struct work_struct work;
> > +};
> > +
> > +static void __bL_switch_to(struct work_struct *work)
> > +{
> > +       struct switch_args *args = container_of(work, struct switch_args,
> > work);
> > +       bL_switch_to(args->cluster);
> > +}
> > +
> > +/*
> > + * bL_switch_request - Switch to a specific cluster for the given CPU
> > + *
> > + * @cpu: the CPU to switch
> > + * @new_cluster_id: the ID of the cluster to switch to.
> > + *
> > + * This function causes a cluster switch on the given CPU.  If the given
> > + * CPU is the same as the calling CPU then the switch happens right away.
> > + * Otherwise the request is put on a work queue to be scheduled on the
> > + * remote CPU.
> > + */
> > +void bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
> > +{
> > +       unsigned int this_cpu = get_cpu();
> > +       struct switch_args args;
> > +
> > +       if (cpu == this_cpu) {
> > +               bL_switch_to(new_cluster_id);
> > +               put_cpu();
> > +               return;
> > +       }
> > +       put_cpu();
> > +
> > +       args.cluster = new_cluster_id;
> > +       INIT_WORK_ONSTACK(&args.work, __bL_switch_to);
> > +       schedule_work_on(cpu, &args.work);
> 
> The comment at the top of schedule_work_on() says:
>  [...]
>  * We queue the work to a specific CPU, the caller must ensure it
>  * can't go away.
>  [...]
> 
> I see we don't disable cpu hotplug requests until later in the series - does
> that matter? Until that patch, it seems that we could hotplug off the core
> that we'd scheduled the work onto?

Much worse than that could happen if e.g. someone were to hotplug in a 
counterpart CPU here.  So really this is not something I'd worry about 
for this early patch in the series.

> Hope some of those questions are helpful,

Absolutely.


Nicolas
