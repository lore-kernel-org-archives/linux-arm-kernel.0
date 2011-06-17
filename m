From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Fri, 17 Jun 2011 13:55:38 -0700
Subject: [PATCH v2] msm: timer: compensate for timer shift in
	msm_read_timer_count
Message-ID: <1308344138-2862-1-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some msm targets have timers whose lower bits are unreliable. So, we
present our timers as lower frequency than they actually are, and ignore
the bottom 5 bits on such targets. This compensation was erroneously
removed from the msm_read_timer_count function, so restore it.

This was broken by 94790ec25 "msm: timer: SMP timer support for msm".

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/timer.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 38b95e9..608ec4d 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -100,7 +100,11 @@ static cycle_t msm_read_timer_count(struct clocksource *cs)
 {
 	struct msm_clock *clk = container_of(cs, struct msm_clock, clocksource);
 
-	return readl(clk->global_counter);
+	/*
+	 * Shift timer count down by a constant due to unreliable lower bits
+	 * on some targets.
+	 */
+	return readl(clk->global_counter) >> clk->shift;
 }
 
 static struct msm_clock *clockevent_to_clock(struct clock_event_device *evt)
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
