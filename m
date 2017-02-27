From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 27 Feb 2017 19:54:27 +0000
Subject: [RFC PATCH 16/30] iommu/arm-smmu-v3: Use shared ASID set
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
Message-ID: <20170227195441.5170-17-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have two exclusive sets of ASIDs: private and shared. SMMUv3 allows
for contexts to take part in distributed TLB maintenance via the ASET bit.
When this bit is 0 for a given context, TLB entries tagged with its ASID
are invalidated by broadcast TLB maintenance. Set ASET=0 for task contexts.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3af47b1427a6..86d5430bd68d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1263,7 +1263,8 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_master_data *master,
 		      CTXDESC_CD_0_ENDI |
 #endif
 		      CTXDESC_CD_0_R | CTXDESC_CD_0_A |
-		      CTXDESC_CD_0_ASET_PRIVATE |
+		      (ssid ? CTXDESC_CD_0_ASET_SHARED :
+			      CTXDESC_CD_0_ASET_PRIVATE) |
 		      CTXDESC_CD_0_AA64 |
 		      (u64)cfg->asid << CTXDESC_CD_0_ASID_SHIFT |
 		      CTXDESC_CD_0_V;
-- 
2.11.0
