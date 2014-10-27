From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Oct 2014 12:06:36 +0000
Subject: [PATCHv2 6/9] arm: perf: kill get_hw_events()
In-Reply-To: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1414411599-1938-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the arm pmu code is limited to CPU PMUs the get_hw_events()
function is superfluous, as we'll always have a set of per-cpu
pmu_hw_events structures.

This patch removes the get_hw_events() function, replacing it with
a percpu hw_events pointer. Uses of get_hw_events are updated to use
this_cpu_ptr.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h          |  2 +-
 arch/arm/kernel/perf_event.c        |  6 +++---
 arch/arm/kernel/perf_event_cpu.c    |  7 +------
 arch/arm/kernel/perf_event_v6.c     | 12 ++++++------
 arch/arm/kernel/perf_event_v7.c     | 14 +++++++-------
 arch/arm/kernel/perf_event_xscale.c | 20 ++++++++++----------
 6 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 3d7e30b..f273dd2 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -109,7 +109,7 @@ struct arm_pmu {
 	struct mutex	reserve_mutex;
 	u64		max_period;
 	struct platform_device	*plat_device;
-	struct pmu_hw_events	*(*get_hw_events)(void);
+	struct pmu_hw_events	__percpu *hw_events;
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 8648107..05ac5ee 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -201,7 +201,7 @@ static void
 armpmu_del(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
@@ -218,7 +218,7 @@ static int
 armpmu_add(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 	int err = 0;
@@ -467,7 +467,7 @@ static int armpmu_event_init(struct perf_event *event)
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
-	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
 
 	if (enabled)
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 1528d3c..d3fa1cc 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -67,11 +67,6 @@ EXPORT_SYMBOL_GPL(perf_num_counters);
 #include "perf_event_v6.c"
 #include "perf_event_v7.c"
 
-static struct pmu_hw_events *cpu_pmu_get_cpu_events(void)
-{
-	return this_cpu_ptr(&cpu_hw_events);
-}
-
 static void cpu_pmu_enable_percpu_irq(void *data)
 {
 	int irq = *(int *)data;
@@ -174,7 +169,7 @@ static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
 		per_cpu(percpu_pmu, cpu) = cpu_pmu;
 	}
 
-	cpu_pmu->get_hw_events	= cpu_pmu_get_cpu_events;
+	cpu_pmu->hw_events	= &cpu_hw_events;
 	cpu_pmu->request_irq	= cpu_pmu_request_irq;
 	cpu_pmu->free_irq	= cpu_pmu_free_irq;
 
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index abfeb04..f2ffd5c 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -262,7 +262,7 @@ static void armv6pmu_enable_event(struct perf_event *event)
 	unsigned long val, mask, evt, flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
@@ -300,7 +300,7 @@ armv6pmu_handle_irq(int irq_num,
 	unsigned long pmcr = armv6_pmcr_read();
 	struct perf_sample_data data;
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
 
@@ -356,7 +356,7 @@ armv6pmu_handle_irq(int irq_num,
 static void armv6pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
@@ -368,7 +368,7 @@ static void armv6pmu_start(struct arm_pmu *cpu_pmu)
 static void armv6pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
@@ -409,7 +409,7 @@ static void armv6pmu_disable_event(struct perf_event *event)
 	unsigned long val, mask, evt, flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
@@ -444,7 +444,7 @@ static void armv6mpcore_pmu_disable_event(struct perf_event *event)
 	unsigned long val, mask, flags, evt = 0;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 116758b..fa76b25 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -705,7 +705,7 @@ static void armv7pmu_enable_event(struct perf_event *event)
 	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
@@ -751,7 +751,7 @@ static void armv7pmu_disable_event(struct perf_event *event)
 	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
@@ -783,7 +783,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	u32 pmnc;
 	struct perf_sample_data data;
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
 
@@ -843,7 +843,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 static void armv7pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
@@ -854,7 +854,7 @@ static void armv7pmu_start(struct arm_pmu *cpu_pmu)
 static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
@@ -1287,7 +1287,7 @@ static void krait_pmu_disable_event(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/* Disable counter and interrupt */
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
@@ -1313,7 +1313,7 @@ static void krait_pmu_enable_event(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 08da0af..8af9f1f 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -138,7 +138,7 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 	unsigned long pmnc;
 	struct perf_sample_data data;
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
 
@@ -198,7 +198,7 @@ static void xscale1pmu_enable_event(struct perf_event *event)
 	unsigned long val, mask, evt, flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	switch (idx) {
@@ -234,7 +234,7 @@ static void xscale1pmu_disable_event(struct perf_event *event)
 	unsigned long val, mask, evt, flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	switch (idx) {
@@ -287,7 +287,7 @@ xscale1pmu_get_event_idx(struct pmu_hw_events *cpuc,
 static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
@@ -299,7 +299,7 @@ static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
 static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
@@ -485,7 +485,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 	unsigned long pmnc, of_flags;
 	struct perf_sample_data data;
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
 
@@ -539,7 +539,7 @@ static void xscale2pmu_enable_event(struct perf_event *event)
 	unsigned long flags, ien, evtsel;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	ien = xscale2pmu_read_int_enable();
@@ -585,7 +585,7 @@ static void xscale2pmu_disable_event(struct perf_event *event)
 	unsigned long flags, ien, evtsel, of_flags;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	ien = xscale2pmu_read_int_enable();
@@ -651,7 +651,7 @@ out:
 static void xscale2pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc() & ~XSCALE_PMU_CNT64;
@@ -663,7 +663,7 @@ static void xscale2pmu_start(struct arm_pmu *cpu_pmu)
 static void xscale2pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc();
-- 
1.9.1
