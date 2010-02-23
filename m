From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 18:04:04 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <1266947915.3123.150.camel@e102109-lin.cambridge.arm.com>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<20100223173334.GA13519@n2100.arm.linux.org.uk>
	<1266947915.3123.150.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1266948244.3123.152.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-23 at 17:58 +0000, Catalin Marinas wrote:
> On Tue, 2010-02-23 at 17:33 +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 23, 2010 at 11:01:05AM +0000, Catalin Marinas wrote:
> > > The mandatory barriers (mb, rmb, wmb) are used even on uniprocessor
> > > systems for things like ordering Normal Non-cacheable memory accesses
> > > with DMA transfer (via Device memory writes). The current implementation
> > > uses dmb() for mb() and friends but this is not sufficient. The DMB only
> > > ensures the ordering of accesses with regards to a single observer
> > > accessing the same memory.
> >
> > Erm, I also don't think your statement here is right.  DMB is defined in
> > the ARM ARM to be by default a full-system, read/write memory barrier.
> > It has this property:
> >
> >   If the required shareability is Full system then the operation applies
> >   to all observers within the system.
> > ...
> >   Any observer with the same required shareability domain as Pe observes
> >   all members of Group A before it observes any member of Group B to the
> >   extent that those group members are required to be observed, as
> >   determined by the shareability and cacheability of the memory locations
> >   accessed by the group members.  Where members of Group A and Group B
> >   access the same memory-mapped peripheral, all members of Group A will
> >   be visible at the memory-mapped peripheral before any members of Group
> >   B are visible at that peripheral.
> >
> > This most definitely is not "single observer" - it's all observers within
> > the same "shareability domain".  That may encompass all CPUs and not
> > devices and DMA agents.
> 
> Yes, that's correct but see below (the issue is the definition of
> "observability").

I meant that the definitions in the ARM ARM encompass all CPUs,
devices/DMA agents (but only when acting as masters).

-- 
Catalin
