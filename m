From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  7 Dec 2010 20:38:48 -0800
Subject: [PATCHv3 4/4] msm: timer: Migrate to timer based __delay()
In-Reply-To: <1291783128-27520-1-git-send-email-sboyd@codeaurora.org>
References: <1291783128-27520-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1291783128-27520-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have to provide a dummy set_mode for the DGT since we don't
want it to ever turn off.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/timex.h |    1 +
 arch/arm/mach-msm/timer.c              |   16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/timex.h b/arch/arm/mach-msm/include/mach/timex.h
index a62e6b2..52b602b 100644
--- a/arch/arm/mach-msm/include/mach/timex.h
+++ b/arch/arm/mach-msm/include/mach/timex.h
@@ -17,5 +17,6 @@
 #define __ASM_ARCH_MSM_TIMEX_H
 
 #define CLOCK_TICK_RATE		1000000
+#define ARCH_HAS_READ_CURRENT_TIMER
 
 #endif
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 950100f..3e4c205 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -84,6 +84,12 @@ static cycle_t msm_dgt_read(struct clocksource *cs)
 	return readl(MSM_DGT_BASE + TIMER_COUNT_VAL) >> MSM_DGT_SHIFT;
 }
 
+int read_current_timer(unsigned long *timer_val)
+{
+	*timer_val = readl(MSM_DGT_BASE + TIMER_COUNT_VAL);
+	return 0;
+}
+
 static int msm_timer_set_next_event(unsigned long cycles,
 				    struct clock_event_device *evt)
 {
@@ -122,6 +128,12 @@ static void msm_timer_set_mode(enum clock_event_mode mode,
 	}
 }
 
+static void msm_timer_set_mode_nop(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	/* The timer is always ticking so do nothing */
+}
+
 static struct msm_clock msm_clocks[] = {
 	{
 		.clockevent = {
@@ -157,7 +169,7 @@ static struct msm_clock msm_clocks[] = {
 			.shift          = 32 + MSM_DGT_SHIFT,
 			.rating         = 300,
 			.set_next_event = msm_timer_set_next_event,
-			.set_mode       = msm_timer_set_mode,
+			.set_mode       = msm_timer_set_mode_nop,
 		},
 		.clocksource = {
 			.name           = "dg_timer",
@@ -218,6 +230,8 @@ static void __init msm_timer_init(void)
 
 		clockevents_register_device(ce);
 	}
+	writel(1, MSM_DGT_BASE + TIMER_ENABLE);
+	set_delay_fn(read_current_timer_delay_loop);
 }
 
 struct sys_timer msm_timer = {
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
