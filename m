From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 12:30:40 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <1266927403.3123.56.camel@e102109-lin.cambridge.arm.com>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<20100223111036.GA10501@n2100.arm.linux.org.uk>
	<1266927403.3123.56.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100223123040.GC10501@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 12:16:43PM +0000, Catalin Marinas wrote:
> On Tue, 2010-02-23 at 11:10 +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 23, 2010 at 11:01:05AM +0000, Catalin Marinas wrote:
> > > -#define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > > -#define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > > -#define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > > +#define mb()		dsb()
> > > +#define rmb()		dmb()
> > > +#define wmb()		dsb()
> > 
> > What is the reason for getting rid of the arch_is_coherent() bit here
> > and imposing non-compiler barriers on everything?  
> 
> The original code defines the mandatory barriers only if
> __LINUX_ARCH_ARM__ >= 7 || CONFIG_SMP.

No.  Please read the code.

The original code defines mandatory barriers in the following cases:
- ARMv7+
- SMP
- Any architecture which sets arch_is_coherent() (for coherent DMA) -
  which at the moment is only Xscale 3 on IXP23xx platforms.

So, we end up with mandatory barriers for: ARMv7+, ARMv6 SMP, XScale 3.
We end up with mb() and friends being compiler barriers on everything
else.

However, because dsb() replaced the 'drain write buffer' instruction in
things like the TLB operations, dsb() et al need to be defined for the
other architectures - and TLB operations execute dsb() according to the
TLB type attributes.

What your patch does is make mb() and friends unconditionally call dsb()
and friends.  As I've pointed out, this is totally wrong.  We only need
mb() and friends to be dsb() et al for ARMv6+ and anything which has
arch_is_coherent() enabled.

So, all you need to do is to leave the #else clause as-is, and change:

#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)

to be

#if __LINUX_ARM_ARCH__ >= 6

No need for any additional ifdefs.
