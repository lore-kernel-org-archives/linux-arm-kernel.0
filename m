From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 11:04:41 +0000
Subject: [PATCH 04/14] drivers/perf: arm_pmu: factor out pmu registration
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489143891-11596-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently arm_pmu_device_probe contains probing logic specific to the
platform_device infrastructure, and some logic required to safely
register the PMU with various systems.

This patch factors out the logic relating to the registration of the
PMU. This makes arm_pmu_device_probe a little easier to read, and will
make it easier to reuse the logic for an ACPI-specific probing
mechanism.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index e7529a0..4ae9c49 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -982,6 +982,31 @@ void armpmu_free(struct arm_pmu *pmu)
 	kfree(pmu);
 }
 
+int armpmu_register(struct arm_pmu *pmu)
+{
+	int ret;
+
+	ret = cpu_pmu_init(pmu);
+	if (ret)
+		return ret;
+
+	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
+	if (ret)
+		goto out_destroy;
+
+	if (!__oprofile_cpu_pmu)
+		__oprofile_cpu_pmu = pmu;
+
+	pr_info("enabled with %s PMU driver, %d counters available\n",
+		pmu->name, pmu->num_events);
+
+	return 0;
+
+out_destroy:
+	cpu_pmu_destroy(pmu);
+	return ret;
+}
+
 int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table)
@@ -1025,25 +1050,12 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		goto out_free;
 	}
 
-
-	ret = cpu_pmu_init(pmu);
+	ret = armpmu_register(pmu);
 	if (ret)
 		goto out_free;
 
-	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
-	if (ret)
-		goto out_destroy;
-
-	if (!__oprofile_cpu_pmu)
-		__oprofile_cpu_pmu = pmu;
-
-	pr_info("enabled with %s PMU driver, %d counters available\n",
-			pmu->name, pmu->num_events);
-
 	return 0;
 
-out_destroy:
-	cpu_pmu_destroy(pmu);
 out_free:
 	pr_info("%s: failed to register PMU devices!\n",
 		of_node_full_name(node));
-- 
1.9.1
