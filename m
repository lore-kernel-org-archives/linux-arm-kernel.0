From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 12 Jun 2014 13:08:09 +0800
Subject: [PATCH RFC v2 0/3] Add support for Hisilicon SMMU architecture
Message-ID: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:

- Split Hisilicon smmu implementation in a separate file, hisi-smmu.c
- Refactor arm-smmu.c. Some direct call hardware dependent functions replaced
  with hooks. And move common struct and marco definition into arm-smmu.h
- Merge the description of Hisilicon private properties into arm,smmu.txt

Hisilicon smmu is similar to arm-smmu, some code can be direct reused. For
example: map and unmap, device tree configuration, and the software framework.
I found that, abstract about 11 hardware dependent functions in arm-smmu.c is
enough . Abstract means use hooks to replace the direct call of functions. Now,
if need to support Hisilicon SMMU or others arm smmu variants, just selective
rewrite these hooks. And I add a dt_cfg_probe hook, to allow each variant parse
their hardware special configuration. Finally, flush_pgtable is a special case,
hardware independent but maybe referenced. So, total 13 hooks.

Additional:
Arnd Bergmann told me to pay attention to the discussion of "devicetree: Add
generic IOMMU device tree bindings". But, this subject is still discussing, no
conclusion now. Besides, exclude the Hisilicon private properties, all keep the
same to arm-smmu. So, I think this version is not relate to the discussion now.

Zhen Lei (3):
  iommu/arm: Adjust code to facilitate support arm smmu variants
  iommu/hisilicon: Add support for Hisilicon Ltd. System MMU
    architecture
  documentation/iommu: Add description of Hisilicon SMMU private
    binding

 .../devicetree/bindings/iommu/arm,smmu.txt         |  16 +
 drivers/iommu/Kconfig                              |   7 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/arm-smmu.c                           | 190 +++---
 drivers/iommu/arm-smmu.h                           | 165 +++++
 drivers/iommu/hisi-smmu.c                          | 662 +++++++++++++++++++++
 6 files changed, 927 insertions(+), 114 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu.h
 create mode 100644 drivers/iommu/hisi-smmu.c

--
1.8.0
