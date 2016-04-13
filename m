From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 13 Apr 2016 18:12:59 +0100
Subject: [PATCH 3/7] iommu/arm-smmu: Work around MMU-500 prefetch errata
In-Reply-To: <cover.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
Message-ID: <0484444b6257bfb6adb68405a72c64fc4fc98142.1460391217.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMU-500 erratum #841119 is tickled by a particular set of circumstances
interacting with the next-page prefetcher. Since said prefetcher is
quite dumb and actually detrimental to performance in some cases (by
causing unwanted TLB evictions for non-sequential access patterns), we
lose very little by turning it off, and what we gain is a guarantee that
the erratum is never hit.

As a bonus, the same workaround will also prevent erratum #826419 once
v7 short descriptor support is implemented.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 drivers/iommu/arm-smmu.c               | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 806f91c..c6938e5 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -53,6 +53,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
 | ARM            | Cortex-A57      | #852523         | N/A                     |
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
+| ARM            | MMU-500         | #841119,#826419 | N/A                     |
 |                |                 |                 |                         |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d8bc20a..085fc8d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -203,6 +203,7 @@
 #define ARM_SMMU_CB(smmu, n)		((n) * (1 << (smmu)->pgshift))
 
 #define ARM_SMMU_CB_SCTLR		0x0
+#define ARM_SMMU_CB_ACTLR		0x4
 #define ARM_SMMU_CB_RESUME		0x8
 #define ARM_SMMU_CB_TTBCR2		0x10
 #define ARM_SMMU_CB_TTBR0		0x20
@@ -234,6 +235,8 @@
 #define SCTLR_M				(1 << 0)
 #define SCTLR_EAE_SBOP			(SCTLR_AFE | SCTLR_TRE)
 
+#define ARM_MMU500_ACTLR_CPRE		(1 << 1)
+
 #define CB_PAR_F			(1 << 0)
 
 #define ATSR_ACTIVE			(1 << 0)
@@ -280,6 +283,7 @@ enum arm_smmu_arch_version {
 
 enum arm_smmu_implementation {
 	GENERIC_SMMU,
+	ARM_MMU500,
 	CAVIUM_SMMUV2,
 };
 
@@ -1517,6 +1521,15 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, i);
 		writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
 		writel_relaxed(FSR_FAULT, cb_base + ARM_SMMU_CB_FSR);
+		/*
+		 * Disable MMU-500's not-particularly-beneficial next-page
+		 * prefetcher for the sake of errata #841119 and #826419.
+		 */
+		if (smmu->model == ARM_MMU500) {
+			reg = readl_relaxed(cb_base + ARM_SMMU_CB_ACTLR);
+			reg &= ~ARM_MMU500_ACTLR_CPRE;
+			writel_relaxed(reg, cb_base + ARM_SMMU_CB_ACTLR);
+		}
 	}
 
 	/* Invalidate the TLB, just in case */
@@ -1762,6 +1775,7 @@ static struct arm_smmu_match_data name = { .version = ver, .model = imp }
 
 ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
+ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 
 static const struct of_device_id arm_smmu_of_match[] = {
@@ -1769,7 +1783,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
 	{ .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,mmu-401", .data = &smmu_generic_v1 },
-	{ .compatible = "arm,mmu-500", .data = &smmu_generic_v2 },
+	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ },
 };
-- 
2.7.3.dirty
