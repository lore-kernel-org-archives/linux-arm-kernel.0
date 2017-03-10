From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 11:04:39 +0000
Subject: [PATCH 02/14] drivers/perf: arm_pmu: define armpmu_init_fn
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489143891-11596-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We expect an ARM PMU's init function to have a particular prototype,
which we open-code in a few places. This is less than ideal, considering
that we cast a void value to this type in one location, and a mismatch
could easily be missed.

Add a typedef so that we can ensure this is consistent.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c       | 2 +-
 include/linux/perf/arm_pmu.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2bbce3b..1dfda0b 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -989,7 +989,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct pmu_probe_info *probe_table)
 {
 	const struct of_device_id *of_id;
-	const int (*init_fn)(struct arm_pmu *);
+	armpmu_init_fn init_fn;
 	struct device_node *node = pdev->dev.of_node;
 	struct arm_pmu *pmu;
 	int ret = -ENODEV;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 44f43fc..4249914 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -132,10 +132,12 @@ int armpmu_map_event(struct perf_event *event,
 						[PERF_COUNT_HW_CACHE_RESULT_MAX],
 		     u32 raw_event_mask);
 
+typedef int (*armpmu_init_fn)(struct arm_pmu *);
+
 struct pmu_probe_info {
 	unsigned int cpuid;
 	unsigned int mask;
-	int (*init)(struct arm_pmu *);
+	armpmu_init_fn init;
 };
 
 #define PMU_PROBE(_cpuid, _mask, _fn)	\
-- 
1.9.1
