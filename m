From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 12 Jan 2016 09:22:20 +0100
Subject: [PATCH] drivers/perf: arm_pmu: make info messages more verbose
Message-ID: <1452586940-20137-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a big.LITTLE system e.g. with Cortex A57 and A53 in case not all cores
are online at PMU probe time we might get

hw perfevents: failed to probe PMU!
hw perfevents: failed to register PMU devices!

making it unclear which cores failed, here.

Add the name of the PMU which failed resulting in a more verbose and
helpful message

hw perfevents: armv8_cortex_a53: failed to probe PMU!
hw perfevents: armv8_cortex_a53: failed to register PMU devices!

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/perf/arm_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index be3755c..fc1f06f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -904,7 +904,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	}
 
 	if (ret) {
-		pr_info("failed to probe PMU!\n");
+		pr_info("%s: failed to probe PMU!\n", pmu->name);
 		goto out_free;
 	}
 
@@ -921,7 +921,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 out_destroy:
 	cpu_pmu_destroy(pmu);
 out_free:
-	pr_info("failed to register PMU devices!\n");
+	pr_info("%s: failed to register PMU devices!\n", pmu->name);
 	kfree(pmu);
 	return ret;
 }
-- 
2.5.1
