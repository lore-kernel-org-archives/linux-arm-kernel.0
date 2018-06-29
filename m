From: keescook@chromium.org (Kees Cook)
Date: Fri, 29 Jun 2018 11:45:36 -0700
Subject: [PATCH] perf/arm-cci: Remove VLA usage
Message-ID: <20180629184536.GA37337@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLA in favor of a maximum size and adds a sanity check
at registration time. The sizes are all explicitly enumerated already,
so this just collects them into macros.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA at mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/perf/arm-cci.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 0d09d8e669cd..1bfeb160c5b1 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -53,6 +53,16 @@ enum {
 	CCI_IF_MAX,
 };
 
+#define NUM_HW_CNTRS_CII_4XX	4
+#define NUM_HW_CNTRS_CII_5XX	8
+#define NUM_HW_CNTRS_MAX	NUM_HW_CNTRS_CII_5XX
+
+#define FIXED_HW_CNTRS_CII_4XX	1
+#define FIXED_HW_CNTRS_CII_5XX	0
+#define FIXED_HW_CNTRS_MAX	FIXED_HW_CNTRS_CII_4XX
+
+#define HW_CNTRS_MAX		(NUM_HW_CNTRS_MAX + FIXED_HW_CNTRS_MAX)
+
 struct event_range {
 	u32 min;
 	u32 max;
@@ -633,8 +643,7 @@ static void cci_pmu_sync_counters(struct cci_pmu *cci_pmu)
 {
 	int i;
 	struct cci_pmu_hw_events *cci_hw = &cci_pmu->hw_events;
-
-	DECLARE_BITMAP(mask, cci_pmu->num_cntrs);
+	DECLARE_BITMAP(mask, HW_CNTRS_MAX);
 
 	bitmap_zero(mask, cci_pmu->num_cntrs);
 	for_each_set_bit(i, cci_pmu->hw_events.used_mask, cci_pmu->num_cntrs) {
@@ -940,7 +949,7 @@ static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 static void cci5xx_pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 {
 	int i;
-	DECLARE_BITMAP(saved_mask, cci_pmu->num_cntrs);
+	DECLARE_BITMAP(saved_mask, HW_CNTRS_MAX);
 
 	bitmap_zero(saved_mask, cci_pmu->num_cntrs);
 	pmu_save_counters(cci_pmu, saved_mask);
@@ -1245,7 +1254,7 @@ static int validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
-	unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
+	unsigned long mask[BITS_TO_LONGS(HW_CNTRS_MAX)];
 	struct cci_pmu_hw_events fake_pmu = {
 		/*
 		 * Initialise the fake PMU. We only need to populate the
@@ -1403,6 +1412,11 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 	char *name = model->name;
 	u32 num_cntrs;
 
+	if (WARN_ON(model->num_hw_cntrs > NUM_HW_CNTRS_MAX))
+		return -EINVAL;
+	if (WARN_ON(model->fixed_hw_cntrs > FIXED_HW_CNTRS_MAX))
+		return -EINVAL;
+
 	pmu_event_attr_group.attrs = model->event_attrs;
 	pmu_format_attr_group.attrs = model->format_attrs;
 
@@ -1455,8 +1469,8 @@ static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 #ifdef CONFIG_ARM_CCI400_PMU
 	[CCI400_R0] = {
 		.name = "CCI_400",
-		.fixed_hw_cntrs = 1,	/* Cycle counter */
-		.num_hw_cntrs = 4,
+		.fixed_hw_cntrs = FIXED_HW_CNTRS_CII_4XX, /* Cycle counter */
+		.num_hw_cntrs = NUM_HW_CNTRS_CII_4XX,
 		.cntr_size = SZ_4K,
 		.format_attrs = cci400_pmu_format_attrs,
 		.event_attrs = cci400_r0_pmu_event_attrs,
@@ -1475,8 +1489,8 @@ static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 	},
 	[CCI400_R1] = {
 		.name = "CCI_400_r1",
-		.fixed_hw_cntrs = 1,	/* Cycle counter */
-		.num_hw_cntrs = 4,
+		.fixed_hw_cntrs = FIXED_HW_CNTRS_CII_4XX, /* Cycle counter */
+		.num_hw_cntrs = NUM_HW_CNTRS_CII_4XX,
 		.cntr_size = SZ_4K,
 		.format_attrs = cci400_pmu_format_attrs,
 		.event_attrs = cci400_r1_pmu_event_attrs,
@@ -1497,8 +1511,8 @@ static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 #ifdef CONFIG_ARM_CCI5xx_PMU
 	[CCI500_R0] = {
 		.name = "CCI_500",
-		.fixed_hw_cntrs = 0,
-		.num_hw_cntrs = 8,
+		.fixed_hw_cntrs = FIXED_HW_CNTRS_CII_5XX,
+		.num_hw_cntrs = NUM_HW_CNTRS_CII_5XX,
 		.cntr_size = SZ_64K,
 		.format_attrs = cci5xx_pmu_format_attrs,
 		.event_attrs = cci5xx_pmu_event_attrs,
@@ -1521,8 +1535,8 @@ static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 	},
 	[CCI550_R0] = {
 		.name = "CCI_550",
-		.fixed_hw_cntrs = 0,
-		.num_hw_cntrs = 8,
+		.fixed_hw_cntrs = FIXED_HW_CNTRS_CII_5XX,
+		.num_hw_cntrs = NUM_HW_CNTRS_CII_5XX,
 		.cntr_size = SZ_64K,
 		.format_attrs = cci5xx_pmu_format_attrs,
 		.event_attrs = cci5xx_pmu_event_attrs,
-- 
2.17.1


-- 
Kees Cook
Pixel Security
