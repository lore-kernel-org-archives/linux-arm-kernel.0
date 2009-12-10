From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2009 16:39:20 +0000
Subject: dma_cache_maint_contiguous should be patched as dma_cache_maint do
In-Reply-To: <1260459307.23073.41.camel@pc1117.cambridge.arm.com>
References: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
	<1260459307.23073.41.camel@pc1117.cambridge.arm.com>
Message-ID: <20091210163920.GA13210@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 03:35:07PM +0000, Catalin Marinas wrote:
> On Thu, 2009-12-10 at 14:59 +0000, mkl lin wrote:
> > I've got a deadlock while testing SATA AHCI driver ahci.c with the new IPI patch.
> > 
> > My platform is ARM11 MPCore 2CPU, Linux 2.6.31.1, SMP, with L1. I did a
> > simple write-read test with a PCIe SATA adapter and it stuck at first
> > or second round.
> [...]
> > Following is my guess:
> > 
> > CPU1 called ata_scsi_queuecmd and get the lock, and go all the way down
> > into __smp_dma_cache_op, which send the IPI message and waiting for
> > other CPU finish cache operation (I guess so).
> > 
> >     while(!cpus_empty(data.unfinished))
> > 
> > CPU0 also called ata_scsi_queuecmd and stuck in a spinlock, which is
> > obtained by CPU1, with IRQ disabled. So CPU0 could not handle the IPI,
> > keep spining, and CPU1 is waiting for CPU0 to finish handling IPI.
> 
> This looks like a valid scenario, thanks for the analysis.
> 
> The DMA broadcasting patch allows IPI's with interrupts disabled on the
> issuing CPU but that's slightly different and any IPI (not only the DMA
> broadcasting would fail). Basically you can't issue an IPI while holding
> a lock that may be held by a different CPU with interrupts disabled.

I was rather expecting a deadlock report over the DMA cache ops broadcasting,
which is why I've been holding off merging it. 

> Your patch allows interrupts to be taken while in the
> ata_scsi_queuecmd() function but this may have side-effects as this
> function is assumed to be called with interrupts disabled.

Having functions which enable interrupts while the parent is supposed to
be in an atomic context is definitely a recipe for things to go badly
wrong - this is not a solution anyone in their right mind should
contemplate.

> So it leaves us with two workarounds - (1) re-implement this DMA cache
> ops broadcasting with FIQs if the hardware (GIC) configuration allows
> this

I don't think the GIC allows FIQ IPIs - and even if it did, it presents
certain problems for people - the kernel would have to become the sole
owner of FIQs on SMP, and we'd have to prevent other people using them.
They'd certainly not be "fast" interrupts anymore, neither would they
be suitable for software-driven DMA (which is what FIQ gets used as for
some platforms.)

> or (2) instead of broadcasting, do a "Read or Write For Ownership"
> on the calling CPU before invoking the cache operation. By doing this
> the current CPU becomes the owner of the cache lines and it can do cache
> maintenance on them. For large buffers, this RFO/WFO is slower than IPI
> but in the general case it may be actually quicker.

This is probably the best we can do, and it will make DMA performance
suck - thankfully, later SMP CPUs have solved this whole cache IPI
issue by broadcasting the cache operations in hardware (which is actually
the only sane solution to this problem.)

Let's hope that all ARMv7 SMP implementations broadcast the cache
operations.  For the time being, I'm going to assume that this is the
case.  If this is not already the case, it's something I think ARM Ltd
need to ensure that hardware broadcasting is mandated in later versions
of the architecture.

If it is just ARMv6 which is affected by this (note that we can not rely
upon ID_MMFR3 telling us since this register has a different purpose
there) then we can solve this by just modifying the ARMv6 DMA cache
methods - which becomes easier if I get the rearrangement of the DMA
stuff finally sorted.  The *only* thing that remains in the way of that
is the stupid flush_ioremap_region() crap for just one MTD driver.
