From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  1 Jul 2014 16:11:16 +0100
Subject: [PATCH 6/8] arm: perf: clean up PMU names
In-Reply-To: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1404227478-9645-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf userspace tools can't handle dashes or spaces in PMU names,
which conflicts with the current naming scheme in the arm perf backend.
This prevents these PMUs from being accessed by name from the perf
tools. Additionally the ARMv6 pmus are named "v6", which does not fully
distinguish them in the sys/bus/event_source namespace.

This patch renames the PMUs consistently to a lower case form with
underscores, e.g. "armv6_1176", "armv7_cortex_a9". This is both readily
accepted by today's perf tool, and far easier to type than the
(apparently unused) convention in use previously. The OProfile name
conversion code is updated to handle this.

Due to a copy-paste error involving two "xscale1" entries, "xscale2" has
never been matched by the name OProfile name mapping. While we're
updating names, this is corrected.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c    | 10 +++++++---
 arch/arm/kernel/perf_event_v6.c     | 36 ++++++++++++++++++++++++++++++++----
 arch/arm/kernel/perf_event_v7.c     | 16 ++++++++--------
 arch/arm/kernel/perf_event_xscale.c |  4 ++--
 arch/arm/oprofile/common.c          | 14 ++++++++------
 5 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index af9e35e..191aff0 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -233,8 +233,8 @@ static struct of_device_id cpu_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a7-pmu",	.data = armv7_a7_pmu_init},
 	{.compatible = "arm,cortex-a5-pmu",	.data = armv7_a5_pmu_init},
 	{.compatible = "arm,arm11mpcore-pmu",	.data = armv6mpcore_pmu_init},
-	{.compatible = "arm,arm1176-pmu",	.data = armv6pmu_init},
-	{.compatible = "arm,arm1136-pmu",	.data = armv6pmu_init},
+	{.compatible = "arm,arm1176-pmu",	.data = armv6_1176_pmu_init},
+	{.compatible = "arm,arm1136-pmu",	.data = armv6_1136_pmu_init},
 	{.compatible = "qcom,krait-pmu",	.data = krait_pmu_init},
 	{},
 };
@@ -260,9 +260,13 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 	if (implementor == ARM_CPU_IMP_ARM) {
 		switch (part_number) {
 		case ARM_CPU_PART_ARM1136:
+			ret = armv6_1136_pmu_init(pmu);
+			break;
 		case ARM_CPU_PART_ARM1156:
+			ret = armv6_1156_pmu_init(pmu);
+			break;
 		case ARM_CPU_PART_ARM1176:
-			ret = armv6pmu_init(pmu);
+			ret = armv6_1176_pmu_init(pmu);
 			break;
 		case ARM_CPU_PART_ARM11MPCORE:
 			ret = armv6mpcore_pmu_init(pmu);
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 0fd4290..62227d1 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -476,9 +476,8 @@ static int armv6_map_event(struct perf_event *event)
 				&armv6_perf_cache_map, 0xFF);
 }
 
-static int armv6pmu_init(struct arm_pmu *cpu_pmu)
+static void armv6pmu_init(struct arm_pmu *cpu_pmu)
 {
-	cpu_pmu->name		= "v6";
 	cpu_pmu->handle_irq	= armv6pmu_handle_irq;
 	cpu_pmu->enable		= armv6pmu_enable_event;
 	cpu_pmu->disable	= armv6pmu_disable_event;
@@ -490,7 +489,26 @@ static int armv6pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	= armv6_map_event;
 	cpu_pmu->num_events	= 3;
 	cpu_pmu->max_period	= (1LLU << 32) - 1;
+}
+
+static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv6pmu_init(cpu_pmu);
+	cpu_pmu->name		= "armv6_1136"
+	return 0;
+}
+
+static int armv6_1156_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv6pmu_init(cpu_pmu);
+	cpu_pmu->name		= "armv6_1156"
+	return 0;
+}
 
+static int armv6_1176_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv6pmu_init(cpu_pmu);
+	cpu_pmu->name		= "armv6_1176"
 	return 0;
 }
 
@@ -510,7 +528,7 @@ static int armv6mpcore_map_event(struct perf_event *event)
 
 static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	cpu_pmu->name		= "v6mpcore";
+	cpu_pmu->name		= "armv6_11mpcore";
 	cpu_pmu->handle_irq	= armv6pmu_handle_irq;
 	cpu_pmu->enable		= armv6pmu_enable_event;
 	cpu_pmu->disable	= armv6mpcore_pmu_disable_event;
@@ -526,7 +544,17 @@ static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 #else
-static int armv6pmu_init(struct arm_pmu *cpu_pmu)
+static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	return -ENODEV;
+}
+
+static int armv6_1156_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	return -ENODEV;
+}
+
+static int armv6_1176_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	return -ENODEV;
 }
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 871c465..d4129bc 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1008,7 +1008,7 @@ static u32 armv7_read_num_pmnc_events(void)
 static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A8";
+	cpu_pmu->name		= "armv7_cortex_a8";
 	cpu_pmu->map_event	= armv7_a8_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	return 0;
@@ -1017,7 +1017,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A9";
+	cpu_pmu->name		= "armv7_cortex_a9";
 	cpu_pmu->map_event	= armv7_a9_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	return 0;
@@ -1026,7 +1026,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A5";
+	cpu_pmu->name		= "armv7_cortex_a5";
 	cpu_pmu->map_event	= armv7_a5_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	return 0;
@@ -1035,7 +1035,7 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A15";
+	cpu_pmu->name		= "armv7_cortex_a15";
 	cpu_pmu->map_event	= armv7_a15_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
@@ -1045,7 +1045,7 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A7";
+	cpu_pmu->name		= "armv7_cortex_a7";
 	cpu_pmu->map_event	= armv7_a7_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
@@ -1055,7 +1055,7 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A12";
+	cpu_pmu->name		= "armv7_cortex_a12";
 	cpu_pmu->map_event	= armv7_a12_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
@@ -1065,7 +1065,7 @@ static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7_a12_pmu_init(cpu_pmu);
-	cpu_pmu->name = "ARMv7 Cortex-A17";
+	cpu_pmu->name = "armv7_cortex_a17";
 	return 0;
 }
 
@@ -1444,7 +1444,7 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 static int krait_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Krait";
+	cpu_pmu->name		= "armv7_krait";
 	/* Some early versions of Krait don't support PC write events */
 	if (of_property_read_bool(cpu_pmu->plat_device->dev.of_node,
 				  "qcom,no-pc-write"))
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 3d47984..08da0af 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -355,7 +355,7 @@ static int xscale_map_event(struct perf_event *event)
 
 static int xscale1pmu_init(struct arm_pmu *cpu_pmu)
 {
-	cpu_pmu->name		= "xscale1";
+	cpu_pmu->name		= "armv5_xscale1";
 	cpu_pmu->handle_irq	= xscale1pmu_handle_irq;
 	cpu_pmu->enable		= xscale1pmu_enable_event;
 	cpu_pmu->disable	= xscale1pmu_disable_event;
@@ -725,7 +725,7 @@ static inline void xscale2pmu_write_counter(struct perf_event *event, u32 val)
 
 static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
 {
-	cpu_pmu->name		= "xscale2";
+	cpu_pmu->name		= "armv5_xscale2";
 	cpu_pmu->handle_irq	= xscale2pmu_handle_irq;
 	cpu_pmu->enable		= xscale2pmu_enable_event;
 	cpu_pmu->disable	= xscale2pmu_disable_event;
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 99c63d4b..6826e35 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -33,12 +33,14 @@ static struct op_perf_name {
 	char *perf_name;
 	char *op_name;
 } op_perf_name_map[] = {
-	{ "xscale1",		"arm/xscale1"	},
-	{ "xscale1",		"arm/xscale2"	},
-	{ "v6",			"arm/armv6"	},
-	{ "v6mpcore",		"arm/mpcore"	},
-	{ "ARMv7 Cortex-A8",	"arm/armv7"	},
-	{ "ARMv7 Cortex-A9",	"arm/armv7-ca9"	},
+	{ "armv5_xscale1",	"arm/xscale1"	},
+	{ "armv5_xscale2",	"arm/xscale2"	},
+	{ "armv6_1136",		"arm/armv6"	},
+	{ "armv6_1156",		"arm/armv6"	},
+	{ "armv6_1176",		"arm/armv6"	},
+	{ "armv6_11mpcore",	"arm/mpcore"	},
+	{ "armv7_cortex_a8",	"arm/armv7"	},
+	{ "armv7_cortex_a9",	"arm/armv7-ca9"	},
 };
 
 char *op_name_from_perf_id(void)
-- 
1.9.1
