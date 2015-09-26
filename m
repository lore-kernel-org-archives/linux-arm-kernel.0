From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Fri, 25 Sep 2015 17:12:05 -0700
Subject: [PATCH] iommu/arm-smmu: Only return IRQ_NONE if FSR is not set
Message-ID: <1443226325-28456-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we return IRQ_NONE from the context fault handler if the FSR
doesn't actually have the fault bit set (some sort of miswired
interrupt?) or if the client doesn't register an IOMMU fault handler.
However, registering a client fault handler is optional, so telling the
interrupt framework that the interrupt wasn't for this device if the
client doesn't register a handler isn't exactly accurate.  Fix this by
returning IRQ_HANDLED even if the client doesn't register a handler.

Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 48a39dfa9777..95560d447a54 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -653,7 +653,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 		dev_err_ratelimited(smmu->dev,
 		    "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
 		    iova, fsynr, cfg->cbndx);
-		ret = IRQ_NONE;
+		ret = IRQ_HANDLED;
 		resume = RESUME_TERMINATE;
 	}
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
