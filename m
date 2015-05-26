From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:23:36 +0100
Subject: [PATCH 3/7] arm: perf: factor out xscale pmu driver
In-Reply-To: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
References: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432657420-887-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core arm perf code maintains no global state and all
microarchitecture-specific PMU data can be fed in through the shared
probe function, it's possible to use it as a library and get rid of the
C file includes we have currently.

This patch factors out the xscale-specific portions out into the xscale
driver. For the moment this is always built if perf event support is
enabled, but the preprocessor guards will leave behind an empty file.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/Makefile            |  2 +-
 arch/arm/kernel/perf_event_cpu.c    |  4 ----
 arch/arm/kernel/perf_event_xscale.c | 32 +++++++++++++++++++++++++++-----
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 752725d..8b4aad7 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
 obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o
+obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o perf_event_xscale.o
 CFLAGS_pj4-cp0.o		:= -marm
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 797b569..1ebb179 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -60,7 +60,6 @@ int perf_num_counters(void)
 EXPORT_SYMBOL_GPL(perf_num_counters);
 
 /* Include the PMU-specific implementations. */
-#include "perf_event_xscale.c"
 #include "perf_event_v6.c"
 #include "perf_event_v7.c"
 
@@ -267,7 +266,6 @@ static struct platform_device_id cpu_pmu_plat_device_ids[] = {
 	{.name = "arm-pmu"},
 	{.name = "armv6-pmu"},
 	{.name = "armv7-pmu"},
-	{.name = "xscale-pmu"},
 	{},
 };
 
@@ -278,8 +276,6 @@ static const struct pmu_probe_info pmu_probe_table[] = {
 	ARM_PMU_PROBE(ARM_CPU_PART_ARM11MPCORE, armv6mpcore_pmu_init),
 	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A8, armv7_a8_pmu_init),
 	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A9, armv7_a9_pmu_init),
-	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V1, xscale1pmu_init),
-	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V2, xscale2pmu_init),
 	{ /* sentinel value */ }
 };
 
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 8af9f1f..304d056 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -13,6 +13,14 @@
  */
 
 #ifdef CONFIG_CPU_XSCALE
+
+#include <asm/cputype.h>
+#include <asm/irq_regs.h>
+#include <asm/pmu.h>
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
 enum xscale_perf_types {
 	XSCALE_PERFCTR_ICACHE_MISS		= 0x00,
 	XSCALE_PERFCTR_ICACHE_NO_DELIVER	= 0x01,
@@ -740,14 +748,28 @@ static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
 
 	return 0;
 }
-#else
-static inline int xscale1pmu_init(struct arm_pmu *cpu_pmu)
+
+static const struct pmu_probe_info xscale_pmu_probe_table[] = {
+	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V1, xscale1pmu_init),
+	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V2, xscale2pmu_init),
+	{ /* sentinel value */ }
+};
+
+static int xscale_pmu_device_probe(struct platform_device *pdev)
 {
-	return -ENODEV;
+	return arm_pmu_device_probe(pdev, NULL, xscale_pmu_probe_table);
 }
 
-static inline int xscale2pmu_init(struct arm_pmu *cpu_pmu)
+static struct platform_driver xscale_pmu_driver = {
+	.driver		= {
+		.name	= "xscale-pmu",
+	},
+	.probe		= xscale_pmu_device_probe,
+};
+
+static int __init register_xscale_pmu_driver(void)
 {
-	return -ENODEV;
+	return platform_driver_register(&xscale_pmu_driver);
 }
+device_initcall(register_xscale_pmu_driver);
 #endif	/* CONFIG_CPU_XSCALE */
-- 
1.9.1
