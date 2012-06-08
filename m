From: will.deacon@arm.com (Will Deacon)
Date: Fri,  8 Jun 2012 16:18:43 +0100
Subject: [PATCH] ARM: perf: remove arm_perf_pmu_ids global enumeration
Message-ID: <1339168723-30115-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to provide PMU name strings compatible with the OProfile
user ABI, an enumeration of all PMUs is currently used by perf to
identify each PMU uniquely. Unfortunately, this does not scale well
in the presence of multiple PMUs and creates a single, global namespace
across all PMUs in the system.

This patch removes the enumeration and instead uses the name string
for the PMU to map onto the OProfile variant. perf_pmu_name is
implemented for CPU PMUs, which is all that OProfile cares about anyway.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h   |   17 +-------------
 arch/arm/include/asm/pmu.h          |    3 +-
 arch/arm/kernel/perf_event.c        |   15 +++++-------
 arch/arm/kernel/perf_event_v6.c     |    2 -
 arch/arm/kernel/perf_event_v7.c     |    5 ----
 arch/arm/kernel/perf_event_xscale.c |    2 -
 arch/arm/oprofile/common.c          |   43 ++++++++++++++++++++++-------------
 7 files changed, 35 insertions(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 00cbe10..e074948 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -12,21 +12,6 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-/* ARM perf PMU IDs for use by internal perf clients. */
-enum arm_perf_pmu_ids {
-	ARM_PERF_PMU_ID_XSCALE1	= 0,
-	ARM_PERF_PMU_ID_XSCALE2,
-	ARM_PERF_PMU_ID_V6,
-	ARM_PERF_PMU_ID_V6MP,
-	ARM_PERF_PMU_ID_CA8,
-	ARM_PERF_PMU_ID_CA9,
-	ARM_PERF_PMU_ID_CA5,
-	ARM_PERF_PMU_ID_CA15,
-	ARM_PERF_PMU_ID_CA7,
-	ARM_NUM_PMU_IDS,
-};
-
-extern enum arm_perf_pmu_ids
-armpmu_get_pmu_id(void);
+/* Nothing to see here... */
 
 #endif /* __ARM_PERF_EVENT_H__ */
diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 90114fa..4432305 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -103,10 +103,9 @@ struct pmu_hw_events {
 
 struct arm_pmu {
 	struct pmu	pmu;
-	enum arm_perf_pmu_ids id;
 	enum arm_pmu_type type;
 	cpumask_t	active_irqs;
-	const char	*name;
+	char		*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 	void		(*enable)(struct hw_perf_event *evt, int idx);
 	void		(*disable)(struct hw_perf_event *evt, int idx);
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 186c8cb..df85eda 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -47,17 +47,14 @@ static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
 /* Set at runtime when we know what CPU type we are. */
 static struct arm_pmu *cpu_pmu;
 
-enum arm_perf_pmu_ids
-armpmu_get_pmu_id(void)
+const char *perf_pmu_name(void)
 {
-	int id = -ENODEV;
-
-	if (cpu_pmu != NULL)
-		id = cpu_pmu->id;
+	if (!cpu_pmu)
+		return NULL;
 
-	return id;
+	return cpu_pmu->pmu.name;
 }
-EXPORT_SYMBOL_GPL(armpmu_get_pmu_id);
+EXPORT_SYMBOL_GPL(perf_pmu_name);
 
 int perf_num_counters(void)
 {
@@ -760,7 +757,7 @@ init_hw_perf_events(void)
 			cpu_pmu->name, cpu_pmu->num_events);
 		cpu_pmu_init(cpu_pmu);
 		register_cpu_notifier(&pmu_cpu_notifier);
-		armpmu_register(cpu_pmu, "cpu", PERF_TYPE_RAW);
+		armpmu_register(cpu_pmu, cpu_pmu->name, PERF_TYPE_RAW);
 	} else {
 		pr_info("no hardware support available\n");
 	}
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index ab627a7..c90fcb2 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -650,7 +650,6 @@ static int armv6_map_event(struct perf_event *event)
 }
 
 static struct arm_pmu armv6pmu = {
-	.id			= ARM_PERF_PMU_ID_V6,
 	.name			= "v6",
 	.handle_irq		= armv6pmu_handle_irq,
 	.enable			= armv6pmu_enable_event,
@@ -685,7 +684,6 @@ static int armv6mpcore_map_event(struct perf_event *event)
 }
 
 static struct arm_pmu armv6mpcore_pmu = {
-	.id			= ARM_PERF_PMU_ID_V6MP,
 	.name			= "v6mpcore",
 	.handle_irq		= armv6pmu_handle_irq,
 	.enable			= armv6pmu_enable_event,
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index d3c5360..f04070b 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1258,7 +1258,6 @@ static u32 __init armv7_read_num_pmnc_events(void)
 
 static struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
-	armv7pmu.id		= ARM_PERF_PMU_ID_CA8;
 	armv7pmu.name		= "ARMv7 Cortex-A8";
 	armv7pmu.map_event	= armv7_a8_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
@@ -1267,7 +1266,6 @@ static struct arm_pmu *__init armv7_a8_pmu_init(void)
 
 static struct arm_pmu *__init armv7_a9_pmu_init(void)
 {
-	armv7pmu.id		= ARM_PERF_PMU_ID_CA9;
 	armv7pmu.name		= "ARMv7 Cortex-A9";
 	armv7pmu.map_event	= armv7_a9_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
@@ -1276,7 +1274,6 @@ static struct arm_pmu *__init armv7_a9_pmu_init(void)
 
 static struct arm_pmu *__init armv7_a5_pmu_init(void)
 {
-	armv7pmu.id		= ARM_PERF_PMU_ID_CA5;
 	armv7pmu.name		= "ARMv7 Cortex-A5";
 	armv7pmu.map_event	= armv7_a5_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
@@ -1285,7 +1282,6 @@ static struct arm_pmu *__init armv7_a5_pmu_init(void)
 
 static struct arm_pmu *__init armv7_a15_pmu_init(void)
 {
-	armv7pmu.id		= ARM_PERF_PMU_ID_CA15;
 	armv7pmu.name		= "ARMv7 Cortex-A15";
 	armv7pmu.map_event	= armv7_a15_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
@@ -1295,7 +1291,6 @@ static struct arm_pmu *__init armv7_a15_pmu_init(void)
 
 static struct arm_pmu *__init armv7_a7_pmu_init(void)
 {
-	armv7pmu.id		= ARM_PERF_PMU_ID_CA7;
 	armv7pmu.name		= "ARMv7 Cortex-A7";
 	armv7pmu.map_event	= armv7_a7_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index e34e725..f759fe0 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -435,7 +435,6 @@ static int xscale_map_event(struct perf_event *event)
 }
 
 static struct arm_pmu xscale1pmu = {
-	.id		= ARM_PERF_PMU_ID_XSCALE1,
 	.name		= "xscale1",
 	.handle_irq	= xscale1pmu_handle_irq,
 	.enable		= xscale1pmu_enable_event,
@@ -803,7 +802,6 @@ xscale2pmu_write_counter(int counter, u32 val)
 }
 
 static struct arm_pmu xscale2pmu = {
-	.id		= ARM_PERF_PMU_ID_XSCALE2,
 	.name		= "xscale2",
 	.handle_irq	= xscale2pmu_handle_irq,
 	.enable		= xscale2pmu_enable_event,
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 4e0a371..99c63d4b 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -23,26 +23,37 @@
 #include <asm/ptrace.h>
 
 #ifdef CONFIG_HW_PERF_EVENTS
+
+/*
+ * OProfile has a curious naming scheme for the ARM PMUs, but they are
+ * part of the user ABI so we need to map from the perf PMU name for
+ * supported PMUs.
+ */
+static struct op_perf_name {
+	char *perf_name;
+	char *op_name;
+} op_perf_name_map[] = {
+	{ "xscale1",		"arm/xscale1"	},
+	{ "xscale1",		"arm/xscale2"	},
+	{ "v6",			"arm/armv6"	},
+	{ "v6mpcore",		"arm/mpcore"	},
+	{ "ARMv7 Cortex-A8",	"arm/armv7"	},
+	{ "ARMv7 Cortex-A9",	"arm/armv7-ca9"	},
+};
+
 char *op_name_from_perf_id(void)
 {
-	enum arm_perf_pmu_ids id = armpmu_get_pmu_id();
-
-	switch (id) {
-	case ARM_PERF_PMU_ID_XSCALE1:
-		return "arm/xscale1";
-	case ARM_PERF_PMU_ID_XSCALE2:
-		return "arm/xscale2";
-	case ARM_PERF_PMU_ID_V6:
-		return "arm/armv6";
-	case ARM_PERF_PMU_ID_V6MP:
-		return "arm/mpcore";
-	case ARM_PERF_PMU_ID_CA8:
-		return "arm/armv7";
-	case ARM_PERF_PMU_ID_CA9:
-		return "arm/armv7-ca9";
-	default:
-		return NULL;
+	int i;
+	struct op_perf_name names;
+	const char *perf_name = perf_pmu_name();
+
+	for (i = 0; i < ARRAY_SIZE(op_perf_name_map); ++i) {
+		names = op_perf_name_map[i];
+		if (!strcmp(names.perf_name, perf_name))
+			return names.op_name;
 	}
+
+	return NULL;
 }
 #endif
 
-- 
1.7.4.1
