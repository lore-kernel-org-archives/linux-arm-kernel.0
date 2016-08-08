From: sricharan@codeaurora.org (Sricharan R)
Date: Tue,  9 Aug 2016 04:19:02 +0530
Subject: [PATCH 0/8] IOMMU Probe deferral support
Message-ID: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is on top initial post from Laurent Pinchart[1]. This is
a try to see if the iommu ops configuration for the devices
can be called at a generic place so that it works for all
busses. The dma_configure_ops for a device is now called during
the device_attach callback just before the probe of the
bus/driver is called. Similarly dma_deconfigure is called during
device_detach. of_configure_dma_masks is still called for each
of the busses separately, but that can be combined with calling
dma_configure_ops if its safe to have masks not set till probe time.

Also based on comments [2] from last post [3], add_device callback
is called at the point when the ops for that iommu is found.

Have tested this with arm-smmu on platform bus and yet to test for
other busses (pci, amba), but those busses go through the same path
as well.

[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013016.html
[2] http://www.spinics.net/lists/arm-kernel/msg499962.html,
[3] http://www.spinics.net/lists/arm-kernel/msg506072.html

Laurent Pinchart (5):
  arm: dma-mapping: Don't override dma_ops in arch_setup_dma_ops()
  of: dma: Move range size workaround to of_dma_get_range()
  of: dma: Make of_dma_deconfigure() public
  of: dma: Split of_configure_dma() into mask and ops configuration
  iommu: of: Handle IOMMU lookup failure with deferred probing or error

Sricharan R (3):
  drivers: platform: Configure dma operations at probe time
  drivers: platform: Remove call to of_dma_(con/decon)figure_ops
  drivers: iommu: arm-smmu: Set iommu_ops in probe

 arch/arm/mm/dma-mapping.c   |  9 ++++++
 drivers/base/dd.c           | 11 +++++++
 drivers/base/dma-mapping.c  | 11 +++++++
 drivers/iommu/arm-smmu.c    | 17 ++--------
 drivers/iommu/of_iommu.c    | 21 ++++++++++---
 drivers/of/address.c        | 20 ++++++++++--
 drivers/of/device.c         | 77 ++++++++++++++++++++++++++++-----------------
 drivers/of/platform.c       | 11 ++-----
 drivers/pci/probe.c         |  3 +-
 include/linux/dma-mapping.h |  3 ++
 include/linux/of_device.h   | 14 +++++++--
 11 files changed, 136 insertions(+), 61 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
