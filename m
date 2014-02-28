From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 28 Feb 2014 16:37:10 +0100
Subject: [PATCH 2/2] iommu/arm-smmu: Return 0 on unmap failure
In-Reply-To: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1393601830-4677-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOMMU core expects the unmap operation to return the number of bytes
that have been unmapped or 0 on failure, a negative return value being
treated like a number of bytes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c33a310..e7528f0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1464,7 +1464,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
 	arm_smmu_tlb_inv_context(&smmu_domain->root_cfg);
-	return ret ? ret : size;
+	return ret ? 0 : size;
 }
 
 static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
-- 
1.8.3.2
