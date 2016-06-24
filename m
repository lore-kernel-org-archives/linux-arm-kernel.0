From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri, 24 Jun 2016 10:13:25 +0800
Subject: iommu/rockchip: Fix bugs and enable on ARM64
Message-ID: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series intends mostly to enable support for ARM64 architecture
in the rockchip-iommu driver. On the way to do so, some bugs are also
fixed.

The most important changes here are:
 - making the Rockchip IOMMU driver use DMA API for managing cache
   coherency of page tables,
 - making the Rockchip DRM driver not use DMA API on behalf of a virtual
   device (behind a virtual IOMMU) to allocate and map buffers, but
   instead proper DRM helpers and IOMMU API directly.

Changes since v4:
 - Address some coding style comments on:
    - https://chromium-review.googlesource.com/#/c/346328/38
    - https://chromium-review.googlesource.com/#/c/353591/10
Changes since v3:
 - Drop the idea of virtual IOMMU. Instead replace hacky allocation code
   in DRM driver, with proper management of IOMMU domain.
 - Add one more fix for allocation of IOMMU register base addresses.
Changes since v2:
 - Instead of registering virtual IOMMU from DTS, create it when
   attaching.
 - Fix some bugs found in internal review.

Shunqian Zheng (4):
  iommu/rockchip: Fix allocation of bases array in driver probe
  iommu/rockchip: Use DMA API to manage coherency
  iommu/rockchip: Prepare to support generic DMA mapping
  drm/rockchip: Use common IOMMU API to attach devices

Simon Xue (3):
  iommu/rockchip: Fix devm_{request,free}_irq parameter
  iommu/rockchip: Add map_sg callback for rk_iommu_ops
  iommu/rockchip: Enable Rockchip IOMMU on ARM64

Tomasz Figa (1):
  drm/rockchip: Do not use DMA mapping API if attached to IOMMU domain

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 100 +++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   3 +
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 221 ++++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   9 ++
 drivers/iommu/Kconfig                       |   2 +-
 drivers/iommu/rockchip-iommu.c              | 181 +++++++++++++++++------
 6 files changed, 413 insertions(+), 103 deletions(-)

-- 
1.9.1
