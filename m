From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  9 Sep 2016 14:08:26 +0100
Subject: [PATCH 1/5] drivers/perf: arm_pmu: add common attr group fields
In-Reply-To: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
References: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473426510-12697-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for adding common attribute groups, add an array of
attribute group pointers to arm_pmu, which will be used if the
backend hasn't already set pmu::attr_groups.

Subsequent patches will move backends over to using these, before adding
common fields.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c       |  3 +++
 include/linux/perf/arm_pmu.h | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index f5e1008..145caf4 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -1039,6 +1039,9 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		goto out_free;
 	}
 
+	if (!pmu->pmu.attr_groups)
+		pmu->pmu.attr_groups = pmu->attr_groups;
+
 	ret = cpu_pmu_init(pmu);
 	if (ret)
 		goto out_free;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index e188438..268bc63 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -14,7 +14,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
-
+#include <linux/sysfs.h>
 #include <asm/cputype.h>
 
 /*
@@ -77,6 +77,12 @@ struct pmu_hw_events {
 	struct arm_pmu		*percpu_pmu;
 };
 
+enum armpmu_attr_groups {
+	ARMPMU_ATTR_GROUP_EVENTS,
+	ARMPMU_ATTR_GROUP_FORMATS,
+	ARMPMU_NR_ATTR_GROUPS
+};
+
 struct arm_pmu {
 	struct pmu	pmu;
 	cpumask_t	active_irqs;
@@ -111,6 +117,8 @@ struct arm_pmu {
 	struct pmu_hw_events	__percpu *hw_events;
 	struct list_head	entry;
 	struct notifier_block	cpu_pm_nb;
+	/* the attr_groups array must be NULL-terminated */
+	const struct attribute_group *attr_groups[ARMPMU_NR_ATTR_GROUPS + 1];
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-- 
1.9.1
