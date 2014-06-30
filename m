From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jun 2014 11:52:06 +0100
Subject: [PATCH 1/5] iommu/arm-smmu: fix calculation of TCR.T0SZ
In-Reply-To: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
Message-ID: <1404125530-17984-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

T0SZ controls the input address range for TTBR0, so use the input
address range rather than the output address range for the calculation.
For stage-2, this means using the output size of stage-1.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1599354e974d..81e8ec290756 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -800,6 +800,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			reg = TTBCR_TG0_64K;
 
 		if (!stage1) {
+			reg |= (64 - smmu->s1_output_size) << TTBCR_T0SZ_SHIFT;
+
 			switch (smmu->s2_output_size) {
 			case 32:
 				reg |= (TTBCR2_ADDR_32 << TTBCR_PASIZE_SHIFT);
@@ -821,7 +823,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 				break;
 			}
 		} else {
-			reg |= (64 - smmu->s1_output_size) << TTBCR_T0SZ_SHIFT;
+			reg |= (64 - smmu->input_size) << TTBCR_T0SZ_SHIFT;
 		}
 	} else {
 		reg = 0;
-- 
2.0.0
