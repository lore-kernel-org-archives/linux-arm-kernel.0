From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Feb 2014 17:16:32 +0000
Subject: [PATCH 5/5] iommu/arm-smmu: provide option to dsb macro when
 publishing tables
In-Reply-To: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
Message-ID: <1393002992-24561-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On coherent systems, publishing new page tables to the SMMU walker is
achieved with a dsb instruction. In fact, this can be a dsb(ishst) which
also provides the mandatory barrier option for arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 83297fe0878d..1da5b41afc31 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -678,7 +678,7 @@ static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
 
 	/* Ensure new page tables are visible to the hardware walker */
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
-		dsb();
+		dsb(ishst);
 	} else {
 		/*
 		 * If the SMMU can't walk tables in the CPU caches, treat them
-- 
1.8.2.2
