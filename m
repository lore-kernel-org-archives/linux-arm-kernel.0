From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  9 Mar 2015 12:46:30 +0000
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
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

 ---
CPU: 0 PID: 1527 Comm: perf_fuzzer Not tainted 4.0.0-rc2 #57
Hardware name: ARM-Versatile Express
task: bd8484c0 ti: be676000 task.ti: be676000
PC is at 0xbf1bbc90
LR is at validate_event+0x34/0x5c
pc : [<bf1bbc90>]    lr : [<80016060>]    psr: 00000013
...
[<80016060>] (validate_event) from [<80016198>] (validate_group+0x28/0x90)
[<80016198>] (validate_group) from [<80016398>] (armpmu_event_init+0x150/0x218)
[<80016398>] (armpmu_event_init) from [<800882e4>] (perf_try_init_event+0x30/0x48)
[<800882e4>] (perf_try_init_event) from [<8008f544>] (perf_init_event+0x5c/0xf4)
[<8008f544>] (perf_init_event) from [<8008f8a8>] (perf_event_alloc+0x2cc/0x35c)
[<8008f8a8>] (perf_event_alloc) from [<8009015c>] (SyS_perf_event_open+0x498/0xa70)
[<8009015c>] (SyS_perf_event_open) from [<8000e420>] (ret_fast_syscall+0x0/0x34)
Code: bf1be000 bf1bb380 802a2664 00000000 (00000002)
---[ end trace 01aff0ff00926a0a ]---

Also cleans up the code to use the arm_pmu only when we know that
we are dealing with an arm pmu event.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm/kernel/perf_event.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 557e128..4a86a01 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -259,20 +259,29 @@ out:
 }
 
 static int
-validate_event(struct pmu_hw_events *hw_events,
-	       struct perf_event *event)
+validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
+			       struct perf_event *event)
 {
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+	struct arm_pmu *armpmu;
 
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
 	if (event->state < PERF_EVENT_STATE_OFF)
 		return 1;
 
 	if (event->state == PERF_EVENT_STATE_OFF && !event->attr.enable_on_exec)
 		return 1;
 
+	armpmu = to_arm_pmu(event->pmu);
 	return armpmu->get_event_idx(hw_events, event) >= 0;
 }
 
@@ -288,15 +297,15 @@ validate_group(struct perf_event *event)
 	 */
 	memset(&fake_pmu.used_mask, 0, sizeof(fake_pmu.used_mask));
 
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
