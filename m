From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  6 Apr 2017 19:29:10 +0100
Subject: [PATCHv2 03/16] drivers/perf: arm_pmu: fold init into alloc
In-Reply-To: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1491503363-17731-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given we always want to initialise common fields on an allocated PMU,
this patch folds this common initialisation into armpmu_alloc(). This
will make it simpler to reuse this code for an ACPI-specific probe path.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 52 +++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 71a825d..1cb8b1a 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -494,24 +494,6 @@ static ssize_t armpmu_cpumask_show(struct device *dev,
 	.attrs = armpmu_common_attrs,
 };
 
-static void armpmu_init(struct arm_pmu *armpmu)
-{
-	armpmu->pmu = (struct pmu) {
-		.pmu_enable	= armpmu_enable,
-		.pmu_disable	= armpmu_disable,
-		.event_init	= armpmu_event_init,
-		.add		= armpmu_add,
-		.del		= armpmu_del,
-		.start		= armpmu_start,
-		.stop		= armpmu_stop,
-		.read		= armpmu_read,
-		.filter_match	= armpmu_filter_match,
-		.attr_groups	= armpmu->attr_groups,
-	};
-	armpmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =
-		&armpmu_common_attr_group;
-}
-
 /* Set at runtime when we know what CPU type we are. */
 static struct arm_pmu *__oprofile_cpu_pmu;
 
@@ -766,14 +748,6 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	if (err)
 		goto out_unregister;
 
-	/*
-	 * This is a CPU PMU potentially in a heterogeneous configuration (e.g.
-	 * big.LITTLE). This is not an uncore PMU, and we have taken ctx
-	 * sharing into account (e.g. with our pmu::filter_match callback and
-	 * pmu::event_init group validation).
-	 */
-	cpu_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
-
 	return 0;
 
 out_unregister:
@@ -962,6 +936,30 @@ static struct arm_pmu *armpmu_alloc(void)
 		goto out_free_pmu;
 	}
 
+	pmu->pmu = (struct pmu) {
+		.pmu_enable	= armpmu_enable,
+		.pmu_disable	= armpmu_disable,
+		.event_init	= armpmu_event_init,
+		.add		= armpmu_add,
+		.del		= armpmu_del,
+		.start		= armpmu_start,
+		.stop		= armpmu_stop,
+		.read		= armpmu_read,
+		.filter_match	= armpmu_filter_match,
+		.attr_groups	= pmu->attr_groups,
+		/*
+		 * This is a CPU PMU potentially in a heterogeneous
+		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
+		 * and we have taken ctx sharing into account (e.g. with our
+		 * pmu::filter_match callback and pmu::event_init group
+		 * validation).
+		 */
+		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS,
+	};
+
+	pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =
+		&armpmu_common_attr_group;
+
 	for_each_possible_cpu(cpu) {
 		struct pmu_hw_events *events;
 
@@ -998,8 +996,6 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	if (!pmu)
 		return -ENOMEM;
 
-	armpmu_init(pmu);
-
 	pmu->plat_device = pdev;
 
 	ret = pmu_parse_irqs(pmu);
-- 
1.9.1
