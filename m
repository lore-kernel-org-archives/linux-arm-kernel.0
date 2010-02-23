From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 15:12:46 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223123040.GC10501@n2100.arm.linux.org.uk>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<20100223111036.GA10501@n2100.arm.linux.org.uk>
	<1266927403.3123.56.camel@e102109-lin.cambridge.arm.com>
	<20100223123040.GC10501@n2100.arm.linux.org.uk>
Message-ID: <1266937966.3123.121.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-23 at 12:30 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2010 at 12:16:43PM +0000, Catalin Marinas wrote:
> > On Tue, 2010-02-23 at 11:10 +0000, Russell King - ARM Linux wrote:
> > > On Tue, Feb 23, 2010 at 11:01:05AM +0000, Catalin Marinas wrote:
> > > > -#define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > > > -#define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > > > -#define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > > > +#define mb()		dsb()
> > > > +#define rmb()		dmb()
> > > > +#define wmb()		dsb()
> > > 
> > > What is the reason for getting rid of the arch_is_coherent() bit here
> > > and imposing non-compiler barriers on everything?  
> > 
> > The original code defines the mandatory barriers only if
> > __LINUX_ARCH_ARM__ >= 7 || CONFIG_SMP.
> 
> No.  Please read the code.
> 
> The original code defines mandatory barriers in the following cases:
> - ARMv7+
> - SMP
> - Any architecture which sets arch_is_coherent() (for coherent DMA) -
>   which at the moment is only Xscale 3 on IXP23xx platforms.
> 
> So, we end up with mandatory barriers for: ARMv7+, ARMv6 SMP, XScale 3.
> We end up with mb() and friends being compiler barriers on everything
> else.

The scenario I have in mind is when using mb() in relation with DMA
coherent mappings. We only use Normal Uncached for this case on ARMv7.
Earlier architectures, including ARMv6 SMP, we use strongly ordered
which would be fine without any barrier.

Since mb() isn't meant for SMP use, does it still make sense to have it
defined in the ARMv6 SMP case? Would people not use the smp_* variants?

Or is mb() meant to cover all the cases that smp_mb() would cover on
SMP?

> So, all you need to do is to leave the #else clause as-is, and change:
> 
> #if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
> 
> to be
> 
> #if __LINUX_ARM_ARCH__ >= 6

Yes, sounds fine. Just need to check whether the minimum version should
be 6 or 7 (see above).

-- 
Catalin
