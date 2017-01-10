From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 10 Jan 2017 11:17:50 -0600
Subject: [PATCH v12 5/7] arm64: pmu: Detect multiple generic PMUs and append
 counter
In-Reply-To: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
References: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1484068672-15852-6-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In heterogeneous CPU systems its likely that there are multiple
PMU types. If a system is using the generic armv8_pmuv3 rather
than a PMU with a hard-coded set of events then we want to uniquely
identify each PMU in /sys. We do this by appending an "_x" to the
pmu name. This then creates PMUs like, "armv8_pmuv3" and
"armv8_pmuv3_1", "armv8_pmuv3_2" for a system with 3 PMU types.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/perf_event.c |  2 +-
 drivers/perf/arm_pmu.c         | 20 ++++++++++++++++++++
 include/linux/perf/arm_pmu.h   |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 57ae9d9..0fbd7ef 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1002,7 +1002,7 @@ static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
 {
 	armv8_pmu_init(cpu_pmu);
-	cpu_pmu->name			= "armv8_pmuv3";
+	cpu_pmu->name			= ARMV8_PMUV3_DESCRIPTION;
 	cpu_pmu->map_event		= armv8_pmuv3_map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
 		&armv8_pmuv3_events_attr_group;
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 37e241f..85566f6 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -1035,6 +1035,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table)
 {
+	static int duplicate_pmus;
 	const struct of_device_id *of_id;
 	const int (*init_fn)(struct arm_pmu *);
 	struct device_node *node = pdev->dev.of_node;
@@ -1075,6 +1076,25 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		goto out_free;
 	}
 
+	/*
+	 * if this pmu declaration is a generic pmu and we have
+	 * previously found a generic pmu on this platform
+	 * then append a PMU number to the pmu name. This avoids
+	 * changing the names of PMUs that are specific to a class
+	 * of CPUs. The assumption is that if we match a specific PMU
+	 * then it's unique, and another PMU in the system will match
+	 * a different entry rather than needing the _number to
+	 * assure its unique.
+	 */
+	if (!strcmp(pmu->name, ARMV8_PMUV3_DESCRIPTION)) {
+		if (duplicate_pmus) {
+			pmu->name = kasprintf(GFP_KERNEL, "%s_%d",
+					      pmu->name, duplicate_pmus);
+			if (!pmu->name)
+				goto out_free;
+		}
+		duplicate_pmus++;
+	}
 
 	ret = cpu_pmu_init(pmu);
 	if (ret)
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index df1ba55..42b5edb 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -161,6 +161,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct pmu_probe_info *probe_table);
 
 #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
+#define ARMV8_PMUV3_DESCRIPTION "armv8_pmuv3"
 
 #endif /* CONFIG_ARM_PMU */
 
-- 
2.5.5
