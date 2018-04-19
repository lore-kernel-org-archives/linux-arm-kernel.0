From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Thu, 19 Apr 2018 16:06:07 +0200
Subject: [PATCH 37/61] perf: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180419140641.27926-38-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/perf/arm_spe_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 28bb642af18b..54ec278d2fc4 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -131,8 +131,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct arm_spe_pmu *spe_pmu = platform_get_drvdata(pdev);
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 	struct dev_ext_attribute *ea =
 		container_of(attr, struct dev_ext_attribute, attr);
 	int cap = (long)ea->var;
@@ -247,8 +246,7 @@ static ssize_t arm_spe_pmu_get_attr_cpumask(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct arm_spe_pmu *spe_pmu = platform_get_drvdata(pdev);
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
 	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
 }
-- 
2.11.0
