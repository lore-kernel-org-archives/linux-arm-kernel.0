From: ohaugan@codeaurora.org (Olav Haugan)
Date: Mon, 30 Jun 2014 09:51:49 -0700
Subject: [RFC/PATCH 0/7] Add MSM SMMUv1 support
Message-ID: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for Qualcomm MSM SMMUv1 hardware. The first patch
renames the files for the existing MSM IOMMU driver to align with the SMMU
hardware revision (v1 is ARM SMMUv1 spec). The second patch adds back
map_range/unmap_range APIs. These APIs allows SMMU driver implementations to
optimize mappings of scatter-gather list of physically contiguous chunks of
memory. The third patch adds common macros to allow device drivers to poll
memory mapped registers. The fourth and fifth patch is the actual MSM SMMUv1
driver which supports the following:

	- ARM V7S and V7L page table format independent of ARM CPU page table
	  format
	- 4K/64K/1M/16M mappings (V7S)
	- 4K/64K/2M/32M/1G mappings (V7L)
	- ATOS used for unit testing of driver
	- Sharing of page tables among SMMUs
	- Verbose context bank fault reporting
	- Verbose global fault reporting
	- Support for clocks and GDSC
	- map/unmap range
	- Domain specific enabling of coherent Hardware Table Walk (HTW)

The last patch adds a new IOMMU domain attribute allowing us to set whether
hardware table walks should go to cache or not.

Matt Wagantall (1):
  iopoll: Introduce memory-mapped IO polling macros

Olav Haugan (6):
  iommu: msm: Rename iommu driver files
  iommu-api: Add map_range/unmap_range functions
  iommu: msm: Add MSM IOMMUv1 driver
  iommu: msm: Add support for V7L page table format
  defconfig: msm: Enable Qualcomm SMMUv1 driver
  iommu-api: Add domain attribute to enable coherent HTW

 .../devicetree/bindings/iommu/msm,iommu_v1.txt     |   60 +
 arch/arm/configs/qcom_defconfig                    |    3 +-
 drivers/iommu/Kconfig                              |   57 +-
 drivers/iommu/Makefile                             |    8 +-
 drivers/iommu/iommu.c                              |   24 +
 drivers/iommu/{msm_iommu.c => msm_iommu-v0.c}      |    2 +-
 drivers/iommu/msm_iommu-v1.c                       | 1529 +++++++++++++
 drivers/iommu/msm_iommu.c                          |  771 +------
 .../iommu/{msm_iommu_dev.c => msm_iommu_dev-v0.c}  |    2 +-
 drivers/iommu/msm_iommu_dev-v1.c                   |  345 +++
 .../{msm_iommu_hw-8xxx.h => msm_iommu_hw-v0.h}     |    0
 drivers/iommu/msm_iommu_hw-v1.h                    | 2322 ++++++++++++++++++++
 drivers/iommu/msm_iommu_pagetable.c                |  600 +++++
 drivers/iommu/msm_iommu_pagetable.h                |   33 +
 drivers/iommu/msm_iommu_pagetable_lpae.c           |  717 ++++++
 drivers/iommu/msm_iommu_priv.h                     |   65 +
 include/linux/iommu.h                              |   25 +
 include/linux/iopoll.h                             |  114 +
 include/linux/qcom_iommu.h                         |  221 ++
 19 files changed, 6236 insertions(+), 662 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt
 copy drivers/iommu/{msm_iommu.c => msm_iommu-v0.c} (99%)
 create mode 100644 drivers/iommu/msm_iommu-v1.c
 rename drivers/iommu/{msm_iommu_dev.c => msm_iommu_dev-v0.c} (99%)
 create mode 100644 drivers/iommu/msm_iommu_dev-v1.c
 rename drivers/iommu/{msm_iommu_hw-8xxx.h => msm_iommu_hw-v0.h} (100%)
 create mode 100644 drivers/iommu/msm_iommu_hw-v1.h
 create mode 100644 drivers/iommu/msm_iommu_pagetable.c
 create mode 100644 drivers/iommu/msm_iommu_pagetable.h
 create mode 100644 drivers/iommu/msm_iommu_pagetable_lpae.c
 create mode 100644 drivers/iommu/msm_iommu_priv.h
 create mode 100644 include/linux/iopoll.h
 create mode 100644 include/linux/qcom_iommu.h

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
