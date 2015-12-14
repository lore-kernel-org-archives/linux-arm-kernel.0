From: pmallapp@broadcom.com (Prem Mallappa)
Date: Mon, 14 Dec 2015 22:01:14 +0530
Subject: [PATCH] IOMMU: arm-smmu-v3: Fix write to GERRORN register
Message-ID: <1450110674-32120-1-git-send-email-pmallapp@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GERRORN should be toggled value, not just toggled bitmask

Signed-off-by: Prem Mallappa <pmallapp@broadcom.com>
---
 drivers/iommu/arm-smmu-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index dfda564..c2c523d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1267,10 +1267,10 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
-	u32 gerror, gerrorn;
+	u32 gerror, gerrorn, gerror_orig;
 	struct arm_smmu_device *smmu = dev;
 
-	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerror_orig = gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
 
 	gerror ^= gerrorn;
@@ -1313,7 +1313,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (gerror & GERROR_CMDQ_ERR)
 		arm_smmu_cmdq_skip_err(smmu);
 
-	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	writel(gerror_orig, smmu->base + ARM_SMMU_GERRORN);
 	return IRQ_HANDLED;
 }
 
-- 
2.6.0
