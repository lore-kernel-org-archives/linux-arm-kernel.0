From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Fri, 12 May 2017 18:11:03 +0530
Subject: [v6 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
Message-ID: <1494592866-14076-1-git-send-email-gakula@caviumnetworks.com>
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

Changes since v5:
  - Rebased on Robin's "Update SMMU models for IORT rev. C" patch.
     https://www.spinics.net/lists/arm-kernel/msg580728.html
  - Replaced ACPI_IORT_SMMU_V3_CAVIUM_CN99XX macro with ACPI_IORT_SMMU_CAVIUM_CN99XX

Changes since v4:
 - Replaced all page1 offset macros ARM_SMMU_EVTQ/PRIQ_PROD/CONS with
    arm_smmu_page1_fixup(ARM_SMMU_EVTQ/PRIQ_PROD/CONS, smmu)

Changes since v3:
 - Merged patches 1, 2 and 4 of Version 3.
 - Modified the page1_offset_adjust() and get_irq_flags() implementation as
   suggested by Robin.

Changes since v2:
 - Updated "Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt" document with
   new SMMU option used to enable errata workaround.

Changes since v1:
 - Since the use of MIDR register is rejected and SMMU_IIDR is broken on this
   silicon, as suggested by Will Deacon modified the patches to use ThunderX2
   SMMUv3 IORT model number to enable errata workaround. 


Geetha Sowjanya (1):
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126

Linu Cherian (2):
  ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2 SMMUv3
    model
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #74

 Documentation/arm64/silicon-errata.txt             |  2 +
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 ++
 drivers/acpi/arm64/iort.c                          | 10 ++-
 drivers/iommu/arm-smmu-v3.c                        | 93 +++++++++++++++++-----
 4 files changed, 91 insertions(+), 20 deletions(-)

-- 
1.8.3.1
