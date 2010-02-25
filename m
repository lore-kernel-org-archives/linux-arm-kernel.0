From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Feb 2010 18:56:11 +0000
Subject: [PATCH 2/6] ARM: perf-events: use numeric ID to identify PMU
In-Reply-To: <1267124175-21721-2-git-send-email-will.deacon@arm.com>
References: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
	<1267124175-21721-2-git-send-email-will.deacon@arm.com>
Message-ID: <1267124175-21721-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM perf-events framework provides support for a number of different
PMUs using struct arm_pmu. The char *name field of this struct can be
used to identify the PMU, but this is cumbersome if used outside of perf.

This patch replaces the name string for a PMU with an int, which holds
a unique ID for the PMU being represented. This ID can be used to index
an array of names within perf, so no functionality is lost. The presence
of the ID field, allows other kernel subsystems [currently oprofile] to
use their own mappings for the PMU name.

Cc: Jamie Iles <jamie.iles@picochip.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h |   12 +++++++++++
 arch/arm/kernel/perf_event.c      |   39 +++++++++++++++++++++++++++---------
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 49e3049..925b9a4 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -28,4 +28,16 @@ set_perf_event_pending(void)
  * same indexes here for consistency. */
 #define PERF_EVENT_INDEX_OFFSET 1
 
+/* ARM perf PMU IDs for use by internal perf clients. */
+#define ARM_PERF_PMU_ID_XSCALE1	0
+#define ARM_PERF_PMU_ID_XSCALE2	(ARM_PERF_PMU_ID_XSCALE1 + 1)
+#define ARM_PERF_PMU_ID_V6	(ARM_PERF_PMU_ID_XSCALE2 + 1)
+#define ARM_PERF_PMU_ID_V6MP	(ARM_PERF_PMU_ID_V6 + 1)
+#define ARM_PERF_PMU_ID_CA8	(ARM_PERF_PMU_ID_V6MP + 1)
+#define ARM_PERF_PMU_ID_CA9	(ARM_PERF_PMU_ID_CA8 + 1)
+#define ARM_NUM_PMU_IDS		(ARM_PERF_PMU_ID_CA9 + 1)
+
+extern int
+armpmu_get_pmu_id(void);
+
 #endif /* __ARM_PERF_EVENT_H__ */
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index c54ceb3..51d9711 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -16,6 +16,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/perf_event.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
@@ -67,8 +68,18 @@ struct cpu_hw_events {
 };
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
+/* PMU names. */
+static const char *arm_pmu_names[ARM_NUM_PMU_IDS] = {
+	"xscale1",
+	"xscale2",
+	"v6",
+	"v6mpcore",
+	"ARMv7 Cortex-A8",
+	"ARMv7 Cortex-A9",
+};
+
 struct arm_pmu {
-	char		*name;
+	int		id;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 	void		(*enable)(struct hw_perf_event *evt, int idx);
 	void		(*disable)(struct hw_perf_event *evt, int idx);
@@ -87,6 +98,18 @@ struct arm_pmu {
 /* Set at runtime when we know what CPU type we are. */
 static const struct arm_pmu *armpmu;
 
+int
+armpmu_get_pmu_id(void)
+{
+	int id = -ENODEV;
+
+	if (armpmu != NULL)
+		id = armpmu->id;
+
+	return id;
+}
+EXPORT_SYMBOL_GPL(armpmu_get_pmu_id);
+
 #define HW_OP_UNSUPPORTED		0xFFFF
 
 #define C(_x) \
@@ -1143,7 +1166,7 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 }
 
 static const struct arm_pmu armv6pmu = {
-	.name			= "v6",
+	.id			= ARM_PERF_PMU_ID_V6,
 	.handle_irq		= armv6pmu_handle_irq,
 	.enable			= armv6pmu_enable_event,
 	.disable		= armv6pmu_disable_event,
@@ -1166,7 +1189,7 @@ static const struct arm_pmu armv6pmu = {
  * reset the period and enable the interrupt reporting.
  */
 static const struct arm_pmu armv6mpcore_pmu = {
-	.name			= "v6mpcore",
+	.id			= ARM_PERF_PMU_ID_V6MP,
 	.handle_irq		= armv6pmu_handle_irq,
 	.enable			= armv6pmu_enable_event,
 	.disable		= armv6mpcore_pmu_disable_event,
@@ -1196,10 +1219,6 @@ static const struct arm_pmu armv6mpcore_pmu = {
  *  counter and all 4 performance counters together can be reset separately.
  */
 
-#define ARMV7_PMU_CORTEX_A8_NAME		"ARMv7 Cortex-A8"
-
-#define ARMV7_PMU_CORTEX_A9_NAME		"ARMv7 Cortex-A9"
-
 /* Common ARMv7 event types */
 enum armv7_perf_types {
 	ARMV7_PERFCTR_PMNC_SW_INCR		= 0x00,
@@ -2104,7 +2123,7 @@ init_hw_perf_events(void)
 			perf_max_events = armv6mpcore_pmu.num_events;
 			break;
 		case 0xC080:	/* Cortex-A8 */
-			armv7pmu.name = ARMV7_PMU_CORTEX_A8_NAME;
+			armv7pmu.id = ARM_PERF_PMU_ID_CA8;
 			memcpy(armpmu_perf_cache_map, armv7_a8_perf_cache_map,
 				sizeof(armv7_a8_perf_cache_map));
 			armv7pmu.event_map = armv7_a8_pmu_event_map;
@@ -2116,7 +2135,7 @@ init_hw_perf_events(void)
 			perf_max_events = armv7pmu.num_events;
 			break;
 		case 0xC090:	/* Cortex-A9 */
-			armv7pmu.name = ARMV7_PMU_CORTEX_A9_NAME;
+			armv7pmu.id = ARM_PERF_PMU_ID_CA9;
 			memcpy(armpmu_perf_cache_map, armv7_a9_perf_cache_map,
 				sizeof(armv7_a9_perf_cache_map));
 			armv7pmu.event_map = armv7_a9_pmu_event_map;
@@ -2135,7 +2154,7 @@ init_hw_perf_events(void)
 
 	if (armpmu)
 		pr_info("enabled with %s PMU driver, %d counters available\n",
-			armpmu->name, armpmu->num_events);
+			arm_pmu_names[armpmu->id], armpmu->num_events);
 
 	return 0;
 }
-- 
1.6.3.3
