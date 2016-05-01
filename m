From: sricharan@codeaurora.org (Sricharan R)
Date: Mon,  2 May 2016 00:24:28 +0530
Subject: [PATCH V3 0/7] iommu/msm: Add DT adaptation and generic bindings
 support
Message-ID: <1462128875-20988-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm_iommu.c driver currently works based on platform data.
A single master device can be connected to more than one iommu and multiple
contexts in each of the iommu. This association between master and iommus was
represented from platform data using parent/child devices. The master drivers
were responsible for attaching all of the iommus/context to a domain. Now the
platform data support is removed and DT support is added. The master/iommus are
added through generic iommu bindings.

This is essentially rework of the patch posted earlier by
Rob Clark <robdclark@gmail.com>. This series folds the changes in to the
existing driver with the addition of generic bindings.

        http://www.spinics.net/lists/linux-arm-msm/msg10077.html

Tested this series on ifc6410 board.

[V3] Addressed comments to correct the usage
     of the #iommu-cells binding, improve the flush_iotlb_range function,
     added a new patch to use writel_relaxed for register access and split
     up the documentation patch.

[V2] Adapted the driver to use generic ARMV7S short descriptor pagetable ops
     and addressed comments.

[V1]
   https://lists.linuxfoundation.org/pipermail/iommu/2015-August/014074.html

Sricharan R (7):
  iommu/msm: Add DT adaptation
  documentation: iommu: Add bindings for msm,iommu-v0 ip
  iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
  iommu/msm: Add support for generic master bindings
  iommu/msm: use generic ARMV7S short descriptor pagetable ops
  iommu/msm: Use writel_relaxed and add a barrier
  iommu/msm: Remove driver BROKEN

 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  62 ++
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/msm_iommu.c                          | 872 +++++++++++----------
 drivers/iommu/msm_iommu.h                          |  73 +-
 drivers/iommu/msm_iommu_dev.c                      | 381 ---------
 drivers/iommu/msm_iommu_hw-8xxx.h                  |   7 +-
 7 files changed, 567 insertions(+), 832 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 delete mode 100644 drivers/iommu/msm_iommu_dev.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
