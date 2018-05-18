From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:44 -0600
Subject: [RFC v2 00/16] Private PASID and per-instance pagetables
Message-ID: <20180518213500.31595-1-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of a patchset of changes to implmeent private PASID support
for arm-smmu-v2 targets and implement per-instance pagetables for
MSM GPUs.

Per-instance pagetables allow the target GPU driver to create and manage
an individual pagetable for each file descriptor instance and switch
between them asynchronously using the GPU to reprogram the pagetable
registers on the fly.

This is done by expanding the shared PASID support from Jean Phillipe [1]
to create a "private" version of a PASID that enables a IOMMU driver
(arm-smmu-v2) to allocate a new pagetable and associate it with a PASID
identifier. That identifier could then be passed to a set of iommu
map/unmap functions to map entries into the new pagetable. Using a
set of sideband functions the GPU driver can get the TTBR0 and 
other information for each PASID and use that information to
reporgram the pagetables.

The first three patches implement split pagetables for arm-smmu-v2
targets. This allows the GPU to take advantage of split pagetables
to map global buffers that won't be affected by the pagetable switch.

The next 3 patches implement private PASID support by adding a few
new API hooks and piggybacking on existing functions from the shared
PASID effort.

The next 8 patches hook up the MSM-GPU driver to implement and use
per-instance pagetables if available.

And finally the last 2 patches are a re-post of changes I provided
a few weeks ago to get the GPU driver to "opt out" of the DMA domain
and thus keeps the context bank free for the GPU domain (which is
important because the per-instance mechanism only knows how to work
on context bank 0).

All of this is based on top of Jean Phillipe's latest tree available
from.
	git://linux-arm.org/linux-jpb.git sva/v2

[changes from v1]:
 * Switch the domain attribute to SPLIT_TABLES (Robin Murphy)
 * Reuse existing mm hooks as much as possible (Jean Phillipe Brucker)
 * Consolidate iommu map/unmap code (Jean Phillipe Brucker)

[1] https://patchwork.kernel.org/patch/10394883/

Jordan Crouse (16):
  iommu: Add DOMAIN_ATTR_SPLIT_TABLES
  iommu/arm-smmu: Add split pagetable support for arm-smmu-v2
  iommu/io-pgtable-arm: Remove ttbr[1] from io_pgtbl_cfg
  iommu: sva: Add support for private PASIDs
  iommu: arm-smmu: Add support for private PASIDs
  iommu: arm-smmu: Add side-band function for specific PASID callbacks
  drm/msm: Enable 64 bit mode by default
  drm/msm: Pass the MMU domain index in struct msm_file_private
  drm/msm/gpu: Support using split page tables for kernel buffer objects
  drm/msm: Add msm_mmu features
  drm/msm: Add support for iommu-sva PASIDs
  drm/msm: Add support for per-instance address spaces
  drm/msm/a5xx: Support per-instance pagetables
  drm/msm: Support per-instance address spaces
  iommu: Gracefully allow drivers to not attach to a default domain
  iommu/arm-smmu: Add list of devices to opt out of DMA domains

 drivers/gpu/drm/msm/Kconfig               |   1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     |  69 ++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  17 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c |  74 ++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c   |  11 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 +
 drivers/gpu/drm/msm/msm_drv.c             |  45 ++-
 drivers/gpu/drm/msm/msm_drv.h             |   4 +
 drivers/gpu/drm/msm/msm_gem.h             |   1 +
 drivers/gpu/drm/msm/msm_gem_submit.c      |  11 +-
 drivers/gpu/drm/msm/msm_gem_vma.c         |  37 ++-
 drivers/gpu/drm/msm/msm_gpu.c             |  24 +-
 drivers/gpu/drm/msm/msm_gpu.h             |   4 +-
 drivers/gpu/drm/msm/msm_iommu.c           | 192 ++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h             |  19 ++
 drivers/gpu/drm/msm/msm_ringbuffer.h      |   1 +
 drivers/iommu/arm-smmu-regs.h             |  18 ++
 drivers/iommu/arm-smmu-v3-context.c       |   2 +-
 drivers/iommu/arm-smmu.c                  | 370 ++++++++++++++++++++--
 drivers/iommu/io-pgtable-arm-v7s.c        |   3 +-
 drivers/iommu/io-pgtable-arm.c            |   8 +-
 drivers/iommu/io-pgtable.h                |  14 +-
 drivers/iommu/iommu-sva.c                 | 139 +++++++-
 drivers/iommu/iommu.c                     |  83 +++--
 drivers/iommu/ipmmu-vmsa.c                |   2 +-
 drivers/iommu/msm_iommu.c                 |   4 +-
 drivers/iommu/mtk_iommu.c                 |   4 +-
 drivers/iommu/qcom_iommu.c                |   3 +-
 include/linux/arm-smmu.h                  |  18 ++
 include/linux/iommu.h                     |  75 ++++-
 30 files changed, 1137 insertions(+), 121 deletions(-)
 create mode 100644 include/linux/arm-smmu.h

-- 
2.17.0
