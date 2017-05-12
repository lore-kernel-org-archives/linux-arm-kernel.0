From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Fri, 12 May 2017 18:11:06 +0530
Subject: [v6 3/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
 erratum #126
In-Reply-To: <1494592866-14076-1-git-send-email-gakula@caviumnetworks.com>
References: <1494592866-14076-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1494592866-14076-4-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>

Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
lines for gerror, eventq and cmdq-sync.

This patch addresses the issue by checking if any interrupt sources are
using same irq number, then they are registered as shared irqs.

Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 drivers/iommu/arm-smmu-v3.c            | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 4693a32..42422f6 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,6 +63,7 @@ stable kernels.
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
 | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
+| Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
 |                |                 |                 |                             |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c519927c..69d8506 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2232,6 +2232,25 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
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
+	return IRQF_ONESHOT;
+}
+
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
@@ -2252,7 +2271,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	if (irq) {
 		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 						arm_smmu_evtq_thread,
-						IRQF_ONESHOT,
+						get_irq_flags(smmu, irq),
 						"arm-smmu-v3-evtq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable evtq irq\n");
@@ -2261,7 +2280,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	irq = smmu->cmdq.q.irq;
 	if (irq) {
 		ret = devm_request_irq(smmu->dev, irq,
-				       arm_smmu_cmdq_sync_handler, 0,
+				       arm_smmu_cmdq_sync_handler,
+					   get_irq_flags(smmu, irq),
 				       "arm-smmu-v3-cmdq-sync", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable cmdq-sync irq\n");
@@ -2270,7 +2290,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	irq = smmu->gerr_irq;
 	if (irq) {
 		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
-				       0, "arm-smmu-v3-gerror", smmu);
+						get_irq_flags(smmu, irq),
+						"arm-smmu-v3-gerror", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable gerror irq\n");
 	}
@@ -2280,7 +2301,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		if (irq) {
 			ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 							arm_smmu_priq_thread,
-							IRQF_ONESHOT,
+							get_irq_flags(smmu, irq),
 							"arm-smmu-v3-priq",
 							smmu);
 			if (ret < 0)
-- 
1.8.3.1
