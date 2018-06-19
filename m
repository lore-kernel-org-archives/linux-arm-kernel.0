From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 19 Jun 2018 11:15:40 +0100
Subject: [PATCH v3 5/7] arm64: perf: Clean up armv8pmu_select_counter
In-Reply-To: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1529403342-17899-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

armv8pmu_select_counter always returns the passed idx. So
let us make that void and get rid of the pointless checks.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/perf_event.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 66a2ffd..9ce3729 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -503,13 +503,17 @@ static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
 	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
 }
 
-static inline int armv8pmu_select_counter(int idx)
+static inline void armv8pmu_select_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
 	write_sysreg(counter, pmselr_el0);
 	isb();
+}
 
-	return idx;
+static inline u32 armv8pmu_read_evcntr(int idx)
+{
+	armv8pmu_select_counter(idx);
+	return read_sysreg(pmxevcntr_el0);
 }
 
 static inline u64 armv8pmu_read_counter(struct perf_event *event)
@@ -524,12 +528,18 @@ static inline u64 armv8pmu_read_counter(struct perf_event *event)
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		value = read_sysreg(pmccntr_el0);
-	else if (armv8pmu_select_counter(idx) == idx)
-		value = read_sysreg(pmxevcntr_el0);
+	else
+		value = armv8pmu_read_evcntr(idx);
 
 	return value;
 }
 
+static inline void armv8pmu_write_evcntr(int idx, u32 value)
+{
+	armv8pmu_select_counter(idx);
+	write_sysreg(value, pmxevcntr_el0);
+}
+
 static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
@@ -547,16 +557,15 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 		 */
 		value |= 0xffffffff00000000ULL;
 		write_sysreg(value, pmccntr_el0);
-	} else if (armv8pmu_select_counter(idx) == idx)
-		write_sysreg(value, pmxevcntr_el0);
+	} else
+		armv8pmu_write_evcntr(idx, value);
 }
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
 {
-	if (armv8pmu_select_counter(idx) == idx) {
-		val &= ARMV8_PMU_EVTYPE_MASK;
-		write_sysreg(val, pmxevtyper_el0);
-	}
+	armv8pmu_select_counter(idx);
+	val &= ARMV8_PMU_EVTYPE_MASK;
+	write_sysreg(val, pmxevtyper_el0);
 }
 
 static inline int armv8pmu_enable_counter(int idx)
-- 
2.7.4
