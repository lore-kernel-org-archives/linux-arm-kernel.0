From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:34 +0100
Subject: [RFC PATCH 03/11] arm: perf: clean up PMU names
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf userspace tools can't handle dashes or spaces in PMU names,
which conflicts with the current naming scheme in the arm perf backend.
This prevents these PMUs from being accessed by name from the perf
tools. Additionally the ARMv6 pmus are named "v6", which does not fully
distinguish them in the sys/bus/event_source namespace.

This patch replaces the spaces and dashes in pmu names with underscores,
and renames "v6" => "ARMv6" to better describe the PMU to userspace. The
oprofile name conversion code is updated to handle this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v6.c |  4 ++--
 arch/arm/kernel/perf_event_v7.c | 10 +++++-----
 arch/arm/oprofile/common.c      |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 03664b0..e2e5795 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -655,7 +655,7 @@ static int armv6_map_event(struct perf_event *event)
 
 static int armv6pmu_init(struct arm_pmu *cpu_pmu)
 {
-	cpu_pmu->name		= "v6";
+	cpu_pmu->name		= "ARMv6";
 	cpu_pmu->handle_irq	= armv6pmu_handle_irq;
 	cpu_pmu->enable		= armv6pmu_enable_event;
 	cpu_pmu->disable	= armv6pmu_disable_event;
@@ -687,7 +687,7 @@ static int armv6mpcore_map_event(struct perf_event *event)
 
 static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	cpu_pmu->name		= "v6mpcore";
+	cpu_pmu->name		= "ARMv6mpcore";
 	cpu_pmu->handle_irq	= armv6pmu_handle_irq;
 	cpu_pmu->enable		= armv6pmu_enable_event;
 	cpu_pmu->disable	= armv6mpcore_pmu_disable_event;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 039cffb..16a0455 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1240,7 +1240,7 @@ static u32 armv7_read_num_pmnc_events(void)
 static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A8";
+	cpu_pmu->name		= "ARMv7_Cortex_A8";
 	cpu_pmu->map_event	= armv7_a8_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	return 0;
@@ -1249,7 +1249,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A9";
+	cpu_pmu->name		= "ARMv7_Cortex_A9";
 	cpu_pmu->map_event	= armv7_a9_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	return 0;
@@ -1258,7 +1258,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A5";
+	cpu_pmu->name		= "ARMv7_Cortex_A5";
 	cpu_pmu->map_event	= armv7_a5_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	return 0;
@@ -1267,7 +1267,7 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A15";
+	cpu_pmu->name		= "ARMv7_Cortex_A15";
 	cpu_pmu->map_event	= armv7_a15_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
@@ -1277,7 +1277,7 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
-	cpu_pmu->name		= "ARMv7 Cortex-A7";
+	cpu_pmu->name		= "ARMv7_Cortex_A7";
 	cpu_pmu->map_event	= armv7_a7_map_event;
 	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 99c63d4b..31be981 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -35,10 +35,10 @@ static struct op_perf_name {
 } op_perf_name_map[] = {
 	{ "xscale1",		"arm/xscale1"	},
 	{ "xscale1",		"arm/xscale2"	},
-	{ "v6",			"arm/armv6"	},
-	{ "v6mpcore",		"arm/mpcore"	},
-	{ "ARMv7 Cortex-A8",	"arm/armv7"	},
-	{ "ARMv7 Cortex-A9",	"arm/armv7-ca9"	},
+	{ "ARMv6",		"arm/armv6"	},
+	{ "ARMv6mpcore",	"arm/mpcore"	},
+	{ "ARMv7_Cortex_A8",	"arm/armv7"	},
+	{ "ARMv7_Cortex_A9",	"arm/armv7-ca9"	},
 };
 
 char *op_name_from_perf_id(void)
-- 
1.8.1.1
