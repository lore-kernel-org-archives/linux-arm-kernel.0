From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Oct 2014 14:11:18 +0100
Subject: [PATCH 2/8] arm: perf: make PMU probing data-driven
In-Reply-To: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1413897084-19715-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current PMU probing logic consists of a single switch statement,
which means that the core arm_pmu core in perf_event_cpu.c needs to know
about every CPU PMU variant supported by a driver using the arm_pmu
framework. This makes it rather difficult to decouple the drivers from
the (otherwise generic) probing code.

The patch refactors that switch statement to a table-driven lookup,
separating the logic and knowledge (in the form of the table). Later
patches will split the table across the relevant PMU drivers, which can
pass their tables to the generic probing function.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h       | 23 ++++++++++++++++++
 arch/arm/kernel/perf_event_cpu.c | 52 +++++++++++++++-------------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 0b648c5..ff39290 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -15,6 +15,8 @@
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
 
+#include <asm/cputype.h>
+
 /*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
@@ -127,6 +129,27 @@ int armpmu_map_event(struct perf_event *event,
 						[PERF_COUNT_HW_CACHE_RESULT_MAX],
 		     u32 raw_event_mask);
 
+struct pmu_probe_info {
+	unsigned int cpuid;
+	unsigned int mask;
+	int (*init)(struct arm_pmu *);
+};
+
+#define PMU_PROBE(_cpuid, _mask, _fn)	\
+{					\
+	.cpuid = (_cpuid),		\
+	.mask = (_mask),		\
+	.init = (_fn),			\
+}
+
+#define ARM_PMU_PROBE(_cpuid, _fn) \
+	PMU_PROBE(_cpuid, ARM_CPU_PART_MASK, _fn)
+
+#define ARM_PMU_XSCALE_MASK	((0xff << 24) | ARM_CPU_XSCALE_ARCH_MASK)
+
+#define XSCALE_PMU_PROBE(_version, _fn) \
+	PMU_PROBE(ARM_CPU_IMP_INTEL << 24 | _version, ARM_PMU_XSCALE_MASK, _fn)
+
 #endif /* CONFIG_HW_PERF_EVENTS */
 
 #endif /* __ARM_PMU_H__ */
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 4bf4cce..79c1cf4 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -241,48 +241,34 @@ static struct platform_device_id cpu_pmu_plat_device_ids[] = {
 	{},
 };
 
+static struct pmu_probe_info pmu_probe_table[] = {
+	ARM_PMU_PROBE(ARM_CPU_PART_ARM1136, armv6_1136_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_ARM1156, armv6_1156_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_ARM1176, armv6_1176_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_ARM11MPCORE, armv6mpcore_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A8, armv7_a8_pmu_init),
+	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A9, armv7_a9_pmu_init),
+	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V1, xscale1pmu_init),
+	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V2, xscale2pmu_init),
+	{ /* sentinel value */ }
+};
+
 /*
  * CPU PMU identification and probing.
  */
 static int probe_current_pmu(struct arm_pmu *pmu)
 {
 	int cpu = get_cpu();
+	unsigned int cpuid = read_cpuid_id();
 	int ret = -ENODEV;
+	struct pmu_probe_info *info;
 
-	pr_info("probing PMU on CPU %d\n", cpu);
+	pr_info("probing PMU on CPU %d", cpu);
 
-	switch (read_cpuid_part()) {
-	/* ARM Ltd CPUs. */
-	case ARM_CPU_PART_ARM1136:
-		ret = armv6_1136_pmu_init(pmu);
-		break;
-	case ARM_CPU_PART_ARM1156:
-		ret = armv6_1156_pmu_init(pmu);
-		break;
-	case ARM_CPU_PART_ARM1176:
-		ret = armv6_1176_pmu_init(pmu);
-		break;
-	case ARM_CPU_PART_ARM11MPCORE:
-		ret = armv6mpcore_pmu_init(pmu);
-		break;
-	case ARM_CPU_PART_CORTEX_A8:
-		ret = armv7_a8_pmu_init(pmu);
-		break;
-	case ARM_CPU_PART_CORTEX_A9:
-		ret = armv7_a9_pmu_init(pmu);
-		break;
-
-	default:
-		if (read_cpuid_implementor() == ARM_CPU_IMP_INTEL) {
-			switch (xscale_cpu_arch_version()) {
-			case ARM_CPU_XSCALE_ARCH_V1:
-				ret = xscale1pmu_init(pmu);
-				break;
-			case ARM_CPU_XSCALE_ARCH_V2:
-				ret = xscale2pmu_init(pmu);
-				break;
-			}
-		}
+	for (info = pmu_probe_table; info->init != NULL; info++) {
+		if ((cpuid & info->mask) != info->cpuid)
+			continue;
+		ret = info->init(pmu);
 		break;
 	}
 
-- 
1.9.1
