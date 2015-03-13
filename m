From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Mar 2015 11:09:40 -0700
Subject: [PATCH 07/12] clocksource: qcom: Remove dead code
In-Reply-To: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1426270185-19510-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is no longer used now that mach-msm has been removed.
Delete it.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This can be acked and go through arm-soc or applied directly to clocksource
tree.

 drivers/clocksource/qcom-timer.c | 59 ----------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/qcom-timer.c
index 098c542e5c53..cba2d015564c 100644
--- a/drivers/clocksource/qcom-timer.c
+++ b/drivers/clocksource/qcom-timer.c
@@ -40,8 +40,6 @@
 
 #define GPT_HZ 32768
 
-#define MSM_DGT_SHIFT 5
-
 static void __iomem *event_base;
 static void __iomem *sts_base;
 
@@ -232,7 +230,6 @@ err:
 	register_current_timer_delay(&msm_delay_timer);
 }
 
-#ifdef CONFIG_ARCH_QCOM
 static void __init msm_dt_timer_init(struct device_node *np)
 {
 	u32 freq;
@@ -285,59 +282,3 @@ static void __init msm_dt_timer_init(struct device_node *np)
 }
 CLOCKSOURCE_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
 CLOCKSOURCE_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
-#else
-
-static int __init msm_timer_map(phys_addr_t addr, u32 event, u32 source,
-				u32 sts)
-{
-	void __iomem *base;
-
-	base = ioremap(addr, SZ_256);
-	if (!base) {
-		pr_err("Failed to map timer base\n");
-		return -ENOMEM;
-	}
-	event_base = base + event;
-	source_base = base + source;
-	if (sts)
-		sts_base = base + sts;
-
-	return 0;
-}
-
-static notrace cycle_t msm_read_timer_count_shift(struct clocksource *cs)
-{
-	/*
-	 * Shift timer count down by a constant due to unreliable lower bits
-	 * on some targets.
-	 */
-	return msm_read_timer_count(cs) >> MSM_DGT_SHIFT;
-}
-
-void __init msm7x01_timer_init(void)
-{
-	struct clocksource *cs = &msm_clocksource;
-
-	if (msm_timer_map(0xc0100000, 0x0, 0x10, 0x0))
-		return;
-	cs->read = msm_read_timer_count_shift;
-	cs->mask = CLOCKSOURCE_MASK((32 - MSM_DGT_SHIFT));
-	/* 600 KHz */
-	msm_timer_init(19200000 >> MSM_DGT_SHIFT, 32 - MSM_DGT_SHIFT, 7,
-			false);
-}
-
-void __init msm7x30_timer_init(void)
-{
-	if (msm_timer_map(0xc0100000, 0x4, 0x24, 0x80))
-		return;
-	msm_timer_init(24576000 / 4, 32, 1, false);
-}
-
-void __init qsd8x50_timer_init(void)
-{
-	if (msm_timer_map(0xAC100000, 0x0, 0x10, 0x34))
-		return;
-	msm_timer_init(19200000 / 4, 32, 7, false);
-}
-#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
