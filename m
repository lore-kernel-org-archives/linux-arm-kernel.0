From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 20:50:59 -0500 (EST)
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <20130110231359.GD11628@mudshark.cambridge.arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
 <20130110231359.GD11628@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301102028510.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Will Deacon wrote:

> On Thu, Jan 10, 2013 at 12:20:38AM +0000, Nicolas Pitre wrote:
> > From: Dave Martin <dave.martin@linaro.org>
> > 
> > This provides helper methods to coordinate between CPUs coming down
> > and CPUs going up, as well as documentation on the used algorithms,
> > so that cluster teardown and setup
> > operations are not done for a cluster simultaneously.
> 
> [...]
> 
> > +int __init bL_cluster_sync_init(void (*power_up_setup)(void))
> > +{
> > +       unsigned int i, j, mpidr, this_cluster;
> > +
> > +       BUILD_BUG_ON(BL_SYNC_CLUSTER_SIZE * BL_NR_CLUSTERS != sizeof bL_sync);
> > +       BUG_ON((unsigned long)&bL_sync & (__CACHE_WRITEBACK_GRANULE - 1));
> > +
> > +       /*
> > +        * Set initial CPU and cluster states.
> > +        * Only one cluster is assumed to be active at this point.
> > +        */
> > +       for (i = 0; i < BL_NR_CLUSTERS; i++) {
> > +               bL_sync.clusters[i].cluster = CLUSTER_DOWN;
> > +               bL_sync.clusters[i].inbound = INBOUND_NOT_COMING_UP;
> > +               for (j = 0; j < BL_CPUS_PER_CLUSTER; j++)
> > +                       bL_sync.clusters[i].cpus[j].cpu = CPU_DOWN;
> > +       }
> > +       asm ("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
> 
> We have a helper for this...
> 
> > +       this_cluster = (mpidr >> 8) & 0xf;
> 
> ... and also this, thanks to Lorenzo's recent patches.

Indeed, I'll have a closer look at them.

> > +       for_each_online_cpu(i)
> > +               bL_sync.clusters[this_cluster].cpus[i].cpu = CPU_UP;
> > +       bL_sync.clusters[this_cluster].cluster = CLUSTER_UP;
> > +       sync_mem(&bL_sync);
> > +
> > +       if (power_up_setup) {
> > +               bL_power_up_setup_phys = virt_to_phys(power_up_setup);
> > +               sync_mem(&bL_power_up_setup_phys);
> > +       }
> > +
> > +       return 0;
> > +}
> > diff --git a/arch/arm/common/bL_head.S b/arch/arm/common/bL_head.S
> > index 9d351f2b4c..f7a64ac127 100644
> > --- a/arch/arm/common/bL_head.S
> > +++ b/arch/arm/common/bL_head.S
> > @@ -7,11 +7,19 @@
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> > + *
> > + *
> > + * Refer to Documentation/arm/big.LITTLE/cluster-pm-race-avoidance.txt
> > + * for details of the synchronisation algorithms used here.
> >   */
> > 
> >  #include <linux/linkage.h>
> >  #include <asm/bL_entry.h>
> > 
> > +.if BL_SYNC_CLUSTER_CPUS
> > +.error "cpus must be the first member of struct bL_cluster_sync_struct"
> > +.endif
> > +
> >         .macro  pr_dbg  cpu, string
> >  #if defined(CONFIG_DEBUG_LL) && defined(DEBUG)
> >         b       1901f
> > @@ -52,12 +60,82 @@ ENTRY(bL_entry_point)
> >  2:     pr_dbg  r4, "kernel bL_entry_point\n"
> > 
> >         /*
> > -        * MMU is off so we need to get to bL_entry_vectors in a
> > +        * MMU is off so we need to get to various variables in a
> >          * position independent way.
> >          */
> >         adr     r5, 3f
> > -       ldr     r6, [r5]
> > +       ldmia   r5, {r6, r7, r8}
> >         add     r6, r5, r6                      @ r6 = bL_entry_vectors
> > +       ldr     r7, [r5, r7]                    @ r7 = bL_power_up_setup_phys
> > +       add     r8, r5, r8                      @ r8 = bL_sync
> > +
> > +       mov     r0, #BL_SYNC_CLUSTER_SIZE
> > +       mla     r8, r0, r10, r8                 @ r8 = bL_sync cluster base
> > +
> > +       @ Signal that this CPU is coming UP:
> > +       mov     r0, #CPU_COMING_UP
> > +       mov     r5, #BL_SYNC_CPU_SIZE
> > +       mla     r5, r9, r5, r8                  @ r5 = bL_sync cpu address
> > +       strb    r0, [r5]
> > +
> > +       dsb
> 
> Why is a dmb not enough here? In fact, the same goes for most of these
> other than the one preceeding the sev. Is there an interaction with the
> different mappings for the cluster data that I've missed?

Probably Dave could comment more on this as this is his code, or Achin 
who also reviewed it.  I don't know the level of discussion that 
happened inside ARM around those barriers.

When the TC2 firmware didn't properly handle the ACP snoops, the dsb's 
couldn't be used at this point.  The replacement for a dsb was a read 
back followed by a dmb in that case, and then the general sentiment was 
that this was an A15 specific workaround which wasn't architecturally 
guaranteed on all ARMv7 compliant implementations, or something along 
those lines.

Given that the TC2 firmware properly handles the snoops now, and that 
the dsb apparently doesn't require a readback, we just decided to revert 
to having simple dsb's.

> > +
> > +       @ At this point, the cluster cannot unexpectedly enter the GOING_DOWN
> > +       @ state, because there is at least one active CPU (this CPU).
> > +
> > +       @ Check if the cluster has been set up yet:
> > +       ldrb    r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
> > +       cmp     r0, #CLUSTER_UP
> > +       beq     cluster_already_up
> > +
> > +       @ Signal that the cluster is being brought up:
> > +       mov     r0, #INBOUND_COMING_UP
> > +       strb    r0, [r8, #BL_SYNC_CLUSTER_INBOUND]
> > +
> > +       dsb
> > +
> > +       @ Any CPU trying to take the cluster into CLUSTER_GOING_DOWN from this
> > +       @ point onwards will observe INBOUND_COMING_UP and abort.
> > +
> > +       @ Wait for any previously-pending cluster teardown operations to abort
> > +       @ or complete:
> > +cluster_teardown_wait:
> > +       ldrb    r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
> > +       cmp     r0, #CLUSTER_GOING_DOWN
> > +       wfeeq
> > +       beq     cluster_teardown_wait
> > +
> > +       @ power_up_setup is responsible for setting up the cluster:
> > +
> > +       cmp     r7, #0
> > +       mov     r0, #1          @ second (cluster) affinity level
> > +       blxne   r7              @ Call power_up_setup if defined
> > +
> > +       @ Leave the cluster setup critical section:
> > +
> > +       dsb
> > +       mov     r0, #INBOUND_NOT_COMING_UP
> > +       strb    r0, [r8, #BL_SYNC_CLUSTER_INBOUND]
> > +       mov     r0, #CLUSTER_UP
> > +       strb    r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
> > +       dsb
> > +       sev
> > +
> > +cluster_already_up:
> > +       @ If a platform-specific CPU setup hook is needed, it is
> > +       @ called from here.
> > +
> > +       cmp     r7, #0
> > +       mov     r0, #0          @ first (CPU) affinity level
> > +       blxne   r7              @ Call power_up_setup if defined
> > +
> > +       @ Mark the CPU as up:
> > +
> > +       dsb
> > +       mov     r0, #CPU_UP
> > +       strb    r0, [r5]
> > +       dsb
> > +       sev
> > 
> >  bL_entry_gated:
> >         ldr     r5, [r6, r4, lsl #2]            @ r5 = CPU entry vector
> > @@ -70,6 +148,8 @@ bL_entry_gated:
> >         .align  2
> > 
> >  3:     .word   bL_entry_vectors - .
> > +       .word   bL_power_up_setup_phys - 3b
> > +       .word   bL_sync - 3b
> > 
> >  ENDPROC(bL_entry_point)
> > 
> > @@ -79,3 +159,7 @@ ENDPROC(bL_entry_point)
> >         .type   bL_entry_vectors, #object
> >  ENTRY(bL_entry_vectors)
> >         .space  4 * BL_NR_CLUSTERS * BL_CPUS_PER_CLUSTER
> > +
> > +       .type   bL_power_up_setup_phys, #object
> > +ENTRY(bL_power_up_setup_phys)
> > +       .space  4               @ set by bL_cluster_sync_init()
> > diff --git a/arch/arm/include/asm/bL_entry.h b/arch/arm/include/asm/bL_entry.h
> > index 942d7f9f19..167394d9a0 100644
> > --- a/arch/arm/include/asm/bL_entry.h
> > +++ b/arch/arm/include/asm/bL_entry.h
> > @@ -15,8 +15,37 @@
> >  #define BL_CPUS_PER_CLUSTER    4
> >  #define BL_NR_CLUSTERS         2
> > 
> > +/* Definitions for bL_cluster_sync_struct */
> > +#define CPU_DOWN               0x11
> > +#define CPU_COMING_UP          0x12
> > +#define CPU_UP                 0x13
> > +#define CPU_GOING_DOWN         0x14
> > +
> > +#define CLUSTER_DOWN           0x21
> > +#define CLUSTER_UP             0x22
> > +#define CLUSTER_GOING_DOWN     0x23
> > +
> > +#define INBOUND_NOT_COMING_UP  0x31
> > +#define INBOUND_COMING_UP      0x32
> 
> Do these numbers signify anything? Why not 0, 1, 2 etc?

Initially that's what they were.  But durring debugging (as we faced a 
few cache coherency issues here) it was more useful to use numbers with 
an easily distinguishable signature.  For example, a 0 may come from 
anywhere and could mean anything so that is about the worst choice.
Other than that, those numbers have no particular significance.

> > +
> > +/* This is a complete guess. */
> > +#define __CACHE_WRITEBACK_ORDER        6
> 
> Is this CONFIG_ARM_L1_CACHE_SHIFT?

No.  That has to cover L2 as well.

> > +#define __CACHE_WRITEBACK_GRANULE (1 << __CACHE_WRITEBACK_ORDER)
> > +
> > +/* Offsets for the bL_cluster_sync_struct members, for use in asm: */
> > +#define BL_SYNC_CLUSTER_CPUS   0
> 
> Why not use asm-offsets.h for this?

That's how that was done initially. But that ended up cluttering 
asm-offsets.h for stuff that actually is really a local implementation 
detail which doesn't need kernel wide scope.  In other words, the end 
result looked worse.

One could argue that they are still exposed too much as the only files 
that need to know about those defines are bL_head.S and bL_entry.c.

> > +#define BL_SYNC_CPU_SIZE       __CACHE_WRITEBACK_GRANULE
> > +#define BL_SYNC_CLUSTER_CLUSTER \
> > +       (BL_SYNC_CLUSTER_CPUS + BL_SYNC_CPU_SIZE * BL_CPUS_PER_CLUSTER)
> > +#define BL_SYNC_CLUSTER_INBOUND \
> > +       (BL_SYNC_CLUSTER_CLUSTER + __CACHE_WRITEBACK_GRANULE)
> > +#define BL_SYNC_CLUSTER_SIZE \
> > +       (BL_SYNC_CLUSTER_INBOUND + __CACHE_WRITEBACK_GRANULE)
> > +
> 
> Hmm, this looks pretty fragile to me but again, you need this stuff at
> compile time.

There are compile time and run time assertions in bL_entry.c to ensure 
those offsets and the corresponding C structure don't get out of sync.

> Is there an architected maximum value for the writeback
> granule? Failing that, we may as well just use things like
> __cacheline_aligned if we're only using the L1 alignment anyway.

See above -- we need L2 alignment.


Nicolas
