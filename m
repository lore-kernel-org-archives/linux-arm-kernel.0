From: jeremy.linton@arm.com (Jeremy Linton)
Date: Sun, 13 Mar 2016 18:23:16 -0500
Subject: [PATCH 2/4] arm64: pmu: add fallback probe table
In-Reply-To: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
References: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1457911398-22412-3-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

In preparation for ACPI support, add a pmu_probe_info table to
the arm_pmu_device_probe() call. This table gets used when
probing in the absence of a devicetree node for PMU.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/kernel/perf_event.c | 10 +++++++++-
 include/linux/perf/arm_pmu.h   |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 767c4f6..03e0957 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -901,9 +901,17 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{},
 };
 
+static const struct pmu_probe_info armv8_pmu_probe_table[] = {
+	ARMV8_PMU_PART_PROBE(ARM_CPU_PART_CORTEX_A53, armv8_a53_pmu_init),
+	ARMV8_PMU_PART_PROBE(ARM_CPU_PART_CORTEX_A57, armv8_a57_pmu_init),
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
index 4196c90..495332f 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -145,6 +145,9 @@ struct pmu_probe_info {
 #define XSCALE_PMU_PROBE(_version, _fn) \
 	PMU_PROBE(ARM_CPU_IMP_INTEL << 24 | _version, ARM_PMU_XSCALE_MASK, _fn)
 
+#define ARMV8_PMU_PART_PROBE(_part, _fn) \
+	PMU_PROBE((_part) << MIDR_PARTNUM_SHIFT, MIDR_PARTNUM_MASK, _fn)
+
 int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
-- 
2.4.3
