From: sricharan@codeaurora.org (Sricharan R)
Date: Mon,  2 Jan 2017 18:42:43 +0530
Subject: [PATCH V8 8/9] iommu/arm-smmu: Set privileged attribute to 'default'
 instead of 'unprivileged'
In-Reply-To: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
References: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1483362764-11990-9-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the driver sets all the device transactions privileges
to UNPRIVILEGED, but there are cases where the iommu masters wants
to isolate privileged supervisor and unprivileged user.
So don't override the privileged setting to unprivileged, instead
set it to default as incoming and let it be controlled by the pagetable
settings.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a60cded..73a0a25 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1214,7 +1214,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 			continue;
 
 		s2cr[idx].type = type;
-		s2cr[idx].privcfg = S2CR_PRIVCFG_UNPRIV;
+		s2cr[idx].privcfg = S2CR_PRIVCFG_DEFAULT;
 		s2cr[idx].cbndx = cbndx;
 		arm_smmu_write_s2cr(smmu, idx);
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
