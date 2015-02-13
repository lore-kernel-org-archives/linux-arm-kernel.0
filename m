From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Feb 2015 10:24:08 -0800
Subject: [PATCH v2 1/2] ARM: perf: Preparatory work for Scorpion PMU support
In-Reply-To: <1423851849-6069-1-git-send-email-sboyd@codeaurora.org>
References: <1423851849-6069-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1423851849-6069-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do some things to make the Krait PMU support code generic enough
to be used by the Scorpion PMU support code.

 * Rename the venum register functions to be venum instead of krait
   specific because the same registers exist on Scorpion

 * Add a krait_decode_event() function to decode our Krait specific
   event encoding that's the same on Scorpion (modulo an extra region).

 * Drop krait from krait_clear_pmresrn_group() so it can be used
   by Scorpion code

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/perf_event_v7.c | 87 ++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 8993770c47de..84a3ec3bc592 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1141,19 +1141,19 @@ static void krait_write_pmresrn(int n, u32 val)
 	}
 }
 
-static u32 krait_read_vpmresr0(void)
+static u32 venum_read_pmresr(void)
 {
 	u32 val;
 	asm volatile("mrc p10, 7, %0, c11, c0, 0" : "=r" (val));
 	return val;
 }
 
-static void krait_write_vpmresr0(u32 val)
+static void venum_write_pmresr(u32 val)
 {
 	asm volatile("mcr p10, 7, %0, c11, c0, 0" : : "r" (val));
 }
 
-static void krait_pre_vpmresr0(u32 *venum_orig_val, u32 *fp_orig_val)
+static void venum_pre_pmresr(u32 *venum_orig_val, u32 *fp_orig_val)
 {
 	u32 venum_new_val;
 	u32 fp_new_val;
@@ -1170,7 +1170,7 @@ static void krait_pre_vpmresr0(u32 *venum_orig_val, u32 *fp_orig_val)
 	fmxr(FPEXC, fp_new_val);
 }
 
-static void krait_post_vpmresr0(u32 venum_orig_val, u32 fp_orig_val)
+static void venum_post_pmresr(u32 venum_orig_val, u32 fp_orig_val)
 {
 	BUG_ON(preemptible());
 	/* Restore FPEXC */
@@ -1188,6 +1188,21 @@ static u32 krait_get_pmresrn_event(unsigned int region)
 	return pmresrn_table[region];
 }
 
+static void krait_decode_event(u32 event, unsigned int *region,
+		unsigned int *group, unsigned int *code, bool *venum, bool *cpu)
+{
+	if (region)
+		*region = (event >> 12) & 0xf;
+	if (group)
+		*group  = (event >> 0)  & 0xf;
+	if (code)
+		*code   = (event >> 4) & 0xff;
+	if (venum)
+		*venum  = !!(event & VENUM_EVENT);
+	if (cpu)
+		*cpu = !!(event & KRAIT_EVENT);
+}
+
 static void krait_evt_setup(int idx, u32 config_base)
 {
 	u32 val;
@@ -1199,10 +1214,8 @@ static void krait_evt_setup(int idx, u32 config_base)
 	unsigned int group_shift;
 	bool venum_event;
 
-	venum_event = !!(config_base & VENUM_EVENT);
-	region = (config_base >> 12) & 0xf;
-	code   = (config_base >> 4) & 0xff;
-	group  = (config_base >> 0)  & 0xf;
+	krait_decode_event(config_base, &region, &group, &code, &venum_event,
+			   NULL);
 
 	group_shift = group * 8;
 	mask = 0xff << group_shift;
@@ -1220,13 +1233,13 @@ static void krait_evt_setup(int idx, u32 config_base)
 	asm volatile("mcr p15, 0, %0, c9, c15, 0" : : "r" (0));
 
 	if (venum_event) {
-		krait_pre_vpmresr0(&vval, &fval);
-		val = krait_read_vpmresr0();
+		venum_pre_pmresr(&vval, &fval);
+		val = venum_read_pmresr();
 		val &= ~mask;
 		val |= code << group_shift;
 		val |= PMRESRn_EN;
-		krait_write_vpmresr0(val);
-		krait_post_vpmresr0(vval, fval);
+		venum_write_pmresr(val);
+		venum_post_pmresr(vval, fval);
 	} else {
 		val = krait_read_pmresrn(region);
 		val &= ~mask;
@@ -1236,7 +1249,7 @@ static void krait_evt_setup(int idx, u32 config_base)
 	}
 }
 
-static u32 krait_clear_pmresrn_group(u32 val, int group)
+static u32 clear_pmresrn_group(u32 val, int group)
 {
 	u32 mask;
 	int group_shift;
@@ -1260,19 +1273,18 @@ static void krait_clearpmu(u32 config_base)
 	unsigned int group;
 	bool venum_event;
 
-	venum_event = !!(config_base & VENUM_EVENT);
-	region = (config_base >> 12) & 0xf;
-	group  = (config_base >> 0)  & 0xf;
+	krait_decode_event(config_base, &region, &group, NULL, &venum_event,
+			   NULL);
 
 	if (venum_event) {
-		krait_pre_vpmresr0(&vval, &fval);
-		val = krait_read_vpmresr0();
-		val = krait_clear_pmresrn_group(val, group);
-		krait_write_vpmresr0(val);
-		krait_post_vpmresr0(vval, fval);
+		venum_pre_pmresr(&vval, &fval);
+		val = venum_read_pmresr();
+		val = clear_pmresrn_group(val, group);
+		venum_write_pmresr(val);
+		venum_post_pmresr(vval, fval);
 	} else {
 		val = krait_read_pmresrn(region);
-		val = krait_clear_pmresrn_group(val, group);
+		val = clear_pmresrn_group(val, group);
 		krait_write_pmresrn(region, val);
 	}
 }
@@ -1350,9 +1362,9 @@ static void krait_pmu_reset(void *info)
 	krait_write_pmresrn(1, 0);
 	krait_write_pmresrn(2, 0);
 
-	krait_pre_vpmresr0(&vval, &fval);
-	krait_write_vpmresr0(0);
-	krait_post_vpmresr0(vval, fval);
+	venum_pre_pmresr(&vval, &fval);
+	venum_write_pmresr(0);
+	venum_post_pmresr(vval, fval);
 }
 
 static int krait_event_to_bit(struct perf_event *event, unsigned int region,
@@ -1386,26 +1398,20 @@ static int krait_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 {
 	int idx;
 	int bit = -1;
-	unsigned int prefix;
 	unsigned int region;
 	unsigned int code;
 	unsigned int group;
-	bool krait_event;
+	bool venum_event, krait_event;
 	struct hw_perf_event *hwc = &event->hw;
 
-	region = (hwc->config_base >> 12) & 0xf;
-	code   = (hwc->config_base >> 4) & 0xff;
-	group  = (hwc->config_base >> 0) & 0xf;
-	krait_event = !!(hwc->config_base & KRAIT_EVENT_MASK);
+	krait_decode_event(hwc->config_base, &region, &group, &code,
+			   &venum_event, &krait_event);
 
-	if (krait_event) {
+	if (venum_event || krait_event) {
 		/* Ignore invalid events */
 		if (group > 3 || region > 2)
 			return -EINVAL;
-		prefix = hwc->config_base & KRAIT_EVENT_MASK;
-		if (prefix != KRAIT_EVENT && prefix != VENUM_EVENT)
-			return -EINVAL;
-		if (prefix == VENUM_EVENT && (code & 0xe0))
+		if (venum_event && (code & 0xe0))
 			return -EINVAL;
 
 		bit = krait_event_to_bit(event, region, group);
@@ -1427,13 +1433,12 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned int region;
 	unsigned int group;
-	bool krait_event;
+	bool venum_event, krait_event;
 
-	region = (hwc->config_base >> 12) & 0xf;
-	group  = (hwc->config_base >> 0) & 0xf;
-	krait_event = !!(hwc->config_base & KRAIT_EVENT_MASK);
+	krait_decode_event(hwc->config_base, &region, &group, NULL,
+			   &venum_event, &krait_event);
 
-	if (krait_event) {
+	if (venum_event || krait_event) {
 		bit = krait_event_to_bit(event, region, group);
 		clear_bit(bit, cpuc->used_mask);
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
