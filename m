From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 16:02:35 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223152402.GF10501@n2100.arm.linux.org.uk>
References: <20100223152402.GF10501@n2100.arm.linux.org.uk>
Message-ID: <1266940955.3123.133.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-23 at 15:24 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2010 at 03:12:46PM +0000, Catalin Marinas wrote:
> > The scenario I have in mind is when using mb() in relation with DMA
> > coherent mappings. We only use Normal Uncached for this case on ARMv7.
> > Earlier architectures, including ARMv6 SMP, we use strongly ordered
> > which would be fine without any barrier.
> >
> > Since mb() isn't meant for SMP use, does it still make sense to have it
> > defined in the ARMv6 SMP case? Would people not use the smp_* variants?
> 
> Part of the reason for that is that smp_mb() are, afaik, supposed to be
> as strong as mb() in the SMP case, or reduce to compiler barriers in the
> UP case.

I looked again at Documentation/memory-barriers.txt and I haven't seen
anything that would suggest the above. The only reference to these types
of barriers together seems to be:

        Note that SMP memory barriers _must_ be used to control the
        ordering of references to shared memory on SMP systems [...].
        
        Mandatory barriers should not be used to control SMP effects,
        since mandatory barriers unnecessarily impose overhead on UP
        systems. They may, however, be used to control MMIO effects on
        accesses through relaxed memory I/O windows.

They don't seem to imply that one is stronger than the other, only that
they are meant for different scenarios.

> I'm not entirely convinced by the part of your patch which changes the
> SMP barriers yet.  For instance, some drivers contain:
> 
>                 /* We need for force the visibility of tp->intr_mask
>                  * for other CPUs, as we can loose an MSI interrupt
>                  * and potentially wait for a retransmit timeout if we don't.
>                  * The posted write to IntrMask is safe, as it will
>                  * eventually make it to the chip and we won't loose anything
>                  * until it does.
>                  */
>                 tp->intr_mask = 0xffff;
>                 smp_wmb();
>                 RTL_W16(IntrMask, tp->intr_event);
> 
> The second write is a write to hardware, and thus would be to a device
> region.  The first is a write to a memory structure.
> 
> It seems to me given your description in the patch, that having smp_wmb()
> be a dmb(), rather than a wmb() would be insufficient here.

Yes, a DMB is insufficient here (see the Mailbox example in the Barrier
Litmus document from Richard G). That's actually the case with the GIC
currently - CPU0 writes some data, barrier and then IPI to CPU1. If only
DMB is used, the IPI may arrive at CPU1 before the data written by CPU0
reaches the memory.

My proposal for this would be to place an explicit DSB at the beginning
of gic_raise_irq(). Otherwise, we can change smp_wmb() to be a DSB but
we may have some performance penalty for other cases where ordering with
Device accesses is not required.

-- 
Catalin
