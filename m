From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 21 Nov 2013 15:40:36 +0200
Subject: [PATCHv6 00/13] Unifying SMMU driver among Tegra SoCs
Message-ID: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series provide:

(0) IOMMU standard DT binding("iommus")
(1) Unified IOMMU(SMMU) driver among Tegra SoCs
(2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
(3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.

There's been some discussion[1] about device population order, and for
the solution I implemented an IOMMU hook in driver core:

  [PATCHv6 04/13] driver/core: populate devices in order for IOMMUs

which is based on:
  http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006933.html

The main problem here is,

IOMMU devices on the bus need to be poplulated first, then iommu
master devices are done later.

With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
whether a device can be an iommu msater or not. If a device can, we'll
defer to populate that device till an iommu device is populated. Then,
those defered iommu master devices are populated and configured with
help of the already populated iommu device via a new IOMMU API
iommu_ops->driver_bound().

This "iommus=" binding is expected used as the global/standard binding.

Tested IOMMU functionality with T30 SD/MMC. Any further testing with
T114 and/or other devices would be really appreciated.

v5:
Use "iommus=" DT bindings as a standard IOMMU binding.

v4:
Add a hook in driver core to control device populatin order.
Introduced arm,smmu "mmu-master" binding instead of tegra own.
Removed DT patches from this series.
  http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006931.html

v3:
Updated based on Stephen Warren's feedback
  http://lists.linuxfoundation.org/pipermail/iommu/2013-October/006724.html

v2:
Updated based on Thierry Reding's and Stephen Warren's feedback
  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/181888.html

v1:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/180267.html

Available in the git repository at:

  git://git at nv-tegra.nvidia.com/user/hdoyu/linux.git smmu-upstreaming at 20131121


Hiroshi Doyu (13):
  of: introduce of_property_for_earch_phandle_with_args()
  iommu/of: introduce a global iommu device list
  iommu/of: check if dependee iommu is ready or not
  driver/core: populate devices in order for IOMMUs
  iommu/core: add ops->{bound,unbind}_driver()
  ARM: tegra: create a DT header defining SWGROUP ID
  iommu/tegra: smmu: register device to iommu dynamically
  iommu/tegra: smmu: calculate ASID register offset by ID
  iommu/tegra: smmu: get swgroups from DT "iommus="
  iommu/tegra: smmu: allow duplicate ASID wirte
  iommu/tegra: smmu: Rename hwgrp -> swgroups
  iommu/tegra: smmu: add SMMU to an global iommu list
  [FOR TEST] ARM: dt: tegra30: add "iommus" binding

 .../bindings/iommu/nvidia,tegra30-smmu.txt         |  30 +-
 arch/arm/boot/dts/tegra30.dtsi                     |  23 +-
 drivers/base/dd.c                                  |   5 +
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/iommu.c                              |  13 +-
 drivers/iommu/of_iommu.c                           |  53 +++
 drivers/iommu/tegra-smmu.c                         | 383 +++++++++++++--------
 include/dt-bindings/memory/tegra-swgroup.h         |  50 +++
 include/linux/iommu.h                              |   4 +
 include/linux/of.h                                 |   3 +
 include/linux/of_iommu.h                           |  22 ++
 11 files changed, 436 insertions(+), 151 deletions(-)
 create mode 100644 include/dt-bindings/memory/tegra-swgroup.h

-- 
1.8.1.5
