From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:36 +0100
Subject: [RFC PATCH 05/11] arm: perf: make get_hw_events take arm_pmu
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently get_hw_events can only handle one PMU of a particular type, as
it doesn't receive any input to differentiate instances. To support
multiple instances of similar PMUs, each with their own set of
pmu_hw_events structures, get_hw_events must be passed some value that
can be used to find the correct set of pmu_hw_events structures.

This patch changes the interface of get_hw_events to take a struct
arm_pmu pointer, to enable future support for multiple PMUs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h          |  2 +-
 arch/arm/kernel/perf_event.c        |  6 +++---
 arch/arm/kernel/perf_event_cpu.c    |  2 +-
 arch/arm/kernel/perf_event_v6.c     | 12 ++++++------
 arch/arm/kernel/perf_event_v7.c     | 10 +++++-----
 arch/arm/kernel/perf_event_xscale.c | 20 ++++++++++----------
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index f24edad..56724b2 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -86,7 +86,7 @@ struct arm_pmu {
 	struct mutex	reserve_mutex;
 	u64		max_period;
 	struct platform_device	*plat_device;
-	struct pmu_hw_events	*(*get_hw_events)(void);
+	struct pmu_hw_events	*(*get_hw_events)(struct arm_pmu *pmu);
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 3e20fa5..5bcd8ac 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -201,7 +201,7 @@ static void
 armpmu_del(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = armpmu->get_hw_events(armpmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
@@ -216,7 +216,7 @@ static int
 armpmu_add(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = armpmu->get_hw_events(armpmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 	int err = 0;
@@ -449,7 +449,7 @@ static int armpmu_event_init(struct perf_event *event)
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = armpmu->get_hw_events(armpmu);
 	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
 
 	if (enabled)
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 31e9c41..80f1a26 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -66,7 +66,7 @@ EXPORT_SYMBOL_GPL(perf_num_counters);
 #include "perf_event_v6.c"
 #include "perf_event_v7.c"
 
-static struct pmu_hw_events *cpu_pmu_get_cpu_events(void)
+static struct pmu_hw_events *cpu_pmu_get_cpu_events(struct arm_pmu *pmu)
 {
 	return &__get_cpu_var(cpu_hw_events);
 }
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index e2e5795..1647716 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -439,7 +439,7 @@ static void armv6pmu_enable_event(struct perf_event *event)
 	unsigned long val, mask, evt, flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
@@ -477,7 +477,7 @@ armv6pmu_handle_irq(int irq_num,
 	unsigned long pmcr = armv6_pmcr_read();
 	struct perf_sample_data data;
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events(cpu_pmu);
 	struct pt_regs *regs;
 	int idx;
 
@@ -533,7 +533,7 @@ armv6pmu_handle_irq(int irq_num,
 static void armv6pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
@@ -545,7 +545,7 @@ static void armv6pmu_start(struct arm_pmu *cpu_pmu)
 static void armv6pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
@@ -586,7 +586,7 @@ static void armv6pmu_disable_event(struct perf_event *event)
 	unsigned long val, mask, evt, flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
@@ -621,7 +621,7 @@ static void armv6mpcore_pmu_disable_event(struct perf_event *event)
 	unsigned long val, mask, flags, evt = 0;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 16a0455..f4d185e 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -955,7 +955,7 @@ static void armv7pmu_enable_event(struct perf_event *event)
 	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
@@ -1001,7 +1001,7 @@ static void armv7pmu_disable_event(struct perf_event *event)
 	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
@@ -1033,7 +1033,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	u32 pmnc;
 	struct perf_sample_data data;
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events(cpu_pmu);
 	struct pt_regs *regs;
 	int idx;
 
@@ -1093,7 +1093,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 static void armv7pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
@@ -1104,7 +1104,7 @@ static void armv7pmu_start(struct arm_pmu *cpu_pmu)
 static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 63990c4..cd670ea 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -225,7 +225,7 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 	unsigned long pmnc;
 	struct perf_sample_data data;
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events(cpu_pmu);
 	struct pt_regs *regs;
 	int idx;
 
@@ -285,7 +285,7 @@ static void xscale1pmu_enable_event(struct perf_event *event)
 	unsigned long val, mask, evt, flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	switch (idx) {
@@ -321,7 +321,7 @@ static void xscale1pmu_disable_event(struct perf_event *event)
 	unsigned long val, mask, evt, flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	switch (idx) {
@@ -374,7 +374,7 @@ xscale1pmu_get_event_idx(struct pmu_hw_events *cpuc,
 static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
@@ -386,7 +386,7 @@ static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
 static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
@@ -572,7 +572,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 	unsigned long pmnc, of_flags;
 	struct perf_sample_data data;
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events(cpu_pmu);
 	struct pt_regs *regs;
 	int idx;
 
@@ -626,7 +626,7 @@ static void xscale2pmu_enable_event(struct perf_event *event)
 	unsigned long flags, ien, evtsel;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	ien = xscale2pmu_read_int_enable();
@@ -672,7 +672,7 @@ static void xscale2pmu_disable_event(struct perf_event *event)
 	unsigned long flags, ien, evtsel, of_flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 	int idx = hwc->idx;
 
 	ien = xscale2pmu_read_int_enable();
@@ -738,7 +738,7 @@ out:
 static void xscale2pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc() & ~XSCALE_PMU_CNT64;
@@ -750,7 +750,7 @@ static void xscale2pmu_start(struct arm_pmu *cpu_pmu)
 static void xscale2pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events(cpu_pmu);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc();
-- 
1.8.1.1
