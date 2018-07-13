From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri, 13 Jul 2018 11:27:57 -0500
Subject: [PATCH 2/3] iommu/arm-smmu: Add optional SMMU clock
In-Reply-To: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1531499278-32132-3-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add a clock to the SMMU structure. In the device tree case,
check for a clock handle and enable the clock if found.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/iommu/arm-smmu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 69e7c60792a8..0e6dd5019c23 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -212,6 +212,7 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+	struct clk			*clk;
 };
 
 enum arm_smmu_context_fmt {
@@ -1992,6 +1993,15 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	bool legacy_binding;
 
+	/* If a clock is declared, enable it */
+	smmu->clk = devm_clk_get(smmu->dev, NULL);
+	if (IS_ERR(smmu->clk)) {
+		smmu->clk = NULL;
+		dev_dbg(dev, "cannot get smmu clock\n");
+	} else {
+		clk_prepare_enable(smmu->clk);
+	}
+
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
 		dev_err(dev, "missing #global-interrupts property\n");
@@ -2181,6 +2191,10 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	if (smmu->clk)
+		clk_disable_unprepare(smmu->clk);
+
 	return 0;
 }
 
@@ -2193,6 +2207,9 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 
+	if (smmu->clk)
+		clk_prepare_enable(smmu->clk);
+
 	arm_smmu_device_reset(smmu);
 	return 0;
 }
-- 
2.7.4
