From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Apr 2011 15:29:30 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110427230344I.fujita.tomonori@lab.ntt.co.jp>
References: <201104212129.17013.arnd@arndb.de>
	<BANLkTinPbZZS9F1tRCA73fgoD-y__jSfCA@mail.gmail.com>
	<20110427230344I.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <1303914570.15101.33.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-04-27 at 15:06 +0100, FUJITA Tomonori wrote:
> On Wed, 27 Apr 2011 10:52:25 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > Anyway, we end up with different DMA ops per device via dev_archdata.
> 
> Several architectures already do. What's wrong with the approach for
> arm?

Nothing wrong IMHO but it depends on how you group the DMA ops as it may
not be feasible to have all the combinations dmabounce/iommu/coherency
combinations. I think the main combinations would be:

1. standard (no-iommu) + non-coherent
2. standard (no-iommu) + coherent
3. iommu + non-coherent
4. iommu + coherent
5. dmabounce + non-coherent
6. dmabounce + coherent

I think dmabounce and iommu can be exclusive (unless the iommu cannot
access the whole RAM). If that's the case, we can have three type of DMA
ops:

1. standard
2. iommu
3. dmabounce

with an additional flag via dev_archdata for cache coherency level (a
device may be able to snoop the L1 or L2 cache etc.)

-- 
Catalin
