From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 12 Sep 2018 16:24:11 +0100
Subject: [PATCH v2 0/3] iommu: Avoid DMA ops domain refcount contention 
Message-ID: <cover.1536764440.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John raised the issue[1] that we have some unnecessary refcount contention
in the DMA ops path which shows scalability problems now that we have more
real high-performance hardware using iommu-dma. The x86 IOMMU drivers are
sidestepping this by stashing domain references in archdata, but since
that's not very nice for architecture-agnostic code, I think it's time to
look at a generic API-level solution.

These are a couple of quick patches based on the idea I had back when
first implementing iommu-dma, but didn't have any way to justify at the
time. However, the reports of 10-25% better networking performance on v1
suggest that it's very worthwhile (and far more significant than I ever
would have guessed).

As far as merging goes, I don't mind at all whether this goes via IOMMU,
or via dma-mapping provided Joerg's happy to ack it.

Robin.


[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-August/029303.html

Robin Murphy (3):
  iommu: Add fast hook for getting DMA domains
  iommu/dma: Use fast DMA domain lookup
  arm64/dma-mapping: Mildly optimise non-coherent IOMMU ops

 arch/arm64/mm/dma-mapping.c | 10 +++++-----
 drivers/iommu/dma-iommu.c   | 23 ++++++++++++-----------
 drivers/iommu/iommu.c       |  9 +++++++++
 include/linux/iommu.h       |  1 +
 4 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.19.0.dirty
