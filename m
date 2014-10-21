From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Oct 2014 14:11:20 +0100
Subject: [PATCH 4/8] arm: perf: limit size of accounting data
In-Reply-To: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1413897084-19715-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3fc2c83087 (ARM: perf: remove event limit from pmu_hw_events) got
rid of the upper limit on the number of events an arm_pmu could handle,
but introduced additional complexity and places a burden on each PMU
driver to allocate accounting data somehow. So far this has not
generally been useful as the only users of arm_pmu are the CPU backend
and the CCI driver.

Now that the CCI driver plugs into the perf subsystem directly, we can
remove some of the complexities that get in the way of supporting
heterogeneous CPU PMUs.

This patch restores the original limits on pmu_hw_events fields such
that the pmu_hw_events data can be allocated as a contiguous block. This
will simplify dynamic pmu_hw_events allocation in later patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h       | 4 ++--
 arch/arm/kernel/perf_event.c     | 4 +---
 arch/arm/kernel/perf_event_cpu.c | 4 ----
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index ff39290..3d7e30b 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -68,13 +68,13 @@ struct pmu_hw_events {
 	/*
 	 * The events that are active on the PMU for the given index.
 	 */
-	struct perf_event	**events;
+	struct perf_event	*events[ARMPMU_MAX_HWEVENTS];
 
 	/*
 	 * A 1 bit for an index indicates that the counter is being used for
 	 * an event. A 0 means that the counter can be used.
 	 */
-	unsigned long           *used_mask;
+	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
 
 	/*
 	 * Hardware lock to serialize accesses to PMU registers. Needed for the
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index f0bbd3d..01db868 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -275,14 +275,12 @@ validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
 	struct pmu_hw_events fake_pmu;
-	DECLARE_BITMAP(fake_used_mask, ARMPMU_MAX_HWEVENTS);
 
 	/*
 	 * Initialise the fake PMU. We only need to populate the
 	 * used_mask for the purposes of validation.
 	 */
-	memset(fake_used_mask, 0, sizeof(fake_used_mask));
-	fake_pmu.used_mask = fake_used_mask;
+	memset(&fake_pmu.used_mask, 0, sizeof(fake_pmu.used_mask));
 
 	if (!validate_event(&fake_pmu, leader))
 		return -EINVAL;
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index ed7bb04f..ff4a47f 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -36,8 +36,6 @@
 static struct arm_pmu *cpu_pmu;
 
 static DEFINE_PER_CPU(struct arm_pmu *, percpu_pmu);
-static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
-static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
 static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
 
 /*
@@ -172,8 +170,6 @@ static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	int cpu;
 	for_each_possible_cpu(cpu) {
 		struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
-		events->events = per_cpu(hw_events, cpu);
-		events->used_mask = per_cpu(used_mask, cpu);
 		raw_spin_lock_init(&events->pmu_lock);
 		per_cpu(percpu_pmu, cpu) = cpu_pmu;
 	}
-- 
1.9.1
