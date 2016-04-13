From: yang.shi@linaro.org (Shi, Yang)
Date: Wed, 13 Apr 2016 12:31:53 -0700
Subject: SMMU problem found on LS2085A with 4.6-rc3
Message-ID: <570E9EA9.2070903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will & Robin,

I just ran some quick test on my LS2085A board, which has 8 Cortex A57 
cores, with 4.6-rc3 kernel, but I found a regression issue with SMMU.

SMMU driver reports:

arm_smmu_global_fault: 297974 callbacks suppressed
arm_smmu_global_fault: 298561 callbacks suppressed
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu:         GFSR 0x80000004, GFSYNR0 0x00000008, 
GFSYNR1 0x00000300, GFSYNR2 0x00000000
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious
arm-smmu 5000000.iommu: Unexpected global fault, this could be serious


But, it is good with 4.5 kernel. I found the below commit causes it:

commit 9adb95949a343dac53b1cd81dc973b5f815c88d4
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Tue Jan 26 18:06:36 2016 +0000

     iommu/arm-smmu: Support DMA-API domains

     With DMA mapping ops provided by the iommu-dma code, only a minimal
     contribution from the IOMMU driver is needed to create a suitable
     DMA-API domain for them to use. Implement this for the ARM SMMUs.

     Signed-off-by: Robin Murphy <robin.murphy@arm.com>
     Signed-off-by: Will Deacon <will.deacon@arm.com>

Any idea?

Thanks,
Yang
