From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:23 -0700
Subject: [PATCH v4 10/17] clocksource: mxs_timer: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-11-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/mxs_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
index 0f5e65f..445b68a 100644
--- a/drivers/clocksource/mxs_timer.c
+++ b/drivers/clocksource/mxs_timer.c
@@ -222,7 +222,7 @@ static struct clocksource clocksource_mxs = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u32 notrace mxs_read_sched_clock_v2(void)
+static u64 notrace mxs_read_sched_clock_v2(void)
 {
 	return ~readl_relaxed(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1));
 }
@@ -236,7 +236,7 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
 	else {
 		clocksource_mmio_init(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1),
 			"mxs_timer", c, 200, 32, clocksource_mmio_readl_down);
-		setup_sched_clock(mxs_read_sched_clock_v2, 32, c);
+		sched_clock_register(mxs_read_sched_clock_v2, 32, c);
 	}
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
