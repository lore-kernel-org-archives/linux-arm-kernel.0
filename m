From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 21 Jun 2016 12:11:46 -0500
Subject: [PATCH 08/11] arm64: pmu: Provide cpumask attribute for PMU
In-Reply-To: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1466529109-21715-9-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With heterogeneous PMUs its helpful to know which PMUs are bound
to each CPU. Provide that information with a cpumask sysfs entry
similar to other PMUs.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/perf_event.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 356fa6c..dae73ea 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -533,6 +533,26 @@ static struct attribute_group armv8_pmuv3_events_attr_group = {
 
 PMU_FORMAT_ATTR(event, "config:0-9");
 
+static ssize_t
+cpumask_show(struct device *dev, struct device_attribute *attr, char *page)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
+
+	return cpumap_print_to_pagebuf(true, page, &cpu_pmu->supported_cpus);
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *armv8_pmuv3_attrs[] = {
+	 &dev_attr_cpumask.attr,
+	 NULL,
+};
+
+static struct attribute_group armv8_pmuv3_attr_group = {
+	.attrs = armv8_pmuv3_attrs,
+};
+
+
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
 	NULL,
@@ -544,6 +564,7 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 };
 
 static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
+	&armv8_pmuv3_attr_group,
 	&armv8_pmuv3_events_attr_group,
 	&armv8_pmuv3_format_attr_group,
 	NULL,
-- 
2.5.5
