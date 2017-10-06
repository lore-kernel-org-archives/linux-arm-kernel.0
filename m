From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri,  6 Oct 2017 14:31:52 +0100
Subject: [RFCv2 PATCH 25/36] iommu/arm-smmu-v3: Use shared ASID set
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Message-ID: <20171006133203.22803-26-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have two exclusive sets of ASIDs: private and shared. SMMUv3 allows
for contexts to take part in distributed TLB maintenance via the ASET bit.
When this bit is 0 for a given context, TLB entries tagged with its ASID
are invalidated by broadcast TLB maintenance. Set ASET=0 for process
contexts.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e89e6d1263d9..b7355630526a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1240,7 +1240,8 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		      CTXDESC_CD_0_ENDI |
 #endif
 		      CTXDESC_CD_0_R | CTXDESC_CD_0_A |
-		      CTXDESC_CD_0_ASET_PRIVATE |
+		      (ssid ? CTXDESC_CD_0_ASET_SHARED :
+			      CTXDESC_CD_0_ASET_PRIVATE) |
 		      CTXDESC_CD_0_AA64 |
 		      (u64)cd->asid << CTXDESC_CD_0_ASID_SHIFT |
 		      CTXDESC_CD_0_V;
-- 
2.13.3
