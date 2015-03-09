From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  9 Mar 2015 12:46:31 +0000
Subject: [PATCH 2/3] arm64/pmu: Reject groups spanning multiple HW PMUs
In-Reply-To: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1425905192-10509-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Don't allow grouping hardware events from different PMUs
 (eg. CCI + CPU).

Fixes a crash triggered by perf_fuzzer on Linux-4.0-rc2,
with CCI PMU turned on. The validate_event(), after certain checks,
assumes that the given hardware pmu event belongs to armpmu,
which may not be true always, with other hardware PMUs
around (CCI, CCN).

Bad mode in Synchronous Abort handler detected, code 0x86000006 -- IABT (current EL)
CPU: 0 PID: 1371 Comm: perf_fuzzer Not tainted 3.19.0+ #249
Hardware name: V2F-1XV7 Cortex-A53x2 SMM (DT)
task: ffffffc07c73a280 ti: ffffffc07b0a0000 task.ti: ffffffc07b0a0000
PC is at 0x0
LR is at validate_event+0x90/0xa8
pc : [<0000000000000000>] lr : [<ffffffc000090228>] pstate: 00000145
sp : ffffffc07b0a3ba0

[<          (null)>]           (null)
[<ffffffc0000907d8>] armpmu_event_init+0x174/0x3cc
[<ffffffc00015d870>] perf_try_init_event+0x34/0x70
[<ffffffc000164094>] perf_init_event+0xe0/0x10c
[<ffffffc000164348>] perf_event_alloc+0x288/0x358
[<ffffffc000164c5c>] SyS_perf_event_open+0x464/0x98c
Code: bad PC value

Also cleans up the code to use the arm_pmu only when we know
that we are dealing with an arm pmu event.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/perf_event.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 25a5308..68a7415 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -322,22 +322,31 @@ out:
 }
 
 static int
-validate_event(struct pmu_hw_events *hw_events,
-	       struct perf_event *event)
+validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
+				struct perf_event *event)
 {
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+	struct arm_pmu *armpmu;
 	struct hw_perf_event fake_event = event->hw;
 	struct pmu *leader_pmu = event->group_leader->pmu;
 
 	if (is_software_event(event))
 		return 1;
 
+	/*
+	 * Reject groups spanning multiple HW PMUs (e.g. CPU + CCI). The
+	 * core perf code won't check that the pmu->ctx == leader->ctx
+	 * until after pmu->event_init(event).
+	 */
+	if (event->pmu != pmu)
+		return 0;
+
 	if (event->pmu != leader_pmu || event->state < PERF_EVENT_STATE_OFF)
 		return 1;
 
 	if (event->state == PERF_EVENT_STATE_OFF && !event->attr.enable_on_exec)
 		return 1;
 
+	armpmu = to_arm_pmu(event->pmu);
 	return armpmu->get_event_idx(hw_events, &fake_event) >= 0;
 }
 
@@ -355,15 +364,15 @@ validate_group(struct perf_event *event)
 	memset(fake_used_mask, 0, sizeof(fake_used_mask));
 	fake_pmu.used_mask = fake_used_mask;
 
-	if (!validate_event(&fake_pmu, leader))
+	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
 
 	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
-		if (!validate_event(&fake_pmu, sibling))
+		if (!validate_event(event->pmu, &fake_pmu, sibling))
 			return -EINVAL;
 	}
 
-	if (!validate_event(&fake_pmu, event))
+	if (!validate_event(event->pmu, &fake_pmu, event))
 		return -EINVAL;
 
 	return 0;
-- 
1.7.9.5
