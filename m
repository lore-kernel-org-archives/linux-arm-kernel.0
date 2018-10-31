From: vdumpa@nvidia.com (Krishna Reddy)
Date: Wed, 31 Oct 2018 16:43:45 -0700
Subject: [PATCH v2 0/5] Add Tegra194 Dual ARM SMMU driver
Message-ID: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Xavier (Tegra194) SOC has three ARM SMMU(MMU-500) instances.
Two of the SMMU instances are used to interleave IOVA accesses across them.
The IOVA accesses from HW devices are interleaved across these two SMMU instances
and they need to be programmed identical.

The existing ARM SMMU driver can't be used in its current form for programming the
two SMMU instances identically. But, most of the code can be shared between ARM SMMU
driver and Tegra194 SMMU driver.
Page fault handling and TLB sync operations need to know about specific instance
of SMMU for correct fault handling and optimal TLB sync wait. Rest of the code doesn't
need to know about number of SMMU instances. Based on this fact, The patch series here
rearranges the arm-smmu.c code to allow sharing most of the ARM SMMU programming/iommu_ops
code between ARM SMMU driver and Tegra194 SMMU driver and transparently
handles programming of two SMMU instances.

The third SMMU instance would use the existing ARM SMMU driver.

Changes in v2:
* Added CONFIG_ARM_SMMU_TEGRA to protect Tegra194 SMMU driver compilation
* Enabled CONFIG_ARM_SMMU_TEGRA in defconfig
* Added SMMU nodes in Tegra194 device tree

Krishna Reddy (5):
  iommu/arm-smmu: rearrange arm-smmu.c code
  iommu/arm-smmu: Prepare fault, probe, sync functions for sharing code
  iommu/tegra194_smmu: Add Tegra194 SMMU driver
  arm64: defconfig: Enable ARM_SMMU_TEGRA
  arm64: tegra: Add SMMU nodes to Tegra194 device tree

 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  148 ++
 arch/arm64/configs/defconfig             |    1 +
 drivers/iommu/Kconfig                    |   10 +
 drivers/iommu/Makefile                   |    1 +
 drivers/iommu/arm-smmu-common.c          | 1971 +++++++++++++++++++++++++++
 drivers/iommu/arm-smmu-common.h          |  256 ++++
 drivers/iommu/arm-smmu.c                 | 2167 +-----------------------------
 drivers/iommu/tegra194-smmu.c            |  201 +++
 8 files changed, 2595 insertions(+), 2160 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-common.c
 create mode 100644 drivers/iommu/arm-smmu-common.h
 create mode 100644 drivers/iommu/tegra194-smmu.c

-- 
2.1.4
