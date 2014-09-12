From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Sep 2014 17:34:48 +0100
Subject: [RFC PATCH v3 0/7] Introduce automatic DMA configuration for IOMMU
 masters
Message-ID: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is version three of the RFC I've previously posted here:

  RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
  RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html

Changes since RFCv2 include:

  - Put the iommu_ops in iommu_data so of_iommu_configure can avoid using
    the bus_type
  - Initialise the offset and DMA masks on the dev in of_dma_configure
    instead of in the arch callback (as this would cause a regression on
    some architectures)
  - Added deconfigure/teardown code based on ref counting the iommu_dma_mapping
  - A bunch of small fixes (_OF_DECLARE,  some code shuffling, fix multiple
    IOMMU parsing)

All feedback welcome. Hopefully this is now at a point where people can
start looking to port dma-mapping and/or IOMMU drivers to it.

Cheers,

Will

--->8

Will Deacon (7):
  iommu: provide early initialisation hook for IOMMU drivers
  dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
  iommu: add new iommu_ops callback for adding an OF device
  iommu: provide helper function to configure an IOMMU for an of master
  dma-mapping: detect and configure IOMMU in of_dma_configure
  arm: call iommu_init before of_platform_populate
  arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops

 arch/arm/include/asm/dma-mapping.h |  9 ++--
 arch/arm/kernel/setup.c            |  2 +
 arch/arm/mm/dma-mapping.c          | 68 ++++++++++++++++++++++++++----
 drivers/iommu/Kconfig              |  2 +-
 drivers/iommu/of_iommu.c           | 84 ++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c              | 53 +++++++++++++-----------
 include/asm-generic/vmlinux.lds.h  |  2 +
 include/linux/dma-mapping.h        | 21 +++++++---
 include/linux/iommu.h              | 15 +++++++
 include/linux/of_iommu.h           | 35 ++++++++++++++++
 10 files changed, 247 insertions(+), 44 deletions(-)

-- 
2.1.0
