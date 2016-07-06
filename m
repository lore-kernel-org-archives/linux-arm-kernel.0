From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed,  6 Jul 2016 16:51:33 -0700
Subject: [PATCH 0/3] Add support for privileged mappings
Message-ID: <20160706235136.27854-1-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch to the ARM SMMU driver:

    commit d346180e70b91b3d5a1ae7e5603e65593d4622bc
    Author: Robin Murphy <robin.murphy@arm.com>
    Date:   Tue Jan 26 18:06:34 2016 +0000
    
        iommu/arm-smmu: Treat all device transactions as unprivileged

started forcing all SMMU transactions to come through as "unprivileged".
The rationale given was that:

  (1) There is no way in the IOMMU API to even request privileged mappings.

  (2) It's difficult to implement a DMA mapper that correctly models the
      ARM VMSAv8 behavior of unprivileged-writeable =>
      privileged-execute-never.

This series attempts to rectify (1) by introducing an IOMMU API for
privileged mappings (and implementing it in io-pgtable-arm).  It seems like
(2) can be safely ignored for now under the assumption that any users of
the IOMMU_PRIV flag will be using the low-level IOMMU APIs directly, rather
than going through the DMA APIs.

Robin, Will, what do you think?  Jordan and Jeremy can provide more info on
the use case if needed, but the high level is that it's a security feature
to prevent attacks such as [1].

[1] https://github.com/robclark/kilroy


Jeremy Gebben (1):
  iommu/io-pgtable-arm: add support for the IOMMU_PRIV flag

Mitchel Humpherys (2):
  iommu: add IOMMU_PRIV attribute
  Revert "iommu/arm-smmu: Treat all device transactions as unprivileged"

 drivers/iommu/arm-smmu.c       |  5 +----
 drivers/iommu/io-pgtable-arm.c | 16 +++++++++++-----
 include/linux/iommu.h          |  1 +
 3 files changed, 13 insertions(+), 9 deletions(-)

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
