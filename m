From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 20:12:20 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <5359236A.4000707@ti.com>
References: <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk> <6414220.SShvCHLvZQ@wuerfel>
 <20140423190448.GB26756@n2100.arm.linux.org.uk>
 <20140424104737.GE8521@arm.com>
 <20140424111547.GP26756@n2100.arm.linux.org.uk>
 <20140424112152.GF19564@arm.com> <535913D4.6020401@ti.com>
 <20140424140913.GB14110@arm.com> <5359236A.4000707@ti.com>
Message-ID: <20140424191220.GA26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 10:44:58AM -0400, Santosh Shilimkar wrote:
> DMA_TO_DEVICE: CPU->producer and DMA->consumer
> 1. CPU fills a descriptor/buffer in memory for DMA to pick it up.
> 2. Performs necessary dma_op() which on coherent case is NOP...
> ** Here I agree the ordering from all CPUs within the cluster is guaranteed
> as per as the descriptor memory view is concerned.
> But what is produced by CPU is not visible to DMA yet. So completion
> isn't guaranteed.
> 3. If DMA kicks the transfer assuming the producer(CPU) completion then
> that doesn't work.

Step 3 should be done via a writel(), which is a dsb() followed by an
outer_sync() followed by the actual write to the register.

The dsb and outer_sync are there to ensure that the previous writes to
things like DMA coherent memory are visible to the device before the
device sees the write to its register.

Moreover, if there are descriptors in DMA coherent memory, and there is
a bit in them which must be set to hand ownership over to the device
(eg, as in an ethernet driver) then _additionally_ the driver already
has to add an additional barrier between the remainder of the descriptor
update and handing the descriptor over, and that barrier should ensure
that *any* effects prior to the barrier are seen before the effects of
the accesses after the barrier.

That said, in __dma_page_cpu_to_dev() we do the L1 followed by the L2
cache.  The effects of cleaning out the L1 cache must be seen by the
L2 cache before the effects of cleaning the L2 cache.  So we _do_
have an ordering requirement there which is purely down to the
implementation, and not down to any other requirements.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
