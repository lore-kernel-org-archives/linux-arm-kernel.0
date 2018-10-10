From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Oct 2018 17:31:52 +0100
Subject: [PATCH 3/6] arm64: perf: Add support for Armv8.1 PMCEID register
 format
In-Reply-To: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
References: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
Message-ID: <1539189115-16221-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armv8.1 allocated the upper 32-bits of the PMCEID registers to describe
the common architectural and microarchitecture events beginning at 0x4000.

Add support for these registers to our probing code, so that we can
advertise the SPE events when they are supported by the CPU.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 25 ++++++++++++++++++-------
 include/linux/perf/arm_pmu.h   |  4 +++-
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index ac1c5c41501d..1a783df6f234 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -183,12 +183,10 @@
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
 
-/* PMUv3 HW events mapping. */
-
 /*
  * ARMv8 Architectural defined events, not all of these may
- * be supported on any given implementation. Undefined events will
- * be disabled at run-time.
+ * be supported on any given implementation. Unsupported events will
+ * be disabled at run-time based on the PMCEID registers.
  */
 static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
@@ -434,7 +432,13 @@ armv8pmu_event_attr_is_visible(struct kobject *kobj,
 
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
 
-	if (test_bit(pmu_attr->id, cpu_pmu->pmceid_bitmap))
+	if (pmu_attr->id < ARMV8_PMUV3_MAX_COMMON_EVENTS &&
+	    test_bit(pmu_attr->id, cpu_pmu->pmceid_bitmap))
+		return attr->mode;
+
+	pmu_attr->id -= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
+	if (pmu_attr->id < ARMV8_PMUV3_MAX_COMMON_EVENTS &&
+	    test_bit(pmu_attr->id, cpu_pmu->pmceid_ext_bitmap))
 		return attr->mode;
 
 	return 0;
@@ -1061,6 +1065,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	struct armv8pmu_probe_info *probe = info;
 	struct arm_pmu *cpu_pmu = probe->pmu;
 	u64 dfr0;
+	u64 pmceid_raw[2];
 	u32 pmceid[2];
 	int pmuver;
 
@@ -1079,11 +1084,17 @@ static void __armv8pmu_probe_pmu(void *info)
 	/* Add the CPU cycles counter */
 	cpu_pmu->num_events += 1;
 
-	pmceid[0] = read_sysreg(pmceid0_el0);
-	pmceid[1] = read_sysreg(pmceid1_el0);
+	pmceid[0] = pmceid_raw[0] = read_sysreg(pmceid0_el0);
+	pmceid[1] = pmceid_raw[1] = read_sysreg(pmceid1_el0);
 
 	bitmap_from_arr32(cpu_pmu->pmceid_bitmap,
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
+
+	pmceid[0] = pmceid_raw[0] >> 32;
+	pmceid[1] = pmceid_raw[1] >> 32;
+
+	bitmap_from_arr32(cpu_pmu->pmceid_ext_bitmap,
+			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 }
 
 static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index bf309ff6f244..4641e850b204 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -102,8 +102,10 @@ struct arm_pmu {
 	int		(*filter_match)(struct perf_event *event);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
-#define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
+#define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
+#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
+	DECLARE_BITMAP(pmceid_ext_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 	struct platform_device	*plat_device;
 	struct pmu_hw_events	__percpu *hw_events;
 	struct hlist_node	node;
-- 
2.1.4
