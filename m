From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  9 Sep 2016 14:08:30 +0100
Subject: [PATCH 5/5] drivers/perf: arm_pmu: expose a cpumask in sysfs
In-Reply-To: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
References: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473426510-12697-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In systems with heterogeneous CPUs, there are multiple logical CPU PMUs,
each of which covers a subset of CPUs in the system. In some cases
userspace needs to know which CPUs a given logical PMU covers, so we'd
like to expose a cpumask under sysfs, similar to what is done for uncore
PMUs.

Unfortunately, prior to commit 00e727bb389359c8 ("perf stat: Balance
opening and reading events"), perf stat only correctly handled a cpumask
holding a single CPU, and only when profiling in system-wide mode. In
other cases, the presence of a cpumask file could cause perf stat to
behave erratically.

Thus, exposing a cpumask file would break older perf binaries in cases
where they would otherwise work.

To avoid this issue while still providing userspace with the information
it needs, this patch exposes a differently-named file (cpus) under
sysfs. New tools can look for this and operate correctly, while older
tools will not be adversely affected by its presence.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c       | 20 ++++++++++++++++++++
 include/linux/perf/arm_pmu.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index ac83e1e..a484b51 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -534,6 +534,24 @@ static int armpmu_filter_match(struct perf_event *event)
 	return cpumask_test_cpu(cpu, &armpmu->supported_cpus);
 }
 
+static ssize_t armpmu_cpumask_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
+	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
+}
+
+static DEVICE_ATTR(cpus, S_IRUGO, armpmu_cpumask_show, NULL);
+
+static struct attribute *armpmu_common_attrs[] = {
+	&dev_attr_cpus.attr,
+	NULL,
+};
+
+static struct attribute_group armpmu_common_attr_group = {
+	.attrs = armpmu_common_attrs,
+};
+
 static void armpmu_init(struct arm_pmu *armpmu)
 {
 	atomic_set(&armpmu->active_events, 0);
@@ -551,6 +569,8 @@ static void armpmu_init(struct arm_pmu *armpmu)
 		.filter_match	= armpmu_filter_match,
 		.attr_groups	= armpmu->attr_groups,
 	};
+	armpmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =
+		&armpmu_common_attr_group;
 }
 
 /* Set at runtime when we know what CPU type we are. */
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 268bc63..dc1f2f3 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -78,6 +78,7 @@ struct pmu_hw_events {
 };
 
 enum armpmu_attr_groups {
+	ARMPMU_ATTR_GROUP_COMMON,
 	ARMPMU_ATTR_GROUP_EVENTS,
 	ARMPMU_ATTR_GROUP_FORMATS,
 	ARMPMU_NR_ATTR_GROUPS
-- 
1.9.1
