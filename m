From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  6 Apr 2017 19:29:23 +0100
Subject: [PATCHv2 16/16] arm64: pmuv3: use arm_pmu ACPI framework
In-Reply-To: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1491503363-17731-17-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a framework to handle the ACPI bits, make the PMUv3
code use this. The framework is a little different to what was
originally envisaged, and we can drop some unused support code in the
process of moving over to it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 50790d7..48bc505 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1134,24 +1134,9 @@ static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
 	{},
 };
 
-/*
- * Non DT systems have their micro/arch events probed at run-time.
- * A fairly complete list of generic events are provided and ones that
- * aren't supported by the current PMU are disabled.
- */
-static const struct pmu_probe_info armv8_pmu_probe_table[] = {
-	PMU_PROBE(0, 0, armv8_pmuv3_init), /* enable all defined counters */
-	{ /* sentinel value */ }
-};
-
 static int armv8_pmu_device_probe(struct platform_device *pdev)
 {
-	if (acpi_disabled)
-		return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids,
-					    NULL);
-
-	return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids,
-				    armv8_pmu_probe_table);
+	return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids, NULL);
 }
 
 static struct platform_driver armv8_pmu_driver = {
@@ -1162,4 +1147,11 @@ static int armv8_pmu_device_probe(struct platform_device *pdev)
 	.probe		= armv8_pmu_device_probe,
 };
 
-builtin_platform_driver(armv8_pmu_driver);
+int __init armv8_pmu_driver_init(void)
+{
+	if (acpi_disabled)
+		return platform_driver_register(&armv8_pmu_driver);
+	else
+		return arm_pmu_acpi_probe(armv8_pmuv3_init);
+}
+device_initcall(armv8_pmu_driver_init)
-- 
1.9.1
