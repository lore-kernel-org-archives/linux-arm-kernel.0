From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu,  9 Jun 2016 17:23:26 -0500
Subject: [PATCH 1/8] arm64: pmu: add fallback probe table
In-Reply-To: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1465511013-10742-2-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

In preparation for ACPI support, add a pmu_probe_info table to
the arm_pmu_device_probe() call. This table gets used when
probing in the absence of a devicetree node for PMU.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/perf_event.c | 8 +++++++-
 include/linux/perf/arm_pmu.h   | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 838ccf1..917c3e2 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1044,9 +1044,15 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{},
 };
 
+static const struct pmu_probe_info armv8_pmu_probe_table[] = {
+	PMU_PROBE(0, 0, armv8_pmuv3_init), /* if all else fails... */
+	{ /* sentinel value */ }
+};
+
 static int armv8_pmu_device_probe(struct platform_device *pdev)
 {
-	return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids, NULL);
+	return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids,
+				    armv8_pmu_probe_table);
 }
 
 static struct platform_driver armv8_pmu_driver = {
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index d28ac05..7e814fe 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -147,6 +147,9 @@ struct pmu_probe_info {
 #define XSCALE_PMU_PROBE(_version, _fn) \
 	PMU_PROBE(ARM_CPU_IMP_INTEL << 24 | _version, ARM_PMU_XSCALE_MASK, _fn)
 
+#define ARMV8_PMU_PART_PROBE(_part, _fn) \
+	PMU_PROBE((_part) << MIDR_PARTNUM_SHIFT, MIDR_PARTNUM_MASK, _fn)
+
 int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
-- 
2.5.5
