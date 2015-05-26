From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:23:38 +0100
Subject: [PATCH 5/7] arm: perf: factor out armv7 pmu driver
In-Reply-To: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
References: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432657420-887-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core arm perf code maintains no global state and all
microarchitecture-specific PMU data can be fed in through the shared
probe function, it's possible to use it as a library and get rid of the
C file includes we have currently.

This patch factors out the ARMv7-specific portions out into the ARMv7
driver. For the moment this is always built if perf event support is
enabled, but the preprocessor guards will leave behind an empty file.

Now that perf_event_cpu.c contains no microarchitecture-specific data,
the associated probing code is removed, completing its relegation to a
library file. The vestigal "arm-pmu" platform device ID is removed in
this patch, as it has been unused since platform files were updated to
specify a more specific PMU variant.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/Makefile         |  3 +-
 arch/arm/kernel/perf_event_cpu.c | 53 ---------------------------
 arch/arm/kernel/perf_event_v7.c  | 77 +++++++++++++++++++---------------------
 3 files changed, 39 insertions(+), 94 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 42a43da..26de378 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -71,7 +71,8 @@ obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o \
-				   perf_event_xscale.o perf_event_v6.o
+				   perf_event_xscale.o perf_event_v6.o \
+				   perf_event_v7.o
 CFLAGS_pj4-cp0.o		:= -marm
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index d24d585..261b639 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -59,9 +59,6 @@ int perf_num_counters(void)
 }
 EXPORT_SYMBOL_GPL(perf_num_counters);
 
-/* Include the PMU-specific implementations. */
-#include "perf_event_v7.c"
-
 static void cpu_pmu_enable_percpu_irq(void *data)
 {
 	int irq = *(int *)data;
@@ -242,35 +239,6 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 }
 
 /*
- * PMU platform driver and devicetree bindings.
- */
-static const struct of_device_id cpu_pmu_of_device_ids[] = {
-	{.compatible = "arm,cortex-a17-pmu",	.data = armv7_a17_pmu_init},
-	{.compatible = "arm,cortex-a15-pmu",	.data = armv7_a15_pmu_init},
-	{.compatible = "arm,cortex-a12-pmu",	.data = armv7_a12_pmu_init},
-	{.compatible = "arm,cortex-a9-pmu",	.data = armv7_a9_pmu_init},
-	{.compatible = "arm,cortex-a8-pmu",	.data = armv7_a8_pmu_init},
-	{.compatible = "arm,cortex-a7-pmu",	.data = armv7_a7_pmu_init},
-	{.compatible = "arm,cortex-a5-pmu",	.data = armv7_a5_pmu_init},
-	{.compatible = "qcom,krait-pmu",	.data = krait_pmu_init},
-	{.compatible = "qcom,scorpion-pmu",	.data = scorpion_pmu_init},
-	{.compatible = "qcom,scorpion-mp-pmu",	.data = scorpion_mp_pmu_init},
-	{},
-};
-
-static struct platform_device_id cpu_pmu_plat_device_ids[] = {
-	{.name = "arm-pmu"},
-	{.name = "armv7-pmu"},
-	{},
-};
-
-static const struct pmu_probe_info pmu_probe_table[] = {
-	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A8, armv7_a8_pmu_init),
-	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A9, armv7_a9_pmu_init),
-	{ /* sentinel value */ }
-};
-
-/*
  * CPU PMU identification and probing.
  */
 static int probe_current_pmu(struct arm_pmu *pmu,
@@ -393,24 +361,3 @@ out_free:
 	kfree(pmu);
 	return ret;
 }
-
-static int cpu_pmu_device_probe(struct platform_device *pdev)
-{
-	return arm_pmu_device_probe(pdev, cpu_pmu_of_device_ids,
-				    pmu_probe_table);
-}
-
-static struct platform_driver cpu_pmu_driver = {
-	.driver		= {
-		.name	= "arm-pmu",
-		.of_match_table = cpu_pmu_of_device_ids,
-	},
-	.probe		= cpu_pmu_device_probe,
-	.id_table	= cpu_pmu_plat_device_ids,
-};
-
-static int __init register_pmu_driver(void)
-{
-	return platform_driver_register(&cpu_pmu_driver);
-}
-device_initcall(register_pmu_driver);
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index ccec472..f9b37f8 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -19,9 +19,15 @@
 #ifdef CONFIG_CPU_V7
 
 #include <asm/cp15.h>
+#include <asm/cputype.h>
+#include <asm/irq_regs.h>
+#include <asm/pmu.h>
 #include <asm/vfp.h>
 #include "../vfp/vfpinstr.h"
 
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
 /*
  * Common ARMv7 event types
  *
@@ -1853,54 +1859,45 @@ static int scorpion_mp_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->clear_event_idx = scorpion_pmu_clear_event_idx;
 	return armv7_probe_num_events(cpu_pmu);
 }
-#else
-static inline int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
 
-static inline int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
+static const struct of_device_id armv7_pmu_of_device_ids[] = {
+	{.compatible = "arm,cortex-a17-pmu",	.data = armv7_a17_pmu_init},
+	{.compatible = "arm,cortex-a15-pmu",	.data = armv7_a15_pmu_init},
+	{.compatible = "arm,cortex-a12-pmu",	.data = armv7_a12_pmu_init},
+	{.compatible = "arm,cortex-a9-pmu",	.data = armv7_a9_pmu_init},
+	{.compatible = "arm,cortex-a8-pmu",	.data = armv7_a8_pmu_init},
+	{.compatible = "arm,cortex-a7-pmu",	.data = armv7_a7_pmu_init},
+	{.compatible = "arm,cortex-a5-pmu",	.data = armv7_a5_pmu_init},
+	{.compatible = "qcom,krait-pmu",	.data = krait_pmu_init},
+	{.compatible = "qcom,scorpion-pmu",	.data = scorpion_pmu_init},
+	{.compatible = "qcom,scorpion-mp-pmu",	.data = scorpion_mp_pmu_init},
+	{},
+};
 
-static inline int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
+static const struct pmu_probe_info armv7_pmu_probe_table[] = {
+	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A8, armv7_a8_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A9, armv7_a9_pmu_init),
+	{ /* sentinel value */ }
+};
 
-static inline int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
 
-static inline int krait_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv7_pmu_device_probe(struct platform_device *pdev)
 {
-	return -ENODEV;
+	return arm_pmu_device_probe(pdev, armv7_pmu_of_device_ids,
+				    armv7_pmu_probe_table);
 }
 
-static inline int scorpion_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
+static struct platform_driver armv7_pmu_driver = {
+	.driver		= {
+		.name	= "armv7-pmu",
+		.of_match_table = armv7_pmu_of_device_ids,
+	},
+	.probe		= armv7_pmu_device_probe,
+};
 
-static inline int scorpion_mp_pmu_init(struct arm_pmu *cpu_pmu)
+static int __init register_armv7_pmu_driver(void)
 {
-	return -ENODEV;
+	return platform_driver_register(&armv7_pmu_driver);
 }
+device_initcall(register_armv7_pmu_driver);
 #endif	/* CONFIG_CPU_V7 */
-- 
1.9.1
