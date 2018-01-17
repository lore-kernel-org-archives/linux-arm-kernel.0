From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 17 Jan 2018 12:04:43 +0000
Subject: [PATCH 1/3] arm64: perf: Make PMU interrupt NMI safe
In-Reply-To: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
References: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1516190685-20048-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before using an NMI, we must make sure the IRQ handler uses no locks and
only calls NMI safe functions.

Get rid of PMU lock, saving and restoring the PMU counter selector in the
PMU interrupt handler
When PMU interrupt is an NMI do not call irq_work_run and rely on the IRQ
work IPI to run the irq_work queue.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 arch/arm64/kernel/perf_event.c | 41 +++++++++--------------------------------
 drivers/perf/arm_pmu.c         |  1 -
 include/linux/perf/arm_pmu.h   |  6 ------
 3 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 3affca3..57fdd87 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -609,19 +609,10 @@ static inline u32 armv8pmu_getreset_flags(void)

 static void armv8pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;

 	/*
-	 * Enable counter and interrupt, and set the counter to count
-	 * the event that we're interested in.
-	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
-	/*
 	 * Disable counter
 	 */
 	armv8pmu_disable_counter(idx);
@@ -640,24 +631,14 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 * Enable counter
 	 */
 	armv8pmu_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }

 static void armv8pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;

 	/*
-	 * Disable counter and interrupt
-	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
-	/*
 	 * Disable counter
 	 */
 	armv8pmu_disable_counter(idx);
@@ -666,8 +647,6 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	 * Disable interrupt for this counter
 	 */
 	armv8pmu_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }

 static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
@@ -678,6 +657,7 @@ static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
+	u32 pmselr_save = read_sysreg(pmselr_el0);

 	/*
 	 * Get and reset the IRQ flags
@@ -721,37 +701,34 @@ static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
 	}

 	/*
+	 * Restore selector registor as it was potentially used in the
+	 * interrupted context.
+	 */
+	write_sysreg(pmselr_save, pmselr_el0);
+
+	/*
 	 * Handle the pending perf events.
 	 *
 	 * Note: this call *must* be run with interrupts disabled. For
 	 * platforms that can have the PMU interrupts raised as an NMI, this
 	 * will not work.
 	 */
-	irq_work_run();
+	if (!in_nmi())
+		irq_work_run();

 	return IRQ_HANDLED;
 }

 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }

 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }

 static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 7bc5eee..40ad36f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -845,7 +845,6 @@ struct arm_pmu *armpmu_alloc(void)
 		struct pmu_hw_events *events;

 		events = per_cpu_ptr(pmu->hw_events, cpu);
-		raw_spin_lock_init(&events->pmu_lock);
 		events->percpu_pmu = pmu;
 	}

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index af0f44ef..29efdab 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -69,12 +69,6 @@ struct pmu_hw_events {
 	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);

 	/*
-	 * Hardware lock to serialize accesses to PMU registers. Needed for the
-	 * read/modify/write sequences.
-	 */
-	raw_spinlock_t		pmu_lock;
-
-	/*
 	 * When using percpu IRQs, we need a percpu dev_id. Place it here as we
 	 * already have to allocate this struct per cpu.
 	 */
--
1.9.1
