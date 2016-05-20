From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 20 May 2016 16:24:47 +0530
Subject: [PATCH V5 0/7] iommu/msm: Add DT adaptation and generic bindings
 support
Message-ID: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
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

[V5] Changed the compatible binding name as per comments, added comments
     for usage of barriers in patch 6.

[V4] Addressed comments for making the iommu compatible binding more soc
     specific and updated the documentation for the iommu clocks.

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

 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 ++
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/msm_iommu.c                          | 885 +++++++++++----------
 drivers/iommu/msm_iommu.h                          |  73 +-
 drivers/iommu/msm_iommu_dev.c                      | 381 ---------
 drivers/iommu/msm_iommu_hw-8xxx.h                  | 109 +--
 7 files changed, 636 insertions(+), 880 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 delete mode 100644 drivers/iommu/msm_iommu_dev.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
