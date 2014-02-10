From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Feb 2014 14:22:37 +0000
Subject: [PATCH v2 3/5] iommu/arm-smmu: provide option to dsb macro when
 publishing tables
In-Reply-To: <1392042159-11603-1-git-send-email-will.deacon@arm.com>
References: <1392042159-11603-1-git-send-email-will.deacon@arm.com>
Message-ID: <1392042159-11603-3-git-send-email-will.deacon@arm.com>
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
index 8911850c9444..8f6fee54f3b1 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1417,7 +1417,7 @@ out_unlock:
 
 	/* Ensure new page tables are visible to the hardware walker */
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
-		dsb();
+		dsb(ishst);
 
 	return ret;
 }
-- 
1.8.2.2
