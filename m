From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 26 Jul 2013 10:29:13 -0400 (EDT)
Subject: [PATCH 03/13] ARM: b.L: core switcher code
In-Reply-To: <20130726104551.GA28084@e102568-lin.cambridge.arm.com>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-4-git-send-email-nicolas.pitre@linaro.org>
 <20130726104551.GA28084@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1307261013500.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Jul 2013, Lorenzo Pieralisi wrote:

> On Tue, Jul 23, 2013 at 04:31:19AM +0100, Nicolas Pitre wrote:
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
> >   * Return early if the current cluster is the wanted one.
> > 
> >   * Close the gate in the kernel entry vector for both the inbound
> >     and outbound CPUs.
> > 
> >   * Wake up the inbound CPU so it can perform its reset sequence in
> >     parallel up to the kernel entry vector gate.
> > 
> >   * Migrate all interrupts in the GIC targeting the outbound CPU
> >     interface to the inbound CPU interface, including SGIs. This is
> >     performed by gic_migrate_target() in drivers/irqchip/irq-gic.c.
> > 
> >   * Call cpu_pm_enter() which takes care of flushing the VFP state to
> >     RAM and save the CPU interface config from the GIC to RAM.
> 
> If I read the code properly, you always resume on the same logical cpu id
> you suspended on (different HW CPU of course), correct ? This is to validate
> my assumptions on CPU PM notifiers and other code.

Yes, the logical CPU number stays the same.  That's the only way to make 
a transparent migration for core kernel code.

As this patch stands, the physical CPU number will be the same as the 
logical CPU number as well (even though the cluster number changes).  
But that particular assumption is removed later on.

> > 
> >   * Modify the cpu_logical_map to refer to the inbound physical CPU.
> > 
> >   * Call cpu_suspend() which saves the CPU state (general purpose
> >     registers, page table address) onto the stack and store the
> >     resulting stack pointer in an array indexed by the updated
> >     cpu_logical_map, then call the provided shutdown function.
> >     This happens in arch/arm/kernel/sleep.S.
> > 
> > At this point, the provided shutdown function executed by the outbound
> > CPU ungates the inbound CPU. Therefore the inbound CPU:
> > 
> >   * Picks up the saved stack pointer in the array indexed by its MPIDR
> >     in arch/arm/kernel/sleep.S.
> > 
> >   * The MMU and caches are re-enabled using the saved state on the
> >     provided stack, just like if this was a resume operation from a
> >     suspended state.
> > 
> >   * Then cpu_suspend() returns, although this is on the inbound CPU
> >     rather than the outbound CPU which called it initially.
> > 
> >   * The function cpu_pm_exit() is called which effect is to restore the
> >     CPU interface state in the GIC using the state previously saved by
> >     the outbound CPU.
> > 
> >   * Exit of bL_switch_to() to resume normal kernel execution on the
> >     new CPU.
> > 
> > However, the outbound CPU is potentially still running in parallel while
> > the inbound CPU is resuming normal kernel execution, hence we need
> > per CPU stack isolation to execute bL_do_switch().  After the outbound
> > CPU has ungated the inbound CPU, it calls mcpm_cpu_power_down() to:
> > 
> >   * Clean its L1 cache.
> > 
> >   * If it is the last CPU still alive in its cluster (last man standing),
> >     it also cleans its L2 cache and disables cache snooping from the other
> >     cluster.
> > 
> >   * Power down the CPU (or whole cluster).
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
> 
> Yes this is really a sticking point, some comments below.
> 
> > To solve both issues, we borrow some of the task space belonging to
> > the init/idle task which, by its nature, is lightly used and therefore
> > is unlikely to clash with our usage.  The init task is also never going
> > away.
> 
> Unlikely does not mean it will always work and I think it is best
> avoided. Better stick to kernel threads, or a temporary stack but I
> understand for a temporary stack to work you have to force constraints
> on the mcpm backend you do not necessarily want to. More below.

Note that this is indeed changed later on.  But I wanted the code to be 
simpler as a first introductory patch.

And because kernel code expects the 'current' pointer to be valid, even 
in unexpected places such as printk(), this stack needs to be tied to a 
thread-info struct.

> > Right now the logical CPU number is assumed to be equivalent to the
> > physical CPU number within each cluster. The kernel should also be
> > booted with only one cluster active.  These limitations will be lifted
> > eventually.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  arch/arm/Kconfig                   |  17 +++
> >  arch/arm/common/Makefile           |   1 +
> >  arch/arm/common/bL_switcher.c      | 247 +++++++++++++++++++++++++++++++++++++
> >  arch/arm/include/asm/bL_switcher.h |  17 +++
> >  4 files changed, 282 insertions(+)
> >  create mode 100644 arch/arm/common/bL_switcher.c
> >  create mode 100644 arch/arm/include/asm/bL_switcher.h
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index ba412e02ec..2c9e5bf734 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1538,6 +1538,23 @@ config MCPM
> >           for (multi-)cluster based systems, such as big.LITTLE based
> >           systems.
> > 
> > +config BIG_LITTLE
> > +       bool "big.LITTLE support (Experimental)"
> > +       depends on CPU_V7 && SMP
> > +       select MCPM
> > +       help
> > +         This option enables support for the big.LITTLE architecture.
> 
> Probably this belongs in a separate patch (CPU idle driver probably needs
> it too). Not a big deal though (and honestly I do not know how you can
> justify a single patch for that - we need to add this config option, somehow).
> 
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
> >  choice
> >         prompt "Memory split"
> >         default VMSPLIT_3G
> > diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> > index 8c60f473e9..2586240d5a 100644
> > --- a/arch/arm/common/Makefile
> > +++ b/arch/arm/common/Makefile
> > @@ -17,3 +17,4 @@ obj-$(CONFIG_MCPM)            += mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
> >  AFLAGS_mcpm_head.o             := -march=armv7-a
> >  AFLAGS_vlock.o                 := -march=armv7-a
> >  obj-$(CONFIG_TI_PRIV_EDMA)     += edma.o
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
> 
> Is this cpu_switch_mm necessary ? You are executing it to make sure you
> get to wfi with page tables that can't be deallocated by the running inbound
> if I got it right. It is not needed to use the init stack, but you know
> that.

This is also to ensure the active mm matches the value of the 'current' 
pointer.  Again this is going away in a subsequent patch when moving to 
dedicated kernel threads.

> > +
> > +       pr_debug("%s\n", __func__);
> > +
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
> > +       stack += cpu_index * STACK_SIZE + STACK_SIZE;
> 
> I do not like this much , for two reasons. Firstly because it might not work,
> secondly because whatever current usage we do from that point onwards
> is attached to the init thread, I am not sure that's 100% safe either.
> 
> Moving to kernel threads suffers from the same issue, even though I
> should grant there it is easier to monitor stack usage and grab safely
> some starting at the bottom. At least the current pointer behaviour is kept
> coherent. Overall the risk of using current on both outbound and inbound
> CPUs at once with no coordination is a bit scary, probably it is best to
> prevent current pointer usage altogether (but this forces constraints on
> MCPM). I will give it more thought.

The only reason for keeping 'current' valid at the moment is for 
printk() to work. Otherwise random memory corruption does occur.

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
> > +       unsigned int mpidr, cpuid, clusterid, ob_cluster, ib_cluster, this_cpu;
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
> > +               pr_err("%s: mcpm_cpu_power_up() returned %d\n", __func__, ret);
> > +               return ret;
> > +       }
> > +
> > +       /*
> > +        * From this point we are entering the switch critical zone
> > +        * and can't sleep/schedule anymore.
> > +        */
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
> 
> sync_w is not needed anymore, cpu_resume does not use cpu_logical_map.

Good point.


Nicolas
