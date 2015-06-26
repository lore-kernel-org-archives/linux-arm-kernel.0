From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 26 Jun 2015 16:33:00 +0800
Subject: [PATCH 4/8] iommu/arm-smmu: set EPD1 to disable TT1 translation table
 walk
In-Reply-To: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1435307584-9812-5-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we only use TT0 translation, disable TT1 translation will safer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 43120ad..6d6712e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -285,6 +285,7 @@
 #define ARM64_TCR_EPD1_MASK		0x1UL

 #define CTXDESC_CD_0_ENDI		(1UL << 15)
+#define CTXDESC_CD_0_EPD1		(1UL << 30)
 #define CTXDESC_CD_0_V			(1UL << 31)

 #define CTXDESC_CD_0_TCR_IPS_SHIFT	32
@@ -893,7 +894,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 #endif
 	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET_PRIVATE |
 	      CTXDESC_CD_0_AA64 | (u64)cfg->cd.asid << CTXDESC_CD_0_ASID_SHIFT |
-	      CTXDESC_CD_0_V;
+	      CTXDESC_CD_0_EPD1 | CTXDESC_CD_0_V;
 	cfg->cdptr[0] = cpu_to_le64(val);

 	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK << CTXDESC_CD_1_TTB0_SHIFT;
--
1.8.0
