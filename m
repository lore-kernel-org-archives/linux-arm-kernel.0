From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 10 Nov 2011 11:32:24 +0200
Subject: [PATCH v4-rebased 0/7] iommu: split mapping to page sizes as
 supported by the hardware
Message-ID: <1320917551-11328-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3->v4:
- simplify splitter logic (Joerg)
- declare supported page-sizes in the iommu_ops, without extending iommu_register (Joerg)
- iommu_unmap should now return bytes too (Joerg)
- don't cache min_pgsize anymore (Joerg)
- handle cases when ->unmap() actually unmaps more than requested (Joerg)
- unroll iommu_unmap completely in case it fails (KyongHo)
- use size_t for size parameters (KyongHo)
- add a patch to remove the bytes->order->bytes conversion we had
- rabased to master branch of the iommu tree (Joerg)
  (and now rebased to 3.2-rc1)

v2->v3:
- s/KB/KiB/ (David W)

v1->v2:
- split to patches (by keeping the old code around until all drivers are converted) (Joerg)

Tested with OMAP4 (with rpmsg/remoteproc) and compile tested for X86-64.

Ohad Ben-Cohen (7):
  iommu/core: stop converting bytes to page order back and forth
  iommu/core: split mapping to page sizes as supported by the hardware
  iommu/omap: announce supported page sizes
  iommu/msm: announce supported page sizes
  iommu/amd: announce supported page sizes
  iommu/intel: announce supported page sizes
  iommu/core: remove the temporary pgsize settings

 drivers/iommu/amd_iommu.c   |   32 +++++++++---
 drivers/iommu/intel-iommu.c |   30 ++++++++---
 drivers/iommu/iommu.c       |  119 ++++++++++++++++++++++++++++++++++++++----
 drivers/iommu/msm_iommu.c   |   25 ++++-----
 drivers/iommu/omap-iommu.c  |   18 +++---
 drivers/iommu/omap-iovmm.c  |   17 ++----
 include/linux/iommu.h       |   26 +++++++--
 virt/kvm/iommu.c            |    8 ++--
 8 files changed, 205 insertions(+), 70 deletions(-)

-- 
1.7.5.4
