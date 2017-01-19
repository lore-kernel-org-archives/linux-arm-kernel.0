From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2017 18:19:13 +0000
Subject: [PATCH 3/5] iommu/arm-smmu-v3: Install bypass STEs for
 IOMMU_DOMAIN_IDENTITY domains
In-Reply-To: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
Message-ID: <1484849955-1871-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for allowing the default domain type to be overridden,
this patch adds support for IOMMU_DOMAIN_IDENTITY domains to the
ARM SMMUv3 driver.

An identity domain is created by placing the corresponding stream table
entries into "bypass" mode, which allows transactions to flow through
the SMMU without any translation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c254325b0c7a..d33291274455 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -629,6 +629,7 @@ enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
 	ARM_SMMU_DOMAIN_NESTED,
+	ARM_SMMU_DOMAIN_BYPASS,
 };
 
 struct arm_smmu_domain {
@@ -1385,7 +1386,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
+	if (type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
 	/*
@@ -1516,6 +1519,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
+		return 0;
+	}
+
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
@@ -1651,7 +1659,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	ste->bypass = false;
 	ste->valid = true;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
+		ste->bypass = true;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		ste->s1_cfg = &smmu_domain->s1_cfg;
 		ste->s2_cfg = NULL;
 		arm_smmu_write_ctx_desc(smmu, ste->s1_cfg);
-- 
2.1.4
