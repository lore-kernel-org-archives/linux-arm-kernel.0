From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  8 Jun 2011 20:44:02 -0700
Subject: [PATCH] msm: timer: compensate for timer shift in msm_read_timer_count
Message-ID: <1307591042-2369-1-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some msm targets have timers whose lower bits are unreliable. So, we
present our timers as lower frequency than they actually are, and ignore
the bottom 5 bits on such targets. This compensation was erroneously
removed from the msm_read_timer_count function, so restore it.

This was broken by 94790ec25 "msm: timer: SMP timer support for msm".

Change-Id: I8c56bdf82629638748ccf352118ea664f967b87d
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 38b95e9..b3579fe 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -100,7 +100,7 @@ static cycle_t msm_read_timer_count(struct clocksource *cs)
 {
 	struct msm_clock *clk = container_of(cs, struct msm_clock, clocksource);
 
-	return readl(clk->global_counter);
+	return readl(clk->global_counter) >> clk->shift;
 }
 
 static struct msm_clock *clockevent_to_clock(struct clock_event_device *evt)
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
