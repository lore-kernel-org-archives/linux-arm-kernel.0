From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Thu, 31 Aug 2017 16:20:36 +0800
Subject: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
Message-ID: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Philippe has post a patchset for Adding PCIe SVM support to ARM SMMUv3:
https://www.spinics.net/lists/arm-kernel/msg565155.html

But for some platform devices(aka on-chip integrated devices), there is also
SVM requirement, which works based on the SMMU stall mode.
Jean-Philippe has prepared a prototype patchset to support it:
git://linux-arm.org/linux-jpb.git svm/stall

We tested this patchset with some fixes on a on-chip integrated device. The
basic function is ok, so I just send them out for review, although this
patchset heavily depends on the former patchset (PCIe SVM support for ARM
SMMUv3), which is still under discussion.

Patch Overview:
*1 to 3 prepare for device tree or acpi get the device stall ability and pasid bits
*4 is to realise the SVM function for platform device
*5 is fix a bug when test SVM function while SMMU donnot support this feature
*6 avoid ILLEGAL setting of STE and CD entry about stall

Acctually here, I also have a question about SVM on SMMUv3:

1. Why the SVM feature on SMMUv3 depends on BTM feature? when bind a task to device,
   it will register a mmu_notify. Therefore, when a page range is invalid, we can
   send TLBI or ATC invalid without BTM?

2. According to ACPI IORT spec, named component specific data has a node flags field
   whoes bit0 is for Stall support. However, it do not have any field for pasid bit.
   Can we use other 5 bits[5:1] for pasid bit numbers, so we can have 32 pasid bit for
   a single platform device which should be enough, because SMMU only support 20 bit pasid

3. Presently, the pasid is allocate for a task but not for a context, if a task is trying
   to bind to 2 device A and B:
     a) A support 5 pasid bits
     b) B support 2 pasid bits
     c) when the task bind to device A, it allocate pasid = 16
     d) then it must be fail when trying to bind to task B, for its highest pasid is 4.
   So it should allocate a single pasid for a context to avoid this?


Jean-Philippe Brucker (3):
  dt-bindings: document stall and PASID properties for IOMMU masters
  iommu/of: Add stall and pasid properties to iommu_fwspec
  iommu/arm-smmu-v3: Add SVM support for platform devices

Yisheng Xie (3):
  ACPI: IORT: Add stall and pasid properties to iommu_fwspec
  iommu/arm-smmu-v3: fix panic when handle stall mode irq
  iommu/arm-smmu-v3: Avoid ILLEGAL setting of STE.S1STALLD and CD.S

 Documentation/devicetree/bindings/iommu/iommu.txt |  13 ++
 drivers/acpi/arm64/iort.c                         |  20 ++
 drivers/iommu/arm-smmu-v3.c                       | 230 ++++++++++++++++++----
 drivers/iommu/of_iommu.c                          |  11 +
 include/acpi/actbl2.h                             |   5 +
 include/linux/iommu.h                             |   2 +
 6 files changed, 244 insertions(+), 37 deletions(-)

--
1.7.12.4
