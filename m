From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  2 Jul 2018 22:59:43 +0100
Subject: [PATCH v4 2/7] arm_pmu: Change API to support 64bit counter values
In-Reply-To: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
References: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1530568788-26458-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the {read/write}_counter APIs to handle 64bit values
to enable supporting chained event counters. The backends still
use 32bit values and we pass them 32bit values only. So in effect
there are no functional changes.

Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 - No changes since v2
---
 arch/arm/kernel/perf_event_v6.c     | 4 ++--
 arch/arm/kernel/perf_event_v7.c     | 4 ++--
 arch/arm/kernel/perf_event_xscale.c | 8 ++++----
 arch/arm64/kernel/perf_event.c      | 9 ++++-----
 include/linux/perf/arm_pmu.h        | 4 ++--
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index f64a6bf..0729f98 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -233,7 +233,7 @@ armv6_pmcr_counter_has_overflowed(unsigned long pmcr,
 	return ret;
 }
 
-static inline u32 armv6pmu_read_counter(struct perf_event *event)
+static inline u64 armv6pmu_read_counter(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
@@ -251,7 +251,7 @@ static inline u32 armv6pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
-static inline void armv6pmu_write_counter(struct perf_event *event, u32 value)
+static inline void armv6pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index ecca4cd..fd7ce01 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -743,7 +743,7 @@ static inline void armv7_pmnc_select_counter(int idx)
 	isb();
 }
 
-static inline u32 armv7pmu_read_counter(struct perf_event *event)
+static inline u64 armv7pmu_read_counter(struct perf_event *event)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -763,7 +763,7 @@ static inline u32 armv7pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
-static inline void armv7pmu_write_counter(struct perf_event *event, u32 value)
+static inline void armv7pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index c4f0294..942230f 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -316,7 +316,7 @@ static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static inline u32 xscale1pmu_read_counter(struct perf_event *event)
+static inline u64 xscale1pmu_read_counter(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
@@ -337,7 +337,7 @@ static inline u32 xscale1pmu_read_counter(struct perf_event *event)
 	return val;
 }
 
-static inline void xscale1pmu_write_counter(struct perf_event *event, u32 val)
+static inline void xscale1pmu_write_counter(struct perf_event *event, u64 val)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
@@ -678,7 +678,7 @@ static void xscale2pmu_stop(struct arm_pmu *cpu_pmu)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static inline u32 xscale2pmu_read_counter(struct perf_event *event)
+static inline u64 xscale2pmu_read_counter(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
@@ -705,7 +705,7 @@ static inline u32 xscale2pmu_read_counter(struct perf_event *event)
 	return val;
 }
 
-static inline void xscale2pmu_write_counter(struct perf_event *event, u32 val)
+static inline void xscale2pmu_write_counter(struct perf_event *event, u64 val)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 678ecff..66a2ffd 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -512,7 +512,7 @@ static inline int armv8pmu_select_counter(int idx)
 	return idx;
 }
 
-static inline u32 armv8pmu_read_counter(struct perf_event *event)
+static inline u64 armv8pmu_read_counter(struct perf_event *event)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -530,7 +530,7 @@ static inline u32 armv8pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
-static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
+static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -545,9 +545,8 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
 		 * count using the lower 32bits and we want an interrupt when
 		 * it overflows.
 		 */
-		u64 value64 = 0xffffffff00000000ULL | value;
-
-		write_sysreg(value64, pmccntr_el0);
+		value |= 0xffffffff00000000ULL;
+		write_sysreg(value, pmccntr_el0);
 	} else if (armv8pmu_select_counter(idx) == idx)
 		write_sysreg(value, pmxevcntr_el0);
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 12c30a2..f7126a2 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -87,8 +87,8 @@ struct arm_pmu {
 					 struct perf_event *event);
 	int		(*set_event_filter)(struct hw_perf_event *evt,
 					    struct perf_event_attr *attr);
-	u32		(*read_counter)(struct perf_event *event);
-	void		(*write_counter)(struct perf_event *event, u32 val);
+	u64		(*read_counter)(struct perf_event *event);
+	void		(*write_counter)(struct perf_event *event, u64 val);
 	void		(*start)(struct arm_pmu *);
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
-- 
2.7.4
