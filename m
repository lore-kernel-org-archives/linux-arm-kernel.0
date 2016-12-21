From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 21 Dec 2016 11:19:34 +0100
Subject: [PATCH 2/3] drivers/perf: arm_pmu: add arm_pmu_device_remove
In-Reply-To: <20161221101935.17178-1-alexander.stein@systec-electronic.com>
References: <20161221101935.17178-1-alexander.stein@systec-electronic.com>
Message-ID: <20161221101935.17178-3-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM PMU removal function. This will be required by perf event drivers
when option DEBUG_TEST_DRIVER_REMOVE is enabled.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/perf/arm_pmu.c       | 14 ++++++++++++++
 include/linux/perf/arm_pmu.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index a9bbdbf..b7ddc4c 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -1022,6 +1022,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	armpmu_init(pmu);
 
 	pmu->plat_device = pdev;
+	platform_set_drvdata(pdev, pmu);
 
 	if (node && (of_id = of_match_node(of_table, pdev->dev.of_node))) {
 		init_fn = of_id->data;
@@ -1073,6 +1074,19 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	return ret;
 }
 
+int arm_pmu_device_remove(struct platform_device *pdev)
+{
+	struct arm_pmu *pmu = platform_get_drvdata(pdev);
+
+	__oprofile_cpu_pmu = NULL;
+
+	perf_pmu_unregister(&pmu->pmu);
+
+	cpu_pmu_destroy(pmu);
+
+	return 0;
+}
+
 static int arm_pmu_hp_init(void)
 {
 	int ret;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 8462da2..8106f27 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -159,6 +159,8 @@ struct pmu_probe_info {
 int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
+int arm_pmu_device_remove(struct platform_device *pdev);
+
 
 #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
 
-- 
2.10.2
