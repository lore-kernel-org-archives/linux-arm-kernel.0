From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:52:53 +0800
Subject: [PATCH v3 00/13] Add support for Hisilicon SMMU architecture
Message-ID: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v3:
- Split arm-smmu.c into three files: arm-smmu.h arm-smmu-base.c arm-smmu.c.
  To build stardard arm-smmu(v1,v2) driver, use these three files.
  To build hisilicon smmu driver, replace arm-smmu.c with hisi-smmu.c.
  Put all registers(exclude translation table associated) definition into each
  smmu private file.
  Now, hisi smmu driver is not dependent on arm smmu driver. They can seperate
  exist, or coexist(building and running two drivers at the same time).
- Give up Hisilicon private device tree properties.
- Place hooks from global variable into struct arm_smmu_device.
  Deleted three hooks: tlb_sync, flush_pgtable and dt_cfg_probe.
  Add device_remove hook, so hisi-smmu and smmu-v3 can reclaim other resources.
  like dynamic allocted memory. Now, s1cbt and s2cbt memory are allocated in
  hisi-smmu driver again(In v2, I hope BIOS to do this).
- Share the codes which are used to limit the size of smmu ias,oas,uas.
- Add two little patchs about code style, variable types, etc.
- Change context_map in struct arm_smmu_device to dynamic memory allocation.

Changes in v2:
- Split Hisilicon smmu implementation in a separate file, hisi-smmu.c
- Refactor arm-smmu.c. Some direct call hardware dependent functions replaced
  with hooks. And move common struct and marco definition into arm-smmu.h
- Merge the description of Hisilicon private properties into arm,smmu.txt


I tried to merge hisi-smmu driver into arm-smmu.c, but it looks impossible.
The biggest problem is that too many registers are diffrent: the base address,
the field definition, or present only on one side. And if I use #if, hisi-smmu
and arm-smmu can not coexist in one binary file. Almost need 20 #if.

In addition, SMMUv3 is also not compatible with v2. And something is similar
with hisi-smmu: registers definition and fault handler is different with v2,
but can reuse fdt configuration and memory map. Hence, arm-smmu-base.c and
arm-smmu.h should be shared by all SMMUs(v2, v3 and hisi), and each smmu will
own a private file, like: arm-smmu.c(for v1 and v2), arm-smmu-v3.c, hisi-smmu.c

All marcos which are not used in arm-smmu-base.c and not shared by all SMMUs,
have been placed into each private file, some are duplicated. But I think it
will not bring any maintenance headaches, except when need rename the marcos.
After all, it is hardware dependent.

Zhen Lei (13):
  iommu/arm: change some structure member types in arm_smmu_device
  iommu/arm: eliminate errors reported by checkpatch
  iommu/arm: split arm-smmu.c into three files
  iommu/arm: avoid arm-smmu-base.c bound to a specific smmu
  iommu/arm: Rename member "cbar" in struct arm_smmu_cfg to "type"
  iommu/arm: Split arm_smmu_destroy_domain_context to reuse code
  iommu/arm: Split arm_smmu_tlb_sync to reuse code
  iommu/arm: Add hook alloc_context
  iommu/arm: Change context_map to dynamic memory allocation
  iommu/arm: Adjust code to reuse more
  iommu/arm: Put off the initialization phase of arm_smmu_ops
    registration
  iommu/hisilicon: Add support for Hisilicon Ltd. System MMU
    architecture
  documentation/iommu: Add description of Hisilicon SMMU private
    binding

 .../devicetree/bindings/iommu/arm,smmu.txt         |    2 +
 drivers/iommu/Kconfig                              |   14 +
 drivers/iommu/Makefile                             |    2 +
 drivers/iommu/arm-smmu-base.c                      | 1085 +++++++++++++++++
 drivers/iommu/arm-smmu.c                           | 1247 +-------------------
 drivers/iommu/arm-smmu.h                           |  258 ++++
 drivers/iommu/hisi-smmu.c                          |  575 +++++++++
 7 files changed, 1985 insertions(+), 1198 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-base.c
 create mode 100644 drivers/iommu/arm-smmu.h
 create mode 100644 drivers/iommu/hisi-smmu.c

--
1.8.0
