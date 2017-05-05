From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Fri,  5 May 2017 17:38:10 +0530
Subject: [PATCH v3 6/7] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
 erratum #126
In-Reply-To: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1493986091-30521-7-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>

Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
lines for gerror, eventq and cmdq-sync.

This patch addresses the issue by checking if any interrupt sources are
using same irq number, then they are registered as shared irqs.

Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 drivers/iommu/arm-smmu-v3.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 016b702..46428e7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2236,10 +2236,30 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	devm_add_action(dev, arm_smmu_free_msis, dev);
 }
 
+static int get_irq_flags(struct arm_smmu_device *smmu, int irq)
+{
+	int match_count = 0;
+
+	if (irq == smmu->evtq.q.irq)
+		match_count++;
+	if (irq == smmu->cmdq.q.irq)
+		match_count++;
+	if (irq == smmu->gerr_irq)
+		match_count++;
+	if (irq == smmu->priq.q.irq)
+		match_count++;
+
+	if (match_count > 1)
+		return IRQF_SHARED | IRQF_ONESHOT;
+
+	return 0;
+}
+
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
 	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+	u32 irqflags = 0;
 
 	/* Disable IRQs first */
 	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
@@ -2254,9 +2274,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	/* Request interrupt lines */
 	irq = smmu->evtq.q.irq;
 	if (irq) {
+		irqflags = get_irq_flags(smmu, irq);
 		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 						arm_smmu_evtq_thread,
-						IRQF_ONESHOT,
+						IRQF_ONESHOT | irqflags,
 						"arm-smmu-v3-evtq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable evtq irq\n");
@@ -2264,8 +2285,9 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 
 	irq = smmu->cmdq.q.irq;
 	if (irq) {
+		irqflags = get_irq_flags(smmu, irq);
 		ret = devm_request_irq(smmu->dev, irq,
-				       arm_smmu_cmdq_sync_handler, 0,
+				       arm_smmu_cmdq_sync_handler, irqflags,
 				       "arm-smmu-v3-cmdq-sync", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable cmdq-sync irq\n");
@@ -2273,8 +2295,9 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 
 	irq = smmu->gerr_irq;
 	if (irq) {
+		irqflags = get_irq_flags(smmu, irq);
 		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
-				       0, "arm-smmu-v3-gerror", smmu);
+				       irqflags, "arm-smmu-v3-gerror", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable gerror irq\n");
 	}
@@ -2282,9 +2305,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
 		irq = smmu->priq.q.irq;
 		if (irq) {
+			irqflags = get_irq_flags(smmu, irq);
 			ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 							arm_smmu_priq_thread,
-							IRQF_ONESHOT,
+							IRQF_ONESHOT | irqflags,
 							"arm-smmu-v3-priq",
 							smmu);
 			if (ret < 0)
-- 
1.8.3.1
