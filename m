From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 20 Jun 2013 11:54:31 +0200
Subject: [Linaro-mm-sig] [RFC 2/3] ARM: dma-mapping: Pass DMA attrs as
 IOMMU prot
In-Reply-To: <CAMcxFTS0dUUEfGj-=-cb_rdfy+qWvtsaoR6Tv+-x05XX0mZmmw@mail.gmail.com>
References: <CAMcxFTRnnCnPnvMi89r7rUsN4xeYzZGqy9s5v5ukm_fJ_d_RGg@mail.gmail.com><20130620.112439.1330557591655135630.hdoyu@nvidia.com><CAMcxFTS0dUUEfGj-=-cb_rdfy+qWvtsaoR6Tv+-x05XX0mZmmw@mail.gmail.com>
Message-ID: <20130620.125431.1161068035083905855.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Peethambaran <nishanth.p@gmail.com> wrote @ Thu, 20 Jun 2013 10:55:32 +0200:

> Thinking again on it, I feel the translation of dma-attr should happen
> when dma-mapping code makes calls to " iommu mapping" API.
> "iommu mapping" API which does iova management and make iommu API
> calls could be taken out from dma-mapping.c, for which I see
> discussion already happening for arm64.

According to the discussion ARM64:dma-mapping, I got an implression
that IOVA management part in ARM:dma-mapping API would be a new common
module(ie: /lib/iommu-helper.c), but still IOMMU API itself would
reamin as primitive as what they are.

+---------------------------------
|     DMA mapping API
|                            +-----------------
+--------------+-----------+ | DMA mapping API($ARCH)
|   IOMMU API  |  IOVA MGT | +------------------
+--------------+-----------+
|IOMMU API(H/W)|
+--------------+
|  IOMMU H/W   |
+--------------+

> If devices allocate via dma-mapping API, physical mem allocation, iova
> allocation and iommu mapping happens internally.
> Devices may allocate physical memory using any allocator (say ION
> including carveout area), use "iommu mapping" API which will do iova
> allocation and iommu mapping. The prot flags could be useful in this
> case as well - not sure whether we would need dma-attrs here.

I haven't followed ION recently, but can't ION backed by DMA mapping
API instead of using IOMMU API directly?
