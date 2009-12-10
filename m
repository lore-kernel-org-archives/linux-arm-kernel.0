From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Dec 2009 15:35:07 +0000
Subject: dma_cache_maint_contiguous should be patched as dma_cache_maint do
In-Reply-To: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
References: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
Message-ID: <1260459307.23073.41.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-12-10 at 14:59 +0000, mkl lin wrote:
> I've got a deadlock while testing SATA AHCI driver ahci.c with the new IPI patch.
> 
> My platform is ARM11 MPCore 2CPU, Linux 2.6.31.1, SMP, with L1. I did a
> simple write-read test with a PCIe SATA adapter and it stuck at first
> or second round.
[...]
> Following is my guess:
> 
> CPU1 called ata_scsi_queuecmd and get the lock, and go all the way down
> into __smp_dma_cache_op, which send the IPI message and waiting for
> other CPU finish cache operation (I guess so).
> 
>     while(!cpus_empty(data.unfinished))
> 
> CPU0 also called ata_scsi_queuecmd and stuck in a spinlock, which is
> obtained by CPU1, with IRQ disabled. So CPU0 could not handle the IPI,
> keep spining, and CPU1 is waiting for CPU0 to finish handling IPI.

This looks like a valid scenario, thanks for the analysis.

The DMA broadcasting patch allows IPI's with interrupts disabled on the
issuing CPU but that's slightly different and any IPI (not only the DMA
broadcasting would fail). Basically you can't issue an IPI while holding
a lock that may be held by a different CPU with interrupts disabled.

Your patch allows interrupts to be taken while in the
ata_scsi_queuecmd() function but this may have side-effects as this
function is assumed to be called with interrupts disabled.

So it leaves us with two workarounds - (1) re-implement this DMA cache
ops broadcasting with FIQs if the hardware (GIC) configuration allows
this or (2) instead of broadcasting, do a "Read or Write For Ownership"
on the calling CPU before invoking the cache operation. By doing this
the current CPU becomes the owner of the cache lines and it can do cache
maintenance on them. For large buffers, this RFO/WFO is slower than IPI
but in the general case it may be actually quicker.

If you have time (should only take an hour or so but I don't have
hardware to test it), I would be grateful if you could try the
following:

      * Drop my DMA broadcasting patch
      * In the dma_cache_maint (and the contiguous one) do the following
        based on direction:
              * TO_DEVICE: read each cache line in the buffer (you can
                read a long variable every 32 bytes) before the local
                cache maintenance operations. This ensures that any
                dirty cache lines on other CPUs are transferred to L2
                (or main memory) or the current CPU and the cache
                operation would have the intended effect. The cache
                lines on other CPUs may change to a Shared state (see
                the MESI protocol)
              * FROM_DEVICE:  we don't care about the buffer, just write
                0 in each cache line (as above, you can only write a
                long every 32 bytes). This ensures that the cache lines
                become Exclusive to the current CPU (no other CPU has
                any copies) and the invalidation would ensure that there
                are no cache lines on any CPU
              * BIDIRECTIONAL: read a word in a cache line and write it
                back. After cache clean&invalidate, the cache lines
                would be removed from all the existing CPUs

ARM11MPCore doesn't do speculative accesses so the above should be safe.

Thanks.

-- 
Catalin
