From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 4 Feb 2016 10:58:48 +0100
Subject: [PATCH v2] drivers/perf: arm_pmu: make info messages more verbose
Message-ID: <1454579928-20231-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a big.LITTLE system e.g. with Cortex A57 and A53 in case not all cores
are online at PMU probe time we might get

hw perfevents: failed to probe PMU!
hw perfevents: failed to register PMU devices!

making it unclear which cores failed, here.

Add the device tree full name which failed and the error value resulting
in a more verbose and helpful message like

hw perfevents: /soc/pmu_a53: failed to probe PMU! Error -6
hw perfevents: /soc/pmu_a53: failed to register PMU devices! Error -6

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
Changes in v2: Use the full node name from DT instead of pmu->name, as if
we fail to find anything in the match table, that'll be NULL. Additionally,
add the error value to get an idea why it failed.

 drivers/perf/arm_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 166637f..6fb63a3 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -898,7 +898,8 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	}
 
 	if (ret) {
-		pr_info("failed to probe PMU!\n");
+		pr_info("%s: failed to probe PMU! Error %i\n",
+			node->full_name, ret);
 		goto out_free;
 	}
 
@@ -918,7 +919,8 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 out_destroy:
 	cpu_pmu_destroy(pmu);
 out_free:
-	pr_info("failed to register PMU devices!\n");
+	pr_info("%s: failed to register PMU devices! Error %i\n",
+		node->full_name, ret);
 	kfree(pmu);
 	return ret;
 }
-- 
2.5.1
