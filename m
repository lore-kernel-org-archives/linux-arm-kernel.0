From: robin.murphy@arm.com (Robin Murphy)
Date: Fri,  6 Feb 2015 14:55:12 +0000
Subject: [RFC PATCH v2 0/3] arm64: IOMMU-backed DMA mapping
Message-ID: <cover.1423226542.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is an updated RFC to address some of the initial comments[1].
The first two patches of the original posting, along with the IOVA
series, are now in -next so aren't included here.

If this is starting to look tidy enough, then I'll get to work on
porting arch/arm as well so I can repost as a formal patch set.

Thanks,
Robin.


A branch with all the necessary bits is available at:

   git://linux-arm.org/linux-rm iommu/dma

Main changes since v1:
* rebased to -rc7
* moved common code to drivers/iommu, and tidied up the config
  dependencies
* renamed iommu_dma_mapping to better reflect that it's a managed domain
* abstracted away the explicit use of archdata
* finished the map_sg implementation
* fixed up the mmap implementation with the arch/arm one for now
* removed the iova_to_phys accessor in favour of (more flexibly)
  exposing the iommu domain for where it's needed

More complicated things still to do:
* understand and sort out the compound pages issue
* get domain and group allocation right - I'd like to try integrating
  Joerg's proposals for that area[2][3], which should help.

[1]:http://article.gmane.org/gmane.linux.kernel.iommu/8213
[2]:http://thread.gmane.org/gmane.linux.ports.tegra/20907
[3]:http://thread.gmane.org/gmane.linux.kernel.iommu/8492

Robin Murphy (3):
  iommu: implement common IOMMU ops for DMA mapping
  arm64: add IOMMU dma_ops
  arm64: hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/device.h      |   3 +
 arch/arm64/include/asm/dma-mapping.h |  28 +-
 arch/arm64/mm/dma-mapping.c          | 335 +++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 552 +++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h            |  94 ++++++
 8 files changed, 1016 insertions(+), 5 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
