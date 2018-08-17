From: john.garry@huawei.com (John Garry)
Date: Fri, 17 Aug 2018 14:03:28 +0100
Subject: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <cover.1534250425.git.robin.murphy@arm.com>
References: <cover.1534250425.git.robin.murphy@arm.com>
Message-ID: <db0d436a-6f3c-6161-0dd1-ac42f908c1ee@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/2018 14:04, Robin Murphy wrote:
> John raised the issue[1] that we have some unnecessary refcount contention
> in the DMA ops path which shows scalability problems now that we have more
> real high-performance hardware using iommu-dma. The x86 IOMMU drivers are
> sidestepping this by stashing domain references in archdata, but since
> that's not very nice for architecture-agnostic code, I think it's time to
> look at a generic API-level solution.
>
> These are a couple of quick patches based on the idea I had back when
> first implementing this lot, but didn't have any way to justify at the
> time. The third patch can be ignored for the sake of API discussion, but
> is included for completeness.
>
> Robin.
>

Some results:

PCIe NIC iperf test (128 processes, small packets):
Without patchset:
289232.00 rxpck/s

With patchset:
367283 rxpck/s

JFYI, with Leizhen's non-strict mode patchset + Robin's patchset:
1215539 rxpck/s

Leizhen can share non-strict mode results in his own patchset however.

We did also try the storage controller fio test with a lot of SAS SSD 
disks (24 disks, 24 fio processes) for Robin's patchset only, but did 
not see a significant change.

Thanks to Dongdong + chenxiang for testing.

Let me know if you require more info.

Thanks again,
John


>
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2018-August/029303.html
>
> Robin Murphy (3):
>   iommu: Add fast hook for getting DMA domains
>   iommu/dma: Use fast DMA domain lookup
>   arm64/dma-mapping: Mildly optimise non-coherent IOMMU ops
>
>  arch/arm64/mm/dma-mapping.c | 10 +++++-----
>  drivers/iommu/dma-iommu.c   | 23 ++++++++++++-----------
>  drivers/iommu/iommu.c       |  9 +++++++++
>  include/linux/iommu.h       |  1 +
>  4 files changed, 27 insertions(+), 16 deletions(-)
>
