From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Oct 2015 16:04:23 +0100
Subject: [PATCH 5/6] iommu/arm-smmu: remove redundant calculation of gr0 base
 address
In-Reply-To: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
References: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
Message-ID: <1444921464-14895-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1463fe44fd0f ("iommu/arm-smmu: Don't use VMIDs for stage-1
translations"), we don't need the GR0 base address when initialising a
context bank, so remove the useless local variable and its init code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9aadf36a0747..7c20a68b5a95 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -709,9 +709,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	bool stage1;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	void __iomem *cb_base, *gr0_base, *gr1_base;
+	void __iomem *cb_base, *gr1_base;
 
-	gr0_base = ARM_SMMU_GR0(smmu);
 	gr1_base = ARM_SMMU_GR1(smmu);
 	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
-- 
2.1.4
