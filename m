From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Tue, 20 Jun 2017 19:47:39 +0530
Subject: [PATCH v8 3/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
 erratum #126
In-Reply-To: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1497968259-16390-4-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>

Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
lines for gerror, eventq and cmdq-sync.

SHARED_IRQ option is set as a errata workaround, which allows to share the irq
line by register single irq handler for all the interrupts.

Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
---
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    5 ++
 drivers/iommu/arm-smmu-v3.c                        |   73 ++++++++++++++++----
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 6ecc48c..44b40e0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -55,6 +55,11 @@ the PCIe specification.
 		      Set for Caviun ThunderX2 silicon that doesn't support
 		      SMMU page1 register space.
 
+- cavium,cn9900-broken-unique-irqline
+                    : Use single irq line for all the SMMUv3 interrupts.
+		      Set for Caviun ThunderX2 silicon that doesn't support
+		      MSI and also doesn't have unique irq lines for gerror,
+		      eventq and cmdq-sync.
 ** Example
 
         smmu at 2b400000 {
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2dea4a9..6c0c632 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -598,6 +598,7 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
+#define ARM_SMMU_OPT_SHARED_IRQ	(1 << 2)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -665,6 +666,7 @@ struct arm_smmu_option_prop {
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
+	{ ARM_SMMU_OPT_SHARED_IRQ, "cavium,cn9900-broken-unique-irqline"},
 	{ 0, NULL},
 };
 
@@ -1313,6 +1315,21 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
 	return IRQ_HANDLED;
 }
+/* Shared irq handler*/
+static irqreturn_t arm_smmu_shared_irq_thread(int irq, void *dev)
+{
+	struct arm_smmu_device *smmu = dev;
+	irqreturn_t ret;
+
+	ret = arm_smmu_gerror_handler(irq, dev);
+	if (ret == IRQ_NONE) {
+		arm_smmu_evtq_thread(irq, dev);
+		arm_smmu_cmdq_sync_handler(irq, dev);
+		if (smmu->features & ARM_SMMU_FEAT_PRI)
+			arm_smmu_priq_thread(irq, dev);
+	}
+	return IRQ_HANDLED;
+}
 
 /* IO_PGTABLE API */
 static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
@@ -2230,18 +2247,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	devm_add_action(dev, arm_smmu_free_msis, dev);
 }
 
-static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 {
-	int ret, irq;
-	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
-
-	/* Disable IRQs first */
-	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
-				      ARM_SMMU_IRQ_CTRLACK);
-	if (ret) {
-		dev_err(smmu->dev, "failed to disable irqs\n");
-		return ret;
-	}
+	int irq, ret;
 
 	arm_smmu_setup_msis(smmu);
 
@@ -2284,10 +2292,46 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 			if (ret < 0)
 				dev_warn(smmu->dev,
 					 "failed to enable priq irq\n");
-			else
-				irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 		}
 	}
+}
+
+static void arm_smmu_setup_shared_irqs(struct arm_smmu_device *smmu)
+{
+	int ret, irq;
+
+	/* Single irq is used for all queues, request single interrupt lines */
+	irq = smmu->evtq.q.irq;
+	if (irq) {
+		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
+					arm_smmu_shared_irq_thread,
+					IRQF_ONESHOT | IRQF_SHARED,
+					"arm-smmu-v3-shared_irq", smmu);
+		if (ret < 0)
+			dev_warn(smmu->dev, "failed to enable shared irq\n");
+	}
+}
+
+static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+{
+	int ret;
+	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+
+	/* Disable IRQs first */
+	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
+				      ARM_SMMU_IRQ_CTRLACK);
+	if (ret) {
+		dev_err(smmu->dev, "failed to disable irqs\n");
+		return ret;
+	}
+
+	if (smmu->options & ARM_SMMU_OPT_SHARED_IRQ)
+		arm_smmu_setup_shared_irqs(smmu);
+	else
+		arm_smmu_setup_unique_irqs(smmu);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 
 	/* Enable interrupt generation on the SMMU */
 	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
@@ -2622,7 +2666,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
 {
 	if (model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
-		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
+		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY
+				| ARM_SMMU_OPT_SHARED_IRQ;
 
 	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
 }
-- 
1.7.1
