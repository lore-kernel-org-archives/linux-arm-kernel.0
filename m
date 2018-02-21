From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 21 Feb 2018 15:59:10 -0700
Subject: [RFC 00/14] Per-instance pagetables for MSM GPUs
Message-ID: <20180221225924.30737-1-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a request for comment for support in the iommu, arm-smmu
and MSM GPU driver to support per (GPU) instance pagetables.

The general idea behind per-instance pagetables is that each GPU
client can have its own pagetable and virtual memory space which
prevents malicious or accidental corruption or copying.  We say
per-instance because the pagetables are unique to each DRM file
handle and there could be multiple instances per process.

In newer arm-smmu implementations this behavior could be managed
with hardware based PASIDs (see Jean Phillipe's epic SVA
stack https://patchwork.kernel.org/patch/10214963/)
but all the MSM GPU implementations in existence use
arm-smmu-v2 which doesn't have the ability to support switching
pagetables in hardware. As a result the vendor has added a bit
of hardware specific glue to allow the GPU microcode to switch
the pagetable asynchronously during execution (basically it
reaches out and reprograms some of the context bank registers).

To support all of this we need a handful of changes to allow
the client driver to create a properly formatted pagetable and
directly map and unmap buffers inside of that pagetable and
get the parameters (i.e. the physical address of the pagetable)
to program into the GPU at the appropriate time.

This stack builds on the aforementioned code from Jean-Phillipe to
add the needed support to iommu core and arm-smmu and then implement
per-instance pagetables in the MSM DRM GPU driver for the a5xx
family (tested on the db820c).

The first two patches add support to create enable a TTBR1 pagetable
for arm-smmuv-2 if the appropriate domain attribute is selected.
It creates a pagetable and programs the appropriate registers to
enable TTBR1.  The sign extension bit is programmed as the highest
bit in the ibs region (or the special 48th bit when the UBS is 49
bits).  The correct pagetable is automatically selected for
map/unmap based on the sign extension bit.

The next three patches add "virtual" pasid support. This allows
a client to allocate a pasid which is an index to a pagetable
structure. The pasid token is used to map and unmap entries
in that pagetable structure.  The existing pasid idr for SVA
is reused so that clients that also support hardware PASID
entries can use both types if they wish.

Th next patch adds a special side-band function for arm-smmu
that registers two callbacks to inform the client driver when
a new pasid is created/destroyed. This allows the arm-smmu
driver to pass the pagetable information (ttbr and asid) to
the client without needing changes to the IOMMU core.

All the following patches are for the DRM/GPU driver.  The
first enables 64 bit mode for a5xx which lets us use all
48 bits.  The next patch 5 patches are infrastructure patches
to cleanup address spaces and prepare for having a per-instance
address space and the final patch enables per-instance pagetables
for a5xx and implements the PM4 to switch the pagetable at create
time.

Please know that nearly all of this is up for discussion. In particular
since we all know that the two hardest problems in computer science are
caches, naming and off-by-one errors I am open to fixing the vocabulary
and terminology for "pasid" and "per-instance" and whatever - please
paint that bikeshed if you feel so inclined. Thanks for reading this
far. On with the code.

Applies against git://linux-arm.org/linux-jpb.git sva/v1

Jordan Crouse (14):
  iommu: Add DOMAIN_ATTR_ENABLE_TTBR1
  iommu/arm-smmu: Add support for TTBR1
  iommu: Create a base struct for io_mm
  iommu: sva: Add support for pasid allocation
  iommu: arm-smmu: Add pasid implementation
  iommu: arm-smmu: Add side-band function to specific pasid callbacks
  drm/msm: Enable 64 bit mode by default
  drm/msm: Pass the MMU domain index in struct msm_file_private
  drm/msm/gpu: Support using TTBR1 for kernel buffer objects
  drm/msm: Add msm_mmu features
  drm/msm: Add support for iommu-sva PASIDs
  drm/msm: Add support for per-instance address spaces
  drm/msm: Support per-instance address spaces
  drm/msm/a5xx: Support per-instance pagetables

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     |  69 +++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  17 ++
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c |  76 ++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c   |  11 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 +
 drivers/gpu/drm/msm/msm_drv.c             |  45 +++--
 drivers/gpu/drm/msm/msm_drv.h             |   4 +
 drivers/gpu/drm/msm/msm_gem.h             |   1 +
 drivers/gpu/drm/msm/msm_gem_submit.c      |  13 +-
 drivers/gpu/drm/msm/msm_gem_vma.c         |  36 +++-
 drivers/gpu/drm/msm/msm_gpu.c             |  25 ++-
 drivers/gpu/drm/msm/msm_gpu.h             |   4 +-
 drivers/gpu/drm/msm/msm_iommu.c           | 186 ++++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h             |  19 ++
 drivers/gpu/drm/msm/msm_ringbuffer.h      |   1 +
 drivers/iommu/arm-smmu-regs.h             |   2 -
 drivers/iommu/arm-smmu-v3.c               |   8 +-
 drivers/iommu/arm-smmu.c                  | 210 +++++++++++++++++++++-
 drivers/iommu/io-pgtable-arm.c            | 160 +++++++++++++++--
 drivers/iommu/io-pgtable-arm.h            |  20 +++
 drivers/iommu/io-pgtable.h                |  16 +-
 drivers/iommu/iommu-sva.c                 | 289 ++++++++++++++++++++++++++++--
 drivers/iommu/iommu.c                     |   3 +-
 include/linux/arm-smmu.h                  |  18 ++
 include/linux/iommu.h                     |  68 ++++++-
 25 files changed, 1205 insertions(+), 101 deletions(-)
 create mode 100644 include/linux/arm-smmu.h

-- 
2.16.1
