From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 21 Jul 2015 15:30:28 +0800
Subject: [PATCH v3 0/5] iommu/arm-smmu: add support for non-pci devices
Message-ID: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v2 -> v3:
1. add support for pci device hotplug, which missed in patch v2.
2. only support #iommu-cells = <1>, add corresponding description in arm,smmu-v3.txt.
3. add function find_smmu_by_device which extracted from find_smmu_by_node, to resolve
   the problem mentioned by Robin Murphy in [PATCH v2 7/9].
   Additionally:
   +    platform_set_drvdata(pdev, smmu);       //Patch v2
   +	dev->archdata.iommu = smmu;             //Patch v3, dev = &pdev->dev

v1 -> v2:
update the implementation of patch 1/9 according to Will Deacon's suggestion.
update the comment of patch 3/9 and 4/9.
use arm_smmu_options to skip the execution of command CMD_PREFETCH_CONFIG, see patch 5/9.
patch 6/9 is base on Laurent's series, to support probe deferral.
patch 7/9 according to Robin Murphy's suggestion, remove global variable arm_smmu_devices, thanks.
patch 9/9 add support for a master with multiple stream IDs.

Zhen Lei (5):
  iommu/arm-smmu: to support probe deferral
  iommu/arm-smmu: remove arm_smmu_devices
  iommu/arm-smmu: rename __arm_smmu_get_pci_sid
  iommu/arm-smmu: add support for non-pci devices
  iommu/arm-smmu: describe the limitation of #iommu-cells

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   6 +
 drivers/iommu/arm-smmu-v3.c                        | 209 ++++++++++++++++-----
 2 files changed, 163 insertions(+), 52 deletions(-)

--
1.8.0
