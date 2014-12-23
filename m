From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 23 Dec 2014 09:39:22 -0800
Subject: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
Message-ID: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we do a STLBIALL when we initialize the SMMU.  However, in
some configurations that register is not supposed to be touched and is
marked as "Secure only" in the spec.  Rip it out.

Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60558f794922..9170bbced5e5 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -173,7 +173,6 @@
 #define PIDR2_ARCH_MASK			0xf
 
 /* Global TLB invalidation */
-#define ARM_SMMU_GR0_STLBIALL		0x60
 #define ARM_SMMU_GR0_TLBIVMID		0x64
 #define ARM_SMMU_GR0_TLBIALLNSNH	0x68
 #define ARM_SMMU_GR0_TLBIALLH		0x6c
@@ -1686,7 +1685,6 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	}
 
 	/* Invalidate the TLB, just in case */
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
