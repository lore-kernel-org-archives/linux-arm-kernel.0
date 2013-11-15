From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 15 Nov 2013 17:45:03 +0800
Subject: [PATCH -next] iommu/arm-smmu: fix potential NULL pointer dereference
 in arm_smmu_map()
Message-ID: <CAPgLHd8f7mj2fMXt5_HeCyEhqDP_twFoHH0SNpeBdQXhhqVYxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The dereference should be moved below the NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iommu/arm-smmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2349d62..a0cc0a5 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1420,9 +1420,8 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int flags)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *smmu = smmu_domain->leaf_smmu;
 
-	if (!smmu_domain || !smmu)
+	if (!smmu_domain || !smmu_domain->leaf_smmu)
 		return -ENODEV;
 
 	/* Check for silent address truncation up the SMMU chain. */
