From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 Feb 2015 16:11:34 -0800
Subject: [PATCH v3 2/3] ARM: perf: Only reset PMxEVCNTCR registers on reset
In-Reply-To: <1425082295-10941-1-git-send-email-sboyd@codeaurora.org>
References: <1425082295-10941-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1425082295-10941-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Krait specific PMxEVCNTCR register is unpredictable upon
reset. Currently we clear the register before we setup an event,
but we don't need to do that. Instead, we can iterate through all
the events and clear them once when we reset the PMU, saving a
write in the event setup path.

Cc: Neil Leeder <nleeder@codeaurora.org>
Cc: Ashwin Chaugule <ashwinc@codeaurora.org>
Cc: Sheetal Sahasrabudhe <sheetals@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/perf_event_v7.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 97a7eda8831a..fae6c4ea52e8 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1218,8 +1218,6 @@ static void krait_evt_setup(int idx, u32 config_base)
 	val |= config_base & (ARMV7_EXCLUDE_USER | ARMV7_EXCLUDE_PL1);
 	armv7_pmnc_write_evtsel(idx, val);
 
-	asm volatile("mcr p15, 0, %0, c9, c15, 0" : : "r" (0));
-
 	if (venum_event) {
 		venum_pre_pmresr(&vval, &fval);
 		val = venum_read_pmresr();
@@ -1339,6 +1337,8 @@ static void krait_pmu_enable_event(struct perf_event *event)
 static void krait_pmu_reset(void *info)
 {
 	u32 vval, fval;
+	struct arm_pmu *cpu_pmu = info;
+	u32 idx, nb_cnt = cpu_pmu->num_events;
 
 	armv7pmu_reset(info);
 
@@ -1350,6 +1350,13 @@ static void krait_pmu_reset(void *info)
 	venum_pre_pmresr(&vval, &fval);
 	venum_write_pmresr(0);
 	venum_post_pmresr(vval, fval);
+
+	/* Reset PMxEVNCTCR to sane default */
+	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx) {
+		armv7_pmnc_select_counter(idx);
+		asm volatile("mcr p15, 0, %0, c9, c15, 0" : : "r" (0));
+	}
+
 }
 
 static int krait_event_to_bit(struct perf_event *event, unsigned int region,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
