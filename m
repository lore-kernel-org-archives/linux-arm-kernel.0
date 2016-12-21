From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 21 Dec 2016 11:19:33 +0100
Subject: [PATCH 1/3] drivers/perf: arm_pmu: Use devm_ allocators
In-Reply-To: <20161221101935.17178-1-alexander.stein@systec-electronic.com>
References: <20161221101935.17178-1-alexander.stein@systec-electronic.com>
Message-ID: <20161221101935.17178-2-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This eliminates several calls to kfree.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/perf/arm_pmu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index b37b572..a9bbdbf 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -917,7 +917,8 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 	bool using_spi = false;
 	struct platform_device *pdev = pmu->plat_device;
 
-	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
+	irqs = devm_kcalloc(&pdev->dev, pdev->num_resources, sizeof(*irqs),
+			    GFP_KERNEL);
 	if (!irqs)
 		return -ENOMEM;
 
@@ -939,7 +940,6 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 				pr_err("PPI/SPI IRQ type mismatch for %s!\n",
 					dn->name);
 				of_node_put(dn);
-				kfree(irqs);
 				return -EINVAL;
 			}
 
@@ -988,10 +988,8 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 			int ret;
 
 			ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);
-			if (ret) {
-				kfree(irqs);
+			if (ret)
 				return ret;
-			}
 		} else {
 			/* Otherwise default to all CPUs */
 			cpumask_setall(&pmu->supported_cpus);
@@ -1001,8 +999,6 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 	/* If we matched up the IRQ affinities, use them to route the SPIs */
 	if (using_spi && i == pdev->num_resources)
 		pmu->irq_affinity = irqs;
-	else
-		kfree(irqs);
 
 	return 0;
 }
@@ -1017,7 +1013,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	struct arm_pmu *pmu;
 	int ret = -ENODEV;
 
-	pmu = kzalloc(sizeof(struct arm_pmu), GFP_KERNEL);
+	pmu = devm_kzalloc(&pdev->dev, sizeof(struct arm_pmu), GFP_KERNEL);
 	if (!pmu) {
 		pr_info("failed to allocate PMU device!\n");
 		return -ENOMEM;
@@ -1074,8 +1070,6 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 out_free:
 	pr_info("%s: failed to register PMU devices!\n",
 		of_node_full_name(node));
-	kfree(pmu->irq_affinity);
-	kfree(pmu);
 	return ret;
 }
 
-- 
2.10.2
