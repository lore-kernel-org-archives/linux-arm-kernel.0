From: linucherian@gmail.com (linucherian at gmail.com)
Date: Tue, 11 Apr 2017 20:12:38 +0530
Subject: [RFC PATCH 0/7] Cavium CN99xx SMMUv3 Errata workarounds
Message-ID: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Cavium CN99xx SMMUv3 implementation has two Silicon Erratas.
1. Errata ID #74
   SMMU register alias Page 1 is not implemented
2. Errata ID #126
   SMMU doesnt support unique IRQ lines for gerror, eventq and cmdq-sync

The following patchset does software workaround for these two erratas.
An option flag is introduced for each errata which will enable/disable
the errata workarounds.
For device tree based probing, option flags can be turned on by passing 
relevant options along with the smmuv3 device node. For ACPI, option flags
are turned on when Cavium CN99xx SMMuv3 model is identified in the IORT.

Note: We are in the process of getting necessary IORT SMMUv3 model ID 
      for Cavium CN99xx SMMUv3 implementation and it is yet to get
      allocated. We have assumed model ID 3 for this.

Geetha (1):
  iommu/arm-smmu-v3: Introduce smmu option USE_SHARED_IRQS for Silicon
    errata

Linu Cherian (6):
  iommu/arm-smmu-v3: Introduce smmu option PAGE0_REGS_ONLY for Silicon
    errata.
  iommu/arm-smmu-v3: Do resource size checks based on smmu option
    PAGE0_REGS_ONLY
  ACPICA: IORT: Add SMMuV3 model definitions.
  iommu/arm-smmu-v3: For ACPI based device probing, set relevant options
    for different SMMUv3 implementations.
  ACPI/IORT: Fixup SMMUv3 resource size for Cavium 99xx SMMUv3 model.
  arm64: Documentation: Add Cavium ThunderX2 SMMUv3 erratas.

 Documentation/arm64/silicon-errata.txt |   2 +
 drivers/acpi/arm64/iort.c              |  10 ++-
 drivers/iommu/arm-smmu-v3.c            | 115 ++++++++++++++++++++++++++-------
 include/acpi/actbl2.h                  |   5 ++
 4 files changed, 107 insertions(+), 25 deletions(-)

-- 
1.9.1
