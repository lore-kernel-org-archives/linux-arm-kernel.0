From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Mar 2015 18:15:34 +0000
Subject: [PATCH 1/4] iommu/arm-smmu: ensure CBA2R is initialised before CBAR
 on SMMUv2
In-Reply-To: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
References: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
Message-ID: <1426875337-12808-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VMID16 (8.1) extension to SMMUv2 added a 16-bit VMID16 field to the
CBA2R registers. Unfortunately, if software writes this field as zero
after setting an 8-bit VMID in a stage-2 CBAR, then the VMID may also be
overwritten with zero on some early implementations (the architecture
was later updated to fix this issue).

This patch ensures that we initialise CBA2R before CBAR, therefore
ensuring that the VMID is set correctly.

Tested-by: Manish Jaggi <mjaggi@caviumnetworks.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fc13dd56953e..4abb831e24f0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -730,6 +730,20 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 
+	if (smmu->version > ARM_SMMU_V1) {
+		/*
+		 * CBA2R.
+		 * *Must* be initialised before CBAR thanks to VMID16
+		 * architectural oversight affected some implementations.
+		 */
+#ifdef CONFIG_64BIT
+		reg = CBA2R_RW64_64BIT;
+#else
+		reg = CBA2R_RW64_32BIT;
+#endif
+		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
+	}
+
 	/* CBAR */
 	reg = cfg->cbar;
 	if (smmu->version == ARM_SMMU_V1)
@@ -747,16 +761,6 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	}
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
 
-	if (smmu->version > ARM_SMMU_V1) {
-		/* CBA2R */
-#ifdef CONFIG_64BIT
-		reg = CBA2R_RW64_64BIT;
-#else
-		reg = CBA2R_RW64_32BIT;
-#endif
-		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
-	}
-
 	/* TTBRs */
 	if (stage1) {
 		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-- 
2.1.4
