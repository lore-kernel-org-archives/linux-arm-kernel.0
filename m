From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  6 Oct 2016 08:45:16 +0000
Subject: [PATCH v13 00/15] KVM PCIe/MSI passthrough on ARM/ARM64
Message-ID: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following Robin's series [1], addressing MSI IOMMU mapping for devices
attached to a DMA ops domain, quite a lot of changes (and simplifications)
were induced with respect to the v12 iteration:

- msi-iommu API role now is handled at dma-iommu level
- MSI doorbell registration API still is used for security assessment
  and doorbell overall iommu page size computation.
- MSI layer part II is not needed anymore since mapping directly is
  done in the irqchip compose callback.

The VFIO user API and VFIO layer changes have not changed though. All the
patches now are in the same series.

Tested on AMD Overdrive (single GICv2m frame) with I350 VF assignment.

dependency:
the series depends on Robin's generic-v7 branch:
[1] [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
http://www.spinics.net/lists/arm-kernel/msg531110.html

Best Regards

Eric

Git: complete series available at
https://github.com/eauger/linux/tree/generic-v7-pcie-passthru-v13

the above branch includes a temporary patch to work around a ThunderX pci
bus reset crash (which I think unrelated to this series):
"vfio: pci: HACK! workaround thunderx pci_try_reset_bus crash"
Do not take this one for other platforms.

Eric Auger (14):
  iommu: Introduce DOMAIN_ATTR_MSI_GEOMETRY
  iommu/arm-smmu: Initialize the msi geometry
  genirq/msi: Introduce the MSI doorbell API
  genirq/msi: msi_doorbell_calc_pages
  irqchip/gic-v2m: Register the MSI doorbell
  irqchip/gicv3-its: Register the MSI doorbell
  vfio: Introduce a vfio_dma type field
  vfio/type1: vfio_find_dma accepting a type argument
  vfio/type1: Implement recursive vfio_find_dma_from_node
  vfio/type1: Handle unmap/unpin and replay for VFIO_IOVA_RESERVED slots
  vfio: Allow reserved msi iova registration
  vfio/type1: Check doorbell safety
  iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP
  vfio/type1: Return the MSI geometry through VFIO_IOMMU_GET_INFO
    capability chains

Robin Murphy (1):
  iommu/dma: Allow MSI-only cookies

 drivers/iommu/Kconfig            |   2 +
 drivers/iommu/arm-smmu-v3.c      |   5 +-
 drivers/iommu/arm-smmu.c         |   6 +-
 drivers/iommu/dma-iommu.c        |  40 +++++++
 drivers/iommu/iommu.c            |   5 +
 drivers/irqchip/irq-gic-v2m.c    |  11 +-
 drivers/irqchip/irq-gic-v3-its.c |  14 +++
 drivers/vfio/Kconfig             |   1 +
 drivers/vfio/vfio_iommu_type1.c  | 244 ++++++++++++++++++++++++++++++++++++---
 include/linux/dma-iommu.h        |   9 ++
 include/linux/iommu.h            |  14 +++
 include/linux/msi-doorbell.h     |  92 +++++++++++++++
 include/uapi/linux/vfio.h        |  42 ++++++-
 kernel/irq/Kconfig               |   4 +
 kernel/irq/Makefile              |   1 +
 kernel/irq/msi-doorbell.c        | 162 ++++++++++++++++++++++++++
 16 files changed, 633 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/msi-doorbell.h
 create mode 100644 kernel/irq/msi-doorbell.c

-- 
1.9.1
