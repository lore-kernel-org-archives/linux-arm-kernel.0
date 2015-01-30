From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Jan 2015 22:55:55 +0100
Subject: [PATCH] iommu: arm-smmu: avoid build warning
Message-ID: <1754709.y30A9Ie4hF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM allmodconfig gained a new warning when dma_addr_t is 32-bit wide:

drivers/iommu/arm-smmu.c: In function 'arm_smmu_iova_to_phys_hard':
drivers/iommu/arm-smmu.c:1255:3: warning: right shift count >= width of type

This changes the calculation so that the effective type is always
64-bit.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 859a732e4f713 ("iommu/arm-smmu: add support for iova_to_phys through ATS1PR")

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1d6d43bb3395..fc13dd56953e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1252,7 +1252,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	} else {
 		u32 reg = iova & ~0xfff;
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
-		reg = (iova & ~0xfff) >> 32;
+		reg = ((u64)iova & ~0xfff) >> 32;
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
 	}
 
