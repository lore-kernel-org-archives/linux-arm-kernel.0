From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Nov 2010 17:31:02 +0000
Subject: [PATCH 4/5] ARM: perf: encode PMU name in arm_pmu structure
In-Reply-To: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
Message-ID: <1289842263-21241-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, perf uses the PMU ID as an index into a string table
to look up the name of a given PMU.

This patch encodes the name of a PMU directly into the arm_pmu
structure so that PMU-specific code can be factored out into
separate files.

Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index acc4e91..ac4e9a1 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -69,18 +69,9 @@ struct cpu_hw_events {
 };
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
-/* PMU names. */
-static const char *arm_pmu_names[] = {
-	[ARM_PERF_PMU_ID_XSCALE1] = "xscale1",
-	[ARM_PERF_PMU_ID_XSCALE2] = "xscale2",
-	[ARM_PERF_PMU_ID_V6]	  = "v6",
-	[ARM_PERF_PMU_ID_V6MP]	  = "v6mpcore",
-	[ARM_PERF_PMU_ID_CA8]	  = "ARMv7 Cortex-A8",
-	[ARM_PERF_PMU_ID_CA9]	  = "ARMv7 Cortex-A9",
-};
-
 struct arm_pmu {
 	enum arm_perf_pmu_ids id;
+	const char	*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 	void		(*enable)(struct hw_perf_event *evt, int idx);
 	void		(*disable)(struct hw_perf_event *evt, int idx);
@@ -1225,6 +1216,7 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 
 static const struct arm_pmu armv6pmu = {
 	.id			= ARM_PERF_PMU_ID_V6,
+	.name			= "v6",
 	.handle_irq		= armv6pmu_handle_irq,
 	.enable			= armv6pmu_enable_event,
 	.disable		= armv6pmu_disable_event,
@@ -1254,6 +1246,7 @@ const struct arm_pmu *__init armv6pmu_init(void)
  */
 static const struct arm_pmu armv6mpcore_pmu = {
 	.id			= ARM_PERF_PMU_ID_V6MP,
+	.name			= "v6mpcore",
 	.handle_irq		= armv6pmu_handle_irq,
 	.enable			= armv6pmu_enable_event,
 	.disable		= armv6mpcore_pmu_disable_event,
@@ -2149,6 +2142,7 @@ static u32 __init armv7_reset_read_pmnc(void)
 const struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA8;
+	armv7pmu.name		= "ARMv7 Cortex-A8";
 	armv7pmu.cache_map	= &armv7_a8_perf_cache_map;
 	armv7pmu.event_map	= &armv7_a8_perf_map;
 	armv7pmu.num_events	= armv7_reset_read_pmnc();
@@ -2158,6 +2152,7 @@ const struct arm_pmu *__init armv7_a8_pmu_init(void)
 const struct arm_pmu *__init armv7_a9_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA9;
+	armv7pmu.name		= "ARMv7 Cortex-A9";
 	armv7pmu.cache_map	= &armv7_a9_perf_cache_map;
 	armv7pmu.event_map	= &armv7_a9_perf_map;
 	armv7pmu.num_events	= armv7_reset_read_pmnc();
@@ -2578,6 +2573,7 @@ xscale1pmu_write_counter(int counter, u32 val)
 
 static const struct arm_pmu xscale1pmu = {
 	.id		= ARM_PERF_PMU_ID_XSCALE1,
+	.name		= "xscale1",
 	.handle_irq	= xscale1pmu_handle_irq,
 	.enable		= xscale1pmu_enable_event,
 	.disable	= xscale1pmu_disable_event,
@@ -2939,6 +2935,7 @@ xscale2pmu_write_counter(int counter, u32 val)
 
 static const struct arm_pmu xscale2pmu = {
 	.id		= ARM_PERF_PMU_ID_XSCALE2,
+	.name		= "xscale2",
 	.handle_irq	= xscale2pmu_handle_irq,
 	.enable		= xscale2pmu_enable_event,
 	.disable	= xscale2pmu_disable_event,
@@ -2999,7 +2996,7 @@ init_hw_perf_events(void)
 
 	if (armpmu) {
 		pr_info("enabled with %s PMU driver, %d counters available\n",
-				arm_pmu_names[armpmu->id], armpmu->num_events);
+			armpmu->name, armpmu->num_events);
 	} else {
 		pr_info("no hardware support available\n");
 	}
-- 
1.7.0.4
