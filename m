From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Thu, 22 Jan 2015 15:48:02 -0800
Subject: [PATCH] iommu/arm-smmu: use a threaded handler for context interrupts
Message-ID: <1421970482-11722-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Context interrupts can call domain-specific handlers which might sleep.
Currently we register our handler with request_irq, so our handler is
called in atomic context, so domain handlers that sleep result in an
invalid context BUG.  Fix this by using request_threaded_irq.

This also prepares the way for doing things like enabling clocks within
our interrupt handler.

Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6cd47b75286f..81f6b54d94b1 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -973,8 +973,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
-	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
-			  "arm-smmu-context-fault", domain);
+	ret = request_threaded_irq(irq, NULL, arm_smmu_context_fault,
+				IRQF_ONESHOT | IRQF_SHARED,
+				"arm-smmu-context-fault", domain);
 	if (IS_ERR_VALUE(ret)) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
 			cfg->irptndx, irq);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
