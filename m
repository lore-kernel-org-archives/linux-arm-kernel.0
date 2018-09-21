From: shameerali.kolothum.thodi@huawei.com (Shameer Kolothum)
Date: Fri, 21 Sep 2018 16:08:03 +0100
Subject: [PATCH v3 3/3] perf/smmuv3: Add MSI irq support
In-Reply-To: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20180921150803.25444-4-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for MSI-based counter overflow interrupt.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 2fa6c96..84f7907 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -57,6 +57,7 @@
 #define SMMU_PMCG_OVSSET0               0xCC0
 #define SMMU_PMCG_CFGR                  0xE00
 #define SMMU_PMCG_CFGR_RELOC_CTRS       BIT(20)
+#define SMMU_PMCG_CFGR_MSI              BIT(21)
 #define SMMU_PMCG_CFGR_SIZE_MASK        GENMASK(13, 8)
 #define SMMU_PMCG_CFGR_NCTR_MASK        GENMASK(5, 0)
 #define SMMU_PMCG_CR                    0xE04
@@ -66,6 +67,12 @@
 #define SMMU_PMCG_IRQ_CTRL              0xE50
 #define SMMU_PMCG_IRQ_CTRL_IRQEN        BIT(0)
 #define SMMU_PMCG_IRQ_CFG0              0xE58
+#define SMMU_PMCG_IRQ_CFG1              0xE60
+#define SMMU_PMCG_IRQ_CFG2              0xE64
+
+/* MSI config fields */
+#define MSI_CFG0_ADDR_MASK              GENMASK_ULL(51, 2)
+#define MSI_CFG2_MEMATTR_DEVICE_nGnRE   0x1
 
 #define SMMU_DEFAULT_FILTER_SPAN        1
 #define SMMU_DEFAULT_FILTER_STREAM_ID   GENMASK(31, 0)
@@ -548,11 +555,62 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
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
+		       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
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
 static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
 {
 	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;
 	int irq, ret = -ENXIO;
 
+	smmu_pmu_setup_msi(pmu);
+
 	irq = pmu->irq;
 	if (irq)
 		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
-- 
2.7.4
