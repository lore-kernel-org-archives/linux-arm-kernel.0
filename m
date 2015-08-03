From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Aug 2015 14:25:45 +0100
Subject: [PATCH 03/13] iommu/arm-smmu: Limit 2-level strtab allocation for
 small SID sizes
In-Reply-To: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
Message-ID: <1438608355-7335-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the StreamIDs in a system can all be resolved by a single level-2
stream table (i.e. SIDSIZE < SPLIT), then we currently get our maths
wrong and allocate the largest strtab we support, thanks to unsigned
overflow in our calculation.

This patch fixes the issue by checking the SIDSIZE explicitly when
calculating the size of our first-level stream table.

Reported-by: Matt Evans <matt.evans@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c2c1ad8915d9..4f093373f4c3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2054,9 +2054,17 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	int ret;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 
-	/* Calculate the L1 size, capped to the SIDSIZE */
-	size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
-	size = min(size, smmu->sid_bits - STRTAB_SPLIT);
+	/*
+	 * If we can resolve everything with a single L2 table, then we
+	 * just need a single L1 descriptor. Otherwise, calculate the L1
+	 * size, capped to the SIDSIZE.
+	 */
+	if (smmu->sid_bits < STRTAB_SPLIT) {
+		size = 0;
+	} else {
+		size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
+		size = min(size, smmu->sid_bits - STRTAB_SPLIT);
+	}
 	cfg->num_l1_ents = 1 << size;
 
 	size += STRTAB_SPLIT;
-- 
2.1.4
