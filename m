From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  1 Jul 2014 16:11:18 +0100
Subject: [PATCH 8/8] arm: perf: krait: stop using singleton PMU
In-Reply-To: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1404227478-9645-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the krait_pmu_{enable,disable}_event functions use the global
cpu_pmu variable while all the other pmu enable/disable functions
derive this from the event argument.

This patch brings the Krait functions into line with the rest of the PMU
backends by deriving the address of the pmu from the event argument.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/perf_event_v7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index d4129bc..116758b 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1286,6 +1286,7 @@ static void krait_pmu_disable_event(struct perf_event *event)
 	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	/* Disable counter and interrupt */
@@ -1311,6 +1312,7 @@ static void krait_pmu_enable_event(struct perf_event *event)
 	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	/*
-- 
1.9.1
