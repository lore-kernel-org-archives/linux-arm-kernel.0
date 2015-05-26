From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:23:37 +0100
Subject: [PATCH 4/7] arm: perf: factor out armv6 pmu driver
In-Reply-To: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
References: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432657420-887-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core arm perf code maintains no global state and all
microarchitecture-specific PMU data can be fed in through the shared
probe function, it's possible to use it as a library and get rid of the
C file includes we have currently.

This patch factors out the ARMv6-specific portions out into the ARMv6
driver. For the moment this is always built if perf event support is
enabled, but the preprocessor guards will leave behind an empty file.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/Makefile         |  3 ++-
 arch/arm/kernel/perf_event_cpu.c |  9 --------
 arch/arm/kernel/perf_event_v6.c  | 49 +++++++++++++++++++++++++++++-----------
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 8b4aad7..42a43da 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -70,7 +70,8 @@ obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
 obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o perf_event_xscale.o
+obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o \
+				   perf_event_xscale.o perf_event_v6.o
 CFLAGS_pj4-cp0.o		:= -marm
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 1ebb179..d24d585 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -60,7 +60,6 @@ int perf_num_counters(void)
 EXPORT_SYMBOL_GPL(perf_num_counters);
 
 /* Include the PMU-specific implementations. */
-#include "perf_event_v6.c"
 #include "perf_event_v7.c"
 
 static void cpu_pmu_enable_percpu_irq(void *data)
@@ -253,9 +252,6 @@ static const struct of_device_id cpu_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a8-pmu",	.data = armv7_a8_pmu_init},
 	{.compatible = "arm,cortex-a7-pmu",	.data = armv7_a7_pmu_init},
 	{.compatible = "arm,cortex-a5-pmu",	.data = armv7_a5_pmu_init},
-	{.compatible = "arm,arm11mpcore-pmu",	.data = armv6mpcore_pmu_init},
-	{.compatible = "arm,arm1176-pmu",	.data = armv6_1176_pmu_init},
-	{.compatible = "arm,arm1136-pmu",	.data = armv6_1136_pmu_init},
 	{.compatible = "qcom,krait-pmu",	.data = krait_pmu_init},
 	{.compatible = "qcom,scorpion-pmu",	.data = scorpion_pmu_init},
 	{.compatible = "qcom,scorpion-mp-pmu",	.data = scorpion_mp_pmu_init},
@@ -264,16 +260,11 @@ static const struct of_device_id cpu_pmu_of_device_ids[] = {
 
 static struct platform_device_id cpu_pmu_plat_device_ids[] = {
 	{.name = "arm-pmu"},
-	{.name = "armv6-pmu"},
 	{.name = "armv7-pmu"},
 	{},
 };
 
 static const struct pmu_probe_info pmu_probe_table[] = {
-	ARM_PMU_PROBE(ARM_CPU_PART_ARM1136, armv6_1136_pmu_init),
-	ARM_PMU_PROBE(ARM_CPU_PART_ARM1156, armv6_1156_pmu_init),
-	ARM_PMU_PROBE(ARM_CPU_PART_ARM1176, armv6_1176_pmu_init),
-	ARM_PMU_PROBE(ARM_CPU_PART_ARM11MPCORE, armv6mpcore_pmu_init),
 	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A8, armv7_a8_pmu_init),
 	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A9, armv7_a9_pmu_init),
 	{ /* sentinel value */ }
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index f2ffd5c..09f83e4 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -31,6 +31,14 @@
  */
 
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
+
+#include <asm/cputype.h>
+#include <asm/irq_regs.h>
+#include <asm/pmu.h>
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
 enum armv6_perf_types {
 	ARMV6_PERFCTR_ICACHE_MISS	    = 0x0,
 	ARMV6_PERFCTR_IBUF_STALL	    = 0x1,
@@ -543,24 +551,39 @@ static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 
 	return 0;
 }
-#else
-static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
 
-static int armv6_1156_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
+static struct of_device_id armv6_pmu_of_device_ids[] = {
+	{.compatible = "arm,arm11mpcore-pmu",	.data = armv6mpcore_pmu_init},
+	{.compatible = "arm,arm1176-pmu",	.data = armv6_1176_pmu_init},
+	{.compatible = "arm,arm1136-pmu",	.data = armv6_1136_pmu_init},
+	{ /* sentinel value */ }
+};
 
-static int armv6_1176_pmu_init(struct arm_pmu *cpu_pmu)
+static const struct pmu_probe_info armv6_pmu_probe_table[] = {
+	ARM_PMU_PROBE(ARM_CPU_PART_ARM1136, armv6_1136_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_ARM1156, armv6_1156_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_ARM1176, armv6_1176_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_ARM11MPCORE, armv6mpcore_pmu_init),
+	{ /* sentinel value */ }
+};
+
+static int armv6_pmu_device_probe(struct platform_device *pdev)
 {
-	return -ENODEV;
+	return arm_pmu_device_probe(pdev, armv6_pmu_of_device_ids,
+				    armv6_pmu_probe_table);
 }
 
-static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
+static struct platform_driver armv6_pmu_driver = {
+	.driver		= {
+		.name	= "armv6-pmu",
+		.of_match_table = armv6_pmu_of_device_ids,
+	},
+	.probe		= armv6_pmu_device_probe,
+};
+
+static int __init register_armv6_pmu_driver(void)
 {
-	return -ENODEV;
+	return platform_driver_register(&armv6_pmu_driver);
 }
+device_initcall(register_armv6_pmu_driver);
 #endif	/* CONFIG_CPU_V6 || CONFIG_CPU_V6K */
-- 
1.9.1
