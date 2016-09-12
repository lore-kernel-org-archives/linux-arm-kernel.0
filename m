From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 12 Sep 2016 17:13:38 +0100
Subject: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Message-ID: <cover.1473695704.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

To any more confusing fixups and crazily numbered extra patches, here's
a quick v7 with everything rebased into the right order. The significant
change this time is to implement iommu_fwspec properly from the start,
which ends up being far simpler and more robust than faffing about
introducing it somewhere 'less intrusive' to move toward core code later.

New branch in the logical place:

git://linux-arm.org/linux-rm iommu/generic-v7

Robin.

Mark Rutland (1):
  Docs: dt: add PCI IOMMU map bindings

Robin Murphy (21):
  of/irq: Break out msi-map lookup (again)
  iommu/of: Handle iommu-map property for PCI
  iommu: Introduce iommu_fwspec
  Docs: dt: document ARM SMMUv3 generic binding usage
  iommu/arm-smmu: Fall back to global bypass
  iommu/arm-smmu: Implement of_xlate() for SMMUv3
  iommu/arm-smmu: Support non-PCI devices with SMMUv3
  iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
  iommu/arm-smmu: Handle stream IDs more dynamically
  iommu/arm-smmu: Consolidate stream map entry state
  iommu/arm-smmu: Keep track of S2CR state
  iommu/arm-smmu: Refactor mmu-masters handling
  iommu/arm-smmu: Streamline SMMU data lookups
  iommu/arm-smmu: Add a stream map entry iterator
  iommu/arm-smmu: Intelligent SMR allocation
  iommu/arm-smmu: Convert to iommu_fwspec
  Docs: dt: document ARM SMMU generic binding usage
  iommu/arm-smmu: Wire up generic configuration support
  iommu/arm-smmu: Set domain geometry
  iommu/dma: Add support for mapping MSIs
  iommu/dma: Avoid PCI host bridge windows

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   8 +-
 .../devicetree/bindings/iommu/arm,smmu.txt         |  63 +-
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.h          |   2 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 386 +++++----
 drivers/iommu/arm-smmu.c                           | 962 ++++++++++-----------
 drivers/iommu/dma-iommu.c                          | 161 +++-
 drivers/iommu/iommu.c                              |  56 ++
 drivers/iommu/of_iommu.c                           |  52 +-
 drivers/irqchip/irq-gic-v2m.c                      |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   |   3 +
 drivers/of/irq.c                                   |  78 +-
 drivers/of/of_pci.c                                | 102 +++
 include/linux/device.h                             |   3 +
 include/linux/dma-iommu.h                          |  12 +-
 include/linux/iommu.h                              |  38 +
 include/linux/of_pci.h                             |  10 +
 19 files changed, 1323 insertions(+), 791 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

-- 
2.8.1.dirty
