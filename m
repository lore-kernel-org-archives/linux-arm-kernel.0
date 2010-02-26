From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Feb 2010 15:43:50 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223180342.GA26434@n2100.arm.linux.org.uk>
References: <20100223152402.GF10501@n2100.arm.linux.org.uk>
	<1266940955.3123.133.camel@e102109-lin.cambridge.arm.com>
	<20100223180342.GA26434@n2100.arm.linux.org.uk>
Message-ID: <1267199030.14703.28.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-23 at 18:03 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2010 at 04:02:35PM +0000, Catalin Marinas wrote:
> > > I'm not entirely convinced by the part of your patch which changes the
> > > SMP barriers yet.  For instance, some drivers contain:
> > >
> > >                 /* We need for force the visibility of tp->intr_mask
> > >                  * for other CPUs, as we can loose an MSI interrupt
> > >                  * and potentially wait for a retransmit timeout if we don't.
> > >                  * The posted write to IntrMask is safe, as it will
> > >                  * eventually make it to the chip and we won't loose anything
> > >                  * until it does.
> > >                  */
> > >                 tp->intr_mask = 0xffff;
> > >                 smp_wmb();
> > >                 RTL_W16(IntrMask, tp->intr_event);
> > >
> > > The second write is a write to hardware, and thus would be to a device
> > > region.  The first is a write to a memory structure.
> > >
> > > It seems to me given your description in the patch, that having smp_wmb()
> > > be a dmb(), rather than a wmb() would be insufficient here.
[...]
> Given what you've said, it would appear that smp_wmb() needs to be a
> wmb() in the SMP case, to ensure that the write to intr_mask is
> visible to other CPUs before the interrupt mask write hits the
> peripheral.
> 
> So, that leads us back to the:
> 
> #ifndef CONFIG_SMP
> #define smp_mb()        barrier()
> #define smp_rmb()       barrier()
> #define smp_wmb()       barrier()
> #else
> #define smp_mb()        mb()
> #define smp_rmb()       rmb()
> #define smp_wmb()       wmb()
> #endif

A better implementation would be this:

#ifndef CONFIG_SMP
#define smp_mb()	barrier()
#define smp_rmb()	barrier()
#define smp_wmb()	barrier()
#else
#define smp_mb()	dsb()
#define smp_rmb()	mb()
#define smp_wmb()	dsb()
#endif

Since the mb() may have other effects like draining the L2 write buffer
which is definitely not needed for the SMP barriers.

Anyway, the above change to smp_*mb() would probably have a performance
impact especially with spinlocks.

I can see that the driver situation you described appears in other
drivers as well. Whether this is a correct usage model I can't tell. It
may be worth going with this on linux-arch. PowerPC for example uses a
light barrier for the smp_wmb() case which doesn't ensure ordering
between accesses to normal vs I/O memory.

-- 
Catalin
