From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Apr 2014 10:09:27 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <20140423171727.GK5649@arm.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <201404222153.41786.arnd@arndb.de> <5356C9D1.2060001@ti.com>
 <5895821.PvurJ8TWz2@wuerfel> <5356D163.1070304@ti.com>
 <20140423090251.GA5281@arm.com> <20140423160216.GC2208@arm.com>
 <20140423171727.GK5649@arm.com>
Message-ID: <20140424090927.GB8521@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 06:17:27PM +0100, Will Deacon wrote:
> On Wed, Apr 23, 2014 at 05:02:16PM +0100, Catalin Marinas wrote:
> > On Wed, Apr 23, 2014 at 10:02:51AM +0100, Will Deacon wrote:
> > > On Tue, Apr 22, 2014 at 09:30:27PM +0100, Santosh Shilimkar wrote:
> > > > writel() or an explcit barrier in the driver will do the job. I was
> > > > just thinking that we are trying to work around the short comings
> > > > of streaming API by adding barriers in the driver. For example
> > > > on a non-coherent system, i don't need that barrier because
> > > > dma_ops does take care of that.
> > > 
> > > I wonder whether we can remove those barriers altogether then (from the DMA
> > > cache operations). For the coherent case, the driver must provide the
> > > barrier (probably via writel) so the non-coherent case shouldn't be any
> > > different.
> > 
> > For the DMA_TO_DEVICE case the effect should be the same as wmb()
> > implies dsb (and outer_sync() for write). But the reason we have
> > barriers in the DMA ops is slightly different - the completion of the
> > cache maintenance operation rather than ordering with any previous
> > writes to the DMA buffer.
> > 
> > In the DMA_FROM_DEVICE scenario for example, the CPU gets an interrupt
> > for a finished DMA transfer and executes dma_unmap_single() prior to
> > accessing the page. However the CPU access after unmapping is done using
> > normal LDR/STR which do not imply any barrier. So we need to ensure the
> > completion of the cache invalidation in the dma operation.
> 
> I don't think we necessarily need completion, we just need ordering. That
> is, the normal LDR/STR instructions must be observed after the cache
> maintenance. I'll have to revisit the ARM ARM to be sure of this, but a dmb
> should be sufficient for that guarantee.

If we only do D-cache maintenance by MVA, the ARM ARM (both v7 and v8)
claims that these are ordered relative to any explicit load/stores to
the same address. So in theory we don't even need a DMB for unmapping
with DMA_FROM_DEVICE. But in practice, we may have the outer cache,
hence a DSB is required before the outer_sync() (we could move it there
though).

-- 
Catalin
