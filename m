From: shameerali.kolothum.thodi@huawei.com (Shameer Kolothum)
Date: Tue, 24 Jul 2018 12:45:15 +0100
Subject: [PATCH v2 4/4] perf/smmuv3: Add MSI irq support
In-Reply-To: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20180724114515.21764-5-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for MSI based counter overflow interrupt.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 105 +++++++++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 21 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index b3dc394..ca69813 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -94,6 +94,10 @@
 #define SMMU_PMCG_IRQ_CFG2              0xE64
 #define SMMU_PMCG_IRQ_STATUS            0xE68
 
+/* MSI config fields */
+#define MSI_CFG0_ADDR_MASK              GENMASK_ULL(51, 2)
+#define MSI_CFG2_MEMATTR_DEVICE_nGnRE   0x1
+
 #define SMMU_COUNTER_RELOAD             BIT(31)
 #define SMMU_DEFAULT_FILTER_SEC         0
 #define SMMU_DEFAULT_FILTER_SPAN        1
@@ -657,14 +661,89 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
 	return IRQ_HANDLED;
 }
 
+static void smmu_pmu_free_msis(void *data)
+{
+	struct device *dev = data;
+
+	platform_msi_domain_free_irqs(dev);
+}
+
+static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	phys_addr_t doorbell;
+	struct device *dev = msi_desc_to_dev(desc);
+	struct smmu_pmu *pmu = dev_get_drvdata(dev);
+
+	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
+	doorbell &= MSI_CFG0_ADDR_MASK;
+
+	writeq_relaxed(doorbell, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
+	writel_relaxed(msg->data, pmu->reg_base + SMMU_PMCG_IRQ_CFG1);
+	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
+				pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
+}
+
+static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
+{
+	struct msi_desc *desc;
+	struct device *dev = pmu->dev;
+	int ret;
+
+	/* Clear MSI address reg */
+	writeq_relaxed(0, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
+
+	/* MSI supported or not */
+	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
+		return;
+
+	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
+	if (ret) {
+		dev_warn(dev, "failed to allocate MSIs\n");
+		return;
+	}
+
+	desc = first_msi_entry(dev);
+	if (desc)
+		pmu->irq = desc->irq;
+
+	/* Add callback to free MSIs on teardown */
+	devm_add_action(dev, smmu_pmu_free_msis, dev);
+}
+
+static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
+{
+	int irq, ret = -ENXIO;
+
+	smmu_pmu_setup_msi(pmu);
+
+	irq = pmu->irq;
+	if (irq)
+		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
+			       IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD,
+			       "smmu-v3-pmu", pmu);
+	return ret;
+}
+
 static int smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
 {
+	int ret;
+
 	/* Disable counter and interrupt */
 	writeq(smmu_pmu->counter_present_mask,
 			smmu_pmu->reg_base + SMMU_PMCG_CNTENCLR0);
 	writeq(smmu_pmu->counter_present_mask,
 		smmu_pmu->reg_base + SMMU_PMCG_INTENCLR0);
 
+	ret = smmu_pmu_setup_irq(smmu_pmu);
+	if (ret) {
+		dev_err(smmu_pmu->dev, "failed to setup irqs\n");
+		return ret;
+	}
+
+	/* Pick one CPU to be the preferred one to use */
+	smmu_pmu->on_cpu = smp_processor_id();
+	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
+
 	smmu_pmu_disable(&smmu_pmu->pmu);
 	return 0;
 }
@@ -738,26 +817,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get valid irq for smmu @%pa\n",
-			&mem_resource_0->start);
-		return irq;
-	}
-
-	err = devm_request_irq(dev, irq, smmu_pmu_handle_irq,
-			       IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD,
-			       "smmu-pmu", smmu_pmu);
-	if (err) {
-		dev_err(dev,
-			"Unable to request IRQ%d for SMMU PMU counters\n", irq);
-		return err;
-	}
-
-	smmu_pmu->irq = irq;
-
-	/* Pick one CPU to be the preferred one to use */
-	smmu_pmu->on_cpu = smp_processor_id();
-	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
+	if (irq > 0)
+		smmu_pmu->irq = irq;
 
 	smmu_pmu->num_counters = get_num_counters(smmu_pmu);
 	smmu_pmu->counter_present_mask = GENMASK(smmu_pmu->num_counters - 1, 0);
@@ -765,7 +826,9 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		    SMMU_PMCG_CFGR_SIZE_MASK) >> SMMU_PMCG_CFGR_SIZE_SHIFT;
 	smmu_pmu->counter_mask = GENMASK_ULL(reg_size, 0);
 
-	smmu_pmu_reset(smmu_pmu);
+	err = smmu_pmu_reset(smmu_pmu);
+	if (err)
+		return err;
 
 	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
 					       &smmu_pmu->node);
-- 
2.7.4
