From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Apr 2014 11:13:56 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <20140424091624.GG26756@n2100.arm.linux.org.uk>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <201404222153.41786.arnd@arndb.de> <5356C9D1.2060001@ti.com>
 <5895821.PvurJ8TWz2@wuerfel> <5356D163.1070304@ti.com>
 <20140423090251.GA5281@arm.com> <20140423160216.GC2208@arm.com>
 <20140423171727.GK5649@arm.com> <20140424090927.GB8521@arm.com>
 <20140424091624.GG26756@n2100.arm.linux.org.uk>
Message-ID: <20140424101355.GD8521@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 10:16:24AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 24, 2014 at 10:09:27AM +0100, Catalin Marinas wrote:
> > If we only do D-cache maintenance by MVA, the ARM ARM (both v7 and v8)
> > claims that these are ordered relative to any explicit load/stores to
> > the same address. So in theory we don't even need a DMB for unmapping
> > with DMA_FROM_DEVICE. But in practice, we may have the outer cache,
> > hence a DSB is required before the outer_sync() (we could move it there
> > though).
> 
> The general usecase for outer_sync() is: dsb(); outer_sync();  Why would
> we want to change this to dsb(); dmb(); outer_sync(); (where the dmb is
> in outer_sync itself?)
> 
> Seems more sensible for it to stay at the outer_sync() call site where
> it's needed.

You are right, it gets worse for the wmb() case if we change
outer_sync(), I was thinking about cache maintenance.

An optimisation would be for functions like v7_dma_inv_range() to no
longer have the dsb but move it to the __dma_page_cpu_to_dev() before
the outer_*_range() ops. If we assume that a streaming DMA is started by
a writel() access which has a dsb already, in the absence of outer cache
we wouldn't need any dsb at all, hence something like a conditional
sync_for_outer() barrier (dsb if outer cache or no-op otherwise) in
__dma_page_cpu_to_dev().

In the __dma_page_dev_to_cpu() we wouldn't need any dsb at all for cache
maintenance since subsequent accesses to the same address are ordered by
the hardware (and outer cache maintenance is done before the inner
anyway).

(that's from an ARMv7 perspective, we need to check ordering on earlier
architectures)

-- 
Catalin
