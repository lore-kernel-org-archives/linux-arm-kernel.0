From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 May 2018 11:35:15 +0100
Subject: [PATCH] arm_pmu: simplify arm_pmu::handle_irq
Message-ID: <20180510103515.41767-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm_pmu::handle_irq() callback has the same prototype as a generic
IRQ handler, taking the IRQ number and a void pointer argument which it
must convert to an arm_pmu pointer.

This means that all arm_pmu::handle_irq() take an IRQ number they never
use, and all must explicitly cast the void pointer to an arm_pmu
pointer.

Instead, let's change arm_pmu::handle_irq to take an arm_pmu pointer,
allowing these casts to be removed. The redundant IRQ number parameter
is also removed.

Suggested-by: Hoeun Ryu <hoeun.ryu@lge.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v6.c     | 4 +---
 arch/arm/kernel/perf_event_v7.c     | 3 +--
 arch/arm/kernel/perf_event_xscale.c | 6 ++----
 arch/arm64/kernel/perf_event.c      | 3 +--
 drivers/perf/arm_pmu.c              | 2 +-
 include/linux/perf/arm_pmu.h        | 2 +-
 6 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 1d7061a38922..be42c4f66a40 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -303,12 +303,10 @@ static void armv6pmu_enable_event(struct perf_event *event)
 }
 
 static irqreturn_t
-armv6pmu_handle_irq(int irq_num,
-		    void *dev)
+armv6pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	unsigned long pmcr = armv6_pmcr_read();
 	struct perf_sample_data data;
-	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 870b66c1e4ef..57f01e059f39 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -946,11 +946,10 @@ static void armv7pmu_disable_event(struct perf_event *event)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
+static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	u32 pmnc;
 	struct perf_sample_data data;
-	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index fcf218da660e..88d1a76f5367 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -142,11 +142,10 @@ xscale1_pmnc_counter_has_overflowed(unsigned long pmnc,
 }
 
 static irqreturn_t
-xscale1pmu_handle_irq(int irq_num, void *dev)
+xscale1pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	unsigned long pmnc;
 	struct perf_sample_data data;
-	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
@@ -489,11 +488,10 @@ xscale2_pmnc_counter_has_overflowed(unsigned long of_flags,
 }
 
 static irqreturn_t
-xscale2pmu_handle_irq(int irq_num, void *dev)
+xscale2pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	unsigned long pmnc, of_flags;
 	struct perf_sample_data data;
-	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 85a251b6dfa8..33147aacdafd 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -670,11 +670,10 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
+static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	u32 pmovsr;
 	struct perf_sample_data data;
-	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 1a0d340b65cf..a6347d487635 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -339,7 +339,7 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 		return IRQ_NONE;
 
 	start_clock = sched_clock();
-	ret = armpmu->handle_irq(irq, armpmu);
+	ret = armpmu->handle_irq(armpmu);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 40036a57d072..ad5444491975 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -78,7 +78,7 @@ struct arm_pmu {
 	struct pmu	pmu;
 	cpumask_t	supported_cpus;
 	char		*name;
-	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
+	irqreturn_t	(*handle_irq)(struct arm_pmu *pmu);
 	void		(*enable)(struct perf_event *event);
 	void		(*disable)(struct perf_event *event);
 	int		(*get_event_idx)(struct pmu_hw_events *hw_events,
-- 
2.11.0
