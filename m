From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Tue,  9 May 2017 17:15:10 +0530
Subject: [v4 0/4] Cavium ThunderX2 SMMUv3 errata workarounds
Message-ID: <1494330314-30179-1-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
1. Errata ID #74
   SMMU register alias Page 1 is not implemented
2. Errata ID #126
   SMMU doesnt support unique IRQ lines and also MSI for gerror,
   eventq and cmdq-sync

The following patchset does software workaround for these two erratas.

This series is based on patchset.
https://www.spinics.net/lists/arm-kernel/msg578443.html

Changes from v3:
 - Merged patches 1, 2 and 4 of Version 3.
 - Modified the page1_offset_adjust() and get_irq_flags() implementation as 
   suggested by Robin. 

Changes from v2:
 Updated "Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt" document with
 new SMMU option used to enable errata workaround.

Changes from v1:
 Since the use of MIDR register is rejected and SMMU_IIDR is broken on this
 silicon, as suggested by Will Deacon modified the patches to use ThunderX2
 SMMUv3 IORT model number to enable errata workaround.


Geetha Sowjanya (1):
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126

Linu Cherian (3):
  ACPICA: IORT: Add Cavium ThunderX2 SMMUv3 model definition.
  ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2 SMMUv3
    model
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #74

 Documentation/arm64/silicon-errata.txt             |   2 +
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   6 ++
 drivers/acpi/arm64/iort.c                          |  10 +-
 drivers/iommu/arm-smmu-v3.c                        | 109 ++++++++++++++++-----
 include/acpi/actbl2.h                              |   2 +
 5 files changed, 103 insertions(+), 26 deletions(-)

-- 
1.8.3.1
