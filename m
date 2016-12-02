From: sricharan@codeaurora.org (Sricharan R)
Date: Fri,  2 Dec 2016 20:25:09 +0530
Subject: [PATCH V6 6/6] iommu/arm-smmu: Set privileged attribute to 'default'
 instead of 'unprivileged'
In-Reply-To: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org>
References: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1480690509-13490-7-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the driver sets all the device transactions privileges
to UNPRIVILEGED, but there are cases where the iommu masters wants
to isolate privileged supervisor and unprivileged user.
So don't override the privileged setting to unprivileged, instead
set it to default as incoming and let it be controlled by the pagetable
settings.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---

[V6] V5 was doing this with a 'revert'[1] patch, which no more
     applies on this code base. So changed the same like this.
     [1] https://patchwork.kernel.org/patch/9250493/

 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index eaa8f44..8bb0eea 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1213,7 +1213,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 			continue;
 
 		s2cr[idx].type = type;
-		s2cr[idx].privcfg = S2CR_PRIVCFG_UNPRIV;
+		s2cr[idx].privcfg = S2CR_PRIVCFG_DEFAULT;
 		s2cr[idx].cbndx = cbndx;
 		arm_smmu_write_s2cr(smmu, idx);
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
