From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 12 Jul 2018 14:18:29 +0800
Subject: [PATCH v3 3/6] iommu/amd: use default branch to deal with all
 non-supported capabilities
In-Reply-To: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1531376312-2192-4-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid below warning when new capabilities added:

drivers/iommu/amd_iommu.c: In function 'amd_iommu_capable':
drivers/iommu/amd_iommu.c:3053:2: warning: enumeration value 'IOMMU_CAP_NON_STRICT' not handled in switch [-Wswitch]
     switch (cap) {

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/amd_iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 596b95c..b619e5c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3085,11 +3085,9 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
 		return (irq_remapping_enabled == 1);
-	case IOMMU_CAP_NOEXEC:
+	default:
 		return false;
 	}
-
-	return false;
 }
 
 static void amd_iommu_get_resv_regions(struct device *dev,
-- 
1.8.3
