From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Nov 2014 18:56:29 +0000
Subject: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for IOMMU
 masters
Message-ID: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everybody,

Here is the fourth iteration of the RFC I've previously posted here:

  RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
  RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
  RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html

Changes since RFCv3 include:

  - Drastic simplification of the data structures, so that we no longer
    pass around lists of domains. Instead, dma-mapping is expected to
    allocate the domain (Joerg talked about adding a get_default_domain
    operation to iommu_ops).

  - iommu_ops is used to hold the per-instance IOMMU data

  - Configuration of DMA segments added to of_dma_configure

All feedback welcome.

Cheers,

Will

--->8

Will Deacon (8):
  iommu: provide early initialisation hook for IOMMU drivers
  dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
  iommu: add new iommu_ops callback for adding an OF device
  iommu: provide helper function to configure an IOMMU for an of master
  dma-mapping: detect and configure IOMMU in of_dma_configure
  dma-mapping: set dma segment properties in of_dma_configure
  arm: call iommu_init before of_platform_populate
  arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops

 arch/arm/include/asm/dma-mapping.h | 12 +++---
 arch/arm/kernel/setup.c            |  2 +
 arch/arm/mm/dma-mapping.c          | 80 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/Kconfig              |  2 +-
 drivers/iommu/of_iommu.c           | 50 ++++++++++++++++++++++++
 drivers/of/platform.c              | 54 +++++++++++++------------
 include/asm-generic/vmlinux.lds.h  |  2 +
 include/linux/amba/bus.h           |  1 +
 include/linux/dma-mapping.h        | 13 ++++---
 include/linux/iommu.h              |  8 ++++
 include/linux/of_iommu.h           | 31 +++++++++++++++
 include/linux/platform_device.h    |  2 +
 12 files changed, 214 insertions(+), 43 deletions(-)

-- 
2.1.1
