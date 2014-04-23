From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Apr 2014 17:02:16 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <20140423090251.GA5281@arm.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <201404222153.41786.arnd@arndb.de> <5356C9D1.2060001@ti.com>
 <5895821.PvurJ8TWz2@wuerfel> <5356D163.1070304@ti.com>
 <20140423090251.GA5281@arm.com>
Message-ID: <20140423160216.GC2208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 10:02:51AM +0100, Will Deacon wrote:
> On Tue, Apr 22, 2014 at 09:30:27PM +0100, Santosh Shilimkar wrote:
> > writel() or an explcit barrier in the driver will do the job. I was
> > just thinking that we are trying to work around the short comings
> > of streaming API by adding barriers in the driver. For example
> > on a non-coherent system, i don't need that barrier because
> > dma_ops does take care of that.
> 
> I wonder whether we can remove those barriers altogether then (from the DMA
> cache operations). For the coherent case, the driver must provide the
> barrier (probably via writel) so the non-coherent case shouldn't be any
> different.

For the DMA_TO_DEVICE case the effect should be the same as wmb()
implies dsb (and outer_sync() for write). But the reason we have
barriers in the DMA ops is slightly different - the completion of the
cache maintenance operation rather than ordering with any previous
writes to the DMA buffer.

In the DMA_FROM_DEVICE scenario for example, the CPU gets an interrupt
for a finished DMA transfer and executes dma_unmap_single() prior to
accessing the page. However the CPU access after unmapping is done using
normal LDR/STR which do not imply any barrier. So we need to ensure the
completion of the cache invalidation in the dma operation.

In the I/O coherency case, I would say it is the responsibility of the
device/hardware to ensure that the data is visible to all observers
(CPUs) prior to issuing a interrupt for DMA-ready. Looking at the mvebu
code, I think it covers such scenario from-device or bidirectional
scenarios.

Maybe Santosh still has a point ;) but I don't know what the right
barrier would be here. And I really *hate* per-SoC/snoop unit barriers
(I still hope a dsb would do the trick on newer/ARMv8 systems).

> I need some more coffee and a serious look at the code, but we may be able
> to use dmb instructions to order the cache maintenance and avoid a final
> dsb for completion.

Is the dmb enough (assuming no outer cache)? We need to ensure the
flushed cache lines reach the memory for device access.

-- 
Catalin
