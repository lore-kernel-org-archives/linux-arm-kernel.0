From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 18:07:33 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223180342.GA26434@n2100.arm.linux.org.uk>
References: <20100223152402.GF10501@n2100.arm.linux.org.uk>
	<1266940955.3123.133.camel@e102109-lin.cambridge.arm.com>
	<20100223180342.GA26434@n2100.arm.linux.org.uk>
Message-ID: <1266948453.3123.156.camel@e102109-lin.cambridge.arm.com>
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
> >
> > My proposal for this would be to place an explicit DSB at the beginning
> > of gic_raise_irq(). Otherwise, we can change smp_wmb() to be a DSB but
> > we may have some performance penalty for other cases where ordering with
> > Device accesses is not required.
> 
> That doesn't solve the above case; this isn't GIC code, it's driver code.

As I mentioned in the previous e-mail, my view is that the driver could
just use wmb() rather than smp_wmb() in this case. Are the smp_*()
barriers in Linux required to ensure the relative ordering of anything
other than shared normal memory accesses?

-- 
Catalin
