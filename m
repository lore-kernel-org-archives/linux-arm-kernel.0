From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 14 May 2010 09:53:50 +1000
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <1273765193.4353.157.camel@mulgrave.site>
References: <1273569821.21352.19.camel@pasglop>
	<1273575478.21352.29.camel@pasglop>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C545537F@dbde02.ent.ti.com>
	<20100512222154.GA6841@shareable.org>
	<1273704431.21352.136.camel@pasglop>
	<1273707708.15428.4.camel@mulgrave.site>
	<1273709890.21352.141.camel@pasglop>
	<1273765193.4353.157.camel@mulgrave.site>
Message-ID: <1273794830.21352.202.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Well if the driver can peek at the data after the sync, and have any
> > kind of ordering guarantee that it doesn't get stale data (the load
> > isn't prefetched or speculated early), that would require an mb() or at
> > least rmb().
> 
> So the guarantee that it doesn't look at stale data after the sync on a
> cache coherent machine means ordering the dma write to physical memory
> with the subsequent cpu read ... no memory barrier can actually do that.
> Usually this is done externally, by making sure the memory change is
> visible before sending the irq that tells the driver it is there ... on
> some numa systems, this can be a problem (hence the mmiowb/relaxed read
> thing).

Right. I was more thinking about something along the lines of the device
writes to some descriptor and then queues it up in a list. So we have
two different DMA data structures with a data dependency.

The question is whether the driver can expect to just do the sync, read
the queue, then sync again, then read the descriptor, or does it also
need an explicit rmb in between ?

Let's assume that the ordering is maintained at the DMA -> coherency
domain level, the question is will the sync op be guaranteed to toss
prefetch / speculative loads ? (IE. Guarantee the order of the two loads
done by the CPU) or do we need an explicit rmb.

> > It would seem sensible for drivers to assume that something like
> > dma_cache_sync_for_cpu() thus has the semantics of an rmb() at least,
> > no ?
> 
> I still don't see why ... I don't see how you'd ever get a read of the
> area speculated before the event that tells the driver its OK to read
> the memory.  In theory, I agree that it looks logical to require the
> read never be speculated before the sync ... but in practice, I don't
> see there ever being a problem with this since the sync isn't the event
> that says the memory is safe to read.

Cheers,
Ben.

> James
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
